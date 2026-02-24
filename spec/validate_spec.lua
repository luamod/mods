---@diagnostic disable: undefined-field, need-check-nil, inject-field

local mods = require("mods")
local validate = mods.validate
local quote = mods.utils.quote
local fmt = string.format

local function render_value(v)
  return type(v) == "string" and quote(v) or tostring(v)
end

describe("mods.validate", function()
  local fn = function() end
  local co = coroutine.create(fn)
  local ct = setmetatable({}, { __call = fn })
  local nct = setmetatable({}, { __call = true })
  local tests

  it("exposes positive and negative message tables", function()
    assert.are_equal("table", type(validate.messages.positive))
    assert.are_equal("table", type(validate.messages.negative))
  end)

  -- stylua: ignore
  tests = {
    { "validate"  , validate           },
    { "is"        , validate.is        },
    { "IS"        , validate.Is        },
    { "I_s"       , validate.I_s       },
    { "is_not"    , validate.is_not    },
    { "IS_NOT"    , validate.IS_NOT    },
    { "isNot"     , validate.isNot     },
    { "IsnoT"     , validate.IsnoT     },
    { "iSnOt"     , validate.iSnOt     },
    { "Not"       , validate.Not       },
    { "noT"       , validate.noT       },
    { "not"       , validate["not"]    },
    { "is['not']" , validate.is["not"] },
    { "n_oT"      , validate.n_oT      },
    { "n_o___T"   , validate.n_o___T   },
    { "I_s_N_o_T" , validate.I_s_N_o_T },
    { "I_s_NoT"   , validate.I_s_NoT   },
    { "Is_N_o_T"  , validate.Is_N_o_T  },
  }

  for i = 1, #tests do
    local name, v = unpack(tests[i])
    it(name .. " is callable", function()
      assert.Callable(v)
    end)
  end

  -- stylua: ignore
  tests = {
    "boolean"  , "Boolean"  ,
    "function" , "FunctIOn" ,
    "nil"      , "Nil"      ,
    "number"   , "Number"   ,
    "string"   , "String"   ,
    "table"    , "Table"    ,
    "thread"   , "Thread"   ,
    "userdata" , "UserData" ,
    "callable" , "CallAble" ,
    "false"    , "FalsE"    ,
    "falsy"    , "FALsy"    ,
    "integer"  , "Integer"  ,
    "true"     , "TrUe"     ,
    "truthy"   , "Truthy"   ,
  }

  for _, v in ipairs(tests) do
      -- stylua: ignore start
    it(fmt("%s is function", v), function() assert.is_function(validate[v]) end)
    it(fmt("is.%s is function", v), function() assert.is_function(validate.is[v]) end)
    it(fmt("IS.%s is function", v), function() assert.is_function(validate.IS[v]) end)
    it(fmt("is_%s is function", v), function() assert.is_function(validate["is_" .. v]) end)
    it(fmt("IS_%s is function", v), function() assert.is_function(validate["IS_" .. v]) end)
    it(fmt("IsNoT%s is function", v), function() assert.is_function(validate.IsNoT[v]) end)
    it(fmt("is.NoT%s is function", v), function() assert.is_function(validate.is.NoT[v]) end)
    it(fmt("I_s_N_o_T%s is function", v), function() assert.is_function(validate.I_s_N_o_T[v]) end)
  end

  -- stylua: ignore
  tests = {
    -----type----|------v1-----|------v2------|------------------errmsg------------------
    { "boolean"  , false       , 123          , "expected boolean, got number"          },
    { "boolean"  , true        , nil          , "expected boolean, got nil"             },
    { "function" , fn          , "abc"        , "expected function, got string"         },
    { "nil"      , nil         , 123          , "expected nil, got number"              },
    { "number"   , 123         , "123"        , "expected number, got string"           },
    { "string"   , "abc"       , true         , "expected string, got boolean"          },
    { "table"    , {}          , false        , "expected table, got boolean"           },
    { "thread"   , co          , fn           , "expected thread, got function"         },
    { "userdata" , io.stdout   , {}           , "expected userdata, got table"          },

    { "callable" , ct          , nct          , "expected callable, got table"          },
    { "callable" , fn          , {}           , "expected callable, got table"          },
    { "false"    , false       , true         , "expected false, got true"              },
    { "falsy"    , false       , true         , "expected falsy, got boolean"           },
    { "falsy"    , nil         , 123          , "expected falsy, got number"            },
    { "integer"  , 123         , 13.4         , "expected integer, got 13.4"            },
    { "integer"  , 123         , nil          , "expected integer, got nil"             },
    { "integer"  , 123         , "abc"        , 'expected integer, got "abc"'           },
    { "true"     , true        , false        , "expected true, got false"              },
    { "truthy"   , 123         , nil          , "expected truthy, got nil"              },
    { "truthy"   , true        , false        , "expected truthy, got boolean"          },

    { "file"     , "README.md" , "src"        , '"src" is not a valid file path'        },
    { "file"     , "README.md" , false        , "false is not a valid file path"        },
    { "file"     , "README.md" , "MISSING.md" , '"MISSING.md" is not a valid file path' },
    { "dir"      , "src"       , "README.md"  , '"README.md" is not a valid dir path'   },
    { "dir"      , "src"       , 123          , '123 is not a valid dir path'           },
  }
  -- stylua: ignore end

  for i = 1, #tests do
    local tp, v1, v2, errmsg = unpack(tests[i], 1, 4)

    describe("returns true", function()
      it(fmt("%s(%s)", tp, inspect(v1)), function()
        assert.are_same({ true }, { validate[tp](v1) })
      end)

      it(fmt("validate(%q, %s)", tp, inspect(v1)), function()
        assert.are_same({ true }, { validate(v1, tp) })
      end)
    end)

    describe("returns false", function()
      it(fmt("validate(%q, %s)", tp, inspect(v2)), function()
        assert.are_same({ false, errmsg }, { validate(v2, tp) })
      end)

      it(fmt("%s(%s)", tp, inspect(v2)), function()
        assert.are_same({ false, errmsg }, { validate[tp](v2) })
      end)
    end)

    describe("is_not", function()
      local not_errmsg = tp == "integer" and "expected non-integer, got " .. render_value(v1) or "expected not " .. tp
      if tp == "file" or tp == "dir" then
        return
      end

      it(fmt("is_not.%s(%s)", tp, inspect(v2)), function()
        assert.are_same({ true }, { validate.is_not[tp](v2) })
      end)

      it(fmt("Not.%s(%s)", tp, inspect(v2)), function()
        assert.are_same({ true }, { validate.Not[tp](v2) })
      end)

      it(fmt("is_not(%s, %q)", inspect(v2), tp), function()
        assert.are_same({ true }, { validate.is_not(v2, tp) })
      end)

      it(fmt("is_not.%s(%s)", tp, inspect(v1)), function()
        assert.are_same({ false, not_errmsg }, { validate.is_not[tp](v1) })
      end)

      it(fmt("Not.%s(%s)", tp, inspect(v1)), function()
        assert.are_same({ false, not_errmsg }, { validate.Not[tp](v1) })
      end)

      it(fmt("is_not(%q, %s)", tp, inspect(v1)), function()
        assert.are_same({ false, not_errmsg }, { validate.is_not(v1, tp) })
      end)
    end)

    describe("custom positive messages", function()
      local template = "{{got}} should be {{expected}}\nPassed: {{value}}"
      local expected
      if tp == "false" or tp == "true" then
        expected = tostring(v2)
      elseif tp == "file" or tp == "dir" then
        expected = "invalid path"
      else
        expected = type(v2)
      end
      local custom_errmsg = fmt("%s should be %s\nPassed: %s", expected, tp, render_value(v2))
      local prev_template = validate.messages.positive[tp]
      validate.messages.positive[tp] = template

      it(fmt("%s(%s) returns false", tp, inspect(v2)), function()
        assert.are_same({ false, custom_errmsg }, { validate.is[tp](v2) })
      end)

      it(fmt("validate(%q, %s) returns false", tp, inspect(v2)), function()
        assert.are_same({ false, custom_errmsg }, { validate(v2, tp) })
      end)

      teardown(function()
        validate.messages.positive[tp] = prev_template
      end)
    end)

    describe("custom negative messages", function()
      if tp == "file" or tp == "dir" then
        return
      end

      local template = "{{got}} should not be {{expected}}\nPassed: {{value}}"
      local expected = (tp == "false" or tp == "true") and tostring(v1) or type(v1)
      local custom_errmsg = fmt("%s should not be %s\nPassed: %s", expected, tp, render_value(v1))
      local prev_template = validate.messages.negative[tp]
      validate.messages.negative[tp] = template

      it(fmt("is_not.%s(%s) returns false", tp, inspect(v1)), function()
        assert.are_same({ false, custom_errmsg }, { validate.is_not[tp](v1) })
      end)

      it(fmt("is_not(%q, %s) returns false", tp, inspect(v1)), function()
        assert.are_same({ false, custom_errmsg }, { validate.is_not(v1, tp) })
      end)

      teardown(function()
        validate.messages.negative[tp] = prev_template
      end)
    end)
  end

  describe("on_fail", function()
    it("returns error message when on_fail is not set", function()
      validate.on_fail = nil
      assert.are_same({ false, "expected number, got string" }, { validate.number("abc") })
    end)

    it("errors on non-function", function()
      assert.has_error(function()
        ---@diagnostic disable-next-line: assign-type-mismatch
        validate.on_fail = 123
      end, "validate.on_fail must be a function")
    end)

    it("uses handler return value when on_fail returns one", function()
      local seen
      validate.on_fail = function(errmsg)
        seen = errmsg
        return "custom message"
      end

      local ok, msg = validate.number("abc")
      assert.is_false(ok)
      assert.are_equal("custom message", msg)
      assert.are_equal("expected number, got string", seen)
    end)

    it("returns default message when on_fail returns nil", function()
      validate.on_fail = function() end
      assert.are_same({ false, "expected integer, got 1.5" }, { validate.integer(1.5) })
    end)

    it("returns default message when on_fail returns false", function()
      validate.on_fail = function()
        return false
      end
      assert.are_same({ false, "expected number, got string" }, { validate.number("abc") })
    end)

    it("works when handler raises an error", function()
      validate.on_fail = error
      assert.has_error(function()
        validate.number("abc")
      end, "expected number, got string")
    end)
  end)

  describe("api surface edge cases", function()
    teardown(function()
      validate.on_fail = nil
      validate.foo = nil
      validate.is.list = nil
      validate.is_not.notice = nil
    end)

    it("does not override on_fail when assigning unrelated fields", function()
      validate.on_fail = nil
      validate.foo = 123
      assert.are_equal(123, validate.foo)
      assert.is_nil(validate.on_fail)
      assert.are_same({ false, "expected number, got string" }, { validate.number("abc") })
    end)

    it("defaults callable validate(v) to nil check", function()
      assert.are_same({ true }, { validate() })
      assert.are_same({ false, "expected nil, got number" }, { validate(1) })
    end)

    it("defaults callable is_not(v) to negated nil check", function()
      assert.are_same({ false, "expected not nil" }, { validate.is_not() })
      assert.are_same({ true }, { validate.is_not(1) })
    end)

    it("accepts callable checks for known aliases", function()
      assert.are_same({ true }, { validate(1, "number") })
      assert.are_same({ true }, { validate(1, "NumBeR") })
      assert.are_same({ false, "expected number, got string" }, { validate("x", "number") })
      assert.are_same({ false, "expected number, got string" }, { validate("x", "NumBeR") })
    end)

    local function assert_nil_lookup(t, k)
      assert.has_no.errors(function()
        local _ = t[k]
      end)
      assert.is_nil(t[k])
    end

    it("validate returns nil for non-string index keys without raising", function()
      assert_nil_lookup(validate, 1)
      assert_nil_lookup(validate, true)
      assert_nil_lookup(validate, {})
    end)

    it("validate.is returns nil for non-string index keys without raising", function()
      assert_nil_lookup(validate.is, 1)
      assert_nil_lookup(validate.is, true)
      assert_nil_lookup(validate.is, {})
    end)

    it("validate.is_not returns nil for non-string index keys without raising", function()
      assert_nil_lookup(validate.is_not, 1)
      assert_nil_lookup(validate.is_not, true)
      assert_nil_lookup(validate.is_not, {})
    end)

    it("keeps alias lookup stable for names containing is/not", function()
      local list_validator = function()
        return true
      end
      local notice_validator = function()
        return true
      end
      validate.is.list = list_validator
      validate.is_not.notice = notice_validator

      assert.are_equal(list_validator, validate.List)
      assert.are_equal(list_validator, validate.is.List)
      assert.are_equal(list_validator, validate.islist)

      assert.are_equal(notice_validator, validate.is_not.notIce)
    end)

    it("supports prefixed alias lookup on validate.is", function()
      assert.are_same({ true }, { validate.is.isnumber(1) })
      assert.are_same({ false, "expected number, got string" }, { validate.is.isnumber("x") })
    end)

    it("handles non-string callable type names without errors", function()
      assert.are_same({ false, "expected 123, got number" }, { validate(1, 123) })
      assert.are_same({ true }, { validate.is_not(1, 123) })
    end)
  end)
end)
