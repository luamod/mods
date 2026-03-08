---@meta mods.path

---
---Generic cross-platform path API.
---
---## Usage
---
---```lua
---path = require "mods.path"
---
---print(path.join("src", "mods", "path.lua")) --> "src/mods/path.lua"
---print(path.normpath("a//b/./c"))            --> "a/b/c"
---print(path.splitext("archive.tar.gz"))      --> "archive.tar", ".gz"
---```
---
---@class mods.path
local M = {}

---
---Split extension from a path.
---
---@ignore
---@param path string
---@param sep string
---@param altsep? string
---@param extsep string
---@return string root
---@return string ext
---@private
function M._splitext(path, sep, altsep, extsep) end

--------------------------------------------------------------------------------
------------------------- Normalization & Predicates ---------------------------
--------------------------------------------------------------------------------

---
---Normalize path case using the active path semantics.
---
---```lua
---path.normcase("/A/B") --> "/A/B"
---```
---
---> [!NOTE]
--->
---> On POSIX semantics this returns the input unchanged.
---
---@param s string Input path value.
---@return string value Path after case normalization.
---@nodiscard
function M.normcase(s) end

---
---Join path components.
---
---```lua
---path.join("/usr", "bin")   --> "/usr/bin"
---path.join([[C:\a]], [[b]]) --> [[C:\a\b]]
---```
---
---> [!NOTE]
--->
---> Single input is returned as-is.
---
---@param path string Base path component.
---@param ... string Additional path components.
---@return string value Joined path.
---@nodiscard
function M.join(path, ...) end

---
---Normalize separators and dot segments.
---
---```lua
---path.normpath("/a//./b/..")   --> "/a"
---path.normpath([[A/foo/../B]]) --> [[A\B]]
---```
---
---@param path string Path to normalize.
---@return string value Normalized path.
---@nodiscard
function M.normpath(path) end

---
---Return `true` when `path` is absolute.
---
---```lua
---path.isabs("/a/b") --> true
---```
---
---@param path string Input path.
---@return boolean value True when `path` is absolute.
---@nodiscard
function M.isabs(path) end

--------------------------------------------------------------------------------
------------------------------ Path Decomposition ------------------------------
--------------------------------------------------------------------------------

---
---Split path into directory head and tail component.
---
---```lua
---path.split("/a/b.txt") --> "/a", "b.txt"
---```
---
---@param path string Input path.
---@return string head Directory portion.
---@return string tail Final path component.
---@nodiscard
function M.split(path) end

---
---Split path into a root and extension.
---
---```lua
---path.splitext("archive.tar.gz") --> "archive.tar", ".gz"
---```
---
---@param path string Input path.
---@return string root Path without the final extension.
---@return string ext Final extension including leading dot.
---@nodiscard
function M.splitext(path) end

---
---Split drive prefix from remainder.
---
---```lua
---path.splitdrive("/a/b") --> "", "/a/b"
---```
---
---> [!NOTE]
--->
---> On POSIX semantics the drive portion is always empty.
---
---@param path string Input path.
---@return string drive Drive or share prefix when present.
---@return string rest Path remainder.
---@nodiscard
function M.splitdrive(path) end

---
---Split path into drive, root, and tail components.
---
---```lua
---path.splitroot("/a/b")     --> "", "/", "a/b"
---path.splitroot([[C:\a\b]]) --> "C:", [[\]], "a\\b"
---```
---
---@param path string Path to split.
---@return string drive Drive or share prefix (empty on POSIX).
---@return string root Root separator segment.
---@return string tail Remaining path without leading root separator.
---@nodiscard
function M.splitroot(path) end

---
---Return final path component.
---
---```lua
---path.basename("/a/b.txt")     --> "b.txt"
---path.basename([[C:\a\b.txt]]) --> "b.txt"
---```
---
---@param path string Path to inspect.
---@return string value Final path component.
---@nodiscard
function M.basename(path) end

---
---Return directory portion of a path.
---
---```lua
---path.dirname("/a/b.txt")     --> "/a"
---path.dirname([[C:\a\b.txt]]) --> [[C:\a]]
---```
---
---@param path string Path to inspect.
---@return string value Parent directory path.
---@nodiscard
function M.dirname(path) end

--------------------------------------------------------------------------------
------------------------------ Environment Expand ------------------------------
--------------------------------------------------------------------------------

---
---Expand `~` home segment when available.
---
---```lua
---path.expanduser("~/tmp") --> "<HOME>/tmp" (when HOME is set)
---path.expanduser([[x\y]]) --> [[x\y]]
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
---Return normalized absolute path.
---
---```lua
---path.abspath("/a/./b")      --> "/a/b"
---path.abspath([[C:\a\..\b]]) --> [[C:\b]]
---```
---
---@param path string Path to absolutize.
---@return string value Absolute normalized path.
---@nodiscard
function M.abspath(path) end

---
---Return `path` relative to optional `start` path.
---
---```lua
---path.relpath("/a/b/c", "/a")         --> "b/c"
---path.relpath([[C:\a\b\c]], [[C:\a]]) --> [[b\c]]
---```
---
---@param path string Input path.
---@param start? string Optional base path.
---@return string value Relative path from `start` to `path`.
---@nodiscard
function M.relpath(path, start) end

---
---Return longest common sub-path from a path list.
---
---```lua
---path.commonpath({ "/a/b/c", "/a/b/d" })         --> "/a/b"
---path.commonpath({ [[C:\a\b\c]], [[c:/a/b/d]] }) --> [[C:\a\b]]
---```
---
---> [!NOTE]
--->
---> All inputs must use compatible drive/root semantics.
---> Mixing absolute and relative paths may raise an error.
---
---@param paths string[] List of paths.
---@return string value Longest common sub-path.
---@nodiscard
function M.commonpath(paths) end

return M
