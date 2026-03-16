local is = require "mods.is"
local lfs = require "lfs"

local fmt = string.format

describe("mods.is", function()
  local f = function() end
  local co = coroutine.create(f)
  local ct = setmetatable({}, { __call = f })
  local nct = setmetatable({}, { __call = true })

  it("is is callable", function()
    assert.is_callable(is) ---@diagnostic disable-line: undefined-field
  end)

  -- stylua: ignore
  local tests = {
    -----type----|---valid---|-----invalid-----
    { "Boolean"  , false     , 123            },
    { "boolean"  , true      , nil            },
    { "Function" , f         , "abc"          },
    { "Nil"      , nil       , 123            },
    { "Number"   , 123       , "123"          },
    { "String"   , "abc"     , true           },
    { "Table"    , {}        , false          },
    { "Thread"   , co        , f              },

    { "Callable" , ct        , nct            },
    { "callable" , f         , {}             },
    { "False"    , false     , true           },
    { "falsy"    , false     , true           },
    { "Falsy"    , nil       , 123            },
    { "Integer"  , 123       , 13.4           },
    { "integer"  , 123       , nil            },
    { "true"     , true      , false          },
    { "truthy"   , 123       , nil            },
    { "Truthy"   , true      , false          },
    { "userdata" , io.stdout , {}             },

    { "dir"      , "src"       , "README.md"  },
    { "dir"      , "src"       , 123          },
    { "file"     , "README.md" , "MISSING.md" },
    { "file"     , "README.md" , "src"        },
    { "file"     , "README.md" , false        },
    { "path"     , "README.md" , "MISSING.md" },
    { "path"     , "README.md" , false        },
  }

  for i = 1, #tests do
    local tp, valid, invalid = unpack(tests[i], 1, 3)

    it(fmt("is.%s(%s) returns true", tp, inspect(valid)), function()
      assert.is_true(is[tp](valid))
    end)

    it(fmt("is.%s(%s) returns false", tp, inspect(invalid)), function()
      assert.is_false(is[tp](invalid))
    end)

    it(fmt("is(%q, %s) returns true", tp, inspect(valid)), function()
      assert.is_true(is(valid, tp --[[@as string]]))
    end)

    it(fmt("is(%q, %s) returns false", tp, inspect(invalid)), function()
      assert.is_false(is(invalid, tp --[[@as string]]))
    end)
  end

  it("link detects symlink paths when supported", function()
    local root = os.tmpname()
    os.remove(root)
    assert.is_true(lfs.mkdir(root))

    local target = root .. "/target.txt"
    local link = root .. "/link.txt"
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
end)
