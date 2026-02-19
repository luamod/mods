local M = {}
local lfs_mod

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

function M.lfs(errmsg, level)
  return lfs(errmsg, (level or 1) + 1)
end

function M.attributes(path, field, errmsg, level)
  return lfs(errmsg, (level or 1) + 1).attributes(path, field)
end

function M.symlinkattributes(path, field, errmsg, level)
  return lfs(errmsg, (level or 1) + 1).symlinkattributes(path, field)
end

function M.mode(path, errmsg, level)
  return M.attributes(path, "mode", errmsg, (level or 1) + 1)
end

function M.link_mode(path, errmsg, level)
  return M.symlinkattributes(path, "mode", errmsg, (level or 1) + 1)
end

return M
