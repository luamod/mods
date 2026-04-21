local M = {}

return setmetatable(M, {
  __index = function(t, k)
    local modname = "mods." .. tostring(k)
    local ok, v = pcall(require, modname)
    if not ok then
      error('unknown mods module "' .. tostring(k) .. '"', 2)
    end
    rawset(t, k, v)
    return v
  end,
})
