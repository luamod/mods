---@diagnostic disable: param-type-mismatch, discard-returns

local utils = require("mods.utils")

describe("mods.utils", function()
  local tests

  -------------
  --- quote ---
  -------------

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
    local input, expected = unpack(tests[i], 1, 2)
    local label = ("%q"):format(input)
    it(("quote(%s)"):format(label), function()
      assert.are_equal(expected, utils.quote(input))
    end)
  end

  it("errors on non-string input", function()
    assert.has_error(function()
      utils.quote(false)
    end)
  end)
end)
