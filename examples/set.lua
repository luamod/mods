local Set = require("mods.Set")

local function show(label, ls)
  local out = {}
  for i = 1, #ls do
    out[i] = tostring(ls[i])
  end
  table.sort(out)
  print(label, table.concat(out, ", "))
end

local a = Set({ "red", "green" })
local b = Set({ "green", "blue" })

print("len a:", a:len())
print("len b:", b:len())

local union = a:union(b):values()
local intersection = a:intersection(b):values()
local diff = a:difference(b):values()

show("union:", union)
show("intersection:", intersection)
show("difference:", diff)

print("isdisjoint:", a:isdisjoint(Set({ "yellow" })))
print("issubset:", Set({ "green" }):issubset(a))

local c = Set({ 1, 2, 3 })
local popped = c:pop()
print("pop exists:", popped ~= nil)
print("isempty:", c:isempty())

c:add(4):add(5):discard(2)
show("updated:", c:values())
