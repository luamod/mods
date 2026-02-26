---@meta mods.tbl

---
---Utility functions for working with Lua tables.
---
---## Usage
---
---```lua
---tbl = require "mods.tbl"
---
---print(tbl.count({ a = 1, b = 2 })) --> 2
---```
---
---@class mods.tbl
local M = {}

--------------------------------------------------------------------------------
------------------------------------ Basics ------------------------------------
--------------------------------------------------------------------------------
---
---Core table utilities for clearing and counting.
---

---
---Remove all entries from the table.
---
---```lua
---t = { a = 1, b = 2 }
---clear(t) --> t = {}
---```
---
---@param t table
---@return nil
function M.clear(t) end

---
---Return the number of keys in the table.
---
---```lua
---n = count({ a = 1, b = 2 }) --> 2
---```
---
---@param t table
---@return integer
---@nodiscard
function M.count(t) end

--------------------------------------------------------------------------------
------------------------------------ Copying -----------------------------------
--------------------------------------------------------------------------------
---
---Shallow and deep copy helpers.
---

---
---Create a shallow copy of the table.
---
---```lua
---t = copy({ a = 1, b = 2 }) --> { a = 1, b = 2 }
---```
---
---@generic T:table
---@param t T
---@return T
---@nodiscard
function M.copy(t) end

---
---Create a deep copy of a value.
---
---> [!NOTE]
--->
---> If `v` is a table, all nested tables are copied recursively; other types
---> are returned as-is.
---
---```lua
---t = deepcopy({ a = { b = 1 } }) --> { a = { b = 1 } }
---n = deepcopy(42) --> 42
---```
---
---@generic T
---@param v T
---@return T
---@nodiscard
function M.deepcopy(v) end

--------------------------------------------------------------------------------
------------------------------------- Query ------------------------------------
--------------------------------------------------------------------------------
---
---Read-only lookup and selection helpers.
---

---
---Filter entries by a value predicate.
---
---```lua
---even = filter({ a = 1, b = 2, c = 3 }, function(v)
---  return v % 2 == 0
---end) --> { b = 2 }
---```
---
---@param t table
---@param pred fun(v:any):boolean
---@return table
---@nodiscard
function M.filter(t, pred) end

---
---Find the first key whose value equals the given value.
---
---```lua
---key = find({ a = 1, b = 2, c = 2 }, 2) --> "b" or "c"
---```
---
---@generic T1,T2
---@param t {[T1]:T2}
---@param v T2
---@return T1?
---@nodiscard
function M.find(t, v) end

---
---Return `true` if two tables have the same keys and equal values.
---
---```lua
---ok = same({ a = 1, b = 2 }, { b = 2, a = 1 }) --> true
---ok = same({ a = {} }, { a = {} })             --> false
---```
---
---@param a table
---@param b table
---@return boolean
---@nodiscard
function M.same(a, b) end

---
---Find first value and key matching predicate.
---
---```lua
---v, k = find_if({ a = 1, b = 2 }, function(v, k)
---  return k == "b" and v == 2
---end) --> 2, "b"
---```
---
---@generic T1,T2
---@param t table
---@param pred fun(v:T1,k:T2):boolean
---@return T1? v
---@return T2? k
---@nodiscard
function M.find_if(t, pred) end

---
---Safely get nested value by keys.
---
---```lua
---t = { a = { b = { c = 1 } } }
---v1 = get(t, "a", "b", "c") --> 1
---v2 = get(t) --> { a = { b = { c = 1 } } }
---```
---
---> [!NOTE]
--->
---> If no keys are provided, returns the input table.
---
---@param t table
---@param ... any
---@return any
---@nodiscard
function M.get(t, ...) end

---
---Format a key chain as a Lua-like table access path.
---
---```lua
---p1 = keypath("t", "a", "b", "c")        --> "t.a.b.c"
---p2 = keypath("ctx", "users", 1, "name") --> "ctx.users[1].name"
---p3 = keypath("ctx", "invalid-key")      --> 'ctx["invalid-key"]'
---p4 = keypath()                          --> ""
---```
---
---@param ... any
---@return string
---@nodiscard
function M.keypath(...) end

--------------------------------------------------------------------------------
---------------------------------- Transforms ----------------------------------
--------------------------------------------------------------------------------
---
---Table transformation and conversion utilities.
---

---
---Invert keys/values into new table.
---
---```lua
---t = invert({ a = 1, b = 2 }) --> { [1] = "a", [2] = "b" }
---```
---
---@generic T1,T2
---@param t {[T1]:T2}
---@return {[T2]:T1}
---@nodiscard
function M.invert(t) end

---
---Return true if table has no entries.
---
---```lua
---empty = isempty({}) --> true
---```
---
---@param t table
---@return boolean
---@nodiscard
function M.isempty(t) end

---
---Return a list of all keys in the table.
---
---```lua
---keys = keys({ a = 1, b = 2 }) --> { "a", "b" }
---```
---
---@generic T
---@param t {[any]:T}
---@return mods.List<T>
---@nodiscard
function M.keys(t) end

---
---Return a new table by mapping each value (keys preserved).
---
---```lua
---t = map({ a = 1, b = 2 }, function(v)
---  return v * 10
---end) --> { a = 10, b = 20 }
---```
---
---@generic T1,T2,T3
---@param t {[T1]:T2}
---@param fn fun(v:T2):T3
---@return {[T1]:T3}
---@nodiscard
function M.map(t, fn) end

---
---Return a new table by mapping each key-value pair.
---
---> [!NOTE]
--->
---> Output keeps original keys; only values are transformed by `fn`.
---
---```lua
---t = pairmap({ a = 1, b = 2 }, function(k, v)
---  return k .. v
---end) --> { a = "a1", b = "b2" }
---```
---
---@generic T1,T2,T3
---@param t {[T1]:T2}
---@param fn fun(k:T1, v:T2):T3
---@return {[T1]:T3}
---@nodiscard
function M.pairmap(t, fn) end

---
---Merge entries from `t2` into `t1` and return `t1`.
---
---```lua
---t1 = { a = 1, b = 2 }
---update(t1, { b = 3, c = 4 }) --> t1 is { a = 1, b = 3, c = 4 }
---```
---
---@generic T:table
---@param t1 T
---@param t2 table
---@return T
---@nodiscard
function M.update(t1, t2) end

---
---Return a list of all values in the table.
---
---```lua
---vals = values({ a = 1, b = 2 }) --> { 1, 2 }
---```
---
---@generic T
---@param t {[any]:T}
---@return mods.List<T>
---@nodiscard
function M.values(t) end

return M
