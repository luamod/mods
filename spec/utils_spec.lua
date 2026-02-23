local mods = require("mods")
local utils = mods.utils
local fmt = string.format

describe("mods.utils", function()
  local tests

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

  --------------
  --- repr() ---
  --------------

  it("repr() resolves to inspect or mods.repr", function()
    local ok, inspect = pcall(require, "inspect")
    if ok then
      assert.are_equal(inspect, utils.repr)
    else
      assert.are_equal(mods.repr, utils.repr)
    end
  end)
end)
