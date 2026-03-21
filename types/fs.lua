---@meta mods.fs

---
---Filesystem, environment, and cwd-dependent path operations.
---
---@class mods.fs
local M = {}

--------------------------------------------------------------------------------
--------------------------------- Metadata -------------------------------------
--------------------------------------------------------------------------------

---
---Return file size in bytes.
---
---```lua
---fs.getsize("README.md") --> 1234
---```
---
---@param path string Input path.
---@return integer? size File size in bytes.
---@return string? err Error message when the check fails.
---@nodiscard
function M.getsize(path) end

---
---Return last access time.
---
---```lua
---fs.getatime("README.md") --> 1712345678
---```
---
---@param path string Input path.
---@return number? timestamp Access time (seconds since epoch).
---@return string? err Error message when the check fails.
---@nodiscard
function M.getatime(path) end

---
---Return last modification time.
---
---```lua
---fs.getmtime("README.md") --> 1712345678
---```
---
---@param path string Input path.
---@return number? timestamp Modification time (seconds since epoch).
---@return string? err Error message when the check fails.
---@nodiscard
function M.getmtime(path) end

---
---Return metadata change time.
---
---```lua
---fs.getctime("README.md") --> 1712345678
---```
---
---@param path string Input path.
---@return number? timestamp Change time (seconds since epoch).
---@return string? err Error message when the check fails.
---@nodiscard
function M.getctime(path) end

---
---Return symlink-aware file attributes.
---
---```lua
---fs.lstat("README.md")
---```
---
---@param path string Input path.
---@return LuaFileSystem.Attributes? attrs Symlink-aware attributes, or `nil` on failure.
---@return string? err Error message when the check fails.
---@nodiscard
function M.lstat(path) end

---
---Return file attributes.
---
---```lua
---fs.stat("README.md")
---```
---
---@param path string Input path.
---@return string|integer|LuaFileSystem.AttributeMode|LuaFileSystem.Attributes? attrs File attributes, or `nil` on failure.
---@return string? err Error message when the check fails.
---@nodiscard
function M.stat(path) end

---
---Return whether two paths refer to the same file, or `nil` and an error on failure.
---
---```lua
---fs.samefile("README.md", "README.md") --> true
---```
---
---@param path_a string Input path.
---@param path_b string Input path.
---@return boolean? isSameFile True when both paths refer to the same file.
---@return string? err Error message when the check fails.
---@nodiscard
function M.samefile(path_a, path_b) end

return M
