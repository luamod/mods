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

return M
