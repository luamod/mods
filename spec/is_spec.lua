local helpers = require "spec.helpers"
local mods = require "mods"

local fs = mods.fs
local is = mods.is
local path = mods.path

local fmt = string.format
local make_tmp_dir = helpers.make_tmp_dir
local tmpname = helpers.tmpname

describe("mods.is", function()
  local is_unix = not mods.runtime.is_windows
  local fn = function() end
  local co = coroutine.create(fn)
  local ct = setmetatable({}, { __call = fn })
  local nct = setmetatable({}, { __call = true })

  it("is is callable", function()
    assert.is_callable(is)
  end)

  -- stylua: ignore
  local tests = {
    -----type----|----valid----|-----invalid----
    { "Boolean"  , false       , 123          },
    { "boolean"  , true        , nil          },
    { "Function" , fn          , "abc"        },
    { "Nil"      , nil         , 123          },
    { "Number"   , 123         , "123"        },
    { "String"   , "abc"       , true         },
    { "Table"    , {}          , false        },
    { "Thread"   , co          , fn           },

    { "Callable" , ct          , nct          },
    { "callable" , fn          , {}           },
    { "False"    , false       , true         },
    { "falsy"    , false       , true         },
    { "Falsy"    , nil         , 123          },
    { "Integer"  , 123         , 13.4         },
    { "integer"  , 123         , nil          },
    { "true"     , true        , false        },
    { "truthy"   , 123         , nil          },
    { "Truthy"   , true        , false        },
    { "userdata" , io.stdout   , {}           },

    { "dir"      , "src"       , "README.md"  },
    { "dir"      , "src"       , 123          },
    { "file"     , "README.md" , "MISSING.md" },
    { "file"     , "README.md" , "src"        },
    { "file"     , "README.md" , false        },
    { "path"     , "README.md" , "MISSING.md" },
    { "path"     , "README.md" , false        },
  }

  for i = 1, #tests do
    local tp, valid, invalid = unpack(tests[i] --[[@as {[1]:string, [2]:any, [3]:any}]], 1, 3)

    it(fmt("is.%s(%s) returns true", tp, inspect(valid)), function()
      assert.is_true(is[tp](valid))
    end)

    it(fmt("is.%s(%s) returns false", tp, inspect(invalid)), function()
      assert.is_false(is[tp](invalid))
    end)

    it(fmt("is(%q, %s) returns true", tp, inspect(valid)), function()
      assert.is_true(is(valid, tp))
    end)

    it(fmt("is(%q, %s) returns false", tp, inspect(invalid)), function()
      assert.is_false(is(invalid, tp))
    end)
  end

  it("link detects symlink paths when supported", function()
    local root = make_tmp_dir()

    local target = path.join(root, "target.txt")
    local link = path.join(root, "link.txt")
    assert.is_true(fs.touch(target))

    local ok = fs.symlink(target, link)
    if ok then
      assert.is_true(is.link(link))
    end

    assert.is_true(fs.rm(root, true))
  end)

  if is_unix then
    it("path() returns true for a symlink to an existing file", function()
      local root = make_tmp_dir()

      local target = path.join(root, "target.txt")
      local link = path.join(root, "link.txt")
      assert.is_true(fs.touch(target))
      assert.is_true(fs.symlink(target, link))
      assert.is_true(is.path(link))
      assert.is_true(fs.rm(root, true))
    end)

    it("path() returns true for a broken symlink", function()
      local target = tmpname()
      local link = tmpname()
      assert.is_true(fs.symlink(target, link))
      assert.is_true(is.path(link))
      assert.is_true(fs.rm(link))
    end)
  end
end)
