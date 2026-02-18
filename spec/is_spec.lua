---@diagnostic disable: undefined-field, param-type-mismatch, need-check-nil

local is = require("mods.is")
local fmt = string.format

describe("mods.is", function()
  local f = function() end
  local co = coroutine.create(f)
  local ct = setmetatable({}, { __call = f })
  local nct = setmetatable({}, { __call = true })

  it("is is callable", function()
    assert.is_callable(is)
  end)

  -- stylua: ignore
  local tests = {
    -----type----|----ok-----|-not-ok---
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

  for i = 1, #tests do
    local tp, v1, v2 = unpack(tests[i], 1, 3)

    it(fmt("exposes is.%s", tp), function()
      assert.is_function(is[tp])
    end)

    it(fmt("exposes is.%s", tp:lower()), function()
      assert.is_function(is[tp:lower()])
    end)

    it(fmt("is.%s returns true for %s", tp, inspect(v1)), function()
      assert.is_true(is[tp](v1))
    end)

    it(fmt("is.%s returns false for %s", tp, inspect(v2)), function()
      assert.is_false(is[tp](v2))
    end)

    it(fmt("is(%q, %s) returns true", tp, inspect(v1)), function()
      assert.is_true(is(v1, tp))
    end)

    it(fmt("is(%q, %s) returns false", tp, inspect(v2)), function()
      assert.is_false(is(v2, tp))
    end)
  end
end)
