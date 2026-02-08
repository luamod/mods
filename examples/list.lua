local List = require("mods.List")
local unpack = table.unpack or unpack

local nums = List({ 1, 2, 3, 4, 5, 2 })

print("len        : " .. nums:len())
print("first      : " .. nums:first())
print("last       : " .. nums:last())

local evens = nums:filter(function(n)
  return n % 2 == 0
end)
print(("evens      : %s %s %s"):format(unpack(evens)))

local doubled = nums:map(function(n)
  return n * 2
end)
print(("doubled    : %s %s %s %s %s %s"):format(unpack(doubled)))

local sum = nums:reduce(function(a, b)
  return a + b
end, 0)
print("sum        : " .. sum)

print("contains   : " .. tostring(nums:contains(3)))
print("count      : " .. nums:count(2))

local dropped = nums:drop(3)
print(("drop       : %s %s %s"):format(unpack(dropped)))

local unique = nums:uniq()
print(("uniq       : %s %s %s %s %s"):format(unpack(unique)))

local zipped = List({ "a", "b", "c" }):zip(List({ 1, 2 }))
print(("zip        : { %s, %s } { %s, %s }"):format(zipped[1][1], zipped[1][2], zipped[2][1], zipped[2][2]))

local grouped = nums:group_by(function(n)
  return n % 2 == 0 and "even" or "odd"
end)
print(("group odd  : %s %s %s"):format(unpack(grouped.odd)))
print(("group even : %s %s %s"):format(unpack(grouped.even)))
