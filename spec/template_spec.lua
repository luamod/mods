local template = require("mods.template")

describe("mods.template", function()
  local function name_func()
    return "Ada"
  end

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
  local tests = {
    -- Basic values
    { "{{prize}} awaits you!"                 , "A free trip awaits you!"      },
    { "You’ve unlocked {{achievement}}!"      , "You’ve unlocked a new badge!" },
    { "{{missing}}"                           , ""                             },
    { "{{missing}} just arrived! {{missing}}" , " just arrived! "              },
    { "{{prize}}{{achievement}}"              , "A free tripa new badge"       },
    { "{{ prize }} is great"                  , "A free trip is great"         },

    -- Lookup
    { "{{user.name}}"                         , "Ada"                          },
    { "{{.}}"                              ,    tostring(view)                 },
    { "{{user.meta.role}}"                    , "Engineer"                     },
    { "{{user.missing}}"                      , ""                             },
    { "{{user.name_func}}"                    , "Ada"                          },

    -- Function values
    { "Hi {{name_func}}"                      , "Hi Ada"                       },

    -- Non-string values
    { "Count: {{count}}"                      , "Count: 3"                     },
    { "active: {{user.active}}"               , "active: false"                },
    { "admin: {{user.admin}}"                 , "admin: true"                  },

    -- Edge cases
    { "Empty {{}} tag"                        , "Empty  tag"                   },
    { "Unclosed {{prize"                      , "Unclosed {{prize"             },
  }

  for i = 1, #tests do
    local tmpl, expected = unpack(tests[i])
    it(("render(%q)"):format(tmpl), function()
      local res = template(tmpl, view)
      assert.are_equal(expected, res)
    end)
  end
end)
