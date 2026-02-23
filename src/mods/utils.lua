local mods = require("mods")

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

return setmetatable(M, {
  __index = function(t, k)
    if k == "repr" then
      local ok, inspect = pcall(require, "inspect")
      local repr = ok and inspect or mods.repr
      rawset(t, k, repr)
      return repr
    end
  end,
})
