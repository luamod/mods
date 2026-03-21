local mods = require "mods"

local utils = mods.utils
local lfs = mods.utils.lazy_module("lfs") ---@module 'lfs'

local assert_arg = utils.assert_arg

local open = io.open
local rename = os.rename

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

local function write(p, data, mode)
  local f, err = open(p, mode)
  if not f then
    return false, err
  end

  local ok, write_err = f:write(data)
  f:close()
  if not ok then
    return false, write_err
  end

  return true
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

function M.exists(p)
  assert_arg(1, p, "string")
  return lfs.attributes(p, "mode") ~= nil
end

function M.lexists(p)
  assert_arg(1, p, "string")
  return lfs.symlinkattributes(p, "mode") ~= nil
end

function M.write_bytes(p, data)
  assert_arg(1, p, "string")
  assert_arg(2, data, "string")
  return write(p, data, "wb")
end

function M.write_text(p, data)
  assert_arg(1, p, "string")
  assert_arg(2, data, "string")
  return write(p, data, "w")
end

M.rename = rename

return M
