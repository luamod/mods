local lfs = require "lfs"
local mods = require "mods"

local fs = mods.fs
local path = mods.path
local is_unix = not mods.runtime.is_windows

local fmt = string.format

describe("mods.fs", function()
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

  it("exposes lstat() and stat() as LFS aliases", function()
    assert.is_table(fs.lstat(readme_file))
    assert.is_table(fs.stat(readme_file))
    assert.are_equal(lfs.symlinkattributes, fs.lstat)
    assert.are_equal(lfs.attributes, fs.stat)
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
        local root = os.tmpname()
        local target = path.join(root, "target.txt")
        local link = path.join(root, "hardlink.txt")

        os.remove(root)
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
        local link = os.tmpname()
        os.remove(link)
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
    assert.has_error(function() fs.getatime(false) end, "bad argument #1 to 'getatime' (string expected, got boolean)")
    assert.has_error(function() fs.getctime(0)     end, "bad argument #1 to 'getctime' (string expected, got number)")
    assert.has_error(function() fs.getmtime()      end, "bad argument #1 to 'getmtime' (string expected, got no value)")
    assert.has_error(function() fs.getsize()       end, "bad argument #1 to 'getsize' (string expected, got no value)")

    -- Argument #2 validation.
    assert.has_error(function() fs.samefile("README.md",123) end, "bad argument #2 to 'samefile' (string expected, got number)")
  end)
end)
