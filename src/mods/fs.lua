local mods = require "mods"

local utils = mods.utils
local lfs = mods.utils.lazy_module("lfs") ---@module 'lfs'

local assert_arg = utils.assert_arg

---@type mods.fs
local M = {}

---@param name LuaFileSystem.AttributeName
local function get_attr(p, name)
  local value, err = lfs.attributes(p, name)
  if value == nil then
    return nil, err
  end
  return value
end

function M.getsize(p)
  assert_arg(1, p, "string")
  return get_attr(p, "size")
end

function M.getatime(p)
  assert_arg(1, p, "string")
  return get_attr(p, "access")
end

function M.getmtime(p)
  assert_arg(1, p, "string")
  return get_attr(p, "modification")
end

function M.getctime(p)
  assert_arg(1, p, "string")
  return get_attr(p, "change")
end

function M.samefile(path_a, path_b)
  assert_arg(1, path_a, "string")
  assert_arg(2, path_b, "string")

  local a, b, err

  a, err = M.stat(path_a)
  if not a then
    return nil, err
  end

  b, err = M.stat(path_b)
  if not b then
    return nil, err
  end

  return a.dev == b.dev and a.ino == b.ino
end

function M.stat(p)
  M.stat = lfs.attributes
  return M.stat(p)
end

function M.lstat(p)
  M.lstat = lfs.symlinkattributes
  return M.lstat(p)
end

return M
