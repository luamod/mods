---@meta mods._fs

---Internal filesystem helpers built on top of LuaFileSystem.
---@class mods._fs
local M = {}
local lfs_mod

---Load and cache the `lfs` module.
---@return table
---@nodiscard
local function lfs()
  if lfs_mod then
    return lfs_mod
  end
  local ok, mod = pcall(require, "lfs")
  if not ok then
    error("lfs is required for filesystem operations")
  end
  lfs_mod = mod
  return mod
end

---Return the cached LuaFileSystem module.
---@return table
---@nodiscard
function M.lfs()
  return lfs()
end

---Read filesystem attributes using `lfs.attributes`.
---@param path string
---@param field? string
---@return any
---@nodiscard
function M.attributes(path, field)
  return lfs().attributes(path, field)
end

---Read symlink-aware attributes using `lfs.symlinkattributes`.
---@param path string
---@param field? string
---@return any
---@nodiscard
function M.symlinkattributes(path, field)
  return lfs().symlinkattributes(path, field)
end

---Get the filesystem mode for a path.
---@param path string
---@return string|nil
---@nodiscard
function M.mode(path)
  return M.attributes(path, "mode")
end

---Get the symlink mode for a path without resolving links.
---@param path string
---@return string|nil
---@nodiscard
function M.link_mode(path)
  return M.symlinkattributes(path, "mode")
end

return M
