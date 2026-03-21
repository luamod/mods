---@type mods.fs
local M = {}

---@type LuaFileSystem
local lfs = {}

setmetatable(lfs, {
  __index = function(_, k)
    local ok, mod = pcall(require, "lfs")
    if not ok then
      error("lfs is required for filesystem operations", 2)
    end
    lfs = mod
    return mod[k]
  end,
})

local lfs_map = {
  stat = "attributes",
  lstat = "symlinkattributes",
  rmdir = "rmdir",
  getcwd = "currentdir",
}

setmetatable(M, {
  __index = function(t, k)
    local lfs_name = lfs_map[k]
    if lfs_name then
      local v = lfs[lfs_name]
      t[k] = v
      return v
    end
  end,
})

return M
