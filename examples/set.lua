local Set = require("mods.Set")
local unpack = table.unpack or unpack

local a = Set({ "red", "green" })
local b = Set({ "green", "blue" })

print("len a       : " .. a:len())
print("len b       : " .. b:len())

local union = a:union(b):values()
local intersection = a:intersection(b):values()
local diff = a:difference(b):values()

print(("union       : %s %s"):format(unpack(union)))
print(("intersection: %s"):format(unpack(intersection)))
print(("difference  : %s"):format(unpack(diff)))

print(("isdisjoint  : %s"):format(a:isdisjoint(Set({ "yellow" }))))
print(("issubset    : %s"):format(Set({ "green" }):issubset(a)))

local c = Set({ 1, 2, 3 })
local popped = c:pop()
print(("pop exists  : %s"):format(popped ~= nil))
print(("isempty     : %s"):format(c:isempty()))

c:add(4):add(5):discard(2)
print(("updated     : %s %s %s"):format(unpack(c:values())))
