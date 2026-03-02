local mods = require("mods")
local template = mods.template
local repr = mods.repr
local fmt = string.format

describe("mods.template", function()
  -- stylua: ignore start
  local function name_func() return "Ada" end
  local function table_func() return { x = 1 } end
  local function nil_func() return nil end
  -- stylua: ignore end

  local tests
  local view = {
    achievement = "a new badge",
    count = 3,
    prize = "A free trip",
    user = {
      active = false,
      admin = true,
      name = "Ada",
      meta = { role = "Engineer" },
      name_func = name_func,
    },
    name_func = name_func,
  }

  -- stylua: ignore
  tests = {
    ---------template-------------------------|------------expected-------------
    -- Basic values
    { "{{prize}} awaits you!"                 , "A free trip awaits you!"      },
    { "You’ve unlocked {{achievement}}!"      , "You’ve unlocked a new badge!" },
    { "{{missing}}"                           , ""                             },
    { "{{missing}} just arrived! {{missing}}" , " just arrived! "              },
    { "{{prize}}{{achievement}}"              , "A free tripa new badge"       },
    { "{{ prize }} is great"                  , "A free trip is great"         },

    -- Lookup
    { "{{.}}"                                 , repr(view)                     },
    { "{{user}}"                              , repr(view.user)                },
    { "{{user.name}}"                         , "Ada"                          },
    { "{{user.meta.role}}"                    , "Engineer"                     },
    { "{{user.missing}}"                      , ""                             },
    { "{{user.name_func}}"                    , "Ada"                          },

    -- Function values
    { "Hi {{name_func}}"                      , "Hi Ada"                       },

    -- Non-string values
    { "Count: {{count}}"                      , "Count: 3"                     },
    { "active: {{user.active}}"               , "active: false"                },
    { "admin: {{user.admin}}"                 , "admin: true"                  },
  }
  -- stylua: ignore end

  for i = 1, #tests do
    local tmpl, expected = unpack(tests[i])
    it(fmt("template(%q, {...}) returns correct result", tmpl), function()
      local res = template(tmpl, view)
      assert.are_equal(expected, res)
    end)
  end

  ------------------
  --- Edge cases ---
  ------------------

  -- stylua: ignore
  tests = {
    ---------template----|--------view---------|------expected-------
    { ""                 , view                , ""                 },
    { "{{ x"             , view                , "{{ x"             },
    { "y }}"             , view                , "y }}"             },
    { "{{...}}"          , view                , ""                 },
    { "{{..}}"           , view                , ""                 },
    { "{{   }}"          , view                , ""                 },
    { "{{}}"             , view                , ""                 },
    { "{{fn}}"           , { fn = nil_func }   , ""                 },
    { "{{fn}}"           , { fn = table_func } , repr({ x = 1 })    },
    { "{{.name}}"        , view                , ""                 },
    { "{{user.}}"        , view                , ""                 },
    { "{{.user}}"        , view                , ""                 },
    { "{{user...}}"      , view                , ""                 },
    { "{{user.name}}"    , { user = "x" }      , ""                 },
    { "{{user..name}}"   , { user = "x" }      , ""                 },
    { "Empty {{}} tag"   , view                , "Empty  tag"       },
    { "Unclosed {{prize" , view                , "Unclosed {{prize" },
  }

  for i = 1, #tests do
    local tmpl, v, expected = unpack(tests[i], 1, 3)
    it(fmt("template(%q, %s) handles edge case", tmpl, inspect(v)), function()
      local res = template(tmpl, v --[[@as table]])
      assert.are_equal(expected, res)
    end)
  end

  -- stylua: ignore
  tests = {
    ---------params--------|-----------------------------errmsg------------------------------
    { { "{{name}}", nil   }, "bad argument #2 to 'template' (expected table, got nil)"      },
    { { "{{name}}", 123   }, "bad argument #2 to 'template' (expected table, got number)"   },
    { { "{{name}}", false }, "bad argument #2 to 'template' (expected table, got boolean)"  },
    { { nil       , {}    }, "bad argument #1 to 'template' (expected string, got nil)"     },
    { { 123       , {}    }, "bad argument #1 to 'template' (expected string, got number)"  },
    { { false     , {}    }, "bad argument #1 to 'template' (expected string, got boolean)" },
  }

  for i = 1, #tests do
    local params, errmsg = unpack(tests[i], 1, 3)
    it(fmt("template(%s) errors", args_repr(params)), function()
      assert.has_error(function()
        ---@diagnostic disable-next-line: param-type-mismatch
        _ = template(unpack(params, 1, 2))
      end, errmsg --[[@as string]])
    end)
  end
end)
