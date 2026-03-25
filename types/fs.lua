---@meta mods.fs

---@alias modsFsEntryType "file"|"directory"|"link"|"fifo"|"socket"|"char"|"block"|"unknown"
---@alias modsDirOptions {hidden?:boolean, recursive?:boolean, follow?:boolean, type?:modsFsEntryType}

---
---Filesystem I/O, metadata, and filesystem path operations.
---
---> [!NOTE]
--->
---> This module requires [LuaFileSystem (`lfs`)](https://github.com/lunarmodules/luafilesystem).
---
---## Usage
---
---```lua
---fs = require "mods.fs"
---
---fs.mkdir("tmp/cache/app", true)
---fs.write_text("tmp/cache/app/data.txt", "hello")
---print(fs.read_text("tmp/cache/app/data.txt")) --> "hello"
---```
---
---@class mods.fs
local M = {}

--------------------------------------------------------------------------------
----------------------------------- Reading ------------------------------------
--------------------------------------------------------------------------------

---
---Read full file in binary mode.
---
---```lua
---fs.read_bytes("README.md")
---```
---
---@param path string Input path.
---@return string? body File contents read in binary mode, or `nil` on failure.
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
---@nodiscard
function M.read_bytes(path) end

---
---Read full file in text mode.
---
---```lua
---fs.read_text("README.md")
---```
---
---@param path string Input path.
---@return string? body File contents read in text mode, or `nil` on failure.
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
---@nodiscard
function M.read_text(path) end

---
---Iterator over items in `path`.
---
---```lua
---for name, type in fs.dir(path.cwd(), { recursive = true }) do
---  print(name, type)
---end
---```
---
---@param path string Input path.
---@param opts? modsDirOptions Optional traversal options.
---@return (fun(state:table, prev?:string):basename:string?, type:modsFsEntryType?)? iterator Iterator, or `nil` on failure.
---@return table|string state Iterator state on success, or error message on failure.
function M.dir(path, opts) end

---
---Return direct children of a directory.
---
---```lua
---fs.listdir("src")
---```
---
---@param path string Input path.
---@param opts? modsDirOptions Optional traversal options.
---@return mods.List<string>? paths Direct child paths.
---@return string? err Error message when traversal setup fails.
---@nodiscard
function M.listdir(path, opts) end

--------------------------------------------------------------------------------
----------------------------- Filesystem Mutations -----------------------------
--------------------------------------------------------------------------------

---
---Write full file in binary mode.
---
---```lua
---fs.write_bytes("tmp.bin", "abc") --> true, nil
---```
---
---@param path string Input path.
---@param data string Input data.
---@return true? written `true` when writing succeeds, or `nil` on failure.
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
function M.write_bytes(path, data) end

---
---Write full file in text mode.
---
---```lua
---fs.write_text("tmp.txt", "abc") --> true, nil
---```
---
---@param path string Input path.
---@param data string Input data.
---@return true? written `true` when writing succeeds, or `nil` on failure.
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
function M.write_text(path, data) end

---
---Create file if missing without truncating, or update timestamps if it exists.
---
---```lua
---fs.touch("tmp.txt") --> true, nil
---```
---
---@param path string Input path.
---@return true? touched `true` when the file exists after touch, or `nil` on failure.
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
function M.touch(path) end

---Create a hard link.
---
---```lua
---fs.link("target.txt", "hardlink.txt")
---```
---
---@param path string Existing path to link to.
---@param linkpath string New link path to create.
---@return true? linked `true` when link creation succeeds, or `nil` on failure.
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
function M.link(path, linkpath) end

---
---Create a symbolic link.
---
---```lua
---fs.symlink("target.txt", "symlink.txt")
---```
---
---@param path string Path to reference from the new symlink.
---@param linkpath string New symlink path to create.
---@return true? linked `true` when link creation succeeds, or `nil` on failure.
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
function M.symlink(path, linkpath) end

---
---Return the current working directory.
---
---```lua
---fs.cwd()
---```
---
---@return string? cwd Current working directory, or `nil` on failure.
---@return string? errmsg Error message when the lookup fails.
---@return integer? errcode OS error code when available.
function M.cwd() end

---
---Change the current working directory.
---
---```lua
---fs.cd("src")
---```
---
---@param path string Directory path to switch into.
---@return true? changed `true` when the directory change succeeds, or `nil` on failure.
---@return string? errmsg Error message when the change fails.
function M.cd(path) end

---
---Rename or move a filesystem entry.
---
---```lua
---fs.rename("old.txt", "new.txt")
---```
---
---> [!NOTE]
--->
---> This is an alias for `os.rename`.
---
---@param oldname string Existing path.
---@param newname string Replacement path.
---@return true? renamed `true` when the rename succeeds, or `nil` on failure.
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
function M.rename(oldname, newname) end

---
---Remove a filesystem entry, or a directory tree when `recursive` is `true`.
---
---```lua
---fs.rm("tmp.txt") --> true, nil
---fs.rm("tmp/cache", true) --> true, nil
---```
---
---@param path string Input path.
---@param recursive? boolean Remove a directory tree recursively when `true`.
---@return true? removed `true` when removal succeeds, or `nil` on failure.
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
function M.rm(path, recursive) end

---
---Create a directory.
---
---```lua
---fs.mkdir("tmp/a/b", true)
---```
---
---@param path string Input path.
---@param parents? boolean Create missing parent directories when `true`.
---@return true? created `true` when directory creation succeeds, or `nil` on failure.
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
function M.mkdir(path, parents) end

---
---Copy a file or directory tree.
---
---```lua
---fs.cp("a.txt", "b.txt")
---fs.cp("src", "backup/src")
---```
---
---@param src string Source path.
---@param dst string Destination path.
---@return true? copied `true` when copying succeeds, or `nil` on failure.
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
function M.cp(src, dst) end

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
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
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
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
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
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
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
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
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
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
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
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
---@nodiscard
function M.stat(path) end

---
---Return whether two paths refer to the same file, or `nil` and an error on failure.
---
---```lua
---fs.samefile("README.md", "README.md") --> true
---```
---
---@param a string Input path.
---@param b string Input path.
---@return boolean? isSameFile True when both paths refer to the same file.
---@return string? errmsg Error message when the check fails.
---@return integer? errcode OS error code when available.
---@nodiscard
function M.samefile(a, b) end

--------------------------------------------------------------------------------
------------------------------- Existence Checks -------------------------------
--------------------------------------------------------------------------------

---
---Return `true` when a path exists.
---
---```lua
---fs.exists("README.md") --> true
---```
---
---> [!NOTE]
--->
---> Broken symlinks return `false`.
---
---@param path string Input path.
---@return boolean exists True when the path exists.
---@nodiscard
function M.exists(path) end

---
---Return `true` when a path exists without following symlinks.
---
---```lua
---fs.lexists("README.md") --> true
---```
---
---> [!NOTE]
--->
---> Broken symlinks return `true`.
---
---@param path string Input path.
---@return boolean exists True when the path or symlink entry exists.
---@nodiscard
function M.lexists(path) end

return M
