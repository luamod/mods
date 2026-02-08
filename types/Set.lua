---@meta mods.Set

---A Python-style set class providing common operations to create,
---modify, and query collections of unique values.
---@class mods.Set<T>:{[T]:true}
---@overload fun(t?:any[]|mods.Set|mods.List):mods.Set
local Set = {}
Set.__index = Set

---Add an element to the set.
---
---**Example:**
---```lua
---local s = Set({ "a" })
---s:add("b")
----- result: s contains "a", "b"
---```
---@param v any
---@return self self
function Set:add(v) end

---Remove all elements from the set.
---
---**Example:**
---```lua
---local s = Set({ "a", "b" })
---s:clear()
----- result: s is empty
---```
---@return self self
function Set:clear() end

---Return a shallow copy of the set.
---
---**Example:**
---```lua
---local s = Set({ "a" })
---local c = s:copy()
----- result: c is a new set with "a"
---```
---@return mods.Set
---@nodiscard
function Set:copy() end

---Return elements in this set but not in another.
---
---**Example:**
---```lua
---local s = Set({ "a", "b" })
---local d = s:difference(Set({ "b" }))
----- result: d contains "a"
---```
---@param set mods.Set
---@return mods.Set
---@nodiscard
function Set:difference(set) end

---Remove elements found in another set (in place).
---
---**Example:**
---```lua
---local s = Set({ "a", "b" })
---s:difference_update(Set({ "b" }))
----- result: s contains "a"
---```
---@param set self
---@return self self
function Set:difference_update(set) end

---Remove an element if present, do nothing otherwise.
---
---**Example:**
---```lua
---local s = Set({ "a", "b" })
---s:discard("b")
----- result: s contains "a"
---```
---@param v any
---@return self self
function Set:discard(v) end

Set.remove = Set.discard

---Return elements common to both sets.
---
---**Example:**
---```lua
---local s = Set({ "a", "b" })
---local i = s:intersection(Set({ "b", "c" }))
----- result: i contains "b"
---```
---@param set mods.Set
---@return mods.Set
---@nodiscard
function Set:intersection(set) end

---Keep only elements common to both sets (in place).
---
---**Example:**
---```lua
---local s = Set({ "a", "b" })
---s:intersection_update(Set({ "b", "c" }))
----- result: s contains "b"
---```
---@param set mods.Set
---@return self self
function Set:intersection_update(set) end

---Return true if sets have no elements in common.
---
---**Example:**
---```lua
---local ok = Set({ "a" }):isdisjoint(Set({ "b" }))
----- result: true
---```
---@param set mods.Set
---@return boolean
---@nodiscard
function Set:isdisjoint(set) end

---Return true if the set has no elements.
---
---**Example:**
---```lua
---local empty = Set({}):isempty()
----- result: true
---```
---@return boolean
---@nodiscard
function Set:isempty() end

---Return true if all elements of this set are also in another set.
---
---**Example:**
---```lua
---local ok = Set({ "a" }):issubset(Set({ "a", "b" }))
----- result: true
---```
---@param set mods.Set
---@return boolean
---@nodiscard
function Set:issubset(set) end

---Return true if this set contains all elements of another set.
---
---**Example:**
---```lua
---local ok = Set({ "a", "b" }):issuperset(Set({ "a" }))
----- result: true
---```
---@param set mods.Set
---@return boolean
---@nodiscard
function Set:issuperset(set) end

---Return the number of elements in the set.
---
---**Example:**
---```lua
---local n = Set({ "a", "b" }):len()
----- result: 2
---```
---@return integer
---@nodiscard
function Set:len() end

---Return a new set by mapping each value.
---
---**Example:**
---```lua
---local s = Set({ 1, 2 }):map(function(v) return v * 10 end)
----- result: s contains 10, 20
---```
---@param fn fun(v:T):any
---@return mods.Set
---@nodiscard
function Set:map(fn) end

---Remove and return an arbitrary element.
---
---**Example:**
---```lua
---local v = Set({ "a", "b" }):pop()
----- result: v is either "a" or "b"
---```
---@return any
function Set:pop() end

---Return elements not shared by both sets.
---
---**Example:**
---```lua
---local s = Set({ "a", "b" })
---local d = s:symmetric_difference(Set({ "b", "c" }))
----- result: d contains "a", "c"
---```
---@param set mods.Set
---@return mods.Set
---@nodiscard
function Set:symmetric_difference(set) end

---Update the set with elements not shared by both (in place).
---
---**Example:**
---```lua
---local s = Set({ "a", "b" })
---s:symmetric_difference_update(Set({ "b", "c" }))
----- result: s contains "a", "c"
---```
---@param set self
---@return self self
function Set:symmetric_difference_update(set) end

---Return a new set with all elements from both.
---
---**Example:**
---```lua
---local s = Set({ "a" }):union(Set({ "b" }))
----- result: s contains "a", "b"
---```
---@param set mods.Set
---@return mods.Set
---@nodiscard
function Set:union(set) end

---Add all elements from another set (in place).
---
---**Example:**
---```lua
---local s = Set({ "a" })
---s:update(Set({ "b" }))
----- result: s contains "a", "b"
---```
---@param set mods.Set
---@return self self
function Set:update(set) end

---Return a list of all values in the set.
---
---**Example:**
---```lua
---local values = Set({ "a", "b" }):values()
----- result: { "a", "b" }
---```
---@return mods.List<T>|T[] values
---@nodiscard
function Set:values() end

return Set
