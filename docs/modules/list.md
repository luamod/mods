---
title: List
description:
  Python-style List API for sequence mutation, querying, and transformations.
---

# `List`

A Python-style list class providing common operations to create, modify, and
query sequences of values.

## Quick Reference

**Predicates**

| Function                   | Description                                     |
| -------------------------- | ----------------------------------------------- |
| [`all(pred)`](#fn-allpred) | Return true if all values match the predicate.  |
| [`any(pred)`](#fn-anypred) | Return true if any value matches the predicate. |

**Mutation**

| Function                            | Description                                                          |
| ----------------------------------- | -------------------------------------------------------------------- |
| [`append(v)`](#fn-appendv)          | Append a value to the end of the list.                               |
| [`clear()`](#fn-clear)              | Remove all elements from the list.                                   |
| [`extend(ls)`](#fn-extendls)        | Extend the list with another list.                                   |
| [`extract(pred)`](#fn-extractpred)  | Extract values matching the predicate and remove them from the list. |
| [`insert(pos, v)`](#fn-insertpos-v) | Insert a value at the given position.                                |
| [`insert(v)`](#fn-insertv)          | Append a value to the end of the list.                               |
| [`pop()`](#fn-pop)                  | Remove and return the last element.                                  |
| [`pop(pos)`](#fn-poppos)            | Remove and return the element at the given position.                 |
| [`prepend(v)`](#fn-prependv)        | Insert a value at the start of the list.                             |
| [`remove(v)`](#fn-removev)          | Remove the first matching value.                                     |
| [`sort(comp)`](#fn-sortcomp)        | Sort the list in place.                                              |

**Copying**

| Function             | Description                        |
| -------------------- | ---------------------------------- |
| [`copy()`](#fn-copy) | Return a shallow copy of the list. |

**Query**

| Function                             | Description                                                 |
| ------------------------------------ | ----------------------------------------------------------- |
| [`contains(v)`](#fn-containsv)       | Return true if the list contains the value.                 |
| [`count(v)`](#fn-countv)             | Count how many times a value appears.                       |
| [`index(v)`](#fn-indexv)             | Return the index of the first matching value.               |
| [`index_if(pred)`](#fn-index_ifpred) | Return the index of the first value matching the predicate. |
| [`len()`](#fn-len)                   | Return the number of elements in the list.                  |

**Access**

| Function               | Description                               |
| ---------------------- | ----------------------------------------- |
| [`first()`](#fn-first) | Return the first element or nil if empty. |
| [`last()`](#fn-last)   | Return the last element or nil if empty.  |

**Transform**

| Function                                 | Description                                                        |
| ---------------------------------------- | ------------------------------------------------------------------ |
| [`difference(ls)`](#fn-differencels)     | Return a new list with values not in the given list.               |
| [`drop(n)`](#fn-dropn)                   | Return a new list without the first n elements.                    |
| [`filter(pred)`](#fn-filterpred)         | Return a new list with values matching the predicate.              |
| [`flatten()`](#fn-flatten)               | Flatten one level of nested lists.                                 |
| [`foreach(fn)`](#fn-foreachfn)           | Apply a function to each element (for side effects).               |
| [`group_by(fn)`](#fn-group_byfn)         | Group list values by a computed key.                               |
| [`intersection(ls)`](#fn-intersectionls) | Return values that are also present in the given list.             |
| [`invert()`](#fn-invert)                 | Invert values to indices in a new table.                           |
| [`join(sep)`](#fn-joinsep)               | Join list values into a string.                                    |
| [`map(fn)`](#fn-mapfn)                   | Return a new list by mapping each value.                           |
| [`reduce(fn, init)`](#fn-reducefn-init)  | Reduce the list to a single value using an accumulator.            |
| [`reverse()`](#fn-reverse)               | Return a new list with items reversed.                             |
| [`setify()`](#fn-setify)                 | Convert the list to a set.                                         |
| [`slice(i, j)`](#fn-slicei-j)            | Return a new list containing items from i to j (inclusive).        |
| [`take(n)`](#fn-taken)                   | Return the first n elements as a new list.                         |
| [`uniq()`](#fn-uniq)                     | Return a new list with duplicates removed (first occurrence kept). |
| [`zip(ls)`](#fn-zipls)                   | Zip two lists into a list of 2-element tables.                     |

## Functions

### Predicates

#### `all(pred)` {#fn-allpred}

Return true if all values match the predicate. Empty lists return true.

:::tabs == Example

```lua
local is_even = function(v) return v % 2 == 0 end
local ok = List({ 2, 4 }):all(is_even)
-- result: true
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param pred fun(v:any):boolean
---@return boolean
---@nodiscard
function all(pred) end
```

:::

#### `any(pred)` {#fn-anypred}

Return true if any value matches the predicate.

:::tabs == Example

```lua
local has_len_2 = function(v) return #v == 2 end
local ok = List({ "a", "bb" }):any(has_len_2)
-- result: true
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param pred fun(v:any):boolean
---@return boolean
---@nodiscard
function any(pred) end
```

:::

### Mutation

#### `append(v)` {#fn-appendv}

Append a value to the end of the list.

:::tabs == Example

```lua
local l = List({ "a" }):append("b")
-- result: { "a", "b" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@return T self
function append(v) end
```

:::

#### `clear()` {#fn-clear}

Remove all elements from the list.

:::tabs == Example

```lua
local l = List({ "a", "b" }):clear()
-- result: { }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@return T self
function clear() end
```

:::

#### `extend(ls)` {#fn-extendls}

Extend the list with another list.

:::tabs == Example

```lua
local l = List({ "a" })
l:extend({ "b", "c" })
-- result: { "a", "b", "c" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param ls any[]
---@return T self
function extend(ls) end
```

:::

#### `extract(pred)` {#fn-extractpred}

Extract values matching the predicate and remove them from the list.

:::tabs == Example

```lua
local l = List({ "a", "bb", "c" })
local is_len_1 = function(v) return #v == 1 end
local ex = l:extract(is_len_1)
-- result: ex = { "a", "c" }, l = { "bb" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param pred fun(v:any):boolean
---@return T self
---@nodiscard
function extract(pred) end
```

:::

#### `insert(pos, v)` {#fn-insertpos-v}

Insert a value at the given position.

:::tabs == Example

```lua
local l = List({ "a", "c" }):insert(2, "b")
-- result: { "a", "b", "c" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param pos integer
---@param v any
---@return T self
function insert(pos, v) end
```

:::

#### `insert(v)` {#fn-insertv}

Append a value to the end of the list.

:::tabs == Example

```lua
local l = List({ "a", "b" }):insert("b")
-- result: { "a", "b", "c" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param v any
---@return T self
function insert(v) end
```

:::

#### `pop()` {#fn-pop}

Remove and return the last element.

:::tabs == Example

```lua
local l = List({ "a", "b" })
local v = l:pop()
-- result: v == "b"; l is { "a" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@return any
function pop() end
```

:::

#### `pop(pos)` {#fn-poppos}

Remove and return the element at the given position.

:::tabs == Example

```lua
local l = List({ "a", "b", "c" })
local v = l:pop(2)
-- result: v == "b"; l is { "a", "c" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param pos integer
---@return any
function pop(pos) end
```

:::

#### `prepend(v)` {#fn-prependv}

Insert a value at the start of the list.

:::tabs == Example

```lua
local l = List({ "b", "c" })
l:prepend("a")
-- result: { "a", "b", "c" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param v any
---@return T self
function prepend(v) end
```

:::

#### `remove(v)` {#fn-removev}

Remove the first matching value.

:::tabs == Example

```lua
local l = List({ "a", "b", "b" })
l:remove("b")
-- result: { "a", "b" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param v any
---@return T self
function remove(v) end
```

:::

#### `sort(comp)` {#fn-sortcomp}

Sort the list in place.

:::tabs == Example

```lua
local l = List({ 3, 1, 2 })
l:sort()
-- result: { 1, 2, 3 }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param comp? fun(a,b):boolean
---@return T self
function sort(comp) end
```

:::

### Copying

#### `copy()` {#fn-copy}

Return a shallow copy of the list.

:::tabs == Example

```lua
local c = List({ "a", "b" }):copy()
-- result: { "a", "b" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@return T ls
---@nodiscard
function copy() end
```

:::

### Query

#### `contains(v)` {#fn-containsv}

Return true if the list contains the value.

:::tabs == Example

```lua
local ok = List({ "a", "b" }):contains("b")
-- result: true
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param v any
---@return any
---@nodiscard
function contains(v) end
```

:::

#### `count(v)` {#fn-countv}

Count how many times a value appears.

:::tabs == Example

```lua
local n = List({ "a", "b", "b" }):count("b")
-- result: 2
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@return integer
---@nodiscard
function count(v) end
```

:::

#### `index(v)` {#fn-indexv}

Return the index of the first matching value.

:::tabs == Example

```lua
local i = List({ "a", "b", "c", "b" }):index("b")
-- result: 2
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param v any
---@return any value
---@return integer? index
---@nodiscard
function index(v) end
```

:::

#### `index_if(pred)` {#fn-index_ifpred}

Return the index of the first value matching the predicate.

:::tabs == Example

```lua
local gt_1 = function(x) return x > 1 end
local i = List({ 1, 2, 3 }):index_if(gt_1)
-- result: 2
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param pred fun(v:any):boolean
---@return integer? index
---@nodiscard
function index_if(pred) end
```

:::

#### `len()` {#fn-len}

Return the number of elements in the list.

:::tabs == Example

```lua
local n = List({ "a", "b", "c" }):len()
-- result: 3
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@return integer
---@nodiscard
function len() end
```

:::

### Access

#### `first()` {#fn-first}

Return the first element or nil if empty.

:::tabs == Example

```lua
local v = List({ "a", "b" }):first()
-- result: "a"
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@return any
---@nodiscard
function first() end
```

:::

#### `last()` {#fn-last}

Return the last element or nil if empty.

:::tabs == Example

```lua
local v = List({ "a", "b" }):last()
-- result: "b"
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@return any
---@nodiscard
function last() end
```

:::

### Transform

#### `difference(ls)` {#fn-differencels}

Return a new list with values not in the given list.

:::tabs == Example

```lua
local d = List({ "a", "b", "c" }):difference({ "b" })
-- result: { "a", "c" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@return T ls
---@nodiscard
function difference(ls) end
```

:::

#### `drop(n)` {#fn-dropn}

Return a new list without the first n elements.

:::tabs == Example

```lua
local t = List({ "a", "b", "c" }):drop(1)
-- result: { "b", "c" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param n integer
---@return T ls
---@nodiscard
function drop(n) end
```

:::

#### `filter(pred)` {#fn-filterpred}

Return a new list with values matching the predicate.

:::tabs == Example

```lua
local is_len_1 = function(v) return #v == 1 end
local f = List({ "a", "bb", "c" }):filter(is_len_1)
-- result: { "a", "c" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param pred fun(v:any):boolean
---@return T ls
---@nodiscard
function filter(pred) end
```

:::

#### `flatten()` {#fn-flatten}

Flatten one level of nested lists.

:::tabs == Example

```lua
local f = List({ { "a", "b" }, { "c" } }):flatten()
-- result: { "a", "b", "c" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@return T self
---@nodiscard
function flatten() end
```

:::

#### `foreach(fn)` {#fn-foreachfn}

Apply a function to each element (for side effects). Returns nil.

:::tabs == Example

```lua
List({ "a", "b" }):foreach(print)
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param fn fun(v:any)
---@return nil
function foreach(fn) end
```

:::

#### `group_by(fn)` {#fn-group_byfn}

Group list values by a computed key.

:::tabs == Example

```lua
local words = { "aa", "b", "ccc", "dd" }
local g = List(words):group_by(string.len)
-- result: { {"b"}, { "aa", "dd" }, { "ccc" } }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param fn fun(v:any):any
---@return table<any, T>
---@nodiscard
function group_by(fn) end
```

:::

#### `intersection(ls)` {#fn-intersectionls}

Return values that are also present in the given list. Order is preserved from
the original list.

:::tabs == Example

```lua
local i = List({ "a", "b", "a", "c" }):intersection({ "a", "c" })
-- result: { "a", "a", "c" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param ls T
---@return T self
---@nodiscard
function intersection(ls) end
```

:::

#### `invert()` {#fn-invert}

Invert values to indices in a new table.

:::tabs == Example

```lua
local t = List({ "a", "b", "c" }):invert()
-- result: { a = 1, b = 2, c = 3 }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@return table
---@nodiscard
function invert() end
```

:::

#### `join(sep)` {#fn-joinsep}

Join list values into a string.

:::tabs == Example

```lua
local s = List({ "a", "b", "c" }):join(",")
-- result: "a,b,c"
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param sep? string
---@return string
---@nodiscard
function join(sep) end
```

:::

#### `map(fn)` {#fn-mapfn}

Return a new list by mapping each value.

:::tabs == Example

```lua
local to_upper = function(v) return v:upper() end
local m = List({ "a", "b" }):map(to_upper)
-- result: { "A", "B" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param fn fun(v):any
---@return T ls
---@nodiscard
function map(fn) end
```

:::

#### `reduce(fn, init)` {#fn-reducefn-init}

Reduce the list to a single value using an accumulator. If init is nil, the
first element is used as the initial value. Empty lists return init (or nil if
init is nil).

:::tabs == Example

```lua
local add = function(acc, v) return acc + v end
local sum = List({ 1, 2, 3 }):reduce(add, 0)
-- result: 6

sum = List({ 1, 2, 3 }):reduce(add, 10)
-- result: 16
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param fn fun(acc:any, v:any):any
---@param init? any
---@return any
---@nodiscard
function reduce(fn, init) end
```

:::

#### `reverse()` {#fn-reverse}

Return a new list with items reversed.

:::tabs == Example

```lua
local r = List({ "a", "b", "c" }):reverse()
-- result: { "c", "b", "a" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@return T ls
---@nodiscard
function reverse() end
```

:::

#### `setify()` {#fn-setify}

Convert the list to a set.

:::tabs == Example

```lua
local s = List({ "a", "b", "a" }):setify()
-- result: { a = true, b = true }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@return mods.Set|table<any,true>
---@nodiscard
function setify() end
```

:::

#### `slice(i, j)` {#fn-slicei-j}

Return a new list containing items from i to j (inclusive). Supports negative
indices (-1 is last element).

:::tabs == Example

```lua
local t = List({ "a", "b", "c", "d" }):slice(2, 3)
-- result: { "b", "c" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param i? integer
---@param j? integer
---@return T ls
---@nodiscard
function slice(i, j) end
```

:::

#### `take(n)` {#fn-taken}

Return the first n elements as a new list.

:::tabs == Example

```lua
local t = List({ "a", "b", "c" }):take(2)
-- result: { "a", "b" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param n integer
---@return T ls
---@nodiscard
function take(n) end
```

:::

#### `uniq()` {#fn-uniq}

Return a new list with duplicates removed (first occurrence kept).

:::tabs == Example

```lua
local u = List({ "a", "b", "a", "c" }):uniq()
-- result: { "a", "b", "c" }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@return T ls
---@nodiscard
function uniq() end
```

:::

#### `zip(ls)` {#fn-zipls}

Zip two lists into a list of 2-element tables. Length is the minimum of both
lists.

:::tabs == Example

```lua
local z = List({ "a", "b" }):zip({ 1, 2 })
-- result: { {"a",1}, {"b",2} }
```

== Signature

```lua
---@generic T:mods.List|any[]
---@param self T
---@param ls T
---@return T ls
---@nodiscard
function zip(ls) end
```

:::
