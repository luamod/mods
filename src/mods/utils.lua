local mods = require "mods"

local concat = table.concat
local find = string.find
local fmt = string.format
local getinfo = debug.getinfo
local gsub = string.gsub
local unpack = table.unpack or unpack

---@type mods.utils
local M = {}

local ignored_caller_names = {
  [""] = true,
  ["?"] = true,
  pcall = true,
  xpcall = true,
}

local function inspect(v)
  inspect = require "inspect"
  return inspect(v)
end

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
    local info = getinfo(i, "n")
    local name = info and info.name
    if name and not ignored_caller_names[name] then
      return name
    end
  end
end

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

function M.args_repr(v)
  return inspect(v):gsub("^%s*{%s*(.-)%s*}%s*$", "%1")
end

function M.assert_arg(argn, v, validator, optional, msg)
  local ok, err = validate(v, validator, msg)
  if ok or (optional and v == nil) then
    return v
  end

  local message
  local fname = caller_name(2)
  if fname then
    message = fmt("bad argument #%d to '%s' (%s)", argn, fname, err)
  else
    message = fmt("bad argument #%d (%s)", argn, err)
  end
  error(message, 2)

  return v
end

function M.validate(label, v, validator, optional, msg)
  local ok, err = validate(v, validator, msg)
  if ok or (optional and v == nil) then
    return
  end
  label = type(label) == "table" and M.keypath(unpack(label)) or label
  local message = fmt("%s: %s", label, err)
  error(message, 2)
end

function M.lazy_module(name, err)
  local load_err = err or fmt("failed to load module '%s'", name)
  local mt = {}

  local function load()
    local ok, mod = pcall(require, name)
    if not ok then
      error(load_err, 3)
    end
    mt.__index = mod
    mt.__newindex = mod
    mt.__call = getmetatable(mod) and getmetatable(mod).__call or nil

    return mod
  end

  mt.__index = function(_, k)
    return load()[k]
  end

  mt.__newindex = function(_, k, v)
    load()[k] = v
  end

  mt.__call = function(_, ...)
    return load()(...)
  end

  return setmetatable({}, mt)
end

if _TEST then
  ignored_caller_names.callback = true
  ignored_caller_names.has_error = true
end

return M
