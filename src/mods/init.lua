local mods = {}

([[is keyword List operator Set str stringcase
  tbl template utils validate]]):gsub("%S+", function(name)
  mods[name] = "mods." .. name
end)

---@type mods
---@diagnostic disable-next-line: missing-fields
local M = {}

setmetatable(M, {
  __index = function(t, k)
    local mod = mods[k]
    if mod then
      local v = require(mod)
      rawset(t, k, v)
      return v
    end
  end,
})

return M
