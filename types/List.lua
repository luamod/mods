---@meta mods.List

---A Python-style list class providing common operations to create,
---modify, and query sequences of values.
---@class mods.List<T>:{[integer]:T}
---@overload fun(t?:{}):mods.List
local List = {}
List.__index = List

--------------------------------------------------------------------------------
---------------------------------- Predicates ----------------------------------
--------------------------------------------------------------------------------

---Return true if all values match the predicate.
---Empty lists return true.
---
---**Example:**
---```lua
---local is_even = function(v) return v % 2 == 0 end
---local ok = List({ 2, 4 }):all(is_even)
----- result: true
---```
---@param self mods.List|any[]
---@param pred fun(v:any):boolean
---@return boolean
---@nodiscard
function List:all(pred) end

---Return true if any value matches the predicate.
---
---**Example:**
---```lua
---local has_len_2 = function(v) return #v == 2 end
---local ok = List({ "a", "bb" }):any(has_len_2)
----- result: true
---```
---@param self mods.List|any[]
---@param pred fun(v:any):boolean
---@return boolean
---@nodiscard
function List:any(pred) end

--------------------------------------------------------------------------------
----------------------------------- Mutation -----------------------------------
--------------------------------------------------------------------------------

---Append a value to the end of the list.
---
---**Example:**
---```lua
---local l = List({ "a" }):append("b")
----- result: { "a", "b" }
---```
---@generic T:mods.List|any[]
---@param self T
---@return T self
function List:append(v) end

---Remove all elements from the list.
---
---**Example:**
---```lua
---local l = List({ "a", "b" }):clear()
----- result: { }
---```
---@generic T:mods.List|any[]
---@param self T
---@return T self
function List:clear() end

---Extend the list with another list.
---
---**Example:**
---```lua
---local l = List({ "a" })
---l:extend({ "b", "c" })
----- result: { "a", "b", "c" }
---```
---@generic T:mods.List|any[]
---@param self T
---@param ls any[]
---@return T self
function List:extend(ls) end

---Extract values matching the predicate and remove them from the list.
---
---**Example:**
---```lua
---local l = List({ "a", "bb", "c" })
---local is_len_1 = function(v) return #v == 1 end
---local ex = l:extract(is_len_1)
----- result: ex = { "a", "c" }, l = { "bb" }
---```
---@generic T:mods.List|any[]
---@param self T
---@param pred fun(v:any):boolean
---@return T self
---@nodiscard
function List:extract(pred) end

---Insert a value at the given position.
---
---**Example:**
---```lua
---local l = List({ "a", "c" }):insert(2, "b")
----- result: { "a", "b", "c" }
---```
---@generic T:mods.List|any[]
---@param self T
---@param pos integer
---@param v any
---@return T self
function List:insert(pos, v) end

---Append a value to the end of the list.
---
---**Example:**
---```lua
---local l = List({ "a", "b" }):insert("b")
----- result: { "a", "b", "c" }
---```
---@generic T:mods.List|any[]
---@param self T
---@param v any
---@return T self
function List:insert(v) end

---Remove and return the last element.
---**Example:**
---```lua
---local l = List({ "a", "b" })
---local v = l:pop()
----- result: v == "b"; l is { "a" }
---```
---@param self mods.List|any[]
---@return any
function List:pop() end

---Remove and return the element at the given position.
---
---**Example:**
---```lua
---local l = List({ "a", "b", "c" })
---local v = l:pop(2)
----- result: v == "b"; l is { "a", "c" }
---```
---@param self mods.List|any[]
---@param pos integer
---@return any
function List:pop(pos) end

---Insert a value at the start of the list.
---
---**Example:**
---```lua
---local l = List({ "b", "c" })
---l:prepend("a")
----- result: { "a", "b", "c" }
---```
---@generic T:mods.List|any[]
---@param self T
---@param v any
---@return T self
function List:prepend(v) end

---Remove the first matching value.
---
---**Example:**
---```lua
---local l = List({ "a", "b", "b" })
---l:remove("b")
----- result: { "a", "b" }
---```
---@generic T:mods.List|any[]
---@param self T
---@param v any
---@return T self
function List:remove(v) end

