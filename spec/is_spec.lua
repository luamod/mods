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
    -----type----|----ok-----|--bad---
    { "Boolean"  , false     , 123   },
    { "Boolean"  , true      , nil   },
    { "Callable" , ct        , nct   },
    { "Callable" , f         , {}    },
    { "False"    , false     , true  },
    { "Falsy"    , false     , true  },
    { "Falsy"    , nil       , 123   },
    { "Function" , f         , "abc" },
    { "Integer"  , 123       , 13.4  },
    { "Integer"  , 123       , nil   },
    { "Nil"      , nil       , 123   },
    { "Number"   , 123       , "123" },
    { "String"   , "abc"     , true  },
    { "Table"    , {}        , false },
    { "Thread"   , co        , f     },
    { "True"     , true      , false },
    { "Truthy"   , 123       , nil   },
    { "Truthy"   , true      , false },
    { "Userdata" , io.stdout , {}    },
  }

  local types = Set()
  for i = 1, #tests do
    local tp, ok, bad = unpack(tests[i], 1, 3)
    types:add(tp)

    it(fmt("%s(%s) returns true", tp, inspect(ok)), function()
      assert.is_true(is[tp](ok))
    end)

    it(fmt("%s(%s) returns false", tp, inspect(bad)), function()
      assert.is_false(is[tp](bad))
    end)

    it(fmt("is(%q, %s) returns true", tp, inspect(ok)), function()
      assert.is_true(is(ok, tp))
    end)

    it(fmt("is(%q, %s) returns false", tp, inspect(bad)), function()
      assert.is_false(is(bad, tp))
    end)
  end

  for _, tp in ipairs(types:values()) do
    it(fmt("aliases %s to %s", tp, tp:lower()), function()
      assert.are_equal(is[tp], is[tp:lower()])
    end)
  end
end)
