---@diagnostic disable: param-type-mismatch, undefined-global

local List = require("mods.List")
local Set = require("pl.Set")
local deepcopy = require("pl.tablex").deepcopy

local upper = string.upper
local len = string.len

describe("mods.List", function()
  ([[ _____ ____e ___de __c__ _b_d_ _bc__ _bcd_ a___e
      a_c__ a_c_e ab___ abc__ abcd_ abcde edcba
      ABC__ AZ___ _ZAZA AZAZA ]]):gsub("%S+", function(p)
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
    ------fname------|--list--|----args----|--expected--|-same_ref?---
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
    { "setify"       , AZAZA  , {        } , Set(AZAZA) ,          },
    { "slice"        , abcde  , {        } , abcde      ,          },
    { "slice"        , abcde  , { 2, 4   } , _bcd_      ,          },
    { "sort"         , edcba  , {        } , abcde      , true     },
    { "take"         , abcde  , { 3      } , abc__      ,          },
    { "uniq"         , AZAZA  , {        } , AZ___      ,          },
    { "zip"          , abc__  , { n12    } , { a1, b2 } ,          },
  }
  -- stylua: ignore end

  for i = 1, #tests do
    local fname, ls, args, expected, same_ref = unpack(tests[i])
    ls = deepcopy(List(ls))
    it(fname .. "() returns correct value", function()
      local res = ls[fname](ls, unpack(args))
      assert.are_same(expected, res)
      if same_ref then
        assert.are_equal(ls, res, "Expected same list reference")
      else
        assert.not_equal(ls, res, "Expected different list reference")
      end
    end)
  end

  it("foreach() applies a function to each element and returns nil", function()
    local ls = List({ "a", "b", "c" })
    local seen = {}
    local res = ls:foreach(function(v)
      seen[#seen + 1] = v
    end)
    assert.are_same({ "a", "b", "c" }, seen)
    assert.is_nil(res)
  end)
end)
