local mods = require("mods")
local List = mods.List
local Set = mods.Set
local kw = mods.keyword
local fmt = string.format
local is_lua51 = _VERSION == "Lua 5.1"

describe("mods.keyword", function()
  -- stylua: ignore
  local keywords = List({
    "and"   , "break" , "do"  , "else"    , "elseif",
    "end"   , "false" , "for" , "function", "if"    ,
    "in"    , "local" , "nil" , "not"     , "or"    ,
    "repeat", "return", "then", "true"    , "until" , "while"
  })
  keywords[#keywords + 1] = not is_lua51 and "goto" or nil
  keywords:sort()

  local fn = function() end
  local co = coroutine.create(fn)
  local kwlist = keywords
  local kwset = keywords:toset()
  local tests

  -------------------
  --- iskeyword() ---
  -------------------

  for _, input in ipairs(kwlist) do
    it(fmt("iskeyword(%s) returns true", inspect(input)), function()
      assert.is_true(kw.iskeyword(input))
    end)
  end

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

  for _, input in ipairs(non_keywords) do
    it(fmt("iskeyword(%s) returns false", inspect(input)), function()
      assert.is_false(kw.iskeyword(input))
    end)
  end

  ----------------------
  --- isidentifier() ---
  ----------------------

  -- stylua: ignore
  tests = {
    ------input-----|-expected---
    { "hello"       , true     },
    { "hello_world" , true     },
    { "_name2"      , true     },
    { "goto"        , is_lua51 },
    { "(var"        , false    },
    { "[var"        , false    },
    { "local"       , false    },
    { "function"    , false    },
    { "2bad"        , false    },
    { "bad-name"    , false    },
    { false         , false    },
    { nil           , false    },
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
      assert.are_equal(List, getmetatable(kw.kwlist()))
    end)

    it("returns a fresh copy on each call", function()
      assert.is_false(rawequal(kw.kwlist(), kw.kwlist()))
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
      assert.are_equal(Set, getmetatable(kw.kwset()))
    end)

    it("returns a fresh copy on each call", function()
      assert.is_false(rawequal(kw.kwset(), kw.kwset()))
    end)
  end)
end)
