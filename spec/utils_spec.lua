local utils = require "mods.utils"

local fmt = string.format

describe("mods.utils", function()
  local tests
  local fn = function() end

  ---------------
  --- quote() ---
  ---------------

  -- stylua: ignore
  tests = {
    --------------input--------------|--------------expected---------------
    { "foo"                          , '"foo"'                            },
    { ""                             , '""'                               },
    { ""                             , '""'                               },
    { '"'                            , [['"']]                            },
    { "'"                            , [["'"]]                            },
    { "it's ok"                      , [["it's ok"]]                      },
    { [[a "b" c]]                    , [['a "b" c']]                      },
    { "a 'b' c"                      , [["a 'b' c"]]                      },
    { "bar_baz"                      , '"bar_baz"'                        },
    { [[he said "hi"]]               , [['he said "hi"']]                 },
    { "hello world"                  , '"hello world"'                    },
    { [[back\slash]]                 , [["back\slash"]]                   },
    { [['mix "quotes" and 'single']] , [["'mix \"quotes\" and 'single'"]] },
  }

  for i = 1, #tests do
    local input, expected = unpack(tests[i])
    it(fmt("quote(%q) returns correct result", input), function()
      assert.are_equal(expected, utils.quote(input))
    end)
  end

  -----------------
  --- keypath() ---
  -----------------

  -- stylua: ignore
  tests = {
    -------------params-------------|-------------expected--------------
    { {                           } , ""                               },
    { { "ctx", "end"              } , 'ctx["end"]'                     },
    { { "ctx", "invalid-key"      } , 'ctx["invalid-key"]'             },
    { { "ctx", "users", 1, "name" } , "ctx.users[1].name"              },
    { { "t"                       } , "t"                              },
    { { "t", "a", "b", "c"        } , "t.a.b.c"                        },
    { { fn, "end"                 } , fmt('[%s]["end"]', tostring(fn)) },
  }

  for i = 1, #tests do
    local params, expected = unpack(tests[i], 1, 2)
    it(fmt("keypath(%s) returns correct result", args_repr(params)), function()
      ---@diagnostic disable-next-line: param-type-mismatch
      assert.are_equal(expected, utils.keypath(unpack(params)))
    end)
  end

  -------------------
  --- list_args() ---
  -------------------

  -- stylua: ignore
  tests = {
    ---------input----------|------expected--------
    { {                   } , ""                  },
    { { "a", 1, true      } , '"a", 1, true'      },
    { { "x", "y", "z", {} } , '"x", "y", "z", {}' },
  }

  for i = 1, #tests do
    local input, expected = unpack(tests[i], 1, 2)
    it(fmt("list_args(%s) returns correct result", args_repr(input)), function()
      assert.are_equal(expected, utils.list_args(input))
    end)
  end

  describe("assert_arg()", function()
    it("returns same value when validation passes", function()
      assert.are_equal("abc", utils.assert_arg(1, "abc", "string"))
      assert.are_equal(123, utils.assert_arg(2, 123, "number"))
    end)

    it("returns nil when optional and value is nil", function()
      assert.is_nil(utils.assert_arg(1, nil, "string", true))
    end)

    it("defaults to truthy check when type is omitted", function()
      assert.are_equal("ok", utils.assert_arg(1, "ok"))
      assert.has_error(function()
        utils.assert_arg(2, false)
      end, "bad argument #2 (expected truthy value, got false)")
    end)

    it("throws with bad argument prefix on validation failure", function()
      assert.has_error(function()
        utils.assert_arg(3, 123, "string")
      end, "bad argument #3 (expected string, got number)")
    end)

    it("includes caller function name when available", function()
      local function needs_string(v)
        local out = utils.assert_arg(1, v, "string")
        return out
      end

      assert.has_error(function()
        needs_string(123)
      end, "bad argument #1 to 'needs_string' (expected string, got number)")
    end)

    it("passes custom message template to validate when provided", function()
      assert.has_error(function()
        utils.assert_arg(1, 123, "string", false, "need {{expected}}, got {{got}}")
      end, "bad argument #1 (need string, got number)")
    end)
  end)

  describe("validate()", function()
    it("errors with label prefix on validation failure", function()
      assert.has_error(function()
        utils.validate("count", "x", "number")
      end, "count: expected number, got string")
    end)

    it("uses keypath when label is a table", function()
      assert.has_error(function()
        utils.validate({ "ctx", "users", 1, "name" }, 123, "string")
      end, "ctx.users[1].name: expected string, got number")
    end)

    it("does not error when optional and value is nil", function()
      assert.no_error(function()
        utils.validate("name", nil, "string", true)
      end)
    end)

    it("passes custom message template to validate when provided", function()
      assert.has_error(function()
        utils.validate("count", "x", "number", false, "need {{expected}}, got {{got}}")
      end, "count: need number, got string")
    end)
  end)
end)
