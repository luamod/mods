local lfs = require("lfs")

package.path = "src/?.lua;src/?/init.lua;" .. package.path

local List = require("mods.List")

local TYPES_DIR = "types"
local OUT_DIR = "docs/modules"
local INDEX_OUT = OUT_DIR .. "/index.md"
local GENERATED_DIR = "docs/.vitepress"
local MODULES_OUT = GENERATED_DIR .. "/mods.mts"

local function read_file(path)
  local f = assert(io.open(path, "r"))
  local data = f:read("*a")
  f:close()
  return data
end

local function write_file(path, data)
  local dir = path:match("^(.*)/[^/]+$")
  if dir and lfs.attributes(dir, "mode") ~= "directory" then
    lfs.mkdir(dir)
  end
  local f = assert(io.open(path, "w"))
  f:write(data)
  f:close()
end

local function trim(s)
  return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function slugify_anchor(name, params)
  local base = name .. "(" .. params .. ")"
  base = base:gsub("[()]", "")
  base = base:gsub("%s* ,%s*", "-")
  base = base:gsub(",%s*", "-")
  base = base:gsub("%s+", "")
  return "fn-" .. base:lower()
end

local function parse_block(block_lines)
  local desc_lines = {}
  local anno_lines = {}
  local example_lines = {}
  local in_example = false
  local in_fence = false

  for _, line in ipairs(block_lines) do
    if line:match("^@") then
      table.insert(anno_lines, line)
    elseif line:match("^%*%*Example:%*%*") then
      in_example = true
    elseif in_example then
      if line:match("^```") then
        in_fence = not in_fence
        table.insert(example_lines, line)
      else
        table.insert(example_lines, line)
      end
    elseif line == "" then
      if #desc_lines > 0 and desc_lines[#desc_lines] ~= "" then
        table.insert(desc_lines, "")
      end
    else
      table.insert(desc_lines, line)
    end
  end

  local desc = trim(table.concat(desc_lines, "\n"))
  local example = nil
  if #example_lines > 0 then
    example = trim(table.concat(example_lines, "\n"))
  end

  return {
    desc = desc,
    annotations = anno_lines,
    example = example,
  }
end

local function parse_types_file(path)
  local lines = {}
  local function push_line(v)
    table.insert(lines, v)
  end
  for line in read_file(path):gmatch("[^\n]*\n?") do
    if line == "" then
      break
    end
    local cleaned = line:gsub("\n$", "")
    push_line(cleaned)
  end

  local meta
  local module_desc
  local block = nil
  local funcs = {}
  local function push_func(v)
    table.insert(funcs, v)
  end

  local function flush_block()
    if block and #block > 0 then
      block = nil
    end
  end

  for _, raw in ipairs(lines) do
    local line = raw
    if line:match("^%-%-%-") then
      local text = line:gsub("^%-%-%-%s?", "")
      if text:match("^@meta%s+") then
        meta = text:gsub("^@meta%s+", "")
      elseif text:match("^@class%s+") then
        flush_block()
      else
        block = block or {}
        table.insert(block, text)
        if not module_desc and meta and text ~= "" and not text:match("^@") then
          module_desc = (module_desc or text)
        end
      end
    else
      local fn_full, params = line:match("^function%s+([%w%._:]+)%s*%(([^)]*)%)")
      if fn_full then
        local name = fn_full:match("[^%._:]+$")
        local doc = parse_block(block or {})
        push_func({
          name = name,
          params = trim(params),
          doc = doc,
          annotations = doc.annotations,
        })
        block = nil
      else
        flush_block()
      end
    end
  end

  return {
    meta = meta,
    module_desc = module_desc or "",
    functions = funcs,
  }
end

local function module_short_name(meta)
  if not meta then
    return nil
  end
  local short = meta:match("[^%.]+$")
  return short and short:lower() or nil
end

