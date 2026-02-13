local is = require("mods.is")

local gsub = string.gsub
local sub = string.sub
local find = string.find
local lower = string.lower
local tostring = tostring
local type = type

local is_tmpl, not_tmpl = {}, {}
local is_checks, isnot_checks = {}, {}
local on_fail

---@type mods.validate
---@diagnostic disable-next-line: missing-fields
local M = {
  is = is_checks,
  messages = { positive = is_tmpl, negative = not_tmpl },
}

---
---Smart-quote a string.
---
---Copied from snippets/quote.lua
---
---IMPORTANT: Keep this function in sync with snippets/quote.lua.
---
local function quote(v)
  if find(v, '"', 1, true) and not find(v, "'", 1, true) then
    return "'" .. v .. "'"
  end
  return '"' .. gsub(v, '"', '\\"') .. '"'
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
        return type(v) == "string" and quote(v) or tostring(v)
      end
      return "{{" .. k .. "}}"
    end)
  )

  -- Intentional: only truthy hook returns override the message; nil/false fall back.
  return on_fail and on_fail(msg) or msg
end

--------------------------------------------------------------------------------
---------------------------------- Type checks ---------------------------------
--------------------------------------------------------------------------------

local function type_check(v, tp, is_expected)
  local ok = is[tp](v)
  if (is_expected and ok) or (not is_expected and not ok) then
    return true
  end
  return false, render_msg(tp, type(v), v, is_expected)
end

gsub("boolean function nil number string table thread userdata", "%S+", function(k)
  is_checks[k] = function(v)
    return type_check(v, k, true)
  end
  isnot_checks[k] = function(v)
    return type_check(v, k, false)
  end
end)

--------------------------------------------------------------------------------
--------------------------------- Value checks ---------------------------------
--------------------------------------------------------------------------------

is_tmpl.integer = "expected integer, got {{value}}"
not_tmpl.integer = "expected non-integer, got {{value}}"

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

local value_checks = {
  ["false"] = is.False,
  ["true"] = is.True,
  falsy = is.falsy,
  truthy = is.truthy,
  integer = is.integer,
  callable = is.callable,
}

for k, check in pairs(value_checks) do
  is_checks[k] = function(v)
    return value_check(v, k, check, true)
  end
  isnot_checks[k] = function(v)
    return value_check(v, k, check, false)
  end
end

--------------------------------------------------------------------------------
--------------------------------- Path checks ----------------------------------
--------------------------------------------------------------------------------

is_tmpl.link = "{{value}} is not a valid {{expected}} path"

local function path_check(v, expected_label, check)
  if check(v) then
    return true
  end
  return false, render_msg(expected_label, "invalid path", v, true)
end

for _, k in ipairs({ "block", "char", "device", "dir", "fifo", "file", "socket" }) do
  is_tmpl[k] = "{{value}} is not a valid {{expected}} path"
  is_checks[k] = function(v)
    return path_check(v, k, is[k])
  end
end

is_checks.link = function(v)
  return path_check(v, "link", is.link)
end

--------------------------------------------------------------------------------
-------------------------- Dispatch and alias lookup ---------------------------
--------------------------------------------------------------------------------

---@diagnostic disable-next-line: invisible
M._name, is_checks._name, isnot_checks._name = "is", "is", "isnot"

local function call_validator(self, v, tp)
  tp = tp == nil and "nil" or tp
  local fn = (self._name == "isnot" and isnot_checks or is_checks)[tp]
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

local function strip_prefix(s, prefix)
  if sub(s, 1, #prefix) == prefix then
    return sub(s, #prefix + 1), true
  end
  return s, false
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
    local key = lower(k):gsub("_", "")

    if key == "is" then
      return is_checks
    end

    local v = rawget(is_checks, key)
    if v then
      return v
    end

    key = strip_prefix(key, "is")
    if key == "" then
      return is_checks
    end

    v = rawget(is_checks, key)
    if v then
      return v
    end

    key, v = strip_prefix(key, "not")
    if v then
      return key == "" and isnot_checks or isnot_checks[key]
    end
  end,
})

setmetatable(is_checks, {
  __call = call_validator,
  __index = function(t, k)
    if type(k) ~= "string" then
      return
    end
    local key = lower(k)

    local v = rawget(t, key)
    if v then
      return v
    end

    key = strip_prefix(key, "is")
    return key == "not" and isnot_checks or rawget(t, key)
  end,
})

setmetatable(isnot_checks, {
  __call = call_validator,
  __index = function(t, k)
    if type(k) ~= "string" then
      return nil
    end

    local key = lower(k)
    local v = rawget(t, key)
    if v then
      return v
    end
    return rawget(t, strip_prefix(key, "not"))
  end,
})

if rawget(_G, "_TEST") then
  rawset(M, "quote", quote)
end

return M
