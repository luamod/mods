local helpers = require "spec.helpers"
local lfs = require "lfs"
local mods = require "mods"

local Tree = helpers.Tree
local fs = mods.fs
local path = mods.path

local isdir = mods.is.dir
local make_tmp_dir = helpers.make_tmp_dir
local tmpname = helpers.tmpname
local join = path.join
local dirname = path.dirname

local fmt = string.format

describe("mods.fs", function()
  local is_unix = not mods.runtime.is_windows
  local cwd = path.cwd() --[[@as string]]
  local readme_file = join(cwd, "README.md")
  local spec_file = join(cwd, "spec", "fs_spec.lua")

  for _, fname in ipairs({ "getsize", "getatime", "getmtime", "getctime" }) do
    it(fmt("%s() returns a number for an existing path", fname), function()
      assert.is_number(fs[fname](readme_file))
    end)

    it(fmt("%s() returns nil and an error for a missing path", fname), function()
      local value, errmsg, errcode = fs[fname]("__mods_missing_path__")
      assert.is_nil(value)
      assert.is_string(errmsg)
      assert.is_number(errcode)
    end)
  end

  describe("stat()", function()
    it("exposes an lfs.attributes alias", function()
      assert.is_table(fs.stat(readme_file))
      assert.are_equal(lfs.attributes, fs.stat)
    end)

    it("returns nil and an error for a missing path", function()
      local attrs, errmsg, errcode = fs.stat("__mods_missing_path__")
      assert.is_nil(attrs)
      assert.is_string(errmsg)
      assert.is_number(errcode)
    end)
  end)

  describe("lstat()", function()
    it("exposes an lfs.symlinkattributes alias", function()
      assert.is_table(fs.lstat(readme_file))
      assert.are_equal(lfs.symlinkattributes, fs.lstat)
    end)

    it("returns nil and an error for a missing path", function()
      local attrs, errmsg, errcode = fs.lstat("__mods_missing_path__")
      assert.is_nil(attrs)
      assert.is_string(errmsg)
      assert.is_number(errcode)
    end)
  end)

  describe("rename()", function()
    it("exposes an os.rename alias", function()
      assert.are_equal(os.rename, fs.rename)
    end)

    it("renames a file", function()
      local from = tmpname()
      local to = tmpname()
      assert.is_true(fs.write_text(from, "abc"))
      assert.is_true(fs.rename(from, to))
      assert.is_false(fs.exists(from))
      assert.are_equal("abc", fs.read_text(to))
      assert.is_true(os.remove(to))
    end)

    it("fails with an error for a missing path", function()
      local ok, errmsg, errcode = fs.rename("__mods_missing_path__", tmpname())
      assert.is_nil(ok)
      assert.is_string(errmsg)
      assert.is_number(errcode)
    end)
  end)

  describe("write_bytes()", function()
    it("writes file contents", function()
      local target = tmpname()
      assert.is_true(fs.write_bytes(target, "abc"))
      assert.are_equal("abc", fs.read_bytes(target))
      assert.is_true(os.remove(target))
    end)

    it("fails with an error when the parent directory does not exist", function()
      local target = path.join(tmpname(), "missing", "file.bin")
      local ok, errmsg, errcode = fs.write_bytes(target, "abc")
      assert.is_nil(ok)
      assert.is_string(errmsg)
      assert.is_number(errcode)
    end)
  end)

  describe("write_text()", function()
    it("writes file contents", function()
      local target = tmpname()
      assert.is_true(fs.write_text(target, "abc"))
      assert.are_equal("abc", fs.read_text(target))
      assert.is_true(os.remove(target))
    end)

    it("fails with an error when the parent directory does not exist", function()
      local target = path.join(tmpname(), "missing", "file.txt")
      local ok, errmsg, errcode = fs.write_text(target, "abc")
      assert.is_nil(ok)
      assert.is_string(errmsg)
      assert.is_number(errcode)
    end)
  end)

  describe("read_bytes()", function()
    it("reads file contents", function()
      local target = tmpname()
      assert.is_true(fs.write_bytes(target, "abc"))
      assert.are_equal("abc", fs.read_bytes(target))
      assert.is_true(os.remove(target))
    end)

    it("fails with an error for a missing path", function()
      local body, errmsg, errcode = fs.read_bytes("__mods_missing_path__")
      assert.is_nil(body)
      assert.is_string(errmsg)
      assert.is_number(errcode)
    end)
  end)

  describe("read_text()", function()
    it("reads file contents", function()
      local target = tmpname()
      assert.is_true(fs.write_text(target, "abc"))
      assert.are_equal("abc", fs.read_text(target))
      assert.is_true(os.remove(target))
    end)

    it("fails with an error for a missing path", function()
      local body, errmsg, errcode = fs.read_text("__mods_missing_path__")
      assert.is_nil(body)
      assert.is_string(errmsg)
      assert.is_number(errcode)
    end)
  end)

  describe("touch()", function()
    it("creates a missing file", function()
      local target = tmpname()
      assert.is_true(fs.touch(target))
      assert.are_equal("", fs.read_bytes(target))
      assert.is_true(os.remove(target))
    end)

    it("does not truncate an existing file", function()
      local target = tmpname()
      assert.is_true(fs.write_bytes(target, "abc"))
      assert.is_true(fs.touch(target))
      assert.are_equal("abc", fs.read_bytes(target))
      assert.is_true(os.remove(target))
    end)

    it("updates timestamps for an existing file", function()
      local target = tmpname()
      assert.is_true(fs.write_bytes(target, "abc"))
      assert.is_true(lfs.touch(target, 1, 1))
      assert.is_true(fs.touch(target))
      assert.is_true(fs.getmtime(target) > 1)
      assert.is_true(os.remove(target))
    end)

    it("fails when the parent directory does not exist", function()
      local root = tmpname()
      local target = path.join(root, "missing", "file.txt")
      local ok, errmsg, errcode = fs.touch(target)
      assert.is_nil(ok)
      assert.is_string(errmsg)
      assert.is_number(errcode)
    end)

    if is_unix then
      it("updates an existing file through a symlink", function()
        local target, link = tmpname(), tmpname()
        assert.is_true(fs.write_bytes(target, "abc"))
        assert.is_true(lfs.link(target, link, true))
        assert.is_true(lfs.touch(target, 1, 1))
        assert.is_true(fs.touch(link))
        assert.is_true(fs.getmtime(target) > 1)
        assert.are_equal("abc", fs.read_bytes(target))
        assert.is_true(os.remove(link))
        assert.is_true(os.remove(target))
      end)

      it("heals a broken symlink by creating its target", function()
        local target, link = tmpname(), tmpname()
        assert.is_true(lfs.link(target, link, true))
        assert.is_true(fs.touch(link))
        assert.is_true(fs.exists(link))
        assert.is_true(fs.exists(target))
        assert.is_true(os.remove(link))
        assert.is_true(os.remove(target))
      end)
    end
  end)

  describe("mkdir()", function()
    it("creates a directory without parent mode", function()
      local root = make_tmp_dir()
      local target = path.join(root, "single")

      assert.is_true(fs.mkdir(target))
      assert.is_true(fs.exists(target))
      assert.is_true(isdir(target))
      assert.is_true(fs.rm(root, true))
    end)

    it("creates missing parent directories when parent mode is enabled", function()
      local root = make_tmp_dir()
      local target = path.join(root, "deep", "child")

      assert.is_true(fs.mkdir(target, true))
      assert.is_true(fs.exists(path.dirname(target)))
      assert.is_true(fs.exists(target))
      assert.is_true(isdir(target))
      assert.is_true(fs.rm(root, true))
    end)

    it("succeeds when the target directory already exists", function()
      local root = make_tmp_dir()
      assert.is_true(fs.mkdir(root, true))
      assert.is_true(fs.exists(root))
      assert.is_true(isdir(root))
      assert.is_true(fs.rm(root, true))
    end)

    it("normalizes dot segments before creating parent directories", function()
      local root = make_tmp_dir()
      local target = path.join(root, "alpha", "..", "beta", ".", "child")
      local normalized = path.join(root, "beta", "child")

      assert.is_true(fs.mkdir(target, true))
      assert.is_false(fs.exists(path.join(root, "alpha")))
      assert.is_true(fs.exists(normalized))
      assert.is_true(isdir(normalized))
      assert.is_true(fs.rm(root, true))
    end)

    it("fails when parent directories are missing without parent mode", function()
      local target = path.join(tmpname(), "missing", "child")
      local ok, errmsg, errcode = fs.mkdir(target)
      assert.is_nil(ok)
      assert.is_string(errmsg)
      assert.is_number(errcode)
    end)

    it("fails when a parent path component is a file", function()
      local root = make_tmp_dir()
      local parent_file = path.join(root, "data.txt")
      local target = path.join(parent_file, "child")

      assert.is_true(fs.write_text(parent_file, "abc"))

      local ok, errmsg, errcode = fs.mkdir(target, true)
      assert.is_nil(ok)
      assert.is_string(errmsg)
      assert.is_number(errcode)
      assert.is_true(fs.rm(root, true))
    end)

    it("fails when the target path already exists as a file", function()
      local root = make_tmp_dir()
      local target = path.join(root, "data.txt")

      assert.is_true(fs.write_text(target, "abc"))

      local ok, errmsg, errcode = fs.mkdir(target, true)
      assert.is_nil(ok)
      assert.is_string(errmsg)
      assert.is_number(errcode)
      assert.is_true(fs.rm(root, true))
    end)
  end)

  describe("cp()", function()
    it("copies binary files", function()
      local root = make_tmp_dir()
      local src = join(root, "src.bin")
      local dst = join(root, "dst.bin")
      local body = "a\0b\1c\255z"

      assert.is_true(fs.write_bytes(src, body))
      assert.is_true(fs.cp(src, dst))
      assert.are_equal(body, fs.read_bytes(dst))

      assert.is_true(fs.rm(root, true))
    end)

    it("copies files", function()
      local root = make_tmp_dir()
      local src = join(root, "src.txt")
      local dst = join(root, "dst.txt")

      assert.is_true(fs.write_text(src, "abc"))
      assert.is_true(fs.cp(src, dst))
      assert.are_equal("abc", fs.read_text(dst))

      assert.is_true(fs.rm(root, true))
    end)

    it("overwrites an existing destination file", function()
      local root = make_tmp_dir()
      local src = join(root, "src.txt")
      local dst = join(root, "dst.txt")

      assert.is_true(fs.write_text(src, "new"))
      assert.is_true(fs.write_text(dst, "old"))

      assert.is_true(fs.cp(src, dst))
      assert.are_equal("new", fs.read_text(dst))

      assert.is_true(fs.rm(root, true))
    end)

    it("copies empty directories", function()
      local root = make_tmp_dir()
      local src = join(root, "src")
      local empty = join(src, "empty")
      local dst = join(root, "copy")

      assert.is_true(fs.mkdir(empty, true))

      assert.is_true(fs.cp(src, dst))
      assert.is_true(isdir(join(dst, "empty")))

      assert.is_true(fs.rm(root, true))
    end)

    it("copies directories recursively", function()
      local root = make_tmp_dir()
      local src = join(root, "src")
      local top_level = join(src, "top.txt")
      local nested_dir = join(src, "deep")
      local nested = join(nested_dir, "nested.txt")
      local dst = join(root, "copy")

      assert.is_true(fs.mkdir(nested_dir, true))
      assert.is_true(fs.write_text(top_level, "abc"))
      assert.is_true(fs.write_text(nested, "xyz"))

      assert.is_true(fs.cp(src, dst))
      assert.are_equal("abc", fs.read_text(join(dst, "top.txt")))
      assert.is_true(fs.exists(join(dst, "deep")))
      assert.are_equal("xyz", fs.read_text(join(dst, "deep", "nested.txt")))

      assert.is_true(fs.rm(root, true))
    end)

    it("merges into an existing destination directory", function()
      local root = make_tmp_dir()
      local src = join(root, "src")
      local nested_dir = join(src, "deep")
      local src_file = join(src, "top.txt")
      local nested = join(nested_dir, "nested.txt")
      local dst = join(root, "copy")
      local keep = join(dst, "keep.txt")

      assert.is_true(fs.mkdir(nested_dir, true))
      assert.is_true(fs.mkdir(dst, true))
      assert.is_true(fs.write_text(src_file, "abc"))
      assert.is_true(fs.write_text(nested, "xyz"))
      assert.is_true(fs.write_text(keep, "keep"))

      assert.is_true(fs.cp(src, dst))
      assert.are_equal("keep", fs.read_text(keep))
      assert.are_equal("abc", fs.read_text(join(dst, "top.txt")))
      assert.are_equal("xyz", fs.read_text(join(dst, "deep", "nested.txt")))

      assert.is_true(fs.rm(root, true))
    end)

    it("fails when the source is missing", function()
      local root = make_tmp_dir()
      local missing = join(root, "missing.txt")
      local dst = join(root, "dst.txt")

      local ok, errmsg, errcode = fs.cp(missing, dst)
      assert.are_same({ "nil", "string", "number" }, { type(ok), type(errmsg), type(errcode) })

      assert.is_true(fs.rm(root, true))
    end)

    it("fails when the destination parent is missing", function()
      local root = make_tmp_dir()
      local src = join(root, "src.txt")
      local dst = join(root, "missing", "dst.txt")

      assert.is_true(fs.write_text(src, "abc"))

      local ok, errmsg, errcode = fs.cp(src, dst)
      assert.are_same({ "nil", "string", "number" }, { type(ok), type(errmsg), type(errcode) })

      assert.is_true(fs.rm(root, true))
    end)

    it("fails when a nested destination path conflicts with a file", function()
      local root = make_tmp_dir()
      local src = join(root, "src")
      local nested_dir = join(src, "deep")
      local nested = join(nested_dir, "nested.txt")
      local dst = join(root, "copy")
      local conflicting = join(dst, "deep")

      assert.is_true(fs.mkdir(nested_dir, true))
      assert.is_true(fs.mkdir(dst, true))
      assert.is_true(fs.write_text(nested, "xyz"))
      assert.is_true(fs.write_text(conflicting, "not a dir"))

      local ok, errmsg, errcode = fs.cp(src, dst)
      assert.are_same({ "nil", "string", "number" }, { type(ok), type(errmsg), type(errcode) })

      assert.is_true(fs.rm(root, true))
    end)

    it("fails when copying a directory onto itself", function()
      local root = make_tmp_dir()
      local src = join(root, "src")
      local nested = join(src, "nested.txt")

      assert.is_true(fs.mkdir(src, true))
      assert.is_true(fs.write_text(nested, "xyz"))

      local ok, errmsg, errcode = fs.cp(src, src)
      local msg = "cannot copy a directory into itself or its descendant"
      assert.are_same({ "nil", msg, "nil" }, { type(ok), errmsg, type(errcode) })

      assert.are_equal("xyz", fs.read_text(nested))
      assert.is_true(fs.rm(root, true))
    end)

    it("fails when copying a directory into its descendant", function()
      local root = make_tmp_dir()
      local src = join(root, "src")
      local nested = join(src, "nested.txt")
      local dst = join(src, "child", "copy")

      assert.is_true(fs.mkdir(src, true))
      assert.is_true(fs.write_text(nested, "xyz"))

      local ok, errmsg, errcode = fs.cp(src, dst)
      local msg = "cannot copy a directory into itself or its descendant"
      assert.are_same({ "nil", msg, "nil" }, { type(ok), errmsg, type(errcode) })

      assert.is_false(fs.exists(dst))
      assert.are_equal("xyz", fs.read_text(nested))
      assert.is_true(fs.rm(root, true))
    end)
  end)

  describe("rm()", function()
    it("removes a file without recursive mode", function()
      local target = tmpname()
      assert.is_true(fs.write_text(target, "abc"))
      assert.is_true(fs.rm(target))
      assert.is_false(fs.exists(target))
    end)

    it("removes an empty directory without recursive mode", function()
      local root = make_tmp_dir()
      assert.is_true(fs.rm(root))
      assert.is_false(fs.exists(root))
    end)

    it("fails with an error for a non-empty directory without recursive mode", function()
      local root = make_tmp_dir()
      local target = path.join(root, "data.txt")

      assert.is_true(fs.write_text(target, "abc"))

      local ok, err = fs.rm(root)
      assert.is_nil(ok)
      assert.is_string(err)

      assert.is_true(fs.rm(root, true))
    end)

    it("fails with an error for a non-path", function()
      local ok, err = fs.rm("__mods_missing_path__")
      assert.is_nil(ok)
      assert.is_string(err)

      local ok, err = fs.rm("a/b/c", true)
      assert.is_nil(ok)
      assert.is_string(err)
    end)

    it("fails with an error when recursive mode is used with a file path", function()
      local target = tmpname()
      assert.is_true(fs.write_text(target, "abc"))

      local ok, err = fs.rm(target, true)
      assert.is_nil(ok)
      assert.is_string(err)
      assert.is_true(fs.rm(target))
    end)

    it("removes an empty directory tree recursively", function()
      local root = make_tmp_dir()
      assert.is_true(fs.rm(root, true))
      assert.is_false(fs.exists(root))
    end)

    it("removes a directory tree recursively", function()
      local tree = Tree():dir("sub"):dir(join("sub", "deep")):file("data.txt"):file(join("sub", "deep", "nested.txt"))
      local root = tree.root
      local target = tree:path("data.txt")
      local nested = tree:path(path.join("sub", "deep", "nested.txt"))

      assert.is_true(fs.exists(root))
      assert.is_true(fs.exists(target))
      assert.is_true(fs.exists(nested))

      assert.is_true(fs.rm(root, true))

      assert.is_false(fs.exists(root))
      assert.is_false(fs.exists(target))
      assert.is_false(fs.exists(nested))
    end)

    if is_unix then
      it("removes a symlink root without deleting the target directory", function()
        local external = make_tmp_dir()
        local external_file = path.join(external, "nested.txt")

        assert.is_true(fs.write_text(external_file, "abc"))

        local tree = Tree():link("linked", external, true)
        local root = tree.root
        local link_dir = tree:path("linked")

        assert.is_true(fs.lexists(link_dir))
        assert.is_true(fs.rm(link_dir, true))
        assert.is_false(fs.lexists(link_dir))

        assert.is_true(fs.exists(external))
        assert.are_equal("abc", fs.read_text(external_file))

        assert.is_true(fs.rm(root, true))
        assert.is_true(fs.rm(external, true))
      end)

      it("does not follow symlinked directories during recursive removal", function()
        local root = make_tmp_dir()
        local external = make_tmp_dir()
        local external_file = path.join(external, "nested.txt")
        local link_dir = path.join(root, "linked")

        assert.is_true(fs.write_text(external_file, "abc"))

        local ok = lfs.link(external, link_dir, true)
        if not ok then
          assert.is_true(fs.rm(root, true))
          assert.is_true(fs.rm(external, true))
          return
        end

        assert.is_true(fs.rm(root, true))
        assert.is_true(fs.exists(external))
        assert.are_equal("abc", fs.read_text(external_file))
        assert.is_true(fs.rm(external, true))
      end)
    end
  end)

  describe("exists()", function()
    assert.is_true(fs.exists(readme_file))
    assert.is_false(fs.exists("__mods_missing_path__"))
    assert.is_true(fs.exists(cwd))

    if is_unix then
      it("returns false for a broken symlink", function()
        local target, link = tmpname(), tmpname()
        assert.is_true(lfs.link(target, link, true))
        assert.is_false(fs.exists(link))
        assert.is_true(os.remove(link))
      end)
    end
  end)

  describe("lexists()", function()
    assert.is_true(fs.lexists(readme_file))
    assert.is_false(fs.lexists("__mods_missing_path__"))
    assert.is_true(fs.lexists(cwd))

    if is_unix then
      it("returns true for a symlink path", function()
        local link = tmpname()
        assert.is_true(lfs.link(readme_file, link, true))
        assert.is_true(fs.lexists(link))
        assert.is_true(os.remove(link))
      end)

      it("returns true for a broken symlink", function()
        local target, link = tmpname(), tmpname()
        assert.is_true(lfs.link(target, link, true))
        assert.is_true(fs.lexists(link))
        assert.is_true(os.remove(link))
      end)
    end
  end)

  describe("samefile()", function()
    assert.are_same({ true }, { fs.samefile(readme_file, readme_file) })
    assert.are_same({ true }, { fs.samefile(readme_file, "README.md") })
    assert.are_same({ false }, { fs.samefile(readme_file, spec_file) })

    it("fails on missing path", function()
      local ok, errmsg, errcode = fs.samefile(readme_file, "__mods_missing_path__")
      assert.is_nil(ok)
      assert.is_string(errmsg)
      assert.is_number(errcode)

      ok, errmsg, errcode = fs.samefile("__mods_missing_path__", readme_file)
      assert.is_nil(ok)
      assert.is_string(errmsg)
      assert.is_number(errcode)
    end)

    if is_unix then
      it("returns true for a hard link to the same file", function()
        local root = tmpname()
        local target = path.join(root, "target.txt")
        local link = path.join(root, "hardlink.txt")

        assert.is_true(lfs.mkdir(root))

        local f = assert(io.open(target, "w"))
        f:close()

        assert.is_true(lfs.link(target, link))
        assert.is_true(fs.samefile(target, link))
        assert.is_true(os.remove(link))
        assert.is_true(os.remove(target))
        assert.is_true(lfs.rmdir(root))
      end)

      it("returns true for a symlink to the same file", function()
        local link = tmpname()
        assert.is_true(lfs.link(readme_file, link, true))
        assert.is_true(fs.samefile(readme_file, link))
        os.remove(link)
      end)
    end
  end)

  -- stylua: ignore
  ---@diagnostic disable: param-type-mismatch, discard-returns, missing-parameter, assign-type-mismatch
  it("errors on invalid argument types", function()
    -- Argument #1 validation.
    assert.has_error(function() fs.cp(false)       end, "bad argument #1 to 'cp' (string expected, got boolean)")
    assert.has_error(function() fs.exists(true)    end, "bad argument #1 to 'exists' (string expected, got boolean)")
    assert.has_error(function() fs.getatime(false) end, "bad argument #1 to 'getatime' (string expected, got boolean)")
    assert.has_error(function() fs.getctime(0)     end, "bad argument #1 to 'getctime' (string expected, got number)")
    assert.has_error(function() fs.getmtime()      end, "bad argument #1 to 'getmtime' (string expected, got no value)")
    assert.has_error(function() fs.getsize()       end, "bad argument #1 to 'getsize' (string expected, got no value)")
    assert.has_error(function() fs.lexists({})     end, "bad argument #1 to 'lexists' (string expected, got table)")
    assert.has_error(function() fs.mkdir()         end, "bad argument #1 to 'mkdir' (string expected, got no value)")
    assert.has_error(function() fs.read_bytes({})  end, "bad argument #1 to 'read_bytes' (string expected, got table)")
    assert.has_error(function() fs.read_text({})   end, "bad argument #1 to 'read_text' (string expected, got table)")
    assert.has_error(function() fs.rm({})          end, "bad argument #1 to 'rm' (string expected, got table)")
    assert.has_error(function() fs.touch(false)    end, "bad argument #1 to 'touch' (string expected, got boolean)")
    assert.has_error(function() fs.write_bytes({}) end, "bad argument #1 to 'write_bytes' (string expected, got table)")
    assert.has_error(function() fs.write_text({})  end, "bad argument #1 to 'write_text' (string expected, got table)")

    -- Argument #2 validation.
    assert.has_error(function() fs.cp("a")                      end, "bad argument #2 to 'cp' (string expected, got no value)")
    assert.has_error(function() fs.mkdir("tmp", 1)              end, "bad argument #2 to 'mkdir' (boolean expected, got number)")
    assert.has_error(function() fs.rm("tmp", 1)                 end, "bad argument #2 to 'rm' (boolean expected, got number)")
    assert.has_error(function() fs.samefile(readme_file, 123)   end, "bad argument #2 to 'samefile' (string expected, got number)")
    assert.has_error(function() fs.write_bytes(readme_file, {}) end, "bad argument #2 to 'write_bytes' (string expected, got table)")
    assert.has_error(function() fs.write_text(readme_file)      end, "bad argument #2 to 'write_text' (string expected, got no value)")
  end)
end)
