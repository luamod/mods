---@type mods.utils
local M = {}
local find = string.find
local gsub = string.gsub
local match = string.match

local lua_keywords = {}
([[ and break do else elseif end false for function goto if in local
    nil not or repeat return then true until while ]]):gsub("%w+", function(w)
  lua_keywords[w] = true
end)

function M.isidentifier(s)
  return not lua_keywords[s] and match(s, "^[%a_][%w_]*$") ~= nil
end

function M.quote(v)
  if find(v, '"', 1, true) and not find(v, "'", 1, true) then
    return "'" .. v .. "'"
  end
  return '"' .. gsub(v, '"', '\\"') .. '"'
end

return M
