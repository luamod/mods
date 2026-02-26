local concat = table.concat
local find = string.find
local gmatch = string.gmatch
local match = string.match
local sub = string.sub
local tostring = tostring
local type = type

local function lookup(view, name)
  local dot = find(name, ".", 1, true)
  if not dot then
    if type(view) ~= "table" then
      return
    end
    view = view[name]
  else
    for part in gmatch(name, "[^%.]+") do
      if type(view) ~= "table" then
        return
      end
      view = view[part]
      if view == nil then
        return
      end
    end
  end
  return type(view) == "function" and view() or view
end

local function render(template, view)
  local out = {}
  local i = 1
  view = view or {}

  while true do
    local open = find(template, "{{", i, true)
    if not open then
      out[#out + 1] = sub(template, i)
      break
    end

    out[#out + 1] = sub(template, i, open - 1)

    local open_len = 2
    local close = find(template, "}}", open + open_len, true)
    if not close then
      out[#out + 1] = sub(template, open)
      break
    end

    local content = sub(template, open + open_len, close - 1)
    local name = match(content, "^%s*(.-)%s*$")
    local v = lookup(view, name)

    out[#out + 1] = v == nil and "" or tostring(v)
    i = close + open_len
  end

  return concat(out)
end

return render