---Sort the list in place.
---
---**Example:**
---```lua
---local l = List({ 3, 1, 2 })
---l:sort()
----- result: { 1, 2, 3 }
---```
---@generic T:mods.List|any[]
---@param self T
---@param comp? fun(a,b):boolean
---@return T self
function List:sort(comp) end

--------------------------------------------------------------------------------
----------------------------------- Copying ------------------------------------
--------------------------------------------------------------------------------

---Return a shallow copy of the list.
---
---**Example:**
---```lua
---local c = List({ "a", "b" }):copy()
----- result: { "a", "b" }
---```
---@param self mods.List|any[]
---@return mods.List ls
---@nodiscard
function List:copy() end

--------------------------------------------------------------------------------
------------------------------------- Query ------------------------------------
--------------------------------------------------------------------------------

---Return true if the list contains the value.
---
---**Example:**
---```lua
---local ok = List({ "a", "b" }):contains("b")
----- result: true
---```
---@param self mods.List|any[]
---@param v any
---@return any
---@nodiscard
function List:contains(v) end

---Count how many times a value appears.
---
---**Example:**
---```lua
---local n = List({ "a", "b", "b" }):count("b")
----- result: 2
---```
---@param self mods.List|any[]
---@return integer
---@nodiscard
function List:count(v) end

---Return the index of the first matching value.
---
---**Example:**
---```lua
---local i = List({ "a", "b", "c", "b" }):index("b")
----- result: 2
---```
---@param self mods.List|any[]
---@param v any
---@return any value
---@return integer? index
---@nodiscard
function List:index(v) end

---Return the index of the first value matching the predicate.
---
---**Example:**
---```lua
---local gt_1 = function(x) return x > 1 end
---local i = List({ 1, 2, 3 }):index_if(gt_1)
----- result: 2
---```
---@param self mods.List|any[]
---@param pred fun(v:any):boolean
---@return integer? index
---@nodiscard
function List:index_if(pred) end

---Return the number of elements in the list.
---
---**Example:**
---```lua
---local n = List({ "a", "b", "c" }):len()
----- result: 3
---```
---@param self mods.List|any[]
---@return integer
---@nodiscard
function List:len() end

--------------------------------------------------------------------------------
------------------------------------ Access ------------------------------------
--------------------------------------------------------------------------------

---Return the first element or nil if empty.
---
---**Example:**
---```lua
---local v = List({ "a", "b" }):first()
----- result: "a"
---```
---@param self mods.List|any[]
---@return any
---@nodiscard
function List:first() end

---Return the last element or nil if empty.
---
---**Example:**
---```lua
---local v = List({ "a", "b" }):last()
----- result: "b"
---```
---@param self mods.List|any[]
---@return any
---@nodiscard
function List:last() end

--------------------------------------------------------------------------------
--------------------------------- Transform ------------------------------------
--------------------------------------------------------------------------------

---Return a new list with values not in the given list.
---
---**Example:**
---```lua
---local d = List({ "a", "b", "c" }):difference({ "b" })
----- result: { "a", "c" }
---```
---@generic T:mods.List|any[]
---@param self T
---@return T ls
---@nodiscard
function List:difference(ls) end

---Return a new list without the first n elements.
---
---**Example:**
---```lua
---local t = List({ "a", "b", "c" }):drop(1)
----- result: { "b", "c" }
---```
---@param self mods.List|any[]
---@param n integer
---@return mods.List ls
---@nodiscard
function List:drop(n) end

---Return a new list with values matching the predicate.
---
---**Example:**
---```lua
---local is_len_1 = function(v) return #v == 1 end
---local f = List({ "a", "bb", "c" }):filter(is_len_1)
----- result: { "a", "c" }
---```
---@param self mods.List|any[]
---@param pred fun(v:any):boolean
---@return mods.List ls
---@nodiscard
function List:filter(pred) end

---Flatten one level of nested lists.
---
---**Example:**
---```lua
---local f = List({ { "a", "b" }, { "c" } }):flatten()
----- result: { "a", "b", "c" }
---```
---@param self mods.List|any[]
---@return mods.List self
---@nodiscard
function List:flatten() end

---Apply a function to each element (for side effects).
---Returns nil.
---
---**Example:**
---```lua
---List({ "a", "b" }):foreach(print)
---```
---@param self mods.List|any[]
---@param fn fun(v:any)
---@return nil
function List:foreach(fn) end

