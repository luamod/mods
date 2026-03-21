local fs = require "mods.fs"
local lfs = require "lfs"

describe("mods.fs", function()
  it("aliases getcwd() to lfs.currentdir", function()
    assert.is_function(fs.getcwd)
    assert.are_equal(lfs.currentdir, fs.getcwd)
  end)
end)
