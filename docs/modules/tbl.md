---
description:
  Lua table helpers for copy, query, transform, and safe nested access patterns.
---

# `tbl`

Utility functions for working with Lua tables.

## Quick Reference

**Basics**:

| Function                 | Description                             |
| ------------------------ | --------------------------------------- |
| [`clear(t)`](#fn-cleart) | Remove all entries from the table.      |
| [`count(t)`](#fn-countt) | Return the number of keys in the table. |

**Copying**:

| Function                       | Description                         |
| ------------------------------ | ----------------------------------- |
| [`copy(t)`](#fn-copyt)         | Create a shallow copy of the table. |
| [`deepcopy(v)`](#fn-deepcopyv) | Create a deep copy of a value.      |

**Query**:

| Function                                | Description                                            |
| --------------------------------------- | ------------------------------------------------------ |
| [`filter(t, pred)`](#fn-filtert-pred)   | Filter entries by a value predicate.                   |
| [`find(t, v)`](#fn-findt-v)             | Find the first key whose value equals the given value. |
| [`find_if(t, pred)`](#fn-find_ift-pred) | Find first value and key matching predicate.           |
| [`get(t, ...)`](#fn-gett-varargs)       | Safely get nested value by keys.                       |

**Transforms**:

| Function                            | Description                                                |
| ----------------------------------- | ---------------------------------------------------------- |
| [`invert(t)`](#fn-invertt)          | Invert keys/values into new table.                         |
| [`isempty(t)`](#fn-isemptyt)        | Return true if table has no entries.                       |
| [`keys(t)`](#fn-keyst)              | Return a list of all keys in the table.                    |
| [`map(t, fn)`](#fn-mapt-fn)         | Return a new table by mapping each value (keys preserved). |
| [`pairmap(t, fn)`](#fn-pairmapt-fn) | Return a new table by mapping each key-value pair.         |
| [`update(t1, t2)`](#fn-updatet1-t2) | Merge entries from t2 into t1 and return t1.               |
| [`values(t)`](#fn-valuest)          | Return a list of all values in the table.                  |

## Functions

### Basics

#### `clear(t)` {#fn-cleart}

Remove all entries from the table.

:::tabs == Example

```lua
local t = { a = 1, b = 2 }
clear(t)
-- result: {}
```

== Signature

```lua
---@param t table
---@return nil
function clear(t) end
```

:::

#### `count(t)` {#fn-countt}

Return the number of keys in the table.

:::tabs == Example

```lua
local n = count({ a = 1, b = 2 })
-- result: 2
```

== Signature

```lua
---@param t table
---@return integer
---@nodiscard
function count(t) end
```

:::

### Copying

#### `copy(t)` {#fn-copyt}

Create a shallow copy of the table.

:::tabs == Example

```lua
local t = copy({ a = 1, b = 2 })
-- result: { a = 1, b = 2 }
```

== Signature

```lua
---@generic T:table
---@param t T
---@return T
---@nodiscard
function copy(t) end
```

:::

#### `deepcopy(v)` {#fn-deepcopyv}

Create a deep copy of a value. If `v` is a table, all nested tables are copied
recursively; other types are returned as-is.

:::tabs == Example

```lua
local n = deepcopy(42)
-- result: 42

local t = deepcopy({ a = { b = 1 } })
-- result: { a = { b = 1 } }
```

== Signature

```lua
---@generic T
---@param v T
---@return T
---@nodiscard
function deepcopy(v) end
```

:::

### Query

#### `filter(t, pred)` {#fn-filtert-pred}

Filter entries by a value predicate.

:::tabs == Example

```lua
local even = filter({ a = 1, b = 2, c = 3 }, function(v)
 return v % 2 == 0
end)
-- result: { b = 2 }
```

== Signature

```lua
---@param t table
---@param pred fun(v:any):boolean
---@return table
---@nodiscard
function filter(t, pred) end
```

:::

#### `find(t, v)` {#fn-findt-v}

Find the first key whose value equals the given value.

:::tabs == Example

```lua
local key = find({ a = 1, b = 2, c = 2 }, 2)
-- result: "b" or "c"
```

== Signature

```lua
---@generic T1,T2
---@param t {[T1]:T2}
---@param v T2
---@return T1?
---@nodiscard
function find(t, v) end
```

:::

#### `find_if(t, pred)` {#fn-find_ift-pred}

Find first value and key matching predicate.

:::tabs == Example

```lua
local v, k = find_if({ a = 1, b = 2 }, function(v, k)
 return k == "b" and v == 2
end)
-- result: 2, "b"
```

== Signature

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

#### `get(t, ...)` {#fn-gett-varargs}

Safely get nested value by keys. If no keys are provided, returns the input
table.

:::tabs == Example

```lua
local t = { a = { b = { c = 1 } } }
local v = get(t, "a", "b", "c")
-- result: 1

local v2 = get(t)
-- result: { a = { b = { c = 1 } } }
```

== Signature

```lua
---@param t table
---@param ... any
---@return any
---@nodiscard
function get(t, ...) end
```

:::

### Transforms

#### `invert(t)` {#fn-invertt}

Invert keys/values into new table.

:::tabs == Example

```lua
local t = invert({ a = 1, b = 2 })
-- result: { [1] = "a", [2] = "b" }
```

== Signature

```lua
---@generic T1,T2
---@param t {[T1]:T2}
---@return {[T2]:T1}
---@nodiscard
function invert(t) end
```

:::

#### `isempty(t)` {#fn-isemptyt}

Return true if table has no entries.

:::tabs == Example

```lua
local empty = isempty({})
-- result: true
```

== Signature

```lua
---@param t table
---@return boolean
---@nodiscard
function isempty(t) end
```

:::

#### `keys(t)` {#fn-keyst}

Return a list of all keys in the table.

:::tabs == Example

```lua
local keys = keys({ a = 1, b = 2 })
-- result: { "a", "b" }
```

== Signature

```lua
---@generic T
---@param t {[any]:T}
---@return mods.List<T>|T[]
---@nodiscard
function keys(t) end
```

:::

#### `map(t, fn)` {#fn-mapt-fn}

Return a new table by mapping each value (keys preserved).

:::tabs == Example

```lua
local t = map({ a = 1, b = 2 }, function(v)
 return v * 10
end)
-- result: { a = 10, b = 20 }
```

== Signature

```lua
---@generic T1,T2,T3
---@param t {[T1]:T2}
---@param fn fun(v:T2):T3
---@return {[T1]:T3}
---@nodiscard
function map(t, fn) end
```

:::

#### `pairmap(t, fn)` {#fn-pairmapt-fn}

Return a new table by mapping each key-value pair. The resulting table keeps the
same keys, with values transformed by `fn`.

:::tabs == Example

```lua
local t = pairmap({ a = 1, b = 2 }, function(k, v)
 return k .. v
end)
-- result: { a = "a1", b = "b2" }
```

== Signature

```lua
---@generic T1,T2,T3
---@param t {[T1]:T2}
---@param fn fun(k:T1, v:T2):T3
---@return {[T1]:T3}
---@nodiscard
function pairmap(t, fn) end
```

:::

#### `update(t1, t2)` {#fn-updatet1-t2}

Merge entries from t2 into t1 and return t1.

:::tabs == Example

```lua
local t1 = { a = 1, b = 2 }
update(t1, { b = 3, c = 4 })
-- result: t1 is { a = 1, b = 3, c = 4 }
```

== Signature

```lua
---@generic T:table
---@param t1 T
---@param t2 table
---@return T
---@nodiscard
function update(t1, t2) end
```

:::

#### `values(t)` {#fn-valuest}

Return a list of all values in the table.

:::tabs == Example

```lua
local vals = values({ a = 1, b = 2 })
-- result: { 1, 2 }
```

== Signature

```lua
---@generic T
---@param t {[any]:T}
---@return mods.List<T>|T[]
---@nodiscard
function values(t) end
```

:::
