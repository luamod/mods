local str = require("mods.str")

print("capitalize: " .. str.capitalize("hELLo"))
print("center    : " .. str.center("hi", 6, "-"))
print("count     : " .. str.count("banana", "na"))
print("startswith: " .. tostring(str.startswith("lua-mods", "lua")))
print("endswith  : " .. tostring(str.endswith("archive.tar.gz", ".gz")))

print("expandtabs: " .. str.expandtabs("a\tbb", 4))
print("find      : " .. str.find("hello world", "world"))

local mapped = str.format_map("{name} has {count} messages", { name = "Ada", count = 3 })
print("format_map: " .. mapped)

local split = str.split("a,b,c", ",")
print(("split     : %s %s %s"):format(split[1], split[2], split[3]))

local stripped = str.strip("  hello  ")
print("strip     : " .. stripped)

local replaced = str.replace("hello world", "world", "lua")
print("replace   : " .. replaced)
