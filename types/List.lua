---@meta mods.List

---
---A list class providing common operations to create,
---modify, and query sequences of values.
---
---## Usage
---
---```lua
---List = require "mods.List"
---
---ls = List({ "a" }):append("b")
---print(ls:contains("b")) --> true
---print(ls:index("b"))    --> 2
---```
---
---@class mods.List<T>:{[integer]:T}
---@operator add(mods.List):mods.List
---@operator mul(integer):mods.List
---@operator sub(mods.List):mods.List
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
---@param self mods.List Current list instance.
---@param pred fun(v:any):boolean Predicate function.
---@return boolean ok Whether the condition is met.
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
---@param self mods.List Current list instance.
---@param pred fun(v:any):boolean Predicate function.
---@return boolean ok Whether the condition is met.
---@nodiscard
function List:any(pred) end

---
---Compare two lists using shallow element equality.
---
---```lua
---a = List({ "x", "y" })
---b = List({ "x", "y" })
---ok = a:equals(b) --> true
---```
---
---> [!NOTE]
--->
---> * `equals` is also available through the `==` operator when both
--->   operands are `List`.
--->
--->   ```lua
--->   a = List({ "a", 1 })
--->   b = List({ "a", 1 })
--->   ok = (a == b) --> true
--->   ```
--->
---> * Unlike `==`, this method also works when `ls` is a plain array table.
--->
--->   ```lua
--->   a = List({ "a", 1 })
--->   b = { "a", 1 }
--->   ok = a:equals(b) --> true
--->   ```
--->
---> * `equals` checks only array positions (`1..#list`), so extra non-array
--->   keys are ignored:
--->
--->   ```lua
--->   t = {}
--->   a = List({ "a", t })
--->   b = { "a", t, a = 1 }
--->   ok = a:equals(b) --> true
--->   ```
---
---@param self mods.List Current list instance.
---@param ls mods.List|any[] Other list value.
---@return boolean ok Whether the condition is met.
---@nodiscard
function List:equals(ls) end

---
---Compare two lists lexicographically.
---
---```lua
---ok = List({ 1, 2 }):lt({ 1, 3 })    --> true
---ok = List({ 1, 2 }):lt({ 1, 2, 0 }) --> true
---```
---
---> [!NOTE]
--->
---> `lt` is also available through the `<` operator.
---
---@param self mods.List Current list instance.
---@param ls mods.List|any[] Other list value.
---@return boolean ok Whether the condition is met.
---@nodiscard
function List:lt(ls) end

---
---Compare two lists lexicographically.
---
---```lua
---ok = List({ 1, 2 }):le({ 1, 2 })  --> true
---ok = List({ 1, 2 }):le({ 1, 1 })  --> false
---```
---
---> [!NOTE]
--->
---> `le` is also available through the `<=` operator.
---
---@param self mods.List Current list instance.
---@param ls mods.List|any[] Other list value.
---@return boolean ok Whether the condition is met.
---@nodiscard
function List:le(ls) end

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
---@param self T Current list instance.
---@return T self Current list instance.
function List:append(v) end

---
---Remove all elements from the list.
---
---```lua
---ls = List({ "a", "b" }):clear() --> { }
---```
---
---@generic T:mods.List|any[]
---@param self T Current list instance.
---@return T self Current list instance.
function List:clear() end

---
---Extend the list with another list.
---
---```lua
---ls = List({ "a" }):extend({ "b", "c" }) --> { "a", "b", "c" }
---```
---
---> [!NOTE]
--->
---> `extend` is also available through the `+` operator.
---
---@generic T:mods.List|any[]
---@param self T Current list instance.
---@param ls any[] List values.
---@return T self Current list instance.
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
---@param self T Current list instance.
---@param pred fun(v:any):boolean Predicate function.
---@return mods.List ls Extracted values.
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
---@param self T Current list instance.
---@param pos integer Insert position.
---@param v any Value to insert.
---@return T self Current list instance.
function List:insert(pos, v) end

