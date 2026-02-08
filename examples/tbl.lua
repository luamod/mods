local tbl = require("mods.tbl")
local unpack = table.unpack or unpack

local user = {
  profile = { name = "Ada", age = 36 },
  active = true,
  tags = { "dev", "ops" },
}

print("get      : " .. tbl.get(user, "profile", "name"))
print("count    : " .. tbl.count(user))
print("isempty  : " .. tostring(tbl.isempty({})))

local copied = tbl.copy(user)
print("copy name: " .. copied.profile.name)

local deep = tbl.deepcopy({ a = { b = "nested" } })
print("deepcopy : " .. deep.a.b)

local filtered = tbl.filter({ a = 1, b = 2, c = 3 }, function(v)
  return v % 2 == 1
end)
print(("filter   : %s %s %s"):format(filtered.a, filtered.b, filtered.c))

local inverted = tbl.invert({ a = 1, b = 2 })
print(("invert   : %s %s"):format(inverted[1], inverted[2]))

local keys = tbl.keys({ a = true, b = true, c = true })
print(("keys     : { %s, %s, %s }"):format(unpack(keys)))

local values = tbl.values({ a = 10, b = 20 })
print(("values   : { %s, %s }"):format(unpack(values)))

local merged = tbl.update({ a = 1 }, { b = 2 })
print(("update   : %s %s"):format(merged.a, merged.b))
