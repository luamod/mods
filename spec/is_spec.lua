local mods = require("mods")
local is = mods.is
local Set = mods.Set
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
      assert.is_true(is(valid, tp))
    end)

    it(fmt("is(%q, %s) returns false", tp, inspect(invalid)), function()
      assert.is_false(is(invalid, tp))
    end)
  end
end)