local function render_module(doc)
  local short = module_short_name(doc.meta) or "module"
  local out = List()

  local function push(...)
    for i = 1, select("#", ...) do
      out:append(select(i, ...))
    end
  end

  if doc.meta and doc.meta ~= "" then
    local type_name = doc.meta:gsub("^mods%.", "")
    push("---")
    push("editLinkTarget: types/" .. type_name .. ".lua")
    push("---")
    push("")
  end

  push("# " .. short)
  push("")
  if doc.meta and doc.meta ~= "" then
    push("`" .. doc.meta .. "`" .. (doc.module_desc ~= "" and " " .. doc.module_desc or ""))
  else
    push(doc.module_desc)
  end
  push("")

  if #doc.functions > 0 then
    push("## Quick Reference")
    push("")
    push("| Function | Description |")
    push("| --- | --- |")
    for _, fn in ipairs(doc.functions) do
      local desc = fn.doc.desc:gsub("\n.*", "")
      local anchor = slugify_anchor(fn.name, fn.params)
      push(string.format("| [`%s(%s)`](#%s) | %s |", fn.name, fn.params, anchor, desc))
    end
    push("")

    push("## Functions")
    push("")
    for _, fn in ipairs(doc.functions) do
      local anchor = slugify_anchor(fn.name, fn.params)
      push(string.format('<a id="%s"></a>', anchor))
      push("")
      push(string.format("#### `%s(%s)`", fn.name, fn.params))
      push("")
      if fn.doc.desc ~= "" then
        push(fn.doc.desc)
        push("")
      end
      push(":::tabs")
      if fn.doc.example and fn.doc.example ~= "" then
        push("== Example")
        push("")
        push(fn.doc.example)
        push("")
      end
      push("== Signature")
      push("")
      push("```lua")
      for _, anno in ipairs(fn.annotations or {}) do
        push("---@" .. anno)
      end
      local signature = string.format("function %s(%s) end", fn.name, fn.params)
      push(signature)
      push("```")
      push("")
      push(":::")
      push("")
    end
  end

  return table.concat(out, "\n")
end

local function render_index(docs)
  local out = List()

  local function push(...)
    for i = 1, select("#", ...) do
      out:append(select(i, ...))
    end
  end

  push("---", "editLink: false", "---", "")
  push("# API Overview", "")
  push("| Module | Description |", "| --- | --- |")
  for _, doc in ipairs(docs) do
    local short = module_short_name(doc.meta)
    if short then
      local name = doc.meta or short
      local desc = doc.module_desc or ""
      local link = string.format("/modules/%s", short)
      push(string.format("| [`%s`](%s) | %s |", name, link, desc))
    end
  end
  push("")

  return table.concat(out, "\n")
end

local function render_modules_ts(docs)
  local out = List()

  local function push(...)
    for i = 1, select("#", ...) do
      out:append(select(i, ...))
    end
  end

  local function module_items()
    local items = List()
    local function push_item(v)
      items:append(v)
    end
    push_item({ text = "Overview", link = "/modules/" })
    for _, doc in ipairs(docs) do
      local short = module_short_name(doc.meta)
      if short then
        local label = short == "tbl" and "tbl" or (short:gsub("^%l", string.upper))
        push_item({ text = label, link = "/modules/" .. short })
      end
    end
    return items
  end

  local function emit_items(items)
    push("  items: [")
    for _, item in ipairs(items) do
      push(string.format('    { text: "%s", link: "%s" },', item.text, item.link))
    end
    push("  ],")
  end

  local items = module_items()

  push("export const moduleNav = {")
  push('  text: "Modules",')
  emit_items(items)
  push("};", "")

  push("export const moduleSidebar = {")
  push('  text: "Modules",')
  emit_items(items)
  push("};", "")

  return table.concat(out, "\n")
end

local function iter_files(dir)
  local files = {}
  for file in lfs.dir(dir) do
    if file ~= "." and file ~= ".." and file:match("%.lua$") then
      table.insert(files, dir .. "/" .. file)
    end
  end
  table.sort(files)
  return files
end

local function main()
  local files = iter_files(TYPES_DIR)
  local docs = {}
  local function push_doc(v)
    table.insert(docs, v)
  end
  for _, path in ipairs(files) do
    local doc = parse_types_file(path)
    local short = module_short_name(doc.meta)
    if short and short ~= "mods" then
      local out_path = OUT_DIR .. "/" .. short .. ".md"
      local content = render_module(doc)
      write_file(out_path, content)
      print("wrote", out_path)
      push_doc(doc)
    end
  end

  local index = render_index(docs)
  write_file(INDEX_OUT, index)
  print("wrote", INDEX_OUT)

  local modules_ts = render_modules_ts(docs)
  write_file(MODULES_OUT, modules_ts)
  print("wrote", MODULES_OUT)
end

main()
