---@meta mods.ntpath

---
---Lexical path operations for Windows/NT-style paths.
---
---## Usage
---
---```lua
---ntpath = require "mods.ntpath"
---
---print(ntpath.join([[C:\]], "Users", "me")) --> "C:\Users\me"
---```
---
---@class mods.ntpath
local M = {}

--------------------------------------------------------------------------------
------------------------- Normalization & Predicates ---------------------------
--------------------------------------------------------------------------------

---
---Normalize case and separators for NT paths.
---
---```lua
---ntpath.normcase([[A/B\C]]) --> [[a\b\c]]
---```
---
---@param s string Path string to normalize.
---@return string value Normalized lowercase path with `\` separators.
---@nodiscard
function M.normcase(s) end

---
---Return `true` when `path` is absolute under NT rules.
---
---```lua
---ntpath.isabs([[C:\a]]) --> true
---```
---
---@param path string Path to inspect.
---@return boolean value `true` if the path is absolute.
---@nodiscard
function M.isabs(path) end

---
---Return `true` when `path` points to a mount root.
---
---```lua
---ntpath.ismount([[C:\]]) --> true
---```
---
---@param path string Path to inspect.
---@return boolean value `true` if the path resolves to a mount root.
---@nodiscard
function M.ismount(path) end

---
---Return `true` when `path` contains a reserved NT filename.
---
---```lua
---ntpath.isreserved([[a\CON.txt]]) --> true
---```
---
---@param path string Path to inspect.
---@return boolean value `true` if any component is NT-reserved.
---@nodiscard
function M.isreserved(path) end

--------------------------------------------------------------------------------
------------------------------ Path Decomposition ------------------------------
--------------------------------------------------------------------------------

---
---Join one or more path components.
---
---```lua
---ntpath.join([[C:\a]], [[b]]) --> [[C:\a\b]]
---```
---
---@param path string Base path component.
---@param ... string Additional path components to append.
---@return string value Joined NT path.
---@nodiscard
function M.join(path, ...) end

---
---Split path into directory head and tail component.
---
---```lua
---ntpath.split([[C:\a\b.txt]]) --> [[C:\a]], "b.txt"
---```
---
---@param path string Path to split.
---@return string head Directory portion of the path.
---@return string tail Final path component.
---@nodiscard
function M.split(path) end

---
---Split path into a root and extension.
---
---```lua
---ntpath.splitext("archive.tar.gz") --> "archive.tar", ".gz"
---```
---
---@param path string Path to split.
---@return string root Path without the final extension.
---@return string ext Final extension, including the leading dot when present.
---@nodiscard
function M.splitext(path) end

---
---Split drive prefix from remainder.
---
---```lua
---ntpath.splitdrive([[C:\a\b]]) --> "C:", [[\a\b]]
---```
---
---@param path string Path to split.
---@return string drive Drive or UNC share prefix.
---@return string rest Remaining path after the drive prefix.
---@nodiscard
function M.splitdrive(path) end

---
---Split path into drive, root, and tail components.
---
---```lua
---ntpath.splitroot([[C:\a\b]]) --> "C:", [[\]], "a\\b"
---```
---
---@param path string Path to split.
---@return string drive Drive or UNC share prefix.
---@return string root Root separator portion.
---@return string tail Remaining path after drive and root.
---@nodiscard
function M.splitroot(path) end

---
---Return final path component.
---
---```lua
---ntpath.basename([[C:\a\b.txt]]) --> "b.txt"
---```
---
---@param path string Path to inspect.
---@return string value Final component of the path.
---@nodiscard
function M.basename(path) end

---
---Return directory portion of a path.
---
---```lua
---ntpath.dirname([[C:\a\b.txt]]) --> [[C:\a]]
---```
---
---@param path string Path to inspect.
---@return string value Directory portion of the path.
---@nodiscard
function M.dirname(path) end

--------------------------------------------------------------------------------
------------------------------ Environment Expand ------------------------------
--------------------------------------------------------------------------------

---
---Expand `~` home segment when available.
---
---```lua
---ntpath.expanduser([[x\y]]) --> [[x\y]]
---```
---
---@param path string Path that may begin with `~`.
---@return string value Path with the home segment expanded when available.
---@nodiscard
function M.expanduser(path) end

--------------------------------------------------------------------------------
------------------------------- Derived Paths ----------------------------------
--------------------------------------------------------------------------------

---
---Normalize separators and dot segments.
---
---```lua
---ntpath.normpath([[A/foo/../B]]) --> [[A\B]]
---```
---
---@param path string Path to normalize.
---@return string value Normalized NT path with dot segments resolved lexically.
---@nodiscard
function M.normpath(path) end

---
---Return normalized absolute path.
---
---```lua
---ntpath.abspath([[C:\a\..\b]]) --> [[C:\b]]
---```
---
---@param path string Path to absolutize.
---@return string value Normalized absolute NT path.
---@nodiscard
function M.abspath(path) end

---
---Return `path` relative to optional `start` path.
---
---```lua
---ntpath.relpath([[C:\a\b\c]], [[C:\a]]) --> [[b\c]]
---```
---
---@param path string Target path.
---@param start? string Optional start path used as the base.
---@return string value Relative path from `start` to `path`.
---@nodiscard
function M.relpath(path, start) end

---
---Return longest common sub-path from a path list.
---
---```lua
---ntpath.commonpath({ [[C:\a\b\c]], [[c:/a/b/d]] }) --> [[C:\a\b]]
---```
---
---@param paths string[] Input NT paths.
---@return string value Longest common sub-path.
---@nodiscard
function M.commonpath(paths) end

return M
