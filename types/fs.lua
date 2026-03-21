---@meta mods.fs

local lfs ---@module "lfs"

---
---Filesystem I/O and metadata operations.
---
---## Usage
---
---```lua
---fs = require "mods.fs"
---
---fs.mkdir("tmp/cache/app", true)
---```
---
---@class mods.fs
local M = {}

---Alias of `lfs.currentdir`
M.getcwd = lfs.currentdir

---Alias of `lfs.symlinkattributes`
M.lstat = lfs.symlinkattributes

---Alias of `lfs.rmdir`
M.rmdir = lfs.rmdir

---Alias of `lfs.attributes`
M.stat = lfs.attributes

return M
