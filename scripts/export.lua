------------------------------------------------------------
--- 💡 This script was originally created manually and later
---    updated with AI assistance.
------------------------------------------------------------

local concat = table.concat
local fmt = string.format
local insert = table.insert
local FIELD_OVERVIEW_MIN = 4
local is_function_doc_item

local function first_match(items, pred)
  for _, item in ipairs(items or {}) do
    if pred(item) then
      return item
    end
  end
end

---Prefer meta shortname as module title.
local function pick_module_name(items)
  local item = first_match(items, function(it)
    return it.kind == "meta" and it.shortname
  end)
  return item and item.shortname or "module"
end

---Use class description as module desc.
local function pick_module_desc(items)
  local class_item = first_match(items, function(it)
    return it.kind == "class" and it.desc
  end)
  if class_item then
    return class_item.desc
  end

  local item_with_desc = first_match(items, function(it)
    return it.desc
  end)
  return item_with_desc and item_with_desc.desc
end

local function has_function_items(items)
  return first_match(items, function(it)
    return it.kind == "function" or is_function_doc_item(it)
  end) ~= nil
end

local function collect_include_paths(items)
  local out = {}
  local seen = {}
  for _, item in ipairs(items or {}) do
    local tags = item and item.tags
    local includes = tags and tags.includes
    if type(includes) == "table" then
      for _, path in ipairs(includes) do
        if type(path) == "string" and path ~= "" and not seen[path] then
          seen[path] = true
          insert(out, path)
        end
      end
    end
  end
  return out
end

local function collect_include_blocks(items)
  local out = {}
  for _, item in ipairs(items or {}) do
    local tags = item and item.tags
    local blocks = tags and tags.include_blocks
    if type(blocks) == "table" then
      for _, block in ipairs(blocks) do
        if type(block) == "string" and block ~= "" then
          insert(out, block)
        end
      end
    end
  end
  return out
end

local function read_text_file(path)
  local f = io.open(path, "rb")
  if not f then
    return nil
  end
  local content = f:read("*a")
  f:close()
  return content
end

local function count_function_items(items)
  local n = 0
  for _, item in ipairs(items or {}) do
    if item and (item.kind == "function" or is_function_doc_item(item)) then
      n = n + 1
    end
  end
  return n
end

local function collect_class_fields(items)
  local out = {}
  local seen = {}
  for _, item in ipairs(items or {}) do
    if item and item.kind == "class" then
      local tags = item.tags
      local fields = tags and tags.fields
      if type(fields) == "table" then
        for _, field in ipairs(fields) do
          local name = field and field.name
          local desc = (field and field.desc or ""):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
          if name and desc ~= "" and not seen[name] then
            seen[name] = true
            insert(out, field)
          end
        end
      end
    end
  end
  return out
end

---Extract one-sentence short description from a longer description.
local function first_sentence(s)
  if not s then
    return nil
  end
  local flattened = s:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
  if flattened == "" then
    return nil
  end
  local period = flattened:find("%.")
  if period then
    return flattened:sub(1, period)
  end
  return flattened
end

---Render YAML frontmatter for page description.
local function render_frontmatter(desc)
  local short_desc = first_sentence(desc)
  if not short_desc then
    return nil
  end
  return fmt('---\ndescription: "%s"\n---', short_desc:gsub('"', '\\"'))
end

---Extract and flatten the first paragraph from a longer description.
local function first_paragraph(s)
  if not s then
    return ""
  end
  local para = s:match("^(.-)\n%s*\n") or s
  return para:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
end

---Keep markdown table cells valid by flattening line breaks and escaping pipes.
local function esc_table_cell(s)
  return (s or ""):gsub("\n", " "):gsub("|", "\\|")
end

---Build hash links that match markdown heading anchors.
local function heading_anchor(s)
  return (s or ""):lower():gsub("_+", "-"):gsub("[^%w-]+", ""):gsub("^%-+", ""):gsub("%-+$", "")
end

local function function_signature(item)
  local base = item.shortname or item.name or ""
  if item.kind == "alias" then
    return base
  end
  local params = {}
  local tag_params = item.tags and item.tags.params
  if type(tag_params) == "table" then
    for _, param in ipairs(tag_params) do
      local name = param and param.name
      if name and name ~= "" and name ~= "self" then
        insert(params, name)
      end
    end
  end
  if #params == 0 then
    return base .. "()"
  end
  return base .. "(" .. concat(params, ", ") .. ")"
