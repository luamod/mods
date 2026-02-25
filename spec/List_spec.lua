---@diagnostic disable: undefined-global

local mods = require("mods")
local List = mods.List
local Set = mods.Set
local deepcopy = mods.tbl.deepcopy
local fmt = string.format
local upper = string.upper
local len = string.len

describe("mods.List", function()
  local patterns = [[ _____ ____e ___de __c__ _b_d_ _bc__ _bcd_ a___e
      a_c__ a_c_e ab___ abc__ abcd_ abcde edcba
      ABC__ AZ___ _ZAZA AZAZA ]]

  patterns:gsub("%S+", function(p)
    local ls = {}
    p:gsub(".", function(c)
      ls[#ls + 1] = c ~= "_" and c or nil
    end)
    _G[p] = ls
  end)

  -- stylua: ignore start
  local not_c   = function(v) return v ~= "c" end
  local not_z   = function(v) return v ~= "z" end
  local is_b    = function(v) return v == "b" end
  local is_c    = function(v) return v == "c" end
  local add     = function(a, b) return a + b end
  local ac, e   = a_c__, ____e
  local a1_e2   = { a = 1, e = 2 }
  local a1      = { "a", 1 }
  local b2      = { "b", 2 }
  local n12     = { 1, 2 }
  local n123    = { 1, 2, 3 }
  local words   = { "aa", "b", "ccc", "dd" }
  local by_len  = { List({ "b" }), List({ "aa", "dd" }), List({ "ccc" }) }
  local mixed   = { "a", 1, true, false, {}, "b", "a", 2 }
  local by_type = {
    ["string"]  = List({ "a", "b", "a" }),
    ["number"]  = List({ 1, 2 }),
    ["boolean"] = List({ true, false}),
    ["table"]   = List({{}}),
  }

  local tests = {
    ------fname------|--list--|---params---|--expected--|-same_ref?---
    { "all"          , _____  , { is_b   } , true       ,          },
    { "all"          , abc__  , { is_b   } , false      ,          },
    { "all"          , abc__  , { not_z  } , true       ,          },
    { "any"          , abc__  , { is_b   } , true       ,          },
    { "append"       , abc__  , {        } , abc__      , true     },
    { "append"       , abc__  , { "d"    } , abcd_      , true     },
    { "clear"        , abcde  , {        } , _____      , true     },
    { "contains"     , _bcd_  , {        } , false      ,          },
    { "contains"     , _bcd_  , { "C"    } , false      ,          },
    { "contains"     , _bcd_  , { "c"    } , true       ,          },
    { "copy"         , abcde  , {        } , abcde      ,          },
    { "count"        , AZAZA  , {        } , 0          ,          },
    { "count"        , AZAZA  , { 'A'    } , 3          ,          },
    { "difference"   , a_c_e  , { _bcd_  } , a___e      ,          },
    { "drop"         , abc__  , { 1      } , _bc__      ,          },
    { "extend"       , abc__  , { ___de  } , abcde      , true     },
    { "extract"      , abc__  , { not_c  } , ab___      ,          },
    { "filter"       , _bcd_  , { not_c  } , _b_d_      ,          },
    { "first"        , abc__  , {        } , "a"        ,          },
    { "flatten"      , {ac,e} , {        } , a_c_e      ,          },
    { "group_by"     , mixed  , { type   } , by_type    ,          },
    { "group_by"     , words  , { len    } , by_len     ,          },
    { "index_if"     , abcde  , { is_c   } , 3          ,          },
    { "index"        , abcde  , {        } , nil        ,          },
    { "index"        , abcde  , { "c"    } , 3          ,          },
    { "insert"       , a_c__  , { 2, "b" } , abc__      , true     },
    { "insert"       , abc__  , { "d"    } , abcd_      , true     },
    { "intersection" , a_c_e  , { _bcd_  } , __c__      ,          },
    { "invert"       , a___e  , {        } , a1_e2      ,          },
    { "join"         , abc__  , { ","    } , "a,b,c"    ,          },
    { "join"         , abcde  , {        } , "abcde"    ,          },
    { "keypath"      , abc__  , {        } , "a.b.c"    ,          },
    { "last"         , abc__  , {        } , "c"        ,          },
    { "len"          , _____  , {        } , 0          ,          },
    { "len"          , a_c__  , {        } , 2          ,          },
    { "map"          , abc__  , { upper  } , ABC__      ,          },
    { "pop"          , abc__  , {        } , "c"        ,          },
    { "pop"          , abcde  , { 1      } , "a"        ,          },
    { "pop"          , abcde  , { 5      } , "e"        ,          },
    { "prepend"      , _bc__  , { "a"    } , abc__      , true     },
    { "reduce"       , _____  , { add, 5 } , 5          ,          },
    { "reduce"       , n123   , { add    } , 6          ,          },
    { "reduce"       , n123   , { add, 0 } , 6          ,          },
    { "reduce"       , n123   , { add, 4 } , 10         ,          },
    { "remove"       , abc__  , {        } , abc__      , true     },
    { "remove"       , AZAZA  , { "A"    } , _ZAZA      , true     },
    { "reverse"      , abcde  , {        } , edcba      ,          },
    { "toset"        , AZAZA  , {        } , Set(AZAZA) ,          },
    { "slice"        , abcde  , {        } , abcde      ,          },
    { "slice"        , abcde  , { 2, 4   } , _bcd_      ,          },
    { "sort"         , edcba  , {        } , abcde      , true     },
    { "take"         , abcde  , { 3      } , abc__      ,          },
    { "uniq"         , AZAZA  , {        } , AZ___      ,          },
    { "zip"          , abc__  , { n12    } , { a1, b2 } ,          },
  }
  -- stylua: ignore end

  for i = 1, #tests do
    local fname, ls, params, expected, same_ref = unpack(tests[i], 1, 5)
    ls = deepcopy(List(ls))

    it(fmt("(%s):%s(%s) returns correct result", inspect(ls), fname, args_repr(params)), function()
      ---@diagnostic disable-next-line: param-type-mismatch
      local res = ls[fname](ls, unpack(params))
      assert.are_same(expected, res)

      if same_ref then
        assert.are_equal(true, rawequal(ls, res), "Expected same list reference")
      else
        assert.are_equal(false, rawequal(ls, res), "Expected different list reference")
      end
    end)
  end

  it("foreach() applies a function to each element and returns nil", function()
    local ls = List({ "a", "b", "c" })
    local joined = ""
    local res = ls:foreach(function(v)
      joined = joined .. v
    end)
    assert.are_equal("abc", joined)
    assert.is_nil(res)
  end)

  describe("metamethods", function()
    it("__add extends and returns the left list", function()
      local a = List({ "a", "b" })
      local b = { "c", "d" }
      local c = { "e", "f" }
      local d = a + b + c
      assert.are_same(d, { "a", "b", "c", "d", "e", "f" })
      assert.are_equal(true, rawequal(a, d), "__add returns same lhs ref")
    end)
  end)
end)
