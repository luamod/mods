# List

`mods.List` provides common operations for list values.

## Usage

```lua
local List = require("mods.List")
```

## Functions

### `all(pred)`

Return true if all values match the predicate.

:::tabs
== Example

```lua
local is_even = function(v) return v % 2 == 0 end
local ok = List({ 2, 4 }):all(is_even)
-- result: true
```

== Type

```lua
---@param pred fun(v:any):boolean
---@return boolean
---@nodiscard
function all(pred) end
```
:::

### `any(pred)`

Return true if any value matches the predicate.

:::tabs
== Example

```lua
local has_len_2 = function(v) return #v == 2 end
local ok = List({ "a", "bb" }):any(has_len_2)
-- result: true
```

== Type

```lua
---@param pred fun(v:any):boolean
---@return boolean
---@nodiscard
function any(pred) end
```
:::

### `append(v)`

Append a value to the end of the list.

:::tabs
== Example

```lua
local l = List({ "a" })
l:append("b")
-- result: { "a", "b" }
```

== Type

```lua
function append(v) end
```
:::

### `clear()`

Remove all elements from the list.

:::tabs
== Example

```lua
local l = List({ "a", "b" })
l:clear()
-- result: { }
```

== Type

```lua
function clear() end
```
:::

### `contains(v)`

Return true if the list contains the value.

:::tabs
== Example

```lua
local ok = List({ "a", "b" }):contains("b")
-- result: true
```

== Type

```lua
function contains(v) end
```
:::

### `copy()`

Return a shallow copy of the list.

:::tabs
== Example

```lua
local c = List({ "a", "b" }):copy()
-- result: { "a", "b" }
```

== Type

```lua
---@nodiscard
function copy() end
```
:::

### `count(v)`

Count how many times a value appears.

:::tabs
== Example

```lua
local n = List({ "a", "b", "b" }):count("b")
-- result: 2
```

== Type

```lua
---@nodiscard
function count(v) end
```
:::

### `difference(ls)`

Return a new list with values not in the given list.

:::tabs
== Example

```lua
local d = List({ "a", "b", "c" }):difference({ "b" })
-- result: { "a", "c" }
```

== Type

```lua
function difference(ls) end
```
:::

### `drop(n)`

Return a new list without the first n elements.

:::tabs
== Example

```lua
local t = List({ "a", "b", "c" }):drop(1)
-- result: { "b", "c" }
```

== Type

```lua
---@param n integer
---@return mods.List
---@nodiscard
function drop(n) end
```
:::

### `extend(ls)`

Extend the list with another list.

:::tabs
== Example

```lua
local l = List({ "a" })
l:extend({ "b", "c" })
-- result: { "a", "b", "c" }
```

== Type

```lua
function extend(ls) end
```
:::

### `extract(pred)`

Extract values matching the predicate and remove them from the list.

:::tabs
== Example

```lua
local l = List({ "a", "bb", "c" })
local is_len_1 = function(v) return #v == 1 end
local ex = l:extract(is_len_1)
-- result: ex = { "a", "c" }, l = { "bb" }
```

== Type

```lua
---@param pred fun(v:any):boolean
---@return mods.List
---@nodiscard
function extract(pred) end
```
:::

### `filter(pred)`

Return a new list with values matching the predicate.

:::tabs
== Example

```lua
local is_len_1 = function(v) return #v == 1 end
local f = List({ "a", "bb", "c" }):filter(is_len_1)
-- result: { "a", "c" }
```

== Type

```lua
---@param pred fun(v:any):boolean
---@return mods.List
---@nodiscard
function filter(pred) end
```
:::

### `first()`

Return the first element or nil if empty.

:::tabs
== Example

```lua
local v = List({ "a", "b" }):first()
-- result: "a"
```

== Type

```lua
---@return any
---@nodiscard
function first() end
```
:::

### `flatten()`

Flatten one level of nested lists.

:::tabs
== Example

```lua
local f = List({ { "a", "b" }, { "c" } }):flatten()
-- result: { "a", "b", "c" }
```

== Type

```lua
---@return mods.List
---@nodiscard
function flatten() end
```
:::

### `foreach(fn)`

Apply a function to each element (for side effects).

:::tabs
== Example

```lua
List({ "a", "b" }):foreach(print)
```

== Type

```lua
---@param fn fun(v:any)
---@return nil
function foreach(fn) end
```
:::

### `group_by(fn)`

Group list values by a computed key.

:::tabs
== Example

```lua
local words = { "aa", "b", "ccc", "dd" }
local g = List(words):group_by(string.len)
-- result: { {"b"}, { "aa", "dd" }, { "ccc" } }
```

== Type

```lua
---@param fn fun(v:any):any
---@return table<any, mods.List>
---@nodiscard
function group_by(fn) end
```
:::

### `index(v)`

Return the index of the first matching value.

:::tabs
== Example

```lua
local i = List({ "a", "b", "c", "b" }):index("b")
-- result: 2
```

== Type

```lua
---@param v any
---@return any value
---@return integer? index
---@nodiscard
function index(v) end
```
:::

### `index_if(pred)`

Return the index of the first value matching the predicate.

:::tabs
== Example

```lua
local gt_1 = function(x) return x > 1 end
local i = List({ 1, 2, 3 }):index_if(gt_1)
-- result: 2
```

== Type

```lua
---@param pred fun(v:any):boolean
---@return integer? index
---@nodiscard
function index_if(pred) end
```
:::

### `insert(pos, v)`

Insert a value at the given position.

:::tabs
== Example

```lua
local l = List({ "a", "c" }):insert(2, "b")
-- result: { "a", "b", "c" }
```

== Type

