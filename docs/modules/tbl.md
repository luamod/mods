# tbl

`mods.tbl` is a collection of utility functions for working with plain Lua tables.

## Usage

```lua
local tbl = require("mods.tbl")
```

## Functions

### `clear(t)`

Removes all entries from the table.

:::tabs
== Example

```lua
local t = { a = 1, b = 2 }
tbl.clear(t)
-- t is {}
```

== Type

```lua
---@param t table
---@return nil
function clear(t) end
```
:::

### `copy(t)`

Creates a shallow copy of the table.

:::tabs
== Example

```lua
local t = { a = 1, b = 2 }
local c = tbl.copy(t)
-- c is { a = 1, b = 2 }
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

### `count(t)`

Returns the number of keys in the table.

:::tabs
== Example

```lua
local n = tbl.count({ a = 1, b = 2 })
-- n == 2
```

== Type

```lua
---@param t table
---@return integer
---@nodiscard
function count(t) end
```
:::

### `deepcopy(v)`

Creates a deep copy of a value. Tables are copied recursively.

:::tabs
== Example

```lua
local t = { a = { b = 1 } }
local c = tbl.deepcopy(t)
-- c.a is a new table
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

### `filter(t, pred)`

Filters entries by a value predicate.

:::tabs
== Example

```lua
local even = tbl.filter({ a = 1, b = 2, c = 3 }, function(v)
  return v % 2 == 0
end)
-- even is { b = 2 }
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

### `find(t, v)`

Finds the first key whose value equals `v`.

:::tabs
== Example

```lua
local k = tbl.find({ a = 1, b = 2, c = 2 }, 2)
-- k is "b" or "c"
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

### `find_if(t, pred)`

Finds the first value/key pair matching `pred`.

:::tabs
== Example

```lua
local v, k = tbl.find_if({ a = 1, b = 2 }, function(v, k)
  return k == "b" and v == 2
end)
-- v == 2, k == "b"
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

### `get(t, ...)`

Safely gets a nested value by keys. If no keys are provided, returns `t`.

:::tabs
== Example

```lua
local t = { a = { b = { c = 1 } } }
local v = tbl.get(t, "a", "b", "c")
-- v == 1
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

### `invert(t)`

Inverts keys and values into a new table.

:::tabs
== Example

```lua
local inv = tbl.invert({ a = 1, b = 2 })
-- inv is { [1] = "a", [2] = "b" }
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

### `isempty(t)`

Returns true if the table has no entries.

:::tabs
== Example

```lua
local ok = tbl.isempty({})
-- ok == true
```

== Type

```lua
---@param t table
---@return boolean
---@nodiscard
function isempty(t) end
```
:::

### `keys(t)`

Returns a list of all keys.

:::tabs
== Example

```lua
local keys = tbl.keys({ a = 1, b = 2 })
-- keys is { "a", "b" }
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

### `map(t, fn)`

Maps each value through `fn` (keys preserved).

:::tabs
== Example

```lua
local out = tbl.map({ a = 1, b = 2 }, function(v)
  return v * 10
end)
-- out is { a = 10, b = 20 }
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

### `pairmap(t, fn)`

Maps each key/value pair through `fn` (keys preserved).

:::tabs
== Example

```lua
local out = tbl.pairmap({ a = 1, b = 2 }, function(k, v)
  return k .. v
end)
-- out is { a = "a1", b = "b2" }
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

### `update(t1, t2)`

Merges entries from `t2` into `t1` and returns `t1`.

:::tabs
== Example

```lua
local t1 = { a = 1, b = 2 }
tbl.update(t1, { b = 3, c = 4 })
-- t1 is { a = 1, b = 3, c = 4 }
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

### `values(t)`

Returns a list of all values.

:::tabs
== Example

```lua
local vals = tbl.values({ a = 1, b = 2 })
-- vals is { 1, 2 }
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
