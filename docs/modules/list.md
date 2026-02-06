# List

`mods.List` is a Python-style list class providing common operations to create, modify, and query sequences of values.

## Usage

```lua
local List = require("mods.List")

local l = List({ "a", "b", "a" })
local u = l:uniq()
-- u is { "a", "b" }
```

## Quick Reference

| Function | Description |
| --- | --- |
| [`all(pred)`](#fn-allpred) | Return true if all values match the predicate. |
| [`any(pred)`](#fn-anypred) | Return true if any value matches the predicate. |
| [`contains(v)`](#fn-containsv) | Return true if the list contains the value. |
| [`count(v)`](#fn-countv) | Count how many times a value appears. |
| [`first()`](#fn-first) | Return the first element or nil if empty. |
| [`index(v)`](#fn-indexv) | Return the index of the first matching value. |
| [`index_if(pred)`](#fn-index_ifpred) | Return the index of the first value matching the predicate. |
| [`last()`](#fn-last) | Return the last element or nil if empty. |
| [`len()`](#fn-len) | Return the number of elements in the list. |
| [`copy()`](#fn-copy) | Return a shallow copy of the list. |
| [`difference(ls)`](#fn-differencels) | Return a new list with values not in the given list. |
| [`drop(n)`](#fn-dropn) | Return a new list without the first n elements. |
| [`extract(pred)`](#fn-extractpred) | Extract values matching the predicate and remove them from the list. |
| [`filter(pred)`](#fn-filterpred) | Return a new list with values matching the predicate. |
| [`flatten()`](#fn-flatten) | Flatten one level of nested lists. |
| [`group_by(fn)`](#fn-group_byfn) | Group list values by a computed key. |
| [`intersection(ls)`](#fn-intersectionls) | Return values that are also present in the given list. |
| [`invert()`](#fn-invert) | Invert values to indices in a new table. |
| [`map(fn)`](#fn-mapfn) | Return a new list by mapping each value. |
| [`reverse()`](#fn-reverse) | Return a new list with items reversed. |
| [`setify()`](#fn-setify) | Convert the list to a set. |
| [`slice(i, j)`](#fn-slicei-j) | Return a new list containing items from i to j (inclusive). |
| [`take(n)`](#fn-taken) | Return the first n elements as a new list. |
| [`uniq()`](#fn-uniq) | Return a new list with duplicates removed (first occurrence kept). |
| [`zip(other)`](#fn-zipother) | Zip two lists into a list of 2-element tables. |
| [`append(v)`](#fn-appendv) | Append a value to the end of the list. |
| [`clear()`](#fn-clear) | Remove all elements from the list. |
| [`extend(ls)`](#fn-extendls) | Extend the list with another list. |
| [`insert(v)`](#fn-insertv) | Append a value to the end of the list. |
| [`pop(pos)`](#fn-poppos) | Remove and return the element at the given position. |
| [`prepend(v)`](#fn-prependv) | Insert a value at the start of the list. |
| [`reduce(fn, init)`](#fn-reducefn-init) | Reduce the list to a single value using an accumulator. |
| [`remove(v)`](#fn-removev) | Remove the first matching value. |
| [`sort(comp)`](#fn-sortcomp) | Sort the list in place. |

## Methods

### Query

<a id="fn-allpred"></a>
#### `all(pred)`

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

<a id="fn-anypred"></a>
#### `any(pred)`

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

<a id="fn-containsv"></a>
#### `contains(v)`

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

<a id="fn-countv"></a>
#### `count(v)`

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

<a id="fn-first"></a>
#### `first()`

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

<a id="fn-indexv"></a>
#### `index(v)`

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

<a id="fn-index_ifpred"></a>
#### `index_if(pred)`

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

<a id="fn-last"></a>
#### `last()`

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

<a id="fn-len"></a>
#### `len()`

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

### Transform

<a id="fn-copy"></a>
#### `copy()`

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

<a id="fn-differencels"></a>
#### `difference(ls)`

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

<a id="fn-dropn"></a>
#### `drop(n)`

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

<a id="fn-extractpred"></a>
#### `extract(pred)`

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

<a id="fn-filterpred"></a>
#### `filter(pred)`

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

<a id="fn-flatten"></a>
#### `flatten()`

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

<a id="fn-group_byfn"></a>
#### `group_by(fn)`

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

<a id="fn-intersectionls"></a>
#### `intersection(ls)`

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

<a id="fn-invert"></a>
#### `invert()`

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

<a id="fn-mapfn"></a>
#### `map(fn)`

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

<a id="fn-reverse"></a>
#### `reverse()`

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

<a id="fn-setify"></a>
#### `setify()`

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

<a id="fn-slicei-j"></a>
#### `slice(i, j)`

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

<a id="fn-taken"></a>
#### `take(n)`

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

<a id="fn-uniq"></a>
#### `uniq()`

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

<a id="fn-zipother"></a>
#### `zip(other)`

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

### In-place

<a id="fn-appendv"></a>
#### `append(v)`

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

<a id="fn-clear"></a>
#### `clear()`

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

<a id="fn-extendls"></a>
#### `extend(ls)`

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

<a id="fn-insertv"></a>
#### `insert(v)`

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

<a id="fn-poppos"></a>
#### `pop(pos)`

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

<a id="fn-prependv"></a>
#### `prepend(v)`

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

<a id="fn-reducefn-init"></a>
#### `reduce(fn, init)`

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

<a id="fn-removev"></a>
#### `remove(v)`

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

<a id="fn-sortcomp"></a>
#### `sort(comp)`

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