---
---Append a value to the end of the list.
---
---```lua
---ls = List({ "a", "b" }):insert("c") --> { "a", "b", "c" }
---```
---
---@generic T:mods.List|any[]
---@param self T Current list instance.
---@param v any Value to append.
---@return T self Current list instance.
function List:insert(v) end

---
---Remove and return the last element.
---
---```lua
---ls = List({ "a", "b" })
---v = ls:pop() --> v == "b"; ls is { "a" }
---```
---
---@param self mods.List Current list instance.
---@return any value Removed value.
function List:pop() end

---
---Remove and return the element at the given position.
---
---```lua
---ls = List({ "a", "b", "c" })
---v = ls:pop(2) --> v == "b"; ls is { "a", "c" }
---```
---
---@param self mods.List Current list instance.
---@param pos integer Numeric value.
---@return any value Removed value.
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
---@param self T Current list instance.
---@param v any Value to validate.
---@return T self Current list instance.
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
---@param self T Current list instance.
---@param v any Value to validate.
---@return T self Current list instance.
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
---@param self T Current list instance.
---@param comp? fun(a,b):boolean Optional comparison function (defaults to `nil`).
---@return T self Current list instance.
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
---@param self mods.List Current list instance.
---@return mods.List ls New list.
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
---@param self mods.List Current list instance.
---@param v any Value to validate.
---@return boolean ok Whether the condition is met.
---@nodiscard
function List:contains(v) end

---
---Count how many times a value appears.
---
---```lua
---n = List({ "a", "b", "b" }):count("b") --> 2
---```
---
---@param self mods.List Current list instance.
---@param v any Value to validate.
---@return integer res Result count.
---@nodiscard
function List:count(v) end

---
---Return the index of the first matching value.
---
---```lua
---i = List({ "a", "b", "c", "b" }):index("b") --> 2
---```
---
---@param self mods.List Current list instance.
---@param v any Value to validate.
---@return integer? index Result index, or nil when not found.
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
---@param self mods.List Current list instance.
---@param pred fun(v:any):boolean Predicate function.
---@return integer? index Result index, or nil when no value matches.
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
---> Uses Lua's `#` operator.
---
---@param self mods.List Current list instance.
---@return integer count Element count.
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
---@param self mods.List Current list instance.
---@return any value First value, or `nil` if empty.
---@nodiscard
function List:first() end

---
---Return the last element or `nil` if empty.
---
---```lua
---v = List({ "a", "b" }):last() --> "b"
---```
---
---@param self mods.List Current list instance.
---@return any value Last value, or `nil` if empty.
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
---> [!NOTE]
--->
---> `difference` is also available through the `-` operator.
---
---@generic T:mods.List|any[]
---@param self T Current list instance.
---@param ls mods.List|any[] Other list value.
---@return T ls New list.
---@nodiscard
function List:difference(ls) end

---
---Return a new list without the first n elements.
---
---```lua
---t = List({ "a", "b", "c" }):drop(1) --> { "b", "c" }
---```
---
---@param self mods.List Current list instance.
---@param n integer Numeric value.
---@return mods.List ls New list.
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
---@param self mods.List Current list instance.
---@param pred fun(v:any):boolean Predicate function.
---@return mods.List ls New list.
---@nodiscard
function List:filter(pred) end

---
---Flatten one level of nested lists.
---
---```lua
---f = List({ { "a", "b" }, { "c" } }):flatten() --> { "a", "b", "c" }
---```
---
---@param self mods.List Current list instance.
---@return mods.List ls New list.
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
---@param self mods.List Current list instance.
---@param fn fun(v:any) Callback function.
---@return nil none
function List:foreach(fn) end

---
---Group list values by a computed key.
---
---```lua
---words = { "aa", "b", "ccc", "dd" }
---g = List(words):group_by(string.len) --> { {"b"}, { "aa", "dd" }, { "ccc" } }
---```
---
---@param self mods.List Current list instance.
---@param fn fun(v:any):any Callback function.
---@return table groups Groups keyed by the callback result.
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
---@param self mods.List Current list instance.
---@param ls mods.List|any[] Other list value.
---@return mods.List ls New list.
---@nodiscard
function List:intersection(ls) end

