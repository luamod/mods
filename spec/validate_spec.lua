---@diagnostic disable: param-type-mismatch, need-check-nil, undefined-field

local validate = require("mods.validate")
local Set = require("pl.Set")

local fmt = string.format
local messages = validate.messages
local quote = validate.quote

describe("mods.validate", function()
  local fn = function() end
  local co = coroutine.create(fn)
  local ct = setmetatable({}, { __call = fn })
  local nct = setmetatable({}, { __call = true })

  -- stylua: ignore
  describe("exposes callable roots", function()
    it("validate is callable", function() assert.Callable(validate) end)
    it("is is callable"      , function() assert.Callable(validate.is) end)
    it("is_not is callable"  , function() assert.Callable(validate.is_not) end)
    it("isNot is callable"   , function() assert.Callable(validate.isNot) end)
    it("isnot is callable"   , function() assert.Callable(validate.isnot) end)
    it("Not is callable"     , function() assert.Callable(validate.Not) end)
    it("not is callable"     , function() assert.Callable(validate["not"]) end)
  end)

  -- stylua: ignore
  local tests = {
    -- type checks 

    -----type----|-----ok----|--bad--|---------------errmsg--------------
    { "Boolean"  , false     , 123   , "expected boolean, got number"   },
    { "Boolean"  , true      , nil   , "expected boolean, got nil"      },
    { "Function" , fn        , "abc" , "expected function, got string"  },
    { "Nil"      , nil       , 123   , "expected nil, got number"       },
    { "Number"   , 123       , "123" , "expected number, got string"    },
    { "String"   , "abc"     , true  , "expected string, got boolean"   },
    { "Table"    , {}        , false , "expected table, got boolean"    },
    { "Thread"   , co        , fn    , "expected thread, got function"  },
    { "Userdata" , io.stdout , {}    , "expected userdata, got table"   },

    -- value checks

    -----type----|--ok---|--bad--|------------expected-------------
    { "Callable" , ct    , nct   , "expected callable, got table" },
    { "Callable" , fn    , {}    , "expected callable, got table" },
    { "False"    , false , true  , "expected false, got true"     },
    { "Falsy"    , false , true  , "expected falsy, got boolean"  },
    { "Falsy"    , nil   , 123   , "expected falsy, got number"   },
    { "Integer"  , 123   , 13.4  , "expected integer, got number" },
    { "Integer"  , 123   , nil   , "expected integer, got nil"    },
    { "True"     , true  , false , "expected true, got false"     },
    { "Truthy"   , 123   , nil   , "expected truthy, got nil"     },
    { "Truthy"   , true  , false , "expected truthy, got boolean" },
  }
  -- stylua: ignore end

  describe("exposes check aliases", function()
    local checks = {}
    for i = 1, #tests do
      checks[#checks + 1] = tests[i][1]
    end
    for _, c in ipairs(Set.values(Set(checks))) do
      -- stylua: ignore start
      it(fmt("%s", c:lower())       , function() assert.Function(validate[c:lower()]) end)
      it(fmt("%s", c)               , function() assert.Function(validate[c]) end)
      it(fmt("is_%s", c:lower())    , function() assert.Function(validate["is_" .. c:lower()]) end)
      it(fmt("is_%s", c)            , function() assert.Function(validate["is_" .. c]) end)
      it(fmt("is_not_%s", c:lower()), function() assert.Function(validate["is_not_" .. c:lower()]) end)
      it(fmt("is_not_%s", c)        , function() assert.Function(validate["is_not_" .. c]) end)
      it(fmt("is_not.%s", c:lower()), function() assert.Function(validate.is_not[c:lower()]) end)
      it(fmt("is_not.%s", c)        , function() assert.Function(validate.is_not[c]) end)
      it(fmt("is.%s", c:lower())    , function() assert.Function(validate.is[c:lower()]) end)
      it(fmt("is.%s", c)            , function() assert.Function(validate.is[c]) end)
      it(fmt("isnot_%s", c:lower()) , function() assert.Function(validate["isnot_" .. c:lower()]) end)
      it(fmt("isnot_%s", c:lower()) , function() assert.Function(validate["isnot_" .. c:lower()]) end)
      it(fmt("isNot_%s", c:lower()) , function() assert.Function(validate["isNot_" .. c:lower()]) end)
      it(fmt("isnot_%s", c)         , function() assert.Function(validate["isnot_" .. c]) end)
      it(fmt("isNot_%s", c)         , function() assert.Function(validate["isNot_" .. c]) end)
      it(fmt("isnot.%s", c:lower()) , function() assert.Function(validate.isnot[c:lower()]) end)
      it(fmt("isNot.%s", c:lower()) , function() assert.Function(validate.isNot[c:lower()]) end)
      it(fmt("isnot.%s", c)         , function() assert.Function(validate.isnot[c]) end)
      it(fmt("isNot.%s", c)         , function() assert.Function(validate.isNot[c]) end)
      it(fmt("not_%s", c:lower())   , function() assert.Function(validate["not_" .. c:lower()]) end)
      it(fmt("Not_%s", c:lower())   , function() assert.Function(validate["Not_" .. c:lower()]) end)
      it(fmt("not_%s", c)           , function() assert.Function(validate["not_" .. c]) end)
      it(fmt("Not_%s", c)           , function() assert.Function(validate["Not_" .. c]) end)
      it(fmt("Not.%s", c:lower())   , function() assert.Function(validate.Not[c:lower()]) end)
      it(fmt("not.%s", c:lower())   , function() assert.Function(validate["not"][c:lower()]) end)
      it(fmt("Not.%s", c)           , function() assert.Function(validate.Not[c]) end)
      it(fmt("not.%s", c)           , function() assert.Function(validate["not"][c]) end)
    end
  end)

  local function got_repr(tp, v)
    if tp == "False" or tp == "True" then
      return tostring(v)
    end
    return type(v)
  end

  for i = 1, #tests do
    local tp, ok, bad, errmsg = unpack(tests[i], 1, 4)

    describe("returns true", function()
      it(fmt("%s(%s)", tp, pretty(ok)), function()
        assert.are_same({ true }, { validate[tp](ok) })
      end)

      it(fmt("validate(%q, %s)", tp, pretty(ok)), function()
        assert.are_same({ true }, { validate(ok, tp) })
      end)
    end)

    describe("returns false", function()
      it(fmt("%s(%s)", tp, pretty(bad)), function()
        assert.are_same({ false, errmsg }, { validate[tp](bad) })
      end)

      it(fmt("validate(%q, %s)", tp, pretty(bad)), function()
        assert.are_same({ false, errmsg }, { validate(bad, tp) })
      end)
    end)

    describe("is_not returns true", function()
      it(fmt("is_not.%s(%s)", tp, pretty(bad)), function()
        assert.are_same({ true }, { validate.is_not[tp](bad) })
      end)

      it(fmt("Not.%s(%s)", tp, pretty(bad)), function()
        assert.are_same({ true }, { validate.Not[tp](bad) })
      end)

      it(fmt("is_not(%q, %s)", tp, pretty(bad)), function()
        assert.are_same({ true }, { validate.is_not(bad, tp) })
      end)
    end)

    describe("is_not returns false", function()
      local not_errmsg = "expected not " .. tp:lower()

      it(fmt("is_not.%s(%s)", tp, pretty(ok)), function()
        assert.are_same({ false, not_errmsg }, { validate.is_not[tp](ok) })
      end)

      it(fmt("Not.%s(%s)", tp, pretty(ok)), function()
        assert.are_same({ false, not_errmsg }, { validate.Not[tp](ok) })
      end)

      it(fmt("is_not(%q, %s)", tp, pretty(ok)), function()
        assert.are_same({ false, not_errmsg }, { validate.is_not(ok, tp) })
      end)
    end)

    describe("custom is messages", function()
      local template = "{{got}} should be {{expected}}\nPassed: {{value}}"
      local custom_errmsg = fmt("%s should be %s\nPassed: %s", got_repr(tp, bad), tp:lower(), quote(bad))
      validate.messages.is[tp:lower()] = template

      it(fmt("%s(%s) returns false", tp, pretty(bad)), function()
        assert.are_same({ false, custom_errmsg }, { validate.is[tp](bad) })
      end)

      it(fmt("validate(%q, %s) returns false", tp, pretty(bad)), function()
        assert.are_same({ false, custom_errmsg }, { validate(bad, tp) })
      end)

      teardown(function()
        for k in pairs(messages.is) do
          messages.is[k] = nil
        end
      end)
    end)

    describe("custom is_not messages", function()
      local template = "{{got}} should not be {{expected}}\nPassed: {{value}}"
      local custom_errmsg = fmt("%s should not be %s\nPassed: %s", got_repr(tp, ok), tp:lower(), quote(ok))
      validate.messages.is_not[tp:lower()] = template

      it(fmt("is_not.%s(%s) returns false", tp, pretty(ok)), function()
        assert.are_same({ false, custom_errmsg }, { validate.is_not[tp](ok) })
      end)

      it(fmt("is_not(%q, %s) returns false", tp, pretty(ok)), function()
        assert.are_same({ false, custom_errmsg }, { validate.is_not(ok, tp) })
      end)

      teardown(function()
        for k in pairs(messages.is_not) do
          messages.is_not[k] = nil
        end
      end)
    end)
  end
end)
