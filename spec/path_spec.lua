local is = require "mods.is"
local lfs = require "lfs"
local ntpath = require "mods.ntpath"
local path = require "mods.path"
local posixpath = require "mods.posixpath"
local runtime = require "mods.runtime"
local tbl = require "mods.tbl"

local tbl_keys = tbl.keys
local is_windows = runtime.is_windows

local fmt = string.format

describe("mods.path", function()
  for _, fname in ipairs(tbl_keys(is_windows and ntpath or posixpath)) do
    it(fmt("path.%s equals %s.%s", fname, (is_windows and "ntpath" or "posixpath"), fname), function()
      assert.are_equal((is_windows and ntpath or posixpath)[fname], path[fname])
    end)
  end

  for _, fname in ipairs(is._path_checks) do ---@diagnostic disable-line: invisible
    it(fmt("path.%s equals is.%s", fname, fname), function()
      assert.is_function(path["is" .. fname])
      assert.are_equal(is[fname], path["is" .. fname])
    end)
  end

  it("aliases getcwd() to lfs.currentdir", function()
    assert.is_function(path.getcwd)
    assert.are_equal(lfs.currentdir, path.getcwd)
  end)
end)
