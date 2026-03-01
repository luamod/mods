---@diagnostic disable: undefined-field, need-check-nil, inject-field

local mods = require("mods")
local validate = mods.validate
local capitalize = mods.stringcase.capital
local fmt = string.format
local quote = mods.utils.quote

local function render_value(v)
  return type(v) == "string" and quote(v) or tostring(v)
end

describe("mods.validate", function()
  local fn = function() end
  local co = coroutine.create(fn)
  local ct = setmetatable({}, { __call = fn })
  local nct = setmetatable({}, { __call = true })
  local empty = {}

  it("exposes messages table", function()
    assert.are_equal("table", type(validate.messages))
  end)

  it("is callable", function()
    assert.Callable(validate)
  end)

  it("defaults to truthy check when type is omitted", function()
    assert.are_same({ true }, { validate(true) })
    assert.are_same({ true }, { validate(1) })
    assert.are_same({ false, "expected truthy value, got no value" }, { validate() })
  end)

  it("supports case-insensitive key lookup", function()
    assert.are_equal(validate.number, validate.NumBer)
    assert.are_same({ true }, { validate.NumBer(1) })
  end)

  -- stylua: ignore
  local tests = {
    -----type----|----valid----|----invalid---|--------------------------errmsg--------------------------
    { "boolean"  , false       , 123          , "expected boolean, got number"                          },
    { "boolean"  , true        , nil          , "expected boolean, got no value"                        },
    { "function" , fn          , "abc"        , "expected function, got string"                         },
    { "nil"      , nil         , 123          , "expected nil, got number"                              },
    { "number"   , 123         , "123"        , "expected number, got string"                           },
    { "string"   , "abc"       , true         , "expected string, got boolean"                          },
    { "table"    , {}          , false        , "expected table, got boolean"                           },
    { "thread"   , co          , fn           , "expected thread, got function"                         },
    { "userdata" , io.stdout   , {}           , "expected userdata, got table"                          },

    { "callable" , ct          , nct          , fmt("expected callable value, got %s", tostring(nct))   },
    { "callable" , fn          , empty        , fmt("expected callable value, got %s", tostring(empty)) },
    { "false"    , false       , true         , "expected false value, got true"                        },
    { "falsy"    , false       , true         , "expected falsy value, got true"                        },
    { "falsy"    , nil         , 123          , "expected falsy value, got 123"                         },
    { "integer"  , 123         , 13.4         , "expected integer value, got 13.4"                      },
    { "integer"  , 123         , nil          , "expected integer value, got no value"                  },
    { "integer"  , 123         , "abc"        , 'expected integer value, got "abc"'                     },
    { "true"     , true        , false        , "expected true value, got false"                        },
    { "truthy"   , 123         , nil          , "expected truthy value, got no value"                   },
    { "truthy"   , true        , false        , "expected truthy value, got false"                      },

    { "file"     , "README.md" , "src"        , '"src" is not a valid file path'                        },
    { "file"     , "README.md" , false        , "false is not a valid file path"                        },
    { "file"     , "README.md" , "MISSING.md" , '"MISSING.md" is not a valid file path'                 },
    { "dir"      , "src"       , "README.md"  , '"README.md" is not a valid dir path'                   },
    { "dir"      , "src"       , 123          , '123 is not a valid dir path'                           },
  }
  for i = 1, #tests do
    local tp, valid, invalid, msg = unpack(tests[i], 1, 4)
    local fname = capitalize(tp--[[@as string]])

    it(fmt("validate.%s is function", fname), function()
      assert.Function(validate[fname])
    end)

    it(fmt("validate.%s(%s) returns true", fname, inspect(valid)), function()
      assert.are_same({ true }, { validate[fname](valid) })
      assert.are_same({ true }, { validate(valid, tp) })
    end)

    it(fmt("validate.%s(%s) returns false", fname, inspect(invalid)), function()
      assert.are_same({ false, msg }, { validate[fname](invalid) })
      assert.are_same({ false, msg }, { validate(invalid, tp) })
    end)
  end

  it("uses default type-check message template", function()
    assert.are_same({ false, "expected number, got string" }, { validate.number("x") })
  end)

  it("uses default value-check message template", function()
    local t = {}
    assert.are_same({ false, fmt("expected callable value, got %s", render_value(t)) }, { validate.callable(t) })
  end)

  it("uses default path-check message template", function()
    assert.are_same({ false, '"README.md" is not a valid dir path' }, { validate.dir("README.md") })
  end)

  it("supports custom messages", function()
    local prev = validate.messages.number
    validate.messages.number = "need {{expected}}, got {{got}}"

    assert.are_same({ false, "need number, got string" }, { validate.number("x") })
    assert.are_same({ false, "need number, got string" }, { validate("x", "number") })

    validate.messages.number = prev
  end)

  describe("register", function()
    it("registers custom validator and supports callable dispatch", function()
      validate.register("odd", function(v)
        return type(v) == "number" and v % 2 == 1
      end)

      assert.are_same({ true }, { validate.odd(3) })
      assert.are_same({ true }, { validate(3, "odd") })
      assert.are_same({ false, "expected odd, got number" }, { validate.odd(2) })
      assert.are_same({ false, "expected odd, got string" }, { validate("x", "odd") })
    end)

    it("supports custom default message template", function()
      validate.register("even", function(v)
        return type(v) == "number" and v % 2 == 0
      end, "expected {{expected}} check, got {{value}}")

      assert.are_same({ false, "expected even check, got 3" }, { validate.even(3) })
    end)

    it("allows overriding existing validators", function()
      validate.register("number", function(v)
        return v == 42
      end, "expected {{expected}}, got {{value}}")

      assert.are_same({ true }, { validate.number(42) })
      assert.are_same({ false, "expected number, got 1" }, { validate.number(1) })

      validate.register("number", function(v)
        return type(v) == "number"
      end)
    end)
  end)
end)