---
---Invert values to indices in a new table.
---
---```lua
---t = List({ "a", "b", "c" }):invert() --> { a = 1, b = 2, c = 3 }
---```
---
---@param self mods.List Current list instance.
---@return table idxByValue Table mapping each value to its last index.
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
---@param self mods.List Current list instance.
---@param sep? string Optional separator value (defaults to `""`).
---@param i? integer Optional start index (defaults to `1`).
---@param j? integer Optional end index (defaults to `#self`).
---@return string s Concatenated string.
---@nodiscard
function List:concat(sep, i, j) end

---
---Join list values into a string.
---
---```lua
---s = List({ "a", "b", "c" }):join(",")        --> "a,b,c"
---s = List({ "a", "b", "c" }):join(", ", true) --> '"a", "b", "c"'
---```
---
---> [!NOTE]
--->
---> Values are converted with `tostring` before joining.
---> Set `quoted = true` to quote string values.
---
---@param self mods.List Current list instance.
---@param sep? string Optional separator value (defaults to `""`).
---@param quoted? boolean Optional boolean flag (defaults to `false`).
---@return string s Joined string.
---@nodiscard
function List:join(sep, quoted) end

---
---Render the list to a string via the regular method form.
---
---```lua
---s = List({ "a", "b", 1 }):tostring() --> '{ "a", "b", 1 }'
---```
---
---> [!NOTE]
--->
---> `tostring(list)` calls `list:tostring()`.
---
---@param self mods.List Current list instance.
---@return string s Rendered list string.
---@nodiscard
function List:tostring() end

---
---Render list items as a table-access key path.
---
---```lua
---p = List({ "ctx", "users", 1, "name" }):keypath() --> "ctx.users[1].name"
---```
---
---@param self mods.List Current list instance.
---@return string s Key-path string.
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
---@param self mods.List Current list instance.
---@param fn fun(v):any Callback function.
---@return mods.List ls New list.
---@nodiscard
function List:map(fn) end

---
---Return a new list repeated `n` times (list multiplication behavior).
---
---```lua
---ls = List({ "a", "b" }):mul(3) --> { "a", "b", "a", "b", "a", "b" }
---```
---
---> [!NOTE]
--->
---> `mul` is also available through the `*` operator.
---
---@param self mods.List Current list instance.
---@param n integer Numeric value.
---@return mods.List ls New list.
---@nodiscard
function List:mul(n) end

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
---> For empty lists, returns `init` unchanged (or `nil` when omitted).
---
---@param self mods.List Current list instance.
---@param fn fun(acc:any, v:any):any Reducer function.
---@param init? any Optional initial accumulator; for non-empty lists, `nil` or omitted uses the first item.
---@return any res Reduced value.
---@nodiscard
function List:reduce(fn, init) end

---
---Return a new list with items reversed.
---
---```lua
---r = List({ "a", "b", "c" }):reverse() --> { "c", "b", "a" }
---```
---
---@param self mods.List Current list instance.
---@return mods.List ls New list.
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
---@param self mods.List Current list instance.
---@return mods.Set set New set.
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
---@param self mods.List Current list instance.
---@param i? integer Optional start index (defaults to `1`).
---@param j? integer Optional end index (defaults to `#self`).
---@return mods.List ls New list.
---@nodiscard
function List:slice(i, j) end

---
---Return the first n elements as a new list.
---
---```lua
---t = List({ "a", "b", "c" }):take(2) --> { "a", "b" }
---```
---
---@param self mods.List Current list instance.
---@param n integer Numeric value.
---@return mods.List ls New list.
---@nodiscard
function List:take(n) end

---
---Return a new list with duplicates removed (first occurrence kept).
---
---```lua
---u = List({ "a", "b", "a", "c" }):uniq() --> { "a", "b", "c" }
---```
---
---@param self mods.List Current list instance.
---@return mods.List ls New list.
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
---@param self mods.List Current list instance.
---@param ls mods.List|any[] Other list value.
---@return mods.List ls New list.
---@nodiscard
function List:zip(ls) end

--------------------------------------------------------------------------------
---------------------------------- Metamethods ---------------------------------
--------------------------------------------------------------------------------

