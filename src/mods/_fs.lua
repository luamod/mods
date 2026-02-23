---Internal filesystem helpers built on top of LuaFileSystem.
local M = {}

---Read filesystem attributes using `lfs.attributes`.
---@param path string
---@param field? string
---@return any
---@nodiscard
function M.attributes(path, field)
  return M.lfs.attributes(path, field)
end

---Read symlink-aware attributes using `lfs.symlinkattributes`.
---@param path string
---@param field? string
---@return any
---@nodiscard
function M.symlinkattributes(path, field)
  return M.lfs.symlinkattributes(path, field)
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

return setmetatable(M, {
  __index = function(t, k)
    if k == "lfs" then
      local ok, lfs = pcall(require, "lfs")
      if not ok then
        error("lfs is required for filesystem operations")
      end
      rawset(t, "lfs", lfs)
      return lfs
    end
  end,
})
