---@meta mods.tbl

---Utility functions for working with Lua tables.
---@class mods.tbl
local M = {}

--------------------------------------------------------------------------------
------------------------------------ Basics ------------------------------------
--------------------------------------------------------------------------------

---Remove all entries from the table.
---
---**Example:**
---```lua
---local t = { a = 1, b = 2 }
---clear(t)
----- result: {}
---```
---@param t table
---@return nil
function M.clear(t) end

---Return the number of keys in the table.
---
---**Example:**
---```lua
---local n = count({ a = 1, b = 2 })
----- result: 2
---```
---@param t table
---@return integer
---@nodiscard
function M.count(t) end

--------------------------------------------------------------------------------
------------------------------------ Copying -----------------------------------
--------------------------------------------------------------------------------

---Create a shallow copy of the table.
---
---**Example:**
---```lua
---local t = copy({ a = 1, b = 2 })
----- result: { a = 1, b = 2 }
---```
---@generic T:table
---@param t T
---@return T
---@nodiscard
function M.copy(t) end

---Create a deep copy of a value.
---If `v` is a table, all nested tables are copied recursively; other types are returned as-is.
---
---**Example:**
---```lua
---local n = deepcopy(42)
----- result: 42
---
---local t = deepcopy({ a = { b = 1 } })
----- result: { a = { b = 1 } }
---```
---@generic T
---@param v T
---@return T
---@nodiscard
function M.deepcopy(v) end

--------------------------------------------------------------------------------
------------------------------------- Query ------------------------------------
--------------------------------------------------------------------------------

---Filter entries by a value predicate.
---
---**Example:**
---```lua
---local even = filter({ a = 1, b = 2, c = 3 }, function(v)
---  return v % 2 == 0
---end)
----- result: { b = 2 }
---```
---@param t table
---@param pred fun(v:any):boolean
---@return table
---@nodiscard
function M.filter(t, pred) end

---Find the first key whose value equals the given value.
---
---**Example:**
---```lua
---local key = find({ a = 1, b = 2, c = 2 }, 2)
----- result: "b" or "c"
---```
---@generic T1,T2
---@param t {[T1]:T2}
---@param v T2
---@return T1?
---@nodiscard
function M.find(t, v) end

---Find first value and key matching predicate.
---
---**Example:**
---```lua
---local v, k = find_if({ a = 1, b = 2 }, function(v, k)
---  return k == "b" and v == 2
---end)
----- result: 2, "b"
---```
---@generic T1,T2
---@param t table
---@param pred fun(v:T1,k:T2):boolean
---@return T1? v
---@return T2? k
---@nodiscard
function M.find_if(t, pred) end

---Safely get nested value by keys.
---If no keys are provided, returns the input table.
---
---**Example:**
---```lua
---local t = { a = { b = { c = 1 } } }
---local v = get(t, "a", "b", "c")
----- result: 1
---
---local v2 = get(t)
----- result: { a = { b = { c = 1 } } }
---```
---@param t table
---@param ... any
---@return any
---@nodiscard
function M.get(t, ...) end

--------------------------------------------------------------------------------
---------------------------------- Transforms ----------------------------------
--------------------------------------------------------------------------------

---Invert keys/values into new table.
---
---**Example:**
---```lua
---local t = invert({ a = 1, b = 2 })
----- result: { [1] = "a", [2] = "b" }
---```
---@generic T1,T2
---@param t {[T1]:T2}
---@return {[T2]:T1}
---@nodiscard
function M.invert(t) end

---Return true if table has no entries.
---
---**Example:**
---```lua
---local empty = isempty({})
----- result: true
---```
---@param t table
---@return boolean
---@nodiscard
function M.isempty(t) end

---Return a list of all keys in the table.
---
---**Example:**
---```lua
---local keys = keys({ a = 1, b = 2 })
----- result: { "a", "b" }
---```
---@generic T
---@param t {[any]:T}
---@return mods.List<T>|T[]
---@nodiscard
function M.keys(t) end

---Return a new table by mapping each value (keys preserved).
---
---**Example:**
---```lua
---local t = map({ a = 1, b = 2 }, function(v)
---  return v * 10
---end)
----- result: { a = 10, b = 20 }
---```
---@generic T1,T2,T3
---@param t {[T1]:T2}
---@param fn fun(v:T2):T3
---@return {[T1]:T3}
---@nodiscard
function M.map(t, fn) end

---Return a new table by mapping each key-value pair.
---The resulting table keeps the same keys, with values transformed by `fn`.
---
---**Example:**
---```lua
---local t = pairmap({ a = 1, b = 2 }, function(k, v)
---  return k .. v
---end)
----- result: { a = "a1", b = "b2" }
---```
---@generic T1,T2,T3
---@param t {[T1]:T2}
---@param fn fun(k:T1, v:T2):T3
---@return {[T1]:T3}
---@nodiscard
function M.pairmap(t, fn) end

---Merge entries from t2 into t1 and return t1.
---
---**Example:**
---```lua
---local t1 = { a = 1, b = 2 }
---update(t1, { b = 3, c = 4 })
----- result: t1 is { a = 1, b = 3, c = 4 }
---```
---@generic T:table
---@param t1 T
---@param t2 table
---@return T
---@nodiscard
function M.update(t1, t2) end

---Return a list of all values in the table.
---
---**Example:**
---```lua
---local vals = values({ a = 1, b = 2 })
----- result: { 1, 2 }
---```
---@generic T
---@param t {[any]:T}
---@return mods.List<T>|T[]
---@nodiscard
function M.values(t) end

return M
