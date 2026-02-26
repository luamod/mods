---@diagnostic disable: undefined-global, need-check-nil

local mods = require("mods")
local Set = mods.Set
local List = mods.List
local deepcopy = mods.tbl.deepcopy
local upper = string.upper
local fmt = string.format

describe("mods.Set", function()
  local patterns = [[ _____ ___de _b_d_ _bcd_ a_c__ __c__
      a_c_e a___e abc__ abcd_ abcde
      ab_de ABC__ ]]

  patterns:gsub("%S+", function(p)
    local set = Set()
    p:gsub(".", function(c)
      set[c] = c ~= "_" and true or nil
    end)
    _G[p] = set
  end)

  -- stylua: ignore
  local tests = {
    --------------fname-------------|--set--|-param-|-expected-|-same_ref?---
    { "add"                         , _b_d_ , "c"   , _bcd_    , true    },
    { "clear"                       , abcde , nil   , {}       , true    },
    { "contains"                    , abcde , "a"   , true     ,         },
    { "contains"                    , abcde , "z"   , false    ,         },
    { "copy"                        , abcde , nil   , abcde    ,         },
    { "difference_update"           , a_c_e , _bcd_ , a___e    , true    },
    { "difference"                  , a_c_e , _bcd_ , a___e    ,         },
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
    local fname, set, param, expected, same_ref = unpack(tests[i], 1, 5)
    it(fmt("(%s):%s(%s) returns correct result", inspect(set:values()), fname, inspect(param)), function()
      set = deepcopy(set)
      local res = set[fname](set, param)

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

  it("values() returns a mods.List with all set values", function()
    local ls = { "a", "b", "c" }
    local res = Set(ls):values()
    assert.are_equal(List, getmetatable(res))
    assert.are_same(ls, res:sort())
  end)

  describe("metamethods", function()
    it("__add returns set union", function()
      local a = Set({ "a", "b" })
      local b = Set({ "b", "c" })
      local u = a + b
      assert.are_same({ a = true, b = true, c = true }, u)
      assert.are_same({ a = true, b = true }, a)
      assert.are_same({ b = true, c = true }, b)
    end)

    it("__sub returns set difference", function()
      local a = Set({ "a", "b", "c" })
      local b = Set({ "b", "x" })
      local d = a - b
      assert.are_same({ a = true, c = true }, d)
      assert.are_same({ a = true, b = true, c = true }, a)
      assert.are_same({ b = true, x = true }, b)
    end)

    it("__le returns subset check", function()
      local a = Set({ "a" })
      local b = Set({ "a", "b" })
      local c = Set({ "a", "b" })
      assert.is_true(a <= b)
      assert.is_true(b <= c)
      assert.is_false(b <= a)
    end)

    it("__lt returns proper subset check", function()
      local a = Set({ "a" })
      local b = Set({ "a", "b" })
      local c = Set({ "a", "b" })
      assert.is_true(a < b)
      assert.is_false(b < c)
      assert.is_false(b < a)
    end)
  end)
end)
