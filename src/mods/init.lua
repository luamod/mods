local mods = {}

local module_names = {
  "fs",
  "glob",
  "is",
  "keyword",
  "List",
  "log",
  "ntpath",
  "operator",
  "path",
  "posixpath",
  "repr",
  "runtime",
  "Set",
  "str",
  "stringcase",
  "tbl",
  "template",
  "utils",
  "validate",
}

for i = 1, #module_names do
  local name = module_names[i]
  mods[name] = "mods." .. name
end

local M = {}

if _TEST then
  M._module_name = module_names
end

return setmetatable(M, {
  __index = function(t, k)
    local mod = mods[k]
    if mod then
      local v = require(mod)
      rawset(t, k, v)
      return v
    end
  end,
})
