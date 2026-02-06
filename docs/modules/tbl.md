# tbl

`mods.tbl` is a collection of utility functions for working with plain Lua tables.

## Usage

```lua
local tbl = require("mods.tbl")

local t = { a = 1, b = 2 }
local keys = tbl.keys(t)
-- keys is { "a", "b" }
```

## Quick Reference

| Function | Description |
| --- | --- |
| [`clear(t)`](#fn-cleart) | Remove all entries from the table. |
| [`copy(t)`](#fn-copyt) | Create a shallow copy of the table. |
| [`count(t)`](#fn-countt) | Return the number of keys in the table. |
| [`deepcopy(v)`](#fn-deepcopyv) | Create a deep copy of a value. |
| [`find(t, v)`](#fn-findt-v) | Find the first key whose value equals the given value. |
| [`find_if(t, pred)`](#fn-find_ift-pred) | Find first value and key matching predicate. |
| [`get(t, ...)`](#fn-gett) | Safely get nested value by keys. |
| [`isempty(t)`](#fn-isemptyt) | Return true if table has no entries. |
| [`filter(t, pred)`](#fn-filtert-pred) | Filter entries by a value predicate. |
| [`invert(t)`](#fn-invertt) | Invert keys/values into new table. |
| [`keys(t)`](#fn-keyst) | Return a list of all keys in the table. |
| [`map(t, fn)`](#fn-mapt-fn) | Return a new table by mapping each value (keys preserved). |
| [`pairmap(t, fn)`](#fn-pairmapt-fn) | Return a new table by mapping each key-value pair. |
| [`update(t1, t2)`](#fn-updatet1-t2) | Merge entries from t2 into t1 and return t1. |
| [`values(t)`](#fn-valuest) | Return a list of all values in the table. |

## Functions

### Basics

<a id="fn-cleart"></a>
#### `clear(t)`

Remove all entries from the table.

:::tabs
== Example

```lua
local t = { a = 1, b = 2 }
clear(t)
-- result: {}
```

== Type

```lua
---@param t table
---@return nil
function clear(t) end
```
:::

<a id="fn-copyt"></a>
#### `copy(t)`

Create a shallow copy of the table.

:::tabs
== Example

```lua
local t = copy({ a = 1, b = 2 })
-- result: { a = 1, b = 2 }
```

== Type

```lua
---@generic T:table
---@param t T
---@return T
---@nodiscard
function copy(t) end
```
:::

<a id="fn-countt"></a>
#### `count(t)`

Return the number of keys in the table.

:::tabs
== Example

```lua
local n = count({ a = 1, b = 2 })
-- result: 2
```

== Type

```lua
---@param t table
---@return integer
---@nodiscard
function count(t) end
```
:::

<a id="fn-deepcopyv"></a>
#### `deepcopy(v)`

Create a deep copy of a value.

:::tabs
== Example

```lua
local n = deepcopy(42)
-- result: 42

local t = deepcopy({ a = { b = 1 } })
-- result: { a = { b = 1 } }
```

== Type

```lua
---@generic T
---@param v T
---@return T
---@nodiscard
function deepcopy(v) end
```
:::

### Query

<a id="fn-findt-v"></a>
#### `find(t, v)`

Find the first key whose value equals the given value.

:::tabs
== Example

```lua
local key = find({ a = 1, b = 2, c = 2 }, 2)
-- result: "b" or "c"
```

== Type

```lua
---@generic T1,T2
---@param t {[T1]:T2}
---@param v T2
---@return T1?
---@nodiscard
function find(t, v) end
```
:::

<a id="fn-find_ift-pred"></a>
#### `find_if(t, pred)`

Find first value and key matching predicate.

:::tabs
== Example

```lua
local v, k = find_if({ a = 1, b = 2 }, function(v, k)
  return k == "b" and v == 2
end)
-- result: 2, "b"
```

== Type

```lua
---@generic T1,T2
---@param t table
---@param pred fun(v:T1,k:T2):boolean
---@return T1? v
---@return T2? k
---@nodiscard
function find_if(t, pred) end
```
:::

<a id="fn-gett"></a>
#### `get(t, ...)`

Safely get nested value by keys.

:::tabs
== Example

```lua
local t = { a = { b = { c = 1 } } }
local v = get(t, "a", "b", "c")
-- result: 1

local v2 = get(t)
-- result: { a = { b = { c = 1 } } }
```

== Type

```lua
---@param t table
---@param ... any
---@return any
---@nodiscard
function get(t, ...) end
```
:::

<a id="fn-isemptyt"></a>
#### `isempty(t)`

Return true if table has no entries.

:::tabs
== Example

```lua
local empty = isempty({})
-- result: true
```

== Type

```lua
---@param t table
---@return boolean
---@nodiscard
function isempty(t) end
```
:::

### Transform

<a id="fn-filtert-pred"></a>
#### `filter(t, pred)`

Filter entries by a value predicate.

:::tabs
== Example

```lua
local even = filter({ a = 1, b = 2, c = 3 }, function(v)
  return v % 2 == 0
end)
-- result: { b = 2 }
```

== Type

```lua
---@param t table
---@param pred fun(v:any):boolean
---@return table
---@nodiscard
function filter(t, pred) end
```
:::

<a id="fn-invertt"></a>
#### `invert(t)`

Invert keys/values into new table.

:::tabs
== Example

```lua
local t = invert({ a = 1, b = 2 })
-- result: { [1] = "a", [2] = "b" }
```

== Type

```lua
---@generic T1,T2
---@param t {[T1]:T2}
---@return {[T2]:T1}
---@nodiscard
function invert(t) end
```
:::

<a id="fn-keyst"></a>
#### `keys(t)`

Return a list of all keys in the table.

:::tabs
== Example

```lua
local keys = keys({ a = 1, b = 2 })
-- result: { "a", "b" }
```

== Type

```lua
---@generic T
---@param t {[any]:T}
---@return mods.List<T>
---@nodiscard
function keys(t) end
```
:::

<a id="fn-mapt-fn"></a>
#### `map(t, fn)`

Return a new table by mapping each value (keys preserved).

:::tabs
== Example

```lua
local t = map({ a = 1, b = 2 }, function(v)
  return v * 10
end)
-- result: { a = 10, b = 20 }
```

== Type

```lua
---@generic T1,T2,T3
---@param t {[T1]:T2}
---@param fn fun(v:T2):T3
---@return {[T1]:T3}
---@nodiscard
function map(t, fn) end
```
:::

<a id="fn-pairmapt-fn"></a>
#### `pairmap(t, fn)`

Return a new table by mapping each key-value pair.

:::tabs
== Example

```lua
local t = pairmap({ a = 1, b = 2 }, function(k, v)
  return k .. v
end)
-- result: { a = "a1", b = "b2" }
```

== Type

```lua
---@generic T1,T2,T3
---@param t {[T1]:T2}
---@param fn fun(k:T1, v:T2):T3
---@return {[T1]:T3}
---@nodiscard
function pairmap(t, fn) end
```
:::

<a id="fn-updatet1-t2"></a>
#### `update(t1, t2)`

Merge entries from t2 into t1 and return t1.

:::tabs
== Example

```lua
local t1 = { a = 1, b = 2 }
update(t1, { b = 3, c = 4 })
-- result: t1 is { a = 1, b = 3, c = 4 }
```

== Type

```lua
---@generic T:table
---@param t1 T
---@param t2 table
---@return T
---@nodiscard
function update(t1, t2) end
```
:::

<a id="fn-valuest"></a>
#### `values(t)`

Return a list of all values in the table.

:::tabs
== Example

```lua
local vals = values({ a = 1, b = 2 })
-- result: { 1, 2 }
```

== Type

```lua
---@generic T
---@param t {[any]:T}
---@return mods.List<T>
---@nodiscard
function values(t) end
```
:::
