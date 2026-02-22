local concat = table.concat
local fmt = string.format
local insert = table.insert

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
    return it.kind == "function"
  end) ~= nil
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
  return fmt('---\ndesc: "%s"\n---', short_desc:gsub('"', '\\"'))
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

---Append a quick reference markdown table for function rows.
local function append_quick_ref_table(doc, rows)
  if not rows or #rows == 0 then
    return
  end

  insert(doc, "Function | Description")
  insert(doc, "---- | ----")
  for _, row in ipairs(rows) do
    local anchor = heading_anchor(row.shortname)
    local link = fmt("[`%s`](#%s)", esc_table_cell(row.shortname), anchor)
    insert(doc, fmt("%s | %s", link, esc_table_cell(row.desc)))
  end
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
  local frontmatter = render_frontmatter(module_desc)
  local section_fields = has_section_field(items)
  local function_heading_level = section_fields and "####" or "###"
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
    insert(doc, module_desc)
  end

  if module_name == "template" then
    return concat(doc, "\n")
  end

  if not has_function_items(items) then
    return concat(doc, "\n")
  end

  insert(doc, "## Functions")

  for _, item in ipairs(items) do
    if item.kind == "section" then
      current_section = item.name or "Section"
      if not seen_sections[current_section] then
        insert(section_order, current_section)
        seen_sections[current_section] = true
      end
      insert(details, fmt("### %s", current_section))
      if item.desc then
        insert(details, item.desc)
      end
    elseif item.kind == "function" then
      function_count = function_count + 1
      local row = {
        shortname = item.shortname or "",
        desc = first_paragraph(item.desc),
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

      insert(details, fmt("%s `%s`", function_heading_level, item.shortname))
      if item.desc then
        insert(details, item.desc)
      end
    end
  end

  -- Show quick reference only for larger modules.
  if function_count > 3 then
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

  return concat(doc, "\n")
end

return build_markdown
