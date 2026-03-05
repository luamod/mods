local mods = require("mods")
local path = mods.path
local fmt = string.format

describe("mods.path", function()
  it("is exposed from mods", function()
    assert.is_table(path)
  end)

  -- stylua: ignore
  local splitext_cases = {
    { { "foo.bar"        , "/", nil, "." }, { "foo"             , ".bar" } },
    { { "foo.boo.bar"    , "/", nil, "." }, { "foo.boo"         , ".bar" } },
    { { ".cshrc"         , "/", nil, "." }, { ".cshrc"          , ""     } },
    { { "..."            , "/", nil, "." }, { "..."             , ""     } },
    { { "...."           , "/", nil, "." }, { "...."            , ""     } },
    { { "a/b/c.txt"      , "/", nil, "." }, { "a/b/c"           , ".txt" } },
    { { "abc.def/path.txt/", "/", nil, "." }, { "abc.def/path.txt/", ""  } },
    { { [[C:\a\b.txt]]  , "\\", "/", "." }, { [[C:\a\b]]    , ".txt" } },
    { { [[C:\a\.bashrc]], "\\", "/", "." }, { [[C:\a\.bashrc]], ""    } },
  }

  for i = 1, #splitext_cases do
    local params, expected = unpack(splitext_cases[i], 1, 2)
    it(fmt("_splitext(%s)", args_repr(params)), function()
      assert.are_same(expected, { path._splitext(unpack(params)) })
    end)
  end
end)
