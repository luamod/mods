---@diagnostic disable: undefined-global

local Set = require("mods.Set")
local deepcopy = require("pl.tablex").deepcopy

local upper = string.upper

describe("mods.Set", function()
  ([[ _____ ___de _b_d_ _bcd_ a_c__ __c__
      a_c_e a___e abc__ abcd_ abcde
      ab_de ABC__ ]]):gsub("%S+", function(p)
    local set = Set()
    p:gsub(".", function(c)
      set[c] = c ~= "_" and true or nil
    end)
    _G[p] = set
  end)

  -- stylua: ignore
  local tests = {
    --------------fname-------------|--set--|--arg--|-expected-|-same_ref?---
    { "add"                         , _b_d_ , "c"   , _bcd_    , true    },
    { "clear"                       , abcde , nil   , {}       , true    },
    { "copy"                        , abcde , nil   , abcde    ,         },
    { "difference_update"           , a_c_e , _bcd_ , a___e    , true    },
    { "difference"                  , a_c_e , _bcd_ , a___e    ,         },
    { "discard"                     , _bcd_ , "c"   , _b_d_    , true    },
    { "intersection_update"         , a_c_e , _bcd_ , __c__    , true    },
    { "intersection"                , a_c_e , _bcd_ , __c__    ,         },
    { "isdisjoint"                  , _b_d_ , ___de , false    ,         },
    { "isdisjoint"                  , _b_d_ , a___e , true     ,         },
    { "isempty"                     , _____ , nil   , true     ,         },
    { "isempty"                     , abcde , nil   , false    ,         },
    { "issubset"                    , abcd_ , abcde , true     ,         },
    { "issubset"                    , abcde , abcd_ , false    ,         },
    { "issuperset"                  , abcd_ , abcde , false    ,         },
    { "issuperset"                  , abcde , abcd_ , true     ,         },
    { "len"                         , _____ , nil   , 0        ,         },
    { "len"                         , a_c__ , nil   , 2        ,         },
    { "map"                         , abc__ , upper , ABC__    ,         },
    { "pop"                         , _____ , nil   , nil      ,         },
    { "remove"                      , _bcd_ , "c"   , _b_d_    , true    },
    { "symmetric_difference_update" , a_c_e , _bcd_ , ab_de    , true    },
    { "symmetric_difference"        , a_c_e , _bcd_ , ab_de    ,         },
    { "union"                       , abc__ , ___de , abcde    ,         },
    { "update"                      , abc__ , ___de , abcde    , true    },
    { "values"                      , _____ , nil   , {}       ,         },
  }

  for i = 1, #tests do
    local fname, set, arg_, expected, same_ref = unpack(tests[i], 1, 5)
    it(fname .. "() returns correct value", function()
      set = deepcopy(set)
      local res = set[fname](set, arg_)
      assert.are_same(expected, res)
      if same_ref then
        assert.are_equal(set, res, "Expected same set instance")
      else
        assert.not_equal(set, res, "Expected different set instances")
      end
    end)
  end

  describe("__call", function()
    it("constructs a set from a list", function()
      local s = Set({ "a", "b", "c" })
      assert.is_true(getmetatable(s) == Set)
      assert.are_same({ a = true, b = true, c = true }, s)
    end)

    it("handles duplicate values", function()
      local s = Set({ "a", "b", "a", "c" })
      assert.are_same({ a = true, b = true, c = true }, s)
    end)
  end)

  it("pop() removes and returns an arbitrary element", function()
    local s = Set({ "a", "b", "c" })
    local v = s:pop()
    assert.is_true(v == "a" or v == "b" or v == "c")
    assert.is_nil(s[v])
  end)

  it("values() returns all values as a list", function()
    local ls = { "a", "b", "c" }
    local res = Set(ls):values()
    assert.are_same(ls, res:sort())
  end)
end)
