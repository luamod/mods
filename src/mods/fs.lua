local mods = require "mods"

local is = mods.is
local path = mods.path
local utils = mods.utils
local lfs = mods.utils.lazy_module("lfs") ---@module "lfs"

local assert_arg = utils.assert_arg
local isdir = is.dir
local islink = is.link
local join = path.join

local open = io.open
local remove = os.remove
local rename = os.rename

---@type mods.fs
local M = {}

local CURDIR = "."
local PARDIR = ".."

local function is_dir_marker(entry)
  return entry == CURDIR or entry == PARDIR
end

-- `lfs.dir` throws on failure, so use `pcall` to preserve its error text as `false, err`.
local function open_dir(p)
  local ok, iter, dir_obj = pcall(lfs.dir, p)
  if not ok then
    -- On `pcall` failure, `iter` contains the error message from `lfs.dir`.
    return false, iter
  end
  return iter, dir_obj
end

---@param name LuaFileSystem.AttributeName
local function get_attr(p, name)
  local value, err = lfs.attributes(p, name)
  if value == nil then
    return nil, err
  end
  return value
end

---Read entire file contents using given mode.
---@return string? body, string? err
local function read(p, mode)
  local f, err = open(p, mode)
  if not f then
    return nil, err
  end

  local body = f:read("*a")
  f:close()
  return body
end

---Write file contents using the given mode.
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

---Recursively scan a directory tree into output list.
---@param root string
---@param ls string[]
---@param follow_symlinks? boolean
local function scan_dir(root, ls, follow_symlinks)
  local iter, dir_obj = open_dir(root)
  if not iter then
    return false, dir_obj
  end

  for entry in iter, dir_obj do
    if not is_dir_marker(entry) then
      local child = join(root, entry)
      ls[#ls + 1] = child
      if isdir(child) and (follow_symlinks or not islink(child)) then
        local ok, err = scan_dir(child, ls, follow_symlinks)
        if not ok then
          return false, err
        end
      end
    end
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

function M.touch(p)
  assert_arg(1, p, "string")

  -- `lfs.touch` updates timestamps for existing files but does not create new ones.
  if M.exists(p) then
    local ok, err = lfs.touch(p)
    -- Normalize `lfs.touch` failure from `nil` to `false`.
    return ok == true, err
  end

  local file, err = open(p, "ab")
  if not file then
    return false, err
  end

  file:close()
  return true
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

function M.read_bytes(p)
  assert_arg(1, p, "string")
  return read(p, "rb")
end

function M.read_text(p)
  assert_arg(1, p, "string")
  return read(p, "r")
end

function M.rm(p, recursive)
  assert_arg(1, p, "string")
  assert_arg(2, recursive, "boolean", true)

  if recursive then
    if islink(p) then
      return remove(p)
    end

    local items = {}
    local ok, err

    ok, err = scan_dir(p, items, false)
    if not ok then
      return nil, err
    end

    local rmdir = lfs.rmdir
    for i = #items, 1, -1 do
      local item = items[i]
      local fn = (isdir(item) and not islink(item)) and rmdir or remove
      ok, err = fn(item)
      if not ok then
        return nil, err
      end
    end

    return rmdir(p)
  end

  return remove(p)
end

M.rename = rename

return M