```lua
---@param pos integer
---@param v any
---@return self
function insert(pos, v) end
```
:::

### `insert(v)`

Append a value to the end of the list.

:::tabs
== Example

```lua
local l = List({ "a", "b" }):insert("b")
-- result: { "a", "b", "c" }
```

== Type

```lua
---@param v any
---@return self
function insert(v) end
```
:::

### `intersection(ls)`

Return values that are also present in the given list.

:::tabs
== Example

```lua
local i = List({ "a", "b", "a", "c" }):intersection({ "a", "c" })
-- result: { "a", "a", "c" }
```

== Type

```lua
---@param ls { [integer]: any }
---@return mods.List
---@nodiscard
function intersection(ls) end
```
:::

### `invert()`

Invert values to indices in a new table.

:::tabs
== Example

```lua
local t = List({ "a", "b", "c" }):invert()
-- result: { a = 1, b = 2, c = 3 }
```

== Type

```lua
---@return table
function invert() end
```
:::

### `join(sep)`

Join list values into a string.

:::tabs
== Example

```lua
local s = List({ "a", "b", "c" }):join(",")
-- result: "a,b,c"
```

== Type

```lua
---@param sep? string
function join(sep) end
```
:::

### `last()`

Return the last element or nil if empty.

:::tabs
== Example

```lua
local v = List({ "a", "b" }):last()
-- result: "b"
```

== Type

```lua
---@return any
---@nodiscard
function last() end
```
:::

### `len()`

Return the number of elements in the list.

:::tabs
== Example

```lua
local n = List({ "a", "b", "c" }):len()
-- result: 3
```

== Type

```lua
---@nodiscard
function len() end
```
:::

### `map(fn)`

Return a new list by mapping each value.

:::tabs
== Example

```lua
local to_upper = function(v) return v:upper() end
local m = List({ "a", "b" }):map(to_upper)
-- result: { "A", "B" }
```

== Type

```lua
---@param fn fun(v):any
---@nodiscard
function map(fn) end
```
:::

### `pop()`

Remove and return the last element.

:::tabs
== Example

```lua
local l = List({ "a", "b" })
local v = l:pop()
-- result: v == "b"; l is { "a" }
```

== Type

```lua
---@return any
function pop() end
```
:::

### `pop(pos)`

Remove and return the element at the given position.

:::tabs
== Example

```lua
local l = List({ "a", "b", "c" })
local v = l:pop(2)
-- result: v == "b"; l is { "a", "c" }
```

== Type

```lua
---@param pos integer
---@return any
function pop(pos) end
```
:::

### `prepend(v)`

Insert a value at the start of the list.

:::tabs
== Example

```lua
local l = List({ "b", "c" })
l:prepend("a")
-- result: { "a", "b", "c" }
```

== Type

```lua
---@param v any
---@return self
function prepend(v) end
```
:::

### `reduce(fn, init)`

Reduce the list to a single value using an accumulator.

:::tabs
== Example

```lua
local add = function(acc, v) return acc + v end
local sum = List({ 1, 2, 3 }):reduce(add, 0)
-- result: 6

sum = List({ 1, 2, 3 }):reduce(add, 10)
-- result: 16
```

== Type

```lua
---@param fn fun(acc:any, v:any):any
---@param init? any
---@return any
---@nodiscard
function reduce(fn, init) end
```
:::

### `remove(v)`

Remove the first matching value.

:::tabs
== Example

```lua
local l = List({ "a", "b", "b" })
l:remove("b")
-- result: { "a", "b" }
```

== Type

```lua
function remove(v) end
```
:::

### `reverse()`

Return a new list with items reversed.

:::tabs
== Example

```lua
local r = List({ "a", "b", "c" }):reverse()
-- result: { "c", "b", "a" }
```

== Type

```lua
---@nodiscard
function reverse() end
```
:::

### `setify()`

Convert the list to a set.

:::tabs
== Example

```lua
local s = List({ "a", "b", "a" }):setify()
-- result: { a = true, b = true }
```

== Type

```lua
---@return mods.List
---@nodiscard
function setify() end
```
:::

### `slice(i, j)`

Return a new list containing items from i to j (inclusive).

:::tabs
== Example

```lua
local t = List({ "a", "b", "c", "d" }):slice(2, 3)
-- result: { "b", "c" }
```

== Type

```lua
---@param i? integer
---@param j? integer
---@return mods.List
---@nodiscard
function slice(i, j) end
```
:::

### `sort(comp)`

Sort the list in place.

:::tabs
== Example

```lua
local l = List({ 3, 1, 2 })
l:sort()
-- result: { 1, 2, 3 }
```

== Type

```lua
---@param comp? fun(a:T,b:T):boolean
function sort(comp) end
```
:::

### `take(n)`

Return the first n elements as a new list.

:::tabs
== Example

```lua
local t = List({ "a", "b", "c" }):take(2)
-- result: { "a", "b" }
```

== Type

```lua
---@param n integer
---@return mods.List
---@nodiscard
function take(n) end
```
:::

### `uniq()`

Return a new list with duplicates removed (first occurrence kept).

:::tabs
== Example

```lua
local u = List({ "a", "b", "a", "c" }):uniq()
-- result: { "a", "b", "c" }
```

== Type

```lua
---@return mods.List
---@nodiscard
function uniq() end
```
:::

### `zip(other)`

Zip two lists into a list of 2-element tables.

:::tabs
== Example

```lua
local z = List({ "a", "b" }):zip({ 1, 2 })
-- result: { {"a",1}, {"b",2} }
```

== Type

```lua
---@param other { [integer]: any }
---@return mods.List<{[integer]: any}>
---@nodiscard
function zip(other) end
```
:::
