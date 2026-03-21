local helpers = require "spec.helpers"
local lfs = require "lfs"
local mods = require "mods"

local fs = mods.fs
local path = mods.path

local tmpname = helpers.tmpname
local fmt = string.format

describe("mods.fs", function()
  local is_unix = not mods.runtime.is_windows
  local cwd = path.cwd() --[[@as string]]
  local readme_file = path.join(cwd, "README.md")
  local spec_file = path.join(cwd, "spec", "fs_spec.lua")

  for _, fname in ipairs({ "getsize", "getatime", "getmtime", "getctime" }) do
    it(fmt("%s() returns a number for an existing path", fname), function()
      assert.is_number(fs[fname](readme_file))
    end)

    it(fmt("%s() returns nil and an error for a missing path", fname), function()
      local value, err = fs[fname]("__mods_missing_path__")
      assert.is_nil(value)
      assert.is_string(err)
    end)
  end

  describe("stat()", function()
    it("exposes an lfs.attributes alias", function()
      assert.is_table(fs.stat(readme_file))
      assert.are_equal(lfs.attributes, fs.stat)
    end)

    it("returns nil and an error for a missing path", function()
      local attrs, err = fs.stat("__mods_missing_path__")
      assert.is_nil(attrs)
      assert.is_string(err)
    end)
  end)

  describe("lstat()", function()
    it("exposes an lfs.symlinkattributes alias", function()
      assert.is_table(fs.lstat(readme_file))
      assert.are_equal(lfs.symlinkattributes, fs.lstat)
    end)

    it("returns nil and an error for a missing path", function()
      local attrs, err = fs.lstat("__mods_missing_path__")
      assert.is_nil(attrs)
      assert.is_string(err)
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

    it("returns nil and an error for a missing path", function()
      local ok, err = fs.rename("__mods_missing_path__", tmpname())
      assert.is_nil(ok)
      assert.is_string(err)
    end)
  end)

  describe("write_bytes()", function()
    it("writes file contents", function()
      local target = tmpname()
      assert.is_true(fs.write_bytes(target, "abc"))
      assert.are_equal("abc", fs.read_bytes(target))
      assert.is_true(os.remove(target))
    end)

    it("returns false and an error when the parent directory does not exist", function()
      local target = path.join(tmpname(), "missing", "file.bin")
      local ok, err = fs.write_bytes(target, "abc")
      assert.is_false(ok)
      assert.is_string(err)
    end)
  end)

  describe("write_text()", function()
    it("writes file contents", function()
      local target = tmpname()
      assert.is_true(fs.write_text(target, "abc"))
      assert.are_equal("abc", fs.read_text(target))
      assert.is_true(os.remove(target))
    end)

    it("returns false and an error when the parent directory does not exist", function()
      local target = path.join(tmpname(), "missing", "file.txt")
      local ok, err = fs.write_text(target, "abc")
      assert.is_false(ok)
      assert.is_string(err)
    end)
  end)

  describe("read_bytes()", function()
    it("reads file contents", function()
      local target = tmpname()
      assert.is_true(fs.write_bytes(target, "abc"))
      assert.are_equal("abc", fs.read_bytes(target))
      assert.is_true(os.remove(target))
    end)

    it("returns nil and an error for a missing path", function()
      local body, err = fs.read_bytes("__mods_missing_path__")
      assert.is_nil(body)
      assert.is_string(err)
    end)
  end)

  describe("read_text()", function()
    it("reads file contents", function()
      local target = tmpname()
      assert.is_true(fs.write_text(target, "abc"))
      assert.are_equal("abc", fs.read_text(target))
      assert.is_true(os.remove(target))
    end)

    it("returns nil and an error for a missing path", function()
      local body, err = fs.read_text("__mods_missing_path__")
      assert.is_nil(body)
      assert.is_string(err)
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
      local ok, err = fs.touch(target)
      assert.is_false(ok)
      assert.is_string(err)
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
      local ok, err = fs.samefile(readme_file, "__mods_missing_path__")
      assert.is_nil(ok)
      assert.is_string(err)

      ok, err = fs.samefile("__mods_missing_path__", readme_file)
      assert.is_nil(ok)
      assert.is_string(err)
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
    assert.has_error(function() fs.exists(true)    end, "bad argument #1 to 'exists' (string expected, got boolean)")
    assert.has_error(function() fs.getatime(false) end, "bad argument #1 to 'getatime' (string expected, got boolean)")
    assert.has_error(function() fs.getctime(0)     end, "bad argument #1 to 'getctime' (string expected, got number)")
    assert.has_error(function() fs.getmtime()      end, "bad argument #1 to 'getmtime' (string expected, got no value)")
    assert.has_error(function() fs.getsize()       end, "bad argument #1 to 'getsize' (string expected, got no value)")
    assert.has_error(function() fs.lexists({})     end, "bad argument #1 to 'lexists' (string expected, got table)")
    assert.has_error(function() fs.read_bytes({})  end, "bad argument #1 to 'read_bytes' (string expected, got table)")
    assert.has_error(function() fs.read_text({})   end, "bad argument #1 to 'read_text' (string expected, got table)")
    assert.has_error(function() fs.touch(false)    end, "bad argument #1 to 'touch' (string expected, got boolean)")
    assert.has_error(function() fs.write_bytes({}) end, "bad argument #1 to 'write_bytes' (string expected, got table)")
    assert.has_error(function() fs.write_text({})  end, "bad argument #1 to 'write_text' (string expected, got table)")

    -- Argument #2 validation.
    assert.has_error(function() fs.samefile(readme_file, 123)   end, "bad argument #2 to 'samefile' (string expected, got number)")
    assert.has_error(function() fs.write_bytes(readme_file, {}) end, "bad argument #2 to 'write_bytes' (string expected, got table)")
    assert.has_error(function() fs.write_text(readme_file)      end, "bad argument #2 to 'write_text' (string expected, got no value)")
  end)
end)
