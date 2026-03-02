local isidentifier = require("mods.keyword").isidentifier

local concat = table.concat
local find = string.find
local gsub = string.gsub

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

return M
