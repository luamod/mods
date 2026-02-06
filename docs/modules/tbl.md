# tbl

`mods.tbl` is a collection of utility functions for working with plain Lua tables.

## Usage

```lua
local tbl = require("mods.tbl")
```

## Functions

### Basics

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
