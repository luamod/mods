local ops = require("mods.operator")

describe("mods.operator", function()
  -- stylua: ignore start
  local function sum(a, b) return a + b end
  local tbl = { a = 1 }
  local tests = {
    ---operator--|---------args---------|-expected---
    { "add"      , { 3, 4             } , 7       },
    { "sub"      , { 3, 4             } , -1      },
    { "mul"      , { 3, 4             } , 12      },
    { "div"      , { 10, 4            } , 2.5     },
    { "idiv"     , { 5, 2             } , 2       },
    { "mod"      , { 5, 2             } , 1       },
    { "pow"      , { 2, 4             } , 16      },
    { "unm"      , { -3               } , 3       },

    { "eq"       , { 1, 1             } , true    },
    { "neq"      , { 1, 2             } , true    },
    { "lt"       , { 1, 2             } , true    },
    { "le"       , { 2, 2             } , true    },
    { "gt"       , { 3, 2             } , true    },
    { "ge"       , { 2, 2             } , true    },

    { "land"     , { "hello", "world" } , "world" },
    { "land"     , { false, true      } , false   },
    { "land"     , { true,  true      } , true    },
    { "lnot"     , { true             } , false   },
    { "lor"      , { "hello", "world" } , "hello" },
    { "lor"      , { false, false     } , false   },
    { "lor"      , { false, true      } , true    },

    { "concat"   , { "a", "b"         } , "ab"    },
    { "len"      , { "abc"            } , 3       },

    { "index"    , { tbl, "a"         } , 1       },
    { "index"    , { tbl, "b"         } , nil     },
    { "call"     , { sum, 1, 2        } , 3       },
    { "setindex" , { tbl, "a", 2      } , 2       },
  }
  -- stylua: ignore end

  for i = 1, #tests do
    local op, args, expected = unpack(tests[i])
    it(op .. "() returns correct value", function()
      assert.are_equal(expected, ops[op](unpack(args)))
    end)
  end
end)
