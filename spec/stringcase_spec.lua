---@diagnostic disable: missing-parameter

local stringcase = require("mods.stringcase")

describe("mods.stringcase", function()
  -- stylua: ignore
  local tests = {
    -----case----|----foo_bar_baz--|--FooBar baz------
    { "capital"  , { "Foo_bar-baz" , "Foobar baz"  } },
    { "sentence" , { "Foo_bar-baz" , "FooBar baz"  } },
    { "swap"     , { "FOO_BAR-BAZ" , "fOObAR BAZ"  } },
    { "lower"    , { "foo_bar-baz" , "foobar baz"  } },
    { "upper"    , { "FOO_BAR-BAZ" , "FOOBAR BAZ"  } },
    { "acronym"  , {             "FBB"             } },
    { "camel"    , {          "fooBarBaz"          } },
    { "pascal"   , {          "FooBarBaz"          } },
    { "snake"    , {         "foo_bar_baz"         } },
    { "kebab"    , {         "foo-bar-baz"         } },
    { "title"    , {         "Foo Bar Baz"         } },
    { "dot"      , {         "foo.bar.baz"         } },
    { "path"     , {         "foo/bar/baz"         } },
    { "space"    , {         "foo bar baz"         } },
    { "constant" , {         "FOO_BAR_BAZ"         } },
  }

  for i = 1, #tests do
    local fname, expected = unpack(tests[i])
    for j, s in ipairs({ "foo_bar-baz", "FooBar baz" }) do
      it(("converts to %s(%q)"):format(fname, s), function()
        local res = stringcase[fname](s)
        assert.are_equal(expected[j] or expected[1], res)
      end)
      it(("returns exactly one string %s(%q)"):format(fname, s), function()
        assert.are_same({ expected[j] or expected[1] }, { stringcase[fname](s) })
      end)
    end
  end
end)
