local gsub = string.gsub
local sub = string.sub
local match = string.match
local lower = string.lower
local getmt = getmetatable
local tostring = tostring
local type = type

local is_tmpl, not_tmpl = {}, {}
local is, isnot = {}, {}
local on_fail

---@type mods.validate
---@diagnostic disable-next-line: missing-fields
local M = {
  is = is,
  messages = { positive = is_tmpl, negative = not_tmpl },
}

local function quote(s)
  if type(s) ~= "string" then
    return tostring(s)
  end
  if match(s, '"') and not match(s, "'") then
    return "'" .. s .. "'"
  end
  return '"' .. gsub(s, '"', '\\"') .. '"'
end

local function render_msg(expected, actual, v, is_expected)
  local tmpl
  if is_expected then
    tmpl = is_tmpl[expected] or "expected {{expected}}, got {{got}}"
  else
    tmpl = not_tmpl[expected] or "expected not {{expected}}"
  end
  local msg = (
    gsub(tmpl, "{{(.-)}}", function(k)
      if k == "expected" then
        return tostring(expected)
      elseif k == "got" then
        return actual
      elseif k == "value" then
        return quote(v)
      end
      return "{{" .. k .. "}}"
    end)
  )
  return on_fail and on_fail(msg) or msg
end

-------------------
--- Type checks ---
-------------------

local function type_check(v, tp, is_expected)
  local actual = type(v)
  if is_expected then
    if actual == tp then
      return true
    end
  elseif actual ~= tp then
    return true
  end
  return false, render_msg(tp, actual, v, is_expected)
end

gsub("boolean function nil number string table thread userdata", "%S+", function(k)
  is[k] = function(v)
    return type_check(v, k, true)
  end
  isnot[k] = function(v)
    return type_check(v, k, false)
  end
end)

--------------------
--- Value checks ---
--------------------

local function value_check(v, expected, check, is_expected)
  if is_expected then
    if check(v) then
      return true
    end
  elseif not check(v) then
    return true
  end

  local actual
  if expected == "false" or expected == "true" then
    actual = tostring(v)
  else
    actual = type(v)
  end

  return false, render_msg(expected, actual, v, is_expected)
end

-- stylua: ignore
local value_checks = {
  ["false"] = function(v) return v == false end,
  ["true"] = function(v) return v == true end,
  falsy = function(v) return not v end,
  truthy = function(v) return not not v end,
  integer = function(v) return type(v) == "number" and v % 1 == 0 end,
  callable = function(v)
    if type(v) == "function" then return true end
    local mt = getmt(v)
    return mt and type(mt.__call) == "function" or false
  end,
}

for k, check in pairs(value_checks) do
  is[k] = function(v)
    return value_check(v, k, check, true)
  end
  isnot[k] = function(v)
    return value_check(v, k, check, false)
  end
end

-------------------
--- Path checks ---
-------------------

local lfs

local function require_lfs()
  if lfs then
    return lfs
  end
  local ok, mod = pcall(require, "lfs")
  if not ok then
    error("lfs is required for path-type checks", 2)
  end
  lfs = mod
  return lfs
end

local function attrs(...)
  local mod = require_lfs()
  attrs = mod.attributes
  return attrs(...)
end

local function symlinkattrs(...)
  local mod = require_lfs()
  symlinkattrs = mod.symlinkattributes
  return symlinkattrs(...)
end

local function path_check(v, expected_label, want_mode, use_symlink)
  if type(v) ~= "string" then
    return false, render_msg(expected_label, type(v), v, true)
  end
  local mode, err
  if use_symlink then
    mode, err = symlinkattrs(v, "mode")
  else
    mode, err = attrs(v, "mode")
  end
  if not mode then
    return false, err or ("expected " .. expected_label)
  end

  local ok
  if want_mode then
    ok = mode == want_mode
  else
    ok = mode == "char device" or mode == "block device"
  end

  if ok then
    return true
  end
  return false, render_msg(expected_label, mode, v, true)
end

local path_checks = {
  block = { want_mode = "block device", use_symlink = false },
  char = { want_mode = "char device", use_symlink = false },
  device = { want_mode = nil, use_symlink = false },
  dir = { want_mode = "directory", use_symlink = false },
  fifo = { want_mode = "named pipe", use_symlink = false },
  file = { want_mode = "file", use_symlink = false },
  link = { want_mode = "link", use_symlink = true },
  socket = { want_mode = "socket", use_symlink = false },
}

for k, rule in pairs(path_checks) do
  local want_mode, use_symlink = rule.want_mode, rule.use_symlink
  is[k] = function(v)
    return path_check(v, k, want_mode, use_symlink)
  end
end

--------------------------------------------------------------------------------

---@diagnostic disable-next-line: invisible
M._name, is._name, isnot._name = "is", "is", "isnot"
is_tmpl.integer = "expected integer number, got {{value}}"
not_tmpl.integer = "expected not integer number, got {{value}}"

local function call_validator(self, v, tp)
  tp = tp == nil and "nil" or tp
  local fn = (self._name == "isnot" and isnot or is)[tp]
  if fn then
    return fn(v)
  end
  local actual = type(v)
  if self._name == "isnot" then
    if actual ~= tp then
      return true
    end
  elseif actual == tp then
    return true
  end
  return false, render_msg(tostring(tp), actual, v, self._name == "is")
end

setmetatable(M, {
  __call = call_validator,
  __newindex = function(t, k, v)
    if k == "on_fail" then
      if v ~= nil and type(v) ~= "function" then
        error("validate.on_fail must be a function", 2)
      end
      on_fail = v
      return
    end
    rawset(t, k, v)
  end,
  __index = function(_, k)
    if type(k) ~= "string" then
      return nil
    end
    if k == "on_fail" then
      return on_fail
    end
    k = lower(k):gsub("_", ""):gsub("is", "")

    if k == "" then
      return is
    end
    local v = is[k]
    if v then
      return v
    end

    if sub(k, 1, 3) == "not" then
      return k == "not" and isnot or isnot[k]
    end
  end,
})

setmetatable(is, {
  __call = call_validator,
  __index = function(t, k)
    if type(k) ~= "string" then
      return
    end
    return lower(k) == "not" and isnot or rawget(t, lower(gsub(k, "is", "")))
  end,
})

setmetatable(isnot, {
  __call = call_validator,
  __index = function(t, k)
    return type(k) == "string" and rawget(t, lower(gsub(k, "not", ""))) or nil
  end,
})

if rawget(_G, "_TEST") then
  rawset(M, "quote", quote)
end

return M
