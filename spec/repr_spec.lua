local mods = require("mods")
local kw = mods.keyword
local repr = mods.repr
local fmt = string.format

describe("mods.repr", function()
  local fn = function() end
  local co = coroutine.create(fn)
  local keywords = kw.kwlist()

  -- stylua: ignore
  local tests = {
    ---------input--------|---------------------expected---------------------
    { nil                 , "nil"                                           },
    { true                , "true"                                          },
    { false               , "false"                                         },
    { 42                  , "42"                                            },
    { 'He said "hi"'      , [['He said "hi"']]                              },
    { { hello = "world" } , '{\n  hello = "world"\n}'                       },
    { { "a", "b", "c" }   , '{\n  [1] = "a",\n  [2] = "b",\n  [3] = "c"\n}' },
    { {}                  , '{}'                                            },
    { { { {} } }          , '{\n  [1] = {\n    [1] = {}\n  }\n}'            },
    { fn                  , tostring(fn)                                    },
    { co                  , tostring(co)                                    },
  }

  for i = 1, #tests do
    local input, expected = unpack(tests[i], 1, 2)
    it(fmt("repr(%s)", inspect(input)), function()
      local res = repr(input)
      assert.are_equal(expected, res)
    end)
  end

  for _, v in ipairs(keywords) do
    it(fmt("repr(%q) brackets reserved keys", v), function()
      local expected = '{\n  ["' .. v .. '"] = true\n}'
      assert.are_equal(expected, repr({ [v] = true }))
    end)
  end

  it("renders complex nested tables", function()
    local root = { title = "root" }
    local child = { name = "child" }
    local leaf = { value = 99 }
    root.child = child
    root.self = root
    root.shared_a = leaf
    root.shared_b = leaf
    root.list = { child, { back = root } }
    child.parent = root
    child.link = leaf
    leaf.owner = child

    local res = repr(root)
    local expected = [[
{
  child = {
    link = {
      owner = <cycle>,
      value = 99
    },
    name = "child",
    parent = <cycle>
  },
  list = {
    [1] = {
      link = {
        owner = <cycle>,
        value = 99
      },
      name = "child",
      parent = <cycle>
    },
    [2] = {
      back = <cycle>
    }
  },
  self = <cycle>,
  shared_a = {
    owner = {
      link = <cycle>,
      name = "child",
      parent = <cycle>
    },
    value = 99
  },
  shared_b = {
    owner = {
      link = <cycle>,
      name = "child",
      parent = <cycle>
    },
    value = 99
  },
  title = "root"
}]]

    assert.are_equal(expected, res)
  end)
end)
