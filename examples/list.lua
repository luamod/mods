local List = require("mods.List")

local function show(label, ls)
  local out = {}
  for i = 1, #ls do
    out[i] = tostring(ls[i])
  end
  print(label, table.concat(out, ", "))
end

local nums = List({ 1, 2, 3, 4, 5, 2 })

print("len:", nums:len())
print("first:", nums:first())
print("last:", nums:last())

local evens = nums:filter(function(n)
  return n % 2 == 0
end)
show("evens:", evens)

local doubled = nums:map(function(n)
  return n * 2
end)
show("doubled:", doubled)

print("sum:", nums:reduce(function(a, b)
  return a + b
end, 0))

print("contains 3:", nums:contains(3))
print("count 2:", nums:count(2))

local dropped = nums:drop(2)
show("drop 2:", dropped)

local unique = nums:uniq()
show("uniq:", unique)

local zipped = List({ "a", "b", "c" }):zip(List({ 1, 2 }))
print("zip:", zipped[1][1], zipped[1][2], "/", zipped[2][1], zipped[2][2])

local grouped = nums:group_by(function(n)
  return n % 2 == 0 and "even" or "odd"
end)
show("group odd:", grouped.odd)
show("group even:", grouped.even)
