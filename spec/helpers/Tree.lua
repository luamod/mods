local helpers = require "spec.helpers"
local lfs = require "lfs"
local mods = require "mods"

local path = mods.path
local fs = mods.fs
local isdir = mods.is.dir

---@class Tree
---@overload fun(root: string):Tree
---@field root string
local M = {} ---@cast M Tree
M.__index = M

local make_tmp_dir = helpers.make_tmp_dir

local function ensure_dir(p)
  if p == "" or p == "." or isdir(p) then
    return true
  end

  local parent = path.dirname(p)
  if parent ~= p then
    assert(ensure_dir(parent))
  end

  return lfs.mkdir(p) or isdir(p)
end

---@param relpath string
---Create a directory relative to the tree root.
function M:dir(relpath)
  assert(ensure_dir(path.join(self.root, relpath)))
  return self
end

---@param relpath string
---@param content? string
---Create a text file relative to the tree root.
function M:file(relpath, content)
  local p = path.join(self.root, relpath)
  assert(ensure_dir(path.dirname(p)))
  assert(fs.write_text(p, content or "abc"))
  return self
end

---@param relpath string
---@param target string
---@param symlink? boolean
---Create a symlink or hard link relative to the tree root.
function M:link(relpath, target, symlink)
  local p = path.join(self.root, relpath)
  assert(ensure_dir(path.dirname(p)))
  target = path.isabs(target) and target or path.join(self.root, target)
  assert(lfs.link(target, p, symlink))
  return self
end

---@param relpath string
---Return an absolute path under the tree root.
---@return string
function M:path(relpath)
  return path.join(self.root, relpath)
end

return setmetatable(M, {
  __call = function(_, root)
    return setmetatable({ root = root or make_tmp_dir() }, M)
  end,
})
