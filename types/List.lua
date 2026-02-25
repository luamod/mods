---@meta mods.List

---
---A Python-style list class providing common operations to create,
---modify, and query sequences of values.
---
---## Usage
---
---```lua
---List = require "mods.List"
---
---ls = List({ "a" }):append("b")
---print(ls:contains("b")) --> true
---print(ls:index("b")) --> 2
---```
---
---## Dependencies
---
---Dependencies below are lazy-loaded 💤 on first access.
---
---* [`mods.Set`](https://luamod.github.io/mods/modules/set)
---
---@class mods.List<T>:{[integer]:T}
---@operator add(mods.List):mods.List
---@overload fun(t?:{}):mods.List
local List = {}
List.__index = List

--------------------------------------------------------------------------------
---------------------------------- Predicates ----------------------------------
--------------------------------------------------------------------------------
---
---Boolean checks for list-wide conditions.
---

---
---Return true if all values match the predicate.
---
---```lua
---is_even = function(v) return v % 2 == 0 end
---ok = List({ 2, 4 }):all(is_even) --> true
---```
---
---> [!NOTE]
--->
---> Empty lists return `true`.
---
---@param self mods.List|any[]
---@param pred fun(v:any):boolean
---@return boolean
---@nodiscard
function List:all(pred) end

---
---Return true if any value matches the predicate.
---
---```lua
---has_len_2 = function(v) return #v == 2 end
---ok = List({ "a", "bb" }):any(has_len_2) --> true
---```
---
---@param self mods.List|any[]
---@param pred fun(v:any):boolean
---@return boolean
---@nodiscard
function List:any(pred) end

--------------------------------------------------------------------------------
----------------------------------- Mutation -----------------------------------
--------------------------------------------------------------------------------
---
---In-place operations that modify the current list.
---

---
---Append a value to the end of the list.
---
---```lua
---ls = List({ "a" }):append("b") --> { "a", "b" }
---```
---
---@generic T:mods.List|any[]
---@param self T
---@return T self
function List:append(v) end

---
---Remove all elements from the list.
---
---```lua
---ls = List({ "a", "b" }):clear() --> { }
---```
---
---@generic T:mods.List|any[]
---@param self T
---@return T self
function List:clear() end

---
---Extend the list with another list.
---
---```lua
---ls = List({ "a" }):extend({ "b", "c" }) --> { "a", "b", "c" }
---```
---
---@generic T:mods.List|any[]
---@param self T
---@param ls any[]
---@return T self
function List:extend(ls) end

---
---Extract values matching the predicate and remove them from the list.
---
---```lua
---ls = List({ "a", "bb", "c" })
---is_len_1 = function(v) return #v == 1 end
---ex = ls:extract(is_len_1) --> ex = { "a", "c" }, ls = { "bb" }
---```
---
---@generic T:mods.List|any[]
---@param self T
---@param pred fun(v:any):boolean
---@return T self
---@nodiscard
function List:extract(pred) end

---
---Insert a value at the given position.
---
---```lua
---ls = List({ "a", "c" }):insert(2, "b") --> { "a", "b", "c" }
---```
---
---@generic T:mods.List|any[]
---@param self T
---@param pos integer
---@param v any
---@return T self
function List:insert(pos, v) end

---
---Append a value to the end of the list.
---
---```lua
---ls = List({ "a", "b" }):insert("b") --> { "a", "b", "c" }
---```
---
---@generic T:mods.List|any[]
---@param self T
---@param v any
---@return T self
function List:insert(v) end

---
---Remove and return the last element.
---
---```lua
---ls = List({ "a", "b" })
---v = ls:pop() --> v == "b"; ls is { "a" }
---```
---
---@param self mods.List|any[]
---@return any
function List:pop() end

---
---Remove and return the element at the given position.
---
---```lua
---ls = List({ "a", "b", "c" })
---v = ls:pop(2) --> v == "b"; ls is { "a", "c" }
---```
---
---@param self mods.List|any[]
---@param pos integer
---@return any
function List:pop(pos) end

---
---Insert a value at the start of the list.
---
---```lua
---ls = List({ "b", "c" })
---ls:prepend("a") --> { "a", "b", "c" }
---```
---
---@generic T:mods.List|any[]
---@param self T
---@param v any
---@return T self
function List:prepend(v) end

---
---Remove the first matching value.
---
---```lua
---ls = List({ "a", "b", "b" })
---ls:remove("b") --> { "a", "b" }
---```
---
---@generic T:mods.List|any[]
---@param self T
---@param v any
---@return T self
function List:remove(v) end

---
---Sort the list in place.
---
---```lua
---ls = List({ 3, 1, 2 })
---ls:sort() --> { 1, 2, 3 }
---```
---
---@generic T:mods.List|any[]
---@param self T
---@param comp? fun(a,b):boolean
---@return T self
function List:sort(comp) end

--------------------------------------------------------------------------------
----------------------------------- Copying ------------------------------------
--------------------------------------------------------------------------------
---
---Operations that return copied list data.
---

---
---Return a shallow copy of the list.
---
---```lua
---c = List({ "a", "b" }):copy() --> { "a", "b" }
---```
---
---@param self mods.List|any[]
---@return mods.List ls
---@nodiscard
function List:copy() end

--------------------------------------------------------------------------------
------------------------------------- Query ------------------------------------
--------------------------------------------------------------------------------
---
---Read-only queries for membership, counts, and indices.
---

---
---Return true if the list contains the value.
---
---```lua
---ok = List({ "a", "b" }):contains("b") --> true
---```
---
---@param self mods.List|any[]
---@param v any
---@return any
---@nodiscard
function List:contains(v) end

---
---Count how many times a value appears.
---
---```lua
---n = List({ "a", "b", "b" }):count("b") --> 2
---```
---
---@param self mods.List|any[]
---@return integer
---@nodiscard
function List:count(v) end

---
---Return the index of the first matching value.
---
---```lua
---i = List({ "a", "b", "c", "b" }):index("b") --> 2
---```
---
---@param self mods.List|any[]
---@param v any
---@return any value
---@return integer? index
---@nodiscard
function List:index(v) end

---
---Return the index of the first value matching the predicate.
---
---```lua
---gt_1 = function(x) return x > 1 end
---i = List({ 1, 2, 3 }):index_if(gt_1) --> 2
---```
---
---@param self mods.List|any[]
---@param pred fun(v:any):boolean
---@return integer? index
---@nodiscard
function List:index_if(pred) end

---
---Return the number of elements in the list.
---
---```lua
---n = List({ "a", "b", "c" }):len() --> 3
---```
---
---> [!NOTE]
--->
---> Uses Lua's `#` operator, so length is reliable for contiguous array-like lists.
---
---@param self mods.List|any[]
---@return integer
---@nodiscard
function List:len() end

--------------------------------------------------------------------------------
------------------------------------ Access ------------------------------------
--------------------------------------------------------------------------------
---
---Direct element access helpers.
---

---
---Return the first element or `nil` if empty.
---
---```lua
---v = List({ "a", "b" }):first() --> "a"
---```
---
---@param self mods.List|any[]
---@return any
---@nodiscard
function List:first() end

---
---Return the last element or `nil` if empty.
---
---```lua
---v = List({ "a", "b" }):last() --> "b"
---```
---
---@param self mods.List|any[]
---@return any
---@nodiscard
function List:last() end

--------------------------------------------------------------------------------
--------------------------------- Transform ------------------------------------
--------------------------------------------------------------------------------
---
---Non-mutating transformations and derived-list operations.
---

---
---Return a new list with values not in the given list.
---
---```lua
---d = List({ "a", "b", "c" }):difference({ "b" }) --> { "a", "c" }
---```
---
---@generic T:mods.List|any[]
---@param self T
---@return T ls
---@nodiscard
function List:difference(ls) end

---
---Return a new list without the first n elements.
---
---```lua
---t = List({ "a", "b", "c" }):drop(1) --> { "b", "c" }
---```
---
---@param self mods.List|any[]
---@param n integer
---@return mods.List ls
---@nodiscard
function List:drop(n) end

---
---Return a new list with values matching the predicate.
---
---```lua
---is_len_1 = function(v) return #v == 1 end
---f = List({ "a", "bb", "c" }):filter(is_len_1) --> { "a", "c" }
---```
---
---@param self mods.List|any[]
---@param pred fun(v:any):boolean
---@return mods.List ls
---@nodiscard
function List:filter(pred) end

---
---Flatten one level of nested lists.
---
---```lua
---f = List({ { "a", "b" }, { "c" } }):flatten() --> { "a", "b", "c" }
---```
---
---@param self mods.List|any[]
---@return mods.List self
---@nodiscard
function List:flatten() end

---
---Apply a function to each element (for side effects).
---
---```lua
---List({ "a", "b" }):foreach(print)
-----> prints -> a
-----> prints -> b
---```
---
---@param self mods.List|any[]
---@param fn fun(v:any)
---@return nil
function List:foreach(fn) end

---
---Group list values by a computed key.
---
---```lua
---words = { "aa", "b", "ccc", "dd" }
---g = List(words):group_by(string.len) --> { {"b"}, { "aa", "dd" }, { "ccc" } }
---```
---
---@param self mods.List|any[]
---@param fn fun(v:any):any
---@return table
---@nodiscard
function List:group_by(fn) end

---
---Return values that are also present in the given list.
---
---```lua
---i = List({ "a", "b", "a", "c" }):intersection({ "a", "c" })
-----> { "a", "a", "c" }
---```
---
---> [!NOTE]
--->
---> Order is preserved from the original list.
---
---@param self mods.List|any[]
---@param ls mods.List|any[]
---@return mods.List self
---@nodiscard
function List:intersection(ls) end

---
---Invert values to indices in a new table.
---
---```lua
---t = List({ "a", "b", "c" }):invert() --> { a = 1, b = 2, c = 3 }
---```
---
---@param self mods.List|any[]
---@return table
---@nodiscard
function List:invert() end

---
---Concatenate list values using Lua's native `table.concat` behavior.
---
---```lua
---s = List({ "a", "b", "c" }):concat(",") --> "a,b,c"
---```
---
---> [!NOTE]
--->
---> This method forwards to `table.concat` directly and keeps its strict
---> element rules.
---
---@param self mods.List|any[]
---@param sep? string
---@param i? integer
---@param j? integer
---@return string
---@nodiscard
function List:concat(sep, i, j) end

---
---Join list values into a string.
---
---```lua
---s = List({ "a", "b", "c" }):join(",") --> "a,b,c"
---```
---
---> [!NOTE]
--->
---> Values are converted with `tostring` before joining.
---
---@param self mods.List|any[]
---@param sep? string
---@return string
---@nodiscard
function List:join(sep) end

---
---Render list items as a table-access key path.
---
---```lua
---p = List({ "ctx", "users", 1, "name" }):keypath() --> "ctx.users[1].name"
---```
---
---@param self mods.List|any[]
---@return string
---@nodiscard
function List:keypath() end

---
---Return a new list by mapping each value.
---
---```lua
---to_upper = function(v) return v:upper() end
---m = List({ "a", "b" }):map(to_upper) --> { "A", "B" }
---```
---
---@param self mods.List|any[]
---@param fn fun(v):any
---@return mods.List ls
---@nodiscard
function List:map(fn) end

---
---Reduce the list to a single value using an accumulator.
---
---```lua
---add = function(acc, v) return acc + v end
---sum = List({ 1, 2, 3 }):reduce(add, 0) --> 6
---sum = List({ 1, 2, 3 }):reduce(add, 10) --> 16
---```
---
---> [!NOTE]
--->
---> If init is `nil`, the first element is used as the initial value.
---> Empty lists return init (or `nil` if init is `nil`).
---
---@param self mods.List|any[]
---@param fn fun(acc:any, v:any):any
---@param init? any
---@return any
---@nodiscard
function List:reduce(fn, init) end

---
---Return a new list with items reversed.
---
---```lua
---r = List({ "a", "b", "c" }):reverse() --> { "c", "b", "a" }
---```
---
---@param self mods.List|any[]
---@return mods.List ls
---@nodiscard
function List:reverse() end

---
---Convert the list to a set.
---
---```lua
---s = List({ "a", "b", "a" }):toset() --> { a = true, b = true }
---```
---
---> [!NOTE]
--->
---> Order is preserved from the original list.
---
---@param self mods.List|any[]
---@return mods.Set
---@nodiscard
function List:toset() end

---
---Return a new list containing items from i to j (inclusive).
---
---```lua
---t = List({ "a", "b", "c", "d" }):slice(2, 3) --> { "b", "c" }
---```
---
---> [!NOTE]
--->
---> Supports negative indices (-1 is last element).
---
---@param self mods.List|any[]
---@param i? integer
---@param j? integer
---@return mods.List ls
---@nodiscard
function List:slice(i, j) end

---
---Return the first n elements as a new list.
---
---```lua
---t = List({ "a", "b", "c" }):take(2) --> { "a", "b" }
---```
---
---@param self mods.List|any[]
---@param n integer
---@return mods.List ls
---@nodiscard
function List:take(n) end

---
---Return a new list with duplicates removed (first occurrence kept).
---
---```lua
---u = List({ "a", "b", "a", "c" }):uniq() --> { "a", "b", "c" }
---```
---
---@param self mods.List|any[]
---@return mods.List ls
---@nodiscard
function List:uniq() end

---
---Zip two lists into a list of 2-element tables.
---
---```lua
---z = List({ "a", "b" }):zip({ 1, 2 }) --> { {"a",1}, {"b",2} }
---```
---
---> [!NOTE]
--->
---> Length is the minimum of both lists.
---
---@param self mods.List|any[]
---@param ls mods.List|any[]
---@return mods.List ls
---@nodiscard
function List:zip(ls) end

--------------------------------------------------------------------------------
---------------------------------- Metamethods ---------------------------------
--------------------------------------------------------------------------------

---
---Extend the left-hand list in place with right-hand values, then return the
---same left-hand list reference.
---
---```lua
---a = List({ "a", "b" })
---b = { "c", "d" }
---c = a + b --> c and a are the same reference: { "a", "b", "c", "d" }
---```
---
---> [!NOTE]
--->
---> `__add` mutates and returns the left-hand value (same reference).
---
---@param self mods.List|any[]
---@param ls mods.List|any[]
---@return mods.List|any[] self
function List.__add(self, ls) end

return List
