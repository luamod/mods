---@meta mods.Set

---
---A Python-style set class providing common operations to create,
---modify, and query collections of unique values.
---
---## Usage
---
---```lua
---Set = require "mods.Set"
---
---s = Set({ "a" })
---print(s:contains("a")) --> true
---```
---
---## Dependencies
---
---Dependencies below are lazy-loaded 💤 on first access.
---
---* [`mods.tbl`](https://luamod.github.io/mods/modules/tbl)
---
---@class mods.Set<T>:{[T]:true}
---@operator add(mods.Set):mods.Set
---@operator sub(mods.Set):mods.Set
---@overload fun(t?:any[]|mods.Set|mods.List):mods.Set
local Set = {}
Set.__index = Set

--------------------------------------------------------------------------------
----------------------------------- Mutation -----------------------------------
--------------------------------------------------------------------------------
---
---In-place operations that mutate the current set.
---

---
---Add an element to the set.
---
---```lua
---s = Set({ "a" }):add("b") --> s contains "a", "b"
---```
---
---@generic T:mods.Set|table<any,true>
---@param self T
---@param v any
---@return T self
function Set:add(v) end

---
---Remove all elements from the set.
---
---```lua
---s = Set({ "a", "b" }):clear() --> s is empty
---```
---
---@generic T:mods.Set|table<any,true>
---@param self T
---@return T self
function Set:clear() end

---
---Remove elements found in another set (in place).
---
---```lua
---s = Set({ "a", "b" }):difference_update(Set({ "b" })) --> s contains "a"
---```
---
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return T self
function Set:difference_update(set) end

---
---Keep only elements common to both sets (in place).
---
---```lua
---s = Set({ "a", "b" }):intersection_update(Set({ "b", "c" }))
-----> s contains "b"
---```
---
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return T self
function Set:intersection_update(set) end

---
---Remove and return an arbitrary element.
---
---```lua
---v = Set({ "a", "b" }):pop() --> v is either "a" or "b"
---```
---
---@param self mods.Set|table<any,true>
---@return any
function Set:pop() end

---
---Update the set with elements not shared by both (in place).
---
---```lua
---s = Set({ "a", "b" }):symmetric_difference_update(Set({ "b", "c" }))
-----> s contains "a", "c"
---```
---
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return T self
function Set:symmetric_difference_update(set) end

---
---Add all elements from another set (in place).
---
---```lua
---s = Set({ "a" }):update(Set({ "b" })) --> s contains "a", "b"
---```
---
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return T self
function Set:update(set) end

--------------------------------------------------------------------------------
----------------------------------- Copying ------------------------------------
--------------------------------------------------------------------------------
---
---Non-mutating set operations that return new set instances.
---

---
---Return a shallow copy of the set.
---
---```lua
---c = Set({ "a" }):copy() --> c is a new set with "a"
---```
---
---@param self mods.Set|table<any,true>
---@return mods.Set set
---@nodiscard
function Set:copy() end

---
---Return elements in this set but not in another.
---
---```lua
---d = Set({ "a", "b" }):difference(Set({ "b" })) --> d contains "a"
---```
---
---@param self mods.Set|table<any,true>
---@param set mods.Set|table<any,true>
---@return mods.Set set
---@nodiscard
function Set:difference(set) end

---
---Return elements common to both sets.
---
---```lua
---i = Set({ "a", "b" }):intersection(Set({ "b", "c" })) --> i contains "b"
---```
---
---@param self mods.Set|table<any,true>
---@param set mods.Set|table<any,true>
---@return mods.Set set
---@nodiscard
function Set:intersection(set) end

---
---Remove an element if present, do nothing otherwise.
---
---```lua
---s = Set({ "a", "b" }):remove("b") --> s contains "a"
---```
---
---@generic T:mods.Set|table<any,true>
---@param self T
---@param v any
---@return T self
function Set:remove(v) end

---
---Return elements not shared by both sets.
---
---```lua
---d = Set({ "a", "b" }):symmetric_difference(Set({ "b", "c" }))
-----> d contains "a", "c"
---```
---
---@param self mods.Set|table<any,true>
---@param set mods.Set|table<any,true>
---@return mods.Set set
---@nodiscard
function Set:symmetric_difference(set) end

---
---Return a new set with all elements from both.
---
---```lua
---s = Set({ "a" }):union(Set({ "b" })) --> s contains "a", "b"
---```
---
---@param self mods.Set|table<any,true>
---@param set mods.Set|table<any,true>
---@return mods.Set set
---@nodiscard
function Set:union(set) end

--------------------------------------------------------------------------------
---------------------------------- Predicates ----------------------------------
--------------------------------------------------------------------------------
---
---Boolean checks about set relationships and emptiness.
---

---
---Return true if sets have no elements in common.
---
---```lua
---ok = Set({ "a" }):isdisjoint(Set({ "b" })) --> true
---```
---
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return boolean
---@nodiscard
function Set:isdisjoint(set) end

---
---Return true if the set has no elements.
---
---```lua
---empty = Set({}):isempty() --> true
---```
---
---@param self mods.Set|table<any,true>
---@return boolean
---@nodiscard
function Set:isempty() end

---
---Return true if all elements of this set are also in another set.
---
---```lua
---ok = Set({ "a" }):issubset(Set({ "a", "b" })) --> true
---```
---
---> [!NOTE]
--->
---> `issubset` is also available as the `__le` (`<=`) operator.
---> `a:issubset(b)` is equivalent to `a <= b`.
---
---@param self mods.Set|table<any,true>
---@param set mods.Set|table<any,true>
---@return boolean
---@nodiscard
function Set:issubset(set) end

---
---Return true if this set contains all elements of another set.
---
---```lua
---ok = Set({ "a", "b" }):issuperset(Set({ "a" })) --> true
---```
---
---@param self mods.Set|table<any,true>
---@param set mods.Set|table<any,true>
---@return boolean
---@nodiscard
function Set:issuperset(set) end

--------------------------------------------------------------------------------
------------------------------------- Query ------------------------------------
--------------------------------------------------------------------------------
---
---Read-only queries for membership and size.
---

---
---Return true if the set contains `v`.
---
---```lua
---ok = Set({ "a", "b" }):contains("a") --> true
---ok = Set({ "a", "b" }):contains("z") --> false
---```
---
---@param self mods.Set|table<any,true>
---@param v any
---@return boolean
---@nodiscard
function Set:contains(v) end

---
---Return the number of elements in the set.
---
---```lua
---n = Set({ "a", "b" }):len() --> 2
---```
---
---@param self mods.Set|table<any,true>
---@return integer
---@nodiscard
function Set:len() end

--------------------------------------------------------------------------------
----------------------------------- Transform ----------------------------------
--------------------------------------------------------------------------------
---
---Value-to-value transformations and projection helpers.
---

---
---Return a new set by mapping each value.
---
---```lua
---s = Set({ 1, 2 }):map(function(v) return v * 10 end) --> s contains 10, 20
---```
---
---@param self mods.Set|table<any,true>
---@param fn fun(v:any):any
---@return mods.Set set
---@nodiscard
function Set:map(fn) end

---
---Return a list of all values in the set.
---
---```lua
---values = Set({ "a", "b" }):values() --> { "a", "b" }
---```
---
---@param self mods.Set|table<any,true>
---@return mods.List values
---@nodiscard
function Set:values() end

--------------------------------------------------------------------------------
---------------------------------- Metamethods ---------------------------------
--------------------------------------------------------------------------------

---
---Return the union of two sets using `+`.
---
---```lua
---a = Set({ "a", "b" })
---b = Set({ "b", "c" })
---u = a + b --> { a = true, b = true, c = true }
---```
---
---> [!NOTE]
--->
---> `__add` is the operator form of `:union(set)`.
---
---@param self mods.Set|table<any,true>
---@param set mods.Set|table<any,true>
---@return mods.Set
function Set.__add(self, set) end

---
---Return true if the left set is a subset of the right set using `<=`.
---
---```lua
---a = Set({ "a" })
---b = Set({ "a", "b" })
---ok = a <= b --> true
---```
---
---> [!NOTE]
--->
---> `__le` is the operator form of `:issubset(set)`.
---
---@param self mods.Set|table<any,true>
---@param set mods.Set|table<any,true>
---@return boolean
function Set.__le(self, set) end

---
---Return true if the left set is a proper subset of the right set using `<`.
---
---```lua
---a = Set({ "a" })
---b = Set({ "a", "b" })
---ok = a < b --> true
---```
---
---@param self mods.Set|table<any,true>
---@param set mods.Set|table<any,true>
---@return boolean
function Set.__lt(self, set) end

---
---Return the difference of two sets using `-`.
---
---```lua
---a = Set({ "a", "b" })
---b = Set({ "b", "c" })
---d = a - b --> { a = true }
---```
---
---> [!NOTE]
--->
---> `__sub` is the operator form of `:difference(set)`.
---
---@param self mods.Set|table<any,true>
---@param set mods.Set|table<any,true>
---@return mods.Set
function Set.__sub(self, set) end

return Set
