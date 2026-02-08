local tbl = require("mods.tbl")

local function show_sorted(label, ls)
  local out = {}
  for i = 1, #ls do
    out[i] = ls[i]
  end
  table.sort(out, function(a, b)
    return tostring(a) < tostring(b)
  end)
  print(label, out[1], out[2], out[3])
end

local user = {
  profile = { name = "Ada", age = 36 },
  active = true,
  tags = { "dev", "ops" },
}

print("get:", tbl.get(user, "profile", "name"))
print("count:", tbl.count(user))
print("isempty:", tbl.isempty({}))

local copied = tbl.copy(user)
print("copy name:", copied.profile.name)

local deep = tbl.deepcopy({ a = { b = 1 } })
print("deepcopy:", deep.a.b)

local filtered = tbl.filter({ a = 1, b = 2, c = 3 }, function(v)
  return v % 2 == 1
end)
print("filter:", filtered.a, filtered.c)

local inverted = tbl.invert({ a = 1, b = 2 })
print("invert:", inverted[1], inverted[2])

local keys = tbl.keys({ a = true, b = true, c = true })
show_sorted("keys:", keys)

local values = tbl.values({ a = 10, b = 20 })
show_sorted("values:", values)

local merged = tbl.update({ a = 1 }, { b = 2 })
print("update:", merged.a, merged.b)
