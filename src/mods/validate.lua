local gsub = string.gsub
local match = string.match
local getmt = getmetatable
local tostring = tostring
local type = type

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

local is_tmpl, not_tmpl = {}, {}
local is, is_not = {}, {}
local not_aliases = { "not", "isnot", "is_not", "Not", "isNot" }

---@type mods.validate
---@diagnostic disable-next-line: missing-fields
local M = { is = is, messages = { is = is_tmpl } }

for _, alias in ipairs(not_aliases) do
  M[alias] = is_not
  M.messages[alias] = not_tmpl
end

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
  return (
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

gsub("Boolean Function Nil Number String Table Thread Userdata", "%S+", function(key)
  local tp = key:lower()
  is[key] = function(v)
    return type_check(v, tp, true)
  end
  is_not[key] = function(v)
    return type_check(v, tp, false)
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
  False = function(v) return v == false end,
  True = function(v) return v == true end,
  Falsy = function(v) return not v end,
  Truthy = function(v) return not not v end,
  Integer = function(v) return type(v) == "number" and v % 1 == 0 end,
  Callable = function(v)
    if type(v) == "function" then return true end
    local mt = getmt(v)
    return mt and type(mt.__call) == "function" or false
  end,
}

for k, check in pairs(value_checks) do
  is[k] = function(v)
    return value_check(v, k:lower(), check, true)
  end
  is_not[k] = function(v)
    return value_check(v, k:lower(), check, false)
  end
end

-------------------
--- Path checks ---
-------------------

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
  Block = { want_mode = "block device", use_symlink = false },
  Char = { want_mode = "char device", use_symlink = false },
  Device = { want_mode = nil, use_symlink = false },
  Dir = { want_mode = "directory", use_symlink = false },
  Fifo = { want_mode = "named pipe", use_symlink = false },
  File = { want_mode = "file", use_symlink = false },
  Link = { want_mode = "link", use_symlink = true },
  Socket = { want_mode = "socket", use_symlink = false },
}

for k, rule in pairs(path_checks) do
  local expected = k:lower()
  local want_mode, use_symlink = rule.want_mode, rule.use_symlink
  is[k] = function(v)
    return path_check(v, expected, want_mode, use_symlink)
  end
end

--------------------------------------------------------------------------------

local function snapshot_aliases(src)
  local copy = {}
  for k, v in pairs(src) do
    copy[k] = v
  end
  return copy
end

local function add_prefixed_aliases(dst, key, lower, v, prefixes)
  for i = 1, #prefixes do
    local prefix = prefixes[i]
    dst[prefix .. key] = v
    dst[prefix .. "_" .. key] = v
    dst[prefix .. lower] = v
    dst[prefix .. "_" .. lower] = v
  end
end

local is_entries = snapshot_aliases(is)
local is_not_entries = snapshot_aliases(is_not)
for k, v in pairs(is_entries) do
  local lower = k:lower()
  add_prefixed_aliases(M, k, lower, v, { "is_" })
  M.is[lower] = v
end
for k, v in pairs(is_not_entries) do
  local lower = k:lower()
  add_prefixed_aliases(M, k, lower, v, not_aliases)
  M.is_not[lower] = v
end

local function call_validator(self, v, tp)
  local fn = (self.name == "is_not" and is_not or is)[tp]
  if fn then
    return fn(v)
  end
  local actual = type(v)
  if self.name == "is_not" then
    if actual ~= tp then
      return true
    end
  elseif actual == tp then
    return true
  end
  return false, render_msg(tostring(tp), actual, v, self.name == "is")
end

setmetatable(M, { __call = call_validator, __index = is })
setmetatable(is, { __call = call_validator, __index = { name = "is" } })
setmetatable(is_not, { __call = call_validator, __index = { name = "is_not" } })

if rawget(_G, "_TEST") then
  rawset(M, "quote", quote)
end

return M