end

local function function_ref_id(item)
  return "fn-" .. heading_anchor(item.shortname or item.name or "")
end

local function trim(s)
  return ((s or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function sanitize_alias_part(part)
  local p = trim(part)
  local dq, dq_rest = p:match('^("[^"]*")%s*(.*)$')
  if dq then
    return dq, trim(dq_rest or "")
  end
  local sq, sq_rest = p:match([[^('[^']*')%s*(.*)$]])
  if sq then
    return sq, trim(sq_rest or "")
  end
  return p, ""
end

local function alias_view_to_string(view)
  if type(view) == "table" then
    local out = {}
    local alias_desc = nil
    for _, part in ipairs(view) do
      local p, extra = sanitize_alias_part(tostring(part))
      if p ~= "" then
        insert(out, p)
      end
      if extra ~= "" and not alias_desc then
        alias_desc = extra
      end
    end
    return concat(out, "|"), alias_desc
  end
  return trim(tostring(view or "")), nil
end

local function collect_alias_views(items)
  local out = {}
  for _, item in ipairs(items or {}) do
    if item and item.kind == "alias" and item.view ~= nil then
      local expanded, alias_desc = alias_view_to_string(item.view)
      if expanded ~= "" then
        local data = { view = expanded, desc = alias_desc }
        if type(item.name) == "string" and item.name ~= "" then
          out[item.name] = data
        end
        if type(item.shortname) == "string" and item.shortname ~= "" then
          out[item.shortname] = data
        end
      end
    end
  end
  return out
end

local function expand_type_view(view, alias_views, seen)
  local v = trim(tostring(view or ""))
  if v == "" then
    return "any", nil
  end
  local mapped = alias_views and alias_views[v]
  if not mapped then
    return v, nil
  end
  seen = seen or {}
  if seen[v] then
    return v, mapped.desc
  end
  seen[v] = true
  local out, nested_desc = expand_type_view(mapped.view, alias_views, seen)
  seen[v] = nil
  return out, mapped.desc or nested_desc
end

---Turn inline code refs like `mods.path` into markdown links.
local function linkify_mods_refs(s)
  if not s or s == "" then
    return s or ""
  end
  s = s:gsub("`(mods%.([%a_][%w_]*)%.([%a_][%w_]*))`", function(ref, module_name, member_name)
    local anchor = heading_anchor(member_name)
    return fmt("[`%s`](/modules/%s#fn-%s)", ref, module_name:lower(), anchor)
  end)
  return (
    s:gsub("`(mods%.[%a_][%w_]*)`", function(ref)
      local module_name = ref:match("^mods%.([%a_][%w_]*)$")
      if not module_name then
        return "`" .. ref .. "`"
      end
      return fmt("[`%s`](/modules/%s)", ref, module_name:lower())
    end)
  )
end

local function normalize_api_desc(desc)
  local d = trim(desc or "")
  d = d:gsub("^#%s*", "")
  return linkify_mods_refs(d)
end

local function append_function_api_contract(doc, item, alias_views)
  local tags = item.tags or {}
  local params = tags.params or {}
  local returns = tags.returns or {}
  local has_params = false
  local has_returns = false

  for _, param in ipairs(params) do
    local pname = param and param.name or ""
    if pname ~= "" and pname ~= "self" then
      has_params = true
      break
    end
  end
  has_returns = #returns > 0

  if not has_params and not has_returns then
    return
  end

  if has_params then
    insert(doc, "**Parameters**:")
    for _, param in ipairs(params) do
      local pname = param and param.name or ""
      local pview, alias_desc = expand_type_view(param and param.view or "any", alias_views)
      local pdesc = normalize_api_desc(param and param.desc or "")
      if pdesc == "" and alias_desc and alias_desc ~= "" then
        pdesc = normalize_api_desc(alias_desc)
      end
      if pname ~= "" and pname ~= "self" then
        if pdesc ~= "" then
          insert(doc, fmt("- `%s` (`%s`): %s", pname, pview, pdesc))
        else
          insert(doc, fmt("- `%s` (`%s`)", pname, pview))
        end
      end
    end
  end

  if has_returns then
    insert(doc, "")
    insert(doc, "**Return**:")
    for _, ret in ipairs(returns) do
      local rname = ret and ret.name or ""
      local rview, alias_desc = expand_type_view(ret and ret.view or "any", alias_views)
      local rdesc = normalize_api_desc(ret and ret.desc or "")
      if rdesc == "" and alias_desc and alias_desc ~= "" then
        rdesc = normalize_api_desc(alias_desc)
      end
      local label = rname ~= "" and ("`" .. rname .. "`") or "**value**"
      if rdesc ~= "" then
        insert(doc, fmt("- %s (`%s`): %s", label, rview, rdesc))
      else
        insert(doc, fmt("- %s (`%s`)", label, rview))
      end
    end
  end

  insert(doc, "")
end

local function append_function_signature_details(doc, item, alias_views)
  local desc = item.desc or ""
  local before, code, after = desc:match("^(.-)```lua[^\n]*\n(.-)\n```(.*)$")

  if code then
    local pre = trim(before or "")
    if pre ~= "" then
      insert(doc, linkify_mods_refs(pre))
      insert(doc, "")
    end
  else
    if desc ~= "" then
      insert(doc, linkify_mods_refs(desc))
    end
  end

  append_function_api_contract(doc, item, alias_views)

  if code then
    insert(doc, "**Example**:")
    insert(doc, "```lua")
    insert(doc, trim(code))
    insert(doc, "```")
    local post = trim(after or "")
    if post ~= "" then
      insert(doc, "")
      insert(doc, linkify_mods_refs(post))
    end
    insert(doc, "")
  end
end

---Append a quick reference markdown table for function rows.
local function append_quick_ref_table(doc, rows)
  if not rows or #rows == 0 then
    return
  end

  insert(doc, "Function | Description")
  insert(doc, "---- | ----")
  for _, row in ipairs(rows) do
    local label
    if row.anchor and row.anchor ~= "" then
      label = fmt("[`%s`](#%s)", esc_table_cell(row.signature), row.anchor)
    else
      label = fmt("`%s`", esc_table_cell(row.signature))
    end
    insert(doc, fmt("%s | %s", label, esc_table_cell(row.desc)))
  end
end

local function append_fields_table(doc, fields, alias_views)
  if not fields or #fields == 0 then
    return
  end

  insert(doc, "Field | Description")
  insert(doc, "---- | ----")
  for _, field in ipairs(fields) do
    local name = field.name or ""
    local anchor = heading_anchor(name)
    local link = fmt("[`%s`](#%s)", esc_table_cell(name), anchor)
    local fview = field and field.view or "any"
    local _, alias_desc = expand_type_view(fview, alias_views)
    local desc = esc_table_cell(first_paragraph(linkify_mods_refs(field.desc)))
    if desc == "" and alias_desc and alias_desc ~= "" then
      desc = esc_table_cell(first_paragraph(linkify_mods_refs(alias_desc)))
    end
    insert(doc, fmt("%s | %s", link, desc))
  end
end

is_function_doc_item = function(item)
  if not item or item.kind ~= "alias" then
    return false
  end
  if type(item.name) ~= "string" or not item.name:match("^M%.[%a_][%w_]*$") then
    return false
  end
  if type(item.alias_of) == "string" and item.alias_of:match("^M%.[%a_][%w_]*$") then
    -- Ignore case-only aliases like M.Boolean = M.boolean in docs function list.
    if item.name:lower() == item.alias_of:lower() then
      return false
    end
  end
  return true
end

---Check whether any item has a `section` field in tags.
local function has_section_field(items)
  for _, item in ipairs(items or {}) do
    if item and item.kind == "section" then
      return true
    end
    local tags = item and item.tags
    local fields = tags and tags.fields
    if type(fields) == "table" then
      for _, field in ipairs(fields) do
        if field and field.name == "section" then
          return true
        end
      end
    end
  end
  return false
end

---Build full markdown output: frontmatter, quick reference, and details.
---@param items annot.item[]
---@return string
local function build_markdown(items)
  local module_name = pick_module_name(items)
  local module_desc = pick_module_desc(items)
  local fields = collect_class_fields(items)
  local has_functions = has_function_items(items)
  local total_functions = count_function_items(items)
  local has_functions_header = has_functions and total_functions > 1
  local include_paths = collect_include_paths(items)
  local include_blocks = collect_include_blocks(items)
  local frontmatter = render_frontmatter(module_desc)
  local section_fields = has_section_field(items)
  local alias_views = collect_alias_views(items)
  local function_heading_level
  if section_fields then
    function_heading_level = "####"
  elseif has_functions_header then
    function_heading_level = "###"
  else
    function_heading_level = "##"
  end
  local quick_ref = {}
  local quick_ref_sections = {}
  local section_order = {}
  local seen_sections = {}
  local current_section = nil
  local function_count = 0
  local details = {}
  local doc = {}
  if frontmatter then
    insert(doc, frontmatter)
  end
  insert(doc, fmt("# `%s`", module_name))
  if module_desc then
    insert(doc, linkify_mods_refs(module_desc))
  end

  if not has_functions and #fields == 0 then
    for _, path in ipairs(include_paths) do
      local content = read_text_file(path)
      if content and content ~= "" then
        insert(doc, content)
      end
    end
    for _, block in ipairs(include_blocks) do
      insert(doc, block)
    end
    return concat(doc, "\n")
  end

  if has_functions_header then
    insert(doc, "## Functions")
  end

  for _, item in ipairs(items) do
    if has_functions and item.kind == "section" then
      current_section = item.name or "Section"
      if not seen_sections[current_section] then
        insert(section_order, current_section)
        seen_sections[current_section] = true
      end
      insert(details, fmt("### %s", current_section))
      if item.desc then
        insert(details, linkify_mods_refs(item.desc))
      end
    elseif has_functions and (item.kind == "function" or is_function_doc_item(item)) then
      local alias_doc_item = is_function_doc_item(item)
      function_count = function_count + 1
      local signature = function_signature(item)
      local ref_id = function_ref_id(item)
      local row_anchor = ref_id
      if alias_doc_item then
        row_anchor = nil
      end
      local row = {
        signature = signature,
        anchor = row_anchor,
        desc = first_paragraph(linkify_mods_refs(item.desc)),
      }
      if section_fields then
        local section_name = current_section or "Ungrouped"
        if not quick_ref_sections[section_name] then
          quick_ref_sections[section_name] = {}
        end
        if not seen_sections[section_name] then
          insert(section_order, section_name)
          seen_sections[section_name] = true
        end
        insert(quick_ref_sections[section_name], row)
      else
        insert(quick_ref, row)
      end

      if not alias_doc_item then
        insert(details, fmt('<a id="%s"></a>', ref_id))
        insert(details, fmt("%s `%s`", function_heading_level, signature))
        append_function_signature_details(details, item, alias_views)
      end
    end
  end

  -- Show quick reference only for larger modules.
  if has_functions and function_count > 3 then
    if section_fields then
      for _, section_name in ipairs(section_order) do
        local rows = quick_ref_sections[section_name]
        if rows and #rows > 0 then
          insert(doc, fmt("\n**%s**:\n", section_name))
          append_quick_ref_table(doc, rows)
        end
      end
    else
      append_quick_ref_table(doc, quick_ref)
    end
  end

  for _, line in ipairs(details) do
    insert(doc, line)
  end

  if #fields > 0 then
    insert(doc, "## Fields")
    if #fields >= FIELD_OVERVIEW_MIN then
      append_fields_table(doc, fields, alias_views)
    end
    for _, field in ipairs(fields) do
      insert(doc, "")
      local fview = field and field.view
      local heading = fmt("### `%s`", field.name or "")
      if fview and fview ~= "" then
        local expanded, alias_desc = expand_type_view(fview, alias_views)
        heading = fmt("### `%s` (`%s`)", field.name or "", expanded)
        insert(doc, heading)
        if (not field.desc or field.desc == "") and alias_desc and alias_desc ~= "" then
          insert(doc, "")
          insert(doc, linkify_mods_refs(alias_desc))
        end
      else
        insert(doc, heading)
      end
      if field.desc then
        insert(doc, "")
        insert(doc, linkify_mods_refs(field.desc))
      end
    end
  end

  for _, path in ipairs(include_paths) do
    local content = read_text_file(path)
    if content and content ~= "" then
      insert(doc, content)
    end
  end

  for _, block in ipairs(include_blocks) do
    insert(doc, block)
  end

  return concat(doc, "\n")
end

return build_markdown
