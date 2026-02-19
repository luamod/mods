---@meta mods._fs

---Internal filesystem helpers built on top of LuaFileSystem.
---@class mods._fs
local M = {}
local lfs_mod

---Load and cache the `lfs` module.
---@param errmsg? string
---@param level? integer
---@return table
---@nodiscard
local function lfs(errmsg, level)
  if lfs_mod then
    return lfs_mod
  end
  local ok, mod = pcall(require, "lfs")
  if not ok then
    error(errmsg or "lfs is required for filesystem operations", (level or 1) + 1)
  end
  lfs_mod = mod
  return mod
end

---Return the cached LuaFileSystem module.
---@param errmsg? string
---@param level? integer
---@return table
---@nodiscard
function M.lfs(errmsg, level)
  return lfs(errmsg, (level or 1) + 1)
end

---Read filesystem attributes using `lfs.attributes`.
---@param path string
---@param field? string
---@param errmsg? string
---@param level? integer
---@return any
---@nodiscard
function M.attributes(path, field, errmsg, level)
  return lfs(errmsg, (level or 1) + 1).attributes(path, field)
end

---Read symlink-aware attributes using `lfs.symlinkattributes`.
---@param path string
---@param field? string
---@param errmsg? string
---@param level? integer
---@return any
---@nodiscard
function M.symlinkattributes(path, field, errmsg, level)
  return lfs(errmsg, (level or 1) + 1).symlinkattributes(path, field)
end

---Get the filesystem mode for a path.
---@param path string
---@param errmsg? string
---@param level? integer
---@return string|nil
---@nodiscard
function M.mode(path, errmsg, level)
  return M.attributes(path, "mode", errmsg, (level or 1) + 1)
end

---Get the symlink mode for a path without resolving links.
---@param path string
---@param errmsg? string
---@param level? integer
---@return string|nil
---@nodiscard
function M.link_mode(path, errmsg, level)
  return M.symlinkattributes(path, "mode", errmsg, (level or 1) + 1)
end

return M
