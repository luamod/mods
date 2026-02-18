local List = require("mods.List")
local Set = require("mods.Set")
local kw = require("mods.keyword")

local fmt = string.format
local is_lua51 = _VERSION == "Lua 5.1"

describe("mods.keyword", function()
  local fn = function() end
  local co = coroutine.create(fn)
  -- stylua: ignore
  local kwlist = List({
    "and"   , "break" , "do"  , "else"    , "elseif",
    "end"   , "false" , "for" , "function", "if"    ,
    "in"    , "local" , "nil" , "not"     , "or"    ,
    "repeat", "return", "then", "true"    , "until" , "while"
  })

  if not is_lua51 then
    kwlist:append("goto"):sort()
  end

  local kwset = kwlist:setify()
  local tests

  -------------------
  --- iskeyword() ---
  -------------------

  local non_keywords = {
    "_",
    "",
    "Function",
    "goto1",
    "hello",
    "local_var",
    "nil?",
    "while_",
    {},
    123,
    false,
  }

  for i = 1, #kwlist do
    local input = kwlist[i]
    it(fmt("iskeyword(%s) returns true", inspect(input)), function()
      assert.is_true(kw.iskeyword(input))
    end)
  end

  for i = 1, #non_keywords do
    local input = non_keywords[i]
    it(fmt("iskeyword(%s) returns false", inspect(input)), function()
      assert.is_false(kw.iskeyword(input))
    end)
  end

  ----------------------
  --- isidentifier() ---
  ----------------------

  -- stylua: ignore
  tests = {
    { "hello"       , true     },
    { "hello_world" , true     },
    { "_name2"      , true     },
    { "local"       , false    },
    { "function"    , false    },
    { "goto"        , is_lua51 },
    { "2bad"        , false    },
    { "bad-name"    , false    },
    { false         , false    },
  }

  for i = 1, #tests do
    local input, expected = unpack(tests[i], 1, 2)
    it(fmt("isidentifier(%s)", inspect(input)), function()
      assert.are_equal(expected, kw.isidentifier(input))
    end)
  end

  ------------------------------
  --- normalize_identifier() ---
  ------------------------------

  -- stylua: ignore
  tests = {
    ------input------|----expected----
    { " 2 bad-name " , "_2_bad_name" },
    { "local"        , "local_"      },
    { ""             , "_"           },
    { "   "          , "_"           },
    { false          , "false_"      },
    { fn             , "function_"   },
    { {}             , "table_"      },
    { co             , "thread_"     },
  }

  for i = 1, #tests do
    local input, expected = unpack(tests[i], 1, 2)
    it(fmt("normalize_identifier(%s)", inspect(input)), function()
      assert.are_equal(expected, kw.normalize_identifier(input))
    end)
  end

  ----------------
  --- kwlist() ---
  ----------------

  describe("kwlist()", function()
    it("returns all keywords in order", function()
      assert.are_same(kwlist, kw.kwlist())
    end)

    it("returns a mods.List instance", function()
      local kw = kw.kwlist()
      assert.are_equal(List, getmetatable(kw))
    end)

    it("returns a fresh copy on each call", function()
      local l1 = kw.kwlist()
      local l2 = kw.kwlist()
      assert.are_not_equal(l1, l2)
    end)
  end)

  ---------------
  --- kwset() ---
  ---------------

  describe("kwset()", function()
    it("returns all keywords", function()
      assert.are_same(kwset, kw.kwset())
    end)

    it("returns a mods.Set instance", function()
      local kw = kw.kwset()
      assert.are_equal(Set, getmetatable(kw))
    end)

    it("returns a fresh copy on each call", function()
      local s1 = kw.kwset()
      local s2 = kw.kwset()
      assert.are_not_equal(s1, s2)
    end)
  end)
end)
