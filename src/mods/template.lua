local repr = require("mods.repr")

local concat = table.concat
local find = string.find
local gmatch = string.gmatch
local match = string.match
local sub = string.sub
local tostring = tostring
local type = type

local OPEN_TAG = "{{"
local CLOSE_TAG = "}}"
local TAG_LEN = 2

local function lookup(view, name)
  if name == "." then
    return view
  elseif name == "" or find(name, "..", 1, true) or sub(name, 1, 1) == "." or sub(name, -1) == "." then
    return
  elseif find(name, ".", 1, true) then
    for part in gmatch(name, "[^%.]+") do
      if type(view) ~= "table" then
        return
      end
      view = view[part]
      if view == nil then
        return
      end
    end
  else
    if type(view) ~= "table" then
      return
    end
    view = view[name]
  end

  if type(view) == "function" then
    return view()
  end

  return view
end

local function render(tmpl, view)
  if type(tmpl) ~= "string" then
    error("bad argument #1 to 'template' (expected string, got " .. type(tmpl) .. ")", 2)
  end

  if type(view) ~= "table" then
    error("bad argument #2 to 'template' (expected table, got " .. type(view) .. ")", 2)
  end

  local out = {}
  local i = 1

  while true do
    local open = find(tmpl, OPEN_TAG, i, true)
    if not open then
      out[#out + 1] = sub(tmpl, i)
      break
    end

    out[#out + 1] = sub(tmpl, i, open - 1)

    local close = find(tmpl, CLOSE_TAG, open + TAG_LEN, true)
    if not close then
      out[#out + 1] = sub(tmpl, open)
      break
    end

    local content = sub(tmpl, open + TAG_LEN, close - 1)
    local name = match(content, "^%s*(.-)%s*$")
    local v = lookup(view, name)

    if v == nil then
      out[#out + 1] = ""
    elseif type(v) == "table" then
      out[#out + 1] = repr(v)
    else
      out[#out + 1] = tostring(v)
    end
    i = close + TAG_LEN
  end

  return concat(out)
end

return render
