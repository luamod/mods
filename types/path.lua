---@meta mods.path

---
---Shared generic path helpers used by platform-specific path modules.
---
---@class mods.path
local M = {}

---
---Split extension from a path.
---Follows Python `genericpath._splitext` semantics.
---
---```lua
---local root, ext = path._splitext("archive.tar.gz", "/", nil, ".")
---print(root, ext) --> "archive.tar", ".gz"
---```
---@param path string
---@param sep string
---@param altsep? string
---@param extsep string
---@return string root
---@return string ext
---@nodiscard
function M._splitext(path, sep, altsep, extsep) end

return M