---Group list values by a computed key.
---
---**Example:**
---```lua
---local words = { "aa", "b", "ccc", "dd" }
---local g = List(words):group_by(string.len)
----- result: { {"b"}, { "aa", "dd" }, { "ccc" } }
---```
---@param self mods.List|any[]
---@param fn fun(v:any):any
---@return table
---@nodiscard
function List:group_by(fn) end

---Return values that are also present in the given list.
---Order is preserved from the original list.
---
---**Example:**
---```lua
---local i = List({ "a", "b", "a", "c" }):intersection({ "a", "c" })
----- result: { "a", "a", "c" }
---```
---@param self mods.List|any[]
---@param ls mods.List|any[]
---@return mods.List self
---@nodiscard
function List:intersection(ls) end

---Invert values to indices in a new table.
---
---**Example:**
---```lua
---local t = List({ "a", "b", "c" }):invert()
----- result: { a = 1, b = 2, c = 3 }
---```
---@param self mods.List|any[]
---@return table
---@nodiscard
function List:invert() end

---Join list values into a string.
---
---**Example:**
---```lua
---local s = List({ "a", "b", "c" }):join(",")
----- result: "a,b,c"
---```
---@param self mods.List|any[]
---@param sep? string
---@return string
---@nodiscard
function List:join(sep) end

---Return a new list by mapping each value.
---
---**Example:**
---```lua
---local to_upper = function(v) return v:upper() end
---local m = List({ "a", "b" }):map(to_upper)
----- result: { "A", "B" }
---```
---@param self mods.List|any[]
---@param fn fun(v):any
---@return mods.List ls
---@nodiscard
function List:map(fn) end

---Reduce the list to a single value using an accumulator.
---If init is nil, the first element is used as the initial value.
---Empty lists return init (or nil if init is nil).
---
---**Example:**
---```lua
---local add = function(acc, v) return acc + v end
---local sum = List({ 1, 2, 3 }):reduce(add, 0)
----- result: 6
---
---sum = List({ 1, 2, 3 }):reduce(add, 10)
----- result: 16
---```
---@param self mods.List|any[]
---@param fn fun(acc:any, v:any):any
---@param init? any
---@return any
---@nodiscard
function List:reduce(fn, init) end

---Return a new list with items reversed.
---
---**Example:**
---```lua
---local r = List({ "a", "b", "c" }):reverse()
----- result: { "c", "b", "a" }
---```
---@param self mods.List|any[]
---@return mods.List ls
---@nodiscard
function List:reverse() end

---Convert the list to a set.
---
---**Example:**
---```lua
---local s = List({ "a", "b", "a" }):setify()
----- result: { a = true, b = true }
---```
---@param self mods.List|any[]
---@return mods.Set
---@nodiscard
function List:setify() end

---Return a new list containing items from i to j (inclusive).
---Supports negative indices (-1 is last element).
---
---**Example:**
---```lua
---local t = List({ "a", "b", "c", "d" }):slice(2, 3)
----- result: { "b", "c" }
---```
---@param self mods.List|any[]
---@param i? integer
---@param j? integer
---@return mods.List ls
---@nodiscard
function List:slice(i, j) end

---Return the first n elements as a new list.
---
---**Example:**
---```lua
---local t = List({ "a", "b", "c" }):take(2)
----- result: { "a", "b" }
---```
---@param self mods.List|any[]
---@param n integer
---@return mods.List ls
---@nodiscard
function List:take(n) end

---Return a new list with duplicates removed (first occurrence kept).
---
---**Example:**
---```lua
---local u = List({ "a", "b", "a", "c" }):uniq()
----- result: { "a", "b", "c" }
---```
---@param self mods.List|any[]
---@return mods.List ls
---@nodiscard
function List:uniq() end

---Zip two lists into a list of 2-element tables.
---Length is the minimum of both lists.
---
---**Example:**
---```lua
---local z = List({ "a", "b" }):zip({ 1, 2 })
----- result: { {"a",1}, {"b",2} }
---```
---@param self mods.List|any[]
---@param ls mods.List|any[]
---@return mods.List ls
---@nodiscard
function List:zip(ls) end

return List
