local mods = require "mods"

local concat = table.concat
local find = string.find
local fmt = string.format
local gsub = string.gsub

local ignored_caller_names = {
  pcall = true,
  xpcall = true,
}

local function isidentifier(v)
  isidentifier = mods.keyword.isidentifier
  return isidentifier(v)
end

local function validate(...)
  validate = mods.validate ---@diagnostic disable-line: cast-local-type
  return validate(...)
end

local function caller_name(level)
  local base = (level or 2) + 1
  for i = base, base + 3 do
    local info = debug.getinfo(i, "n")
    local name = info and info.name
    if name and name ~= "" and name ~= "?" and not ignored_caller_names[name] then
      return name
    end
  end
end

---@type mods.utils
local M = {}

function M.quote(v)
  if find(v, '"', 1, true) and not find(v, "'", 1, true) then
    return "'" .. v .. "'"
  end
  return '"' .. gsub(v, '"', '\\"') .. '"'
end

function M.keypath(...)
  local n = select("#", ...)
  if n == 0 then
    return ""
  end

  local res = {}
  for i = 1, n do
    local k = select(i, ...)
    if isidentifier(k) then
      res[#res + 1] = (#res > 0 and "." or "") .. k
    elseif type(k) == "string" then
      res[#res + 1] = "[" .. M.quote(k) .. "]"
    else
      res[#res + 1] = "[" .. tostring(k) .. "]"
    end
  end
  return concat(res)
end

function M.assert_arg(argn, v, tp, lvl, msg)
  local ok, err = validate(v, tp, msg)
  if not ok then
    lvl = lvl or 2
    local message
    local fname = caller_name(lvl)
    if fname then
      message = fmt("bad argument #%d to '%s' (%s)", argn, fname, err)
    else
      message = fmt("bad argument #%d (%s)", argn, err)
    end
    error(message, lvl)
  end
  return v
end

if _TEST then
  ignored_caller_names.callback = true
  ignored_caller_names.has_error = true
end

return M
