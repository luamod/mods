local utils = require("mods.utils")
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
end)
