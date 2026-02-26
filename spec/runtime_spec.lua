local runtime = require("mods.runtime")

describe("mods.runtime", function()
  it("exposes version metadata", function()
    assert.are_equal(_VERSION, runtime.version)
    assert.is_number(runtime.major)
    assert.is_number(runtime.minor)
    assert.is_number(runtime.version_num)
    assert.is_boolean(runtime.is_lua51)
    assert.is_boolean(runtime.is_lua52)
    assert.is_boolean(runtime.is_lua53)
    assert.is_boolean(runtime.is_lua54)
    assert.is_boolean(runtime.is_luajit)
  end)

  it("flags Lua versions consistently", function()
    if _VERSION == "Lua 5.1" then
      assert.is_true(runtime.is_lua51)
      assert.is_false(runtime.is_lua52)
      assert.is_false(runtime.is_lua53)
      assert.is_false(runtime.is_lua54)
    elseif _VERSION == "Lua 5.2" then
      assert.is_false(runtime.is_lua51)
      assert.is_true(runtime.is_lua52)
      assert.is_false(runtime.is_lua53)
      assert.is_false(runtime.is_lua54)
    elseif _VERSION == "Lua 5.3" then
      assert.is_false(runtime.is_lua51)
      assert.is_false(runtime.is_lua52)
      assert.is_true(runtime.is_lua53)
      assert.is_false(runtime.is_lua54)
    elseif _VERSION == "Lua 5.4" then
      assert.is_false(runtime.is_lua51)
      assert.is_false(runtime.is_lua52)
      assert.is_false(runtime.is_lua53)
      assert.is_true(runtime.is_lua54)
    end
  end)

  it("version_num encodes major/minor versions", function()
    assert.are_equal(500 + runtime.minor, runtime.version_num)

    if _VERSION == "Lua 5.1" then
      assert.are_equal(501, runtime.version_num)
    elseif _VERSION == "Lua 5.2" then
      assert.are_equal(502, runtime.version_num)
    elseif _VERSION == "Lua 5.3" then
      assert.are_equal(503, runtime.version_num)
    elseif _VERSION == "Lua 5.4" then
      assert.are_equal(504, runtime.version_num)
    end
  end)
end)