---Compare two lists using shallow element equality (`==`).
---
---```lua
---a = List({ "a", { 1 } })
---b = List({ "a", { 1 } })
---ok = a == b --> false (different nested table references)
---
---t = { 1 }
---a = List({ "a", t })
---b = List({ "a", t })
---ok = a == b --> true (same nested table reference)
---```
---
---> [!NOTE]
--->
---> * `==` returns `false` for `List` vs plain-table comparisons.
--->   Use `:equals(ls)` for `List` vs plain-table comparisons.
--->
--->   ```lua
--->   t = { "a", 1 }
--->   a = List(t)
--->   b = { "a", 1 }
--->   ok = (a == b)     --> false
--->   ok = a:equals(b) --> true
--->   ```
--->
---> * Like `:equals(ls)`, `==` compares only array positions (`1..#list`), so
--->   extra non-array keys are ignored when both operands are `List`.
--->
--->   ```lua
--->   a = List({ "a", t })
--->   b = List({ "a", t, extra = 1 })
--->   ok = (a == b) --> true
--->   ```
---
---@param self mods.List Current list instance.
---@param ls mods.List|any[] Other list value.
---@return boolean ok Whether the condition is met.
---@private
function List.__eq(self, ls) end

---
---Compare two lists lexicographically (`<`).
---
---```lua
---ok = List({ 1, 2 }) < List({ 1, 3 }) --> true
---```
---
---> [!NOTE]
--->
---> `<` is equivalent to `:lt(ls)`.
---
---@param self mods.List Current list instance.
---@param ls mods.List|any[] Other list value.
---@return boolean ok Whether the condition is met.
---@private
function List.__lt(self, ls) end

---
---Compare two lists lexicographically (`<=`).
---
---```lua
---ok = List({ 1, 2 }) <= List({ 1, 2 }) --> true
---```
---
---> [!NOTE]
--->
---> `<=` is equivalent to `:le(ls)`.
---
---@param self mods.List Current list instance.
---@param ls mods.List|any[] Other list value.
---@return boolean ok Whether the condition is met.
---@private
function List.__le(self, ls) end

---
---Repeat a list `n` times (`*`).
---
---```lua
---l1 = List({ "a", "b" }) * 3 --> { "a", "b", "a", "b", "a", "b" }
---l2 = 3 * List({ "a", "b" }) --> { "a", "b", "a", "b", "a", "b" }
---```
---
---> [!NOTE]
--->
---> `*` is equivalent to `:mul(n)`.
---
---@param self integer|mods.List Left operand.
---@param n integer|mods.List Right operand.
---@return mods.List ls New list.
---@private
function List.__mul(self, n) end

---
---Extend the left-hand list in place with right-hand values, then return the
---same left-hand list reference (`+`).
---
---```lua
---a = List({ "a", "b" })
---b = { "c", "d" }
---c = a + b --> c and a are the same reference: { "a", "b", "c", "d" }
---```
---
---> [!NOTE]
--->
---> `+` operator is equivalent to `:extend(ls)`.
---
---@param self mods.List Current list instance.
---@param ls mods.List|any[] Other list value.
---@return mods.List|any[] self Current list instance.
---@private
function List.__add(self, ls) end

---
---Return values from the left list that are not present in the right list (`-`).
---
---```lua
---a = List({ "a", "b", "c" })
---b = { "b" }
---d = a - b --> { "a", "c" }
---```
---
---> [!NOTE]
--->
---> `-` operator is equivalent to `:difference(ls)`.
---
---@param self mods.List Current list instance.
---@param ls mods.List|any[] Other list value.
---@return mods.List ls New list.
---@private
function List.__sub(self, ls) end

---
---Render the list to a string like `{ "a", "b", 1 }`.
---
---```lua
---s = tostring(List({ "a", "b", 1 })) --> '{ "a", "b", 1 }'
---```
---
---> [!NOTE]
--->
---> `tostring(ls)` is equivalent to `:tostring()`.
---
---@param self mods.List Current list instance.
---@return string s Rendered list string.
---@private
function List.__tostring(self) end

return List
