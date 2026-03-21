local helpers = require "spec.helpers"
local lfs = require "lfs"
local mods = require "mods"

local is = mods.is
local path = mods.path

local is_unix = not mods.runtime.is_windows
local fmt = string.format
local tmpname = helpers.tmpname

describe("mods.is", function()
  local fn = function() end
  local co = coroutine.create(fn)
  local ct = setmetatable({}, { __call = fn })
  local nct = setmetatable({}, { __call = true })

  it("is is callable", function()
    assert.is_callable(is) ---@diagnostic disable-line: undefined-field
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
    local root = tmpname()
    assert.is_true(lfs.mkdir(root))

    local target = path.join(root, "target.txt")
    local link = path.join(root, "link.txt")
    local f = assert(io.open(target, "w"))
    f:close()

    local ok = lfs.link(target, link, true)
    if ok then
      assert.is_true(is.link(link))
      os.remove(link)
    end

    os.remove(target)
    lfs.rmdir(root)
  end)

  if is_unix then
    it("path() returns true for a symlink to an existing file", function()
      local root = tmpname()
      assert.is_true(lfs.mkdir(root))

      local target = path.join(root, "target.txt")
      local link = path.join(root, "link.txt")
      local f = assert(io.open(target, "w"))
      f:close()

      assert.is_true(lfs.link(target, link, true))
      assert.is_true(is.path(link))

      os.remove(link)
      os.remove(target)
      lfs.rmdir(root)
    end)

    it("path() returns true for a broken symlink", function()
      local target = tmpname()
      local link = tmpname()

      assert.is_true(lfs.link(target, link, true))
      assert.is_true(is.path(link))

      os.remove(link)
    end)
  end
end)
