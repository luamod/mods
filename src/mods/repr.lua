local mods = require("mods")

local type = type
local next = next
local concat = table.concat
local sort = table.sort
local rep = string.rep
local tostring = tostring
local gmatch = string.gmatch
local isidentifier = mods.keyword.isidentifier
local quote = mods.utils.quote

local INDENT = "  "
local TYPE_RANK = { n = 0 }
for type_name in gmatch("number string boolean table function userdata thread", "%S+") do
  TYPE_RANK.n = TYPE_RANK.n + 1
  TYPE_RANK[type_name] = TYPE_RANK.n
end

-- Compare keys for deterministic mixed-type ordering.
local function key_less(a, b)
  local ta = type(a)
  local tb = type(b)
  if ta ~= tb then
    return TYPE_RANK[ta] < TYPE_RANK[tb]
  end

  if ta == "number" or ta == "string" then
    return a < b
  elseif ta == "boolean" then
    return (not a) and b
  end

  return tostring(a) < tostring(b)
end

-- Sort entry records in place by their keys.
local function sort_entries(t)
  sort(t, function(a, b)
    return key_less(a.key, b.key)
  end)
end

-- Format a table key using identifier or bracket notation.
local function render_key(k)
  if type(k) == "string" then
    if isidentifier(k) then
      return k
    end
    return "[" .. quote(k) .. "]"
  end
  return "[" .. tostring(k) .. "]"
end

-- Recursively render a Lua value with cycle detection.
local function render(value, depth, seen)
  local vt = type(value)
  if vt == "string" then
    return quote(value)
  elseif vt ~= "table" then
    return tostring(value)
  end

  if seen[value] then
    return "<cycle>"
  end
  seen[value] = true

  if next(value) == nil then
    seen[value] = nil
    return "{}"
  end

  local indent = rep(INDENT, depth - 1)
  local out = {}
  local pad = indent .. INDENT
  local first = true
  local entries = {}
  for k, v in next, value do
    entries[#entries + 1] = { key = k, value = v }
  end
  sort_entries(entries)
  out[#out + 1] = "{\n"

  for i = 1, #entries do
    local entry = entries[i]
    local k = entry.key
    local v = entry.value
    if first then
      first = false
    else
      out[#out + 1] = ",\n"
    end
    out[#out + 1] = pad .. render_key(k) .. " = " .. render(v, depth + 1, seen)
  end

  out[#out + 1] = "\n"
  out[#out + 1] = indent
  out[#out + 1] = "}"
  seen[value] = nil

  return concat(out)
end

local function repr(v)
  return render(v, 1, {})
end

return repr
