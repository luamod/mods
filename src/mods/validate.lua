local mods = require "mods"

local is = mods.is
local quote = mods.utils.quote
local template = mods.template
local path_checks = is._path_checks:toset()
local lower = string.lower
local fmt = string.format

---@type mods.validate
---@diagnostic disable-next-line: missing-fields
local M = {}

---@type modsValidateMessages
local messages = {}
local validators = {}

M.messages = messages

local function render_msg(expected, got_kind, v, tmpl)
  local vt = type(v)
  v = vt == "string" and quote(v) or tostring(v)

  if not tmpl then
    if vt ~= "string" and path_checks[expected] then
      tmpl = messages.string
      expected = "string"
    else
      expected = tostring(expected)
      tmpl = messages[expected] or "expected {{expected}}, got {{got}}"
    end
  end

  return template(tmpl, {
    expected = expected,
    got = got_kind == "nil" and "no value" or got_kind,
    value = v == "nil" and "no value" or v,
  })
end

function M.register(name, check, template_msg)
  local key = lower(name)

  if template_msg ~= nil then
    messages[key] = template_msg
  end

  local wrapped = function(value, override_msg)
    if check(value) then
      return true
    end
    return false, render_msg(key, type(value), value, override_msg)
  end

  validators[key] = wrapped
  M[key] = wrapped
end

for tp in ("boolean function nil number string table thread userdata"):gmatch("%S+") do
  M.register(tp, is[tp], fmt("expected %s, got {{got}}", tp))
end

for tp in ("false true falsy truthy integer callable"):gmatch("%S+") do
  M.register(tp, is[tp], fmt("expected %s value, got {{value}}", tp))
end

for tp in pairs(path_checks) do
  local expected = tp == "dir" and "directory" or tp
  M.register(tp, is[tp], fmt("{{value}} is not a valid %s path", expected))
end

messages.path = "{{value}} is not a valid path"

return setmetatable(M, {
  __index = function(_, k)
    if type(k) == "string" then
      return validators[lower(k)]
    end
  end,
  __call = function(_, value, check_name, override_msg)
    check_name = check_name or "truthy"

    local validator = validators[check_name]
    if validator then
      return validator(value, override_msg)
    end

    local got_kind = type(value)
    if got_kind == check_name then
      return true
    end
    return false, render_msg(check_name, got_kind, value, override_msg)
  end,
})
