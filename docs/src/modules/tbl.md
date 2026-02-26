---
desc: "Utility functions for working with Lua tables."
---

# `tbl`

Utility functions for working with Lua tables.

## Usage

```lua
tbl = require "mods.tbl"

print(tbl.count({ a = 1, b = 2 })) --> 2
```

## Functions

**Basics**:

| Function          | Description                             |
| ----------------- | --------------------------------------- |
| [`clear`](#clear) | Remove all entries from the table.      |
| [`count`](#count) | Return the number of keys in the table. |

**Copying**:

| Function                | Description                         |
| ----------------------- | ----------------------------------- |
| [`copy`](#copy)         | Create a shallow copy of the table. |
| [`deepcopy`](#deepcopy) | Create a deep copy of a value.      |

**Query**:

| Function              | Description                                                      |
| --------------------- | ---------------------------------------------------------------- |
| [`filter`](#filter)   | Filter entries by a value predicate.                             |
| [`find`](#find)       | Find the first key whose value equals the given value.           |
| [`same`](#same)       | Return `true` if two tables have the same keys and equal values. |
| [`find_if`](#find-if) | Find first value and key matching predicate.                     |
| [`get`](#get)         | Safely get nested value by keys.                                 |
| [`keypath`](#keypath) | Format a key chain as a Lua-like table access path.              |

**Transforms**:

| Function              | Description                                                |
| --------------------- | ---------------------------------------------------------- |
| [`invert`](#invert)   | Invert keys/values into new table.                         |
| [`isempty`](#isempty) | Return true if table has no entries.                       |
| [`keys`](#keys)       | Return a list of all keys in the table.                    |
| [`map`](#map)         | Return a new table by mapping each value (keys preserved). |
| [`pairmap`](#pairmap) | Return a new table by mapping each key-value pair.         |
| [`update`](#update)   | Merge entries from `t2` into `t1` and return `t1`.         |
| [`values`](#values)   | Return a list of all values in the table.                  |

### Basics

Core table utilities for clearing and counting.

#### `clear`

Remove all entries from the table.

```lua
t = { a = 1, b = 2 }
clear(t) --> t = {}
```

#### `count`

Return the number of keys in the table.

```lua
n = count({ a = 1, b = 2 }) --> 2
```

### Copying

Shallow and deep copy helpers.

#### `copy`

Create a shallow copy of the table.

```lua
t = copy({ a = 1, b = 2 }) --> { a = 1, b = 2 }
```

#### `deepcopy`

Create a deep copy of a value.

> [!NOTE]
>
> If `v` is a table, all nested tables are copied recursively; other types are
> returned as-is.

```lua
t = deepcopy({ a = { b = 1 } }) --> { a = { b = 1 } }
n = deepcopy(42) --> 42
```

### Query

Read-only lookup and selection helpers.

#### `filter`

Filter entries by a value predicate.

```lua
even = filter({ a = 1, b = 2, c = 3 }, function(v)
  return v % 2 == 0
end) --> { b = 2 }
```

#### `find`

Find the first key whose value equals the given value.

```lua
key = find({ a = 1, b = 2, c = 2 }, 2) --> "b" or "c"
```

#### `same`

Return `true` if two tables have the same keys and equal values.

```lua
ok = same({ a = 1, b = 2 }, { b = 2, a = 1 }) --> true
ok = same({ a = {} }, { a = {} })             --> false
```

#### `find_if`

Find first value and key matching predicate.

```lua
v, k = find_if({ a = 1, b = 2 }, function(v, k)
  return k == "b" and v == 2
end) --> 2, "b"
```

#### `get`

Safely get nested value by keys.

```lua
t = { a = { b = { c = 1 } } }
v1 = get(t, "a", "b", "c") --> 1
v2 = get(t) --> { a = { b = { c = 1 } } }
```

> [!NOTE]
>
> If no keys are provided, returns the input table.

#### `keypath`

Format a key chain as a Lua-like table access path.

```lua
p1 = keypath("t", "a", "b", "c")        --> "t.a.b.c"
p2 = keypath("ctx", "users", 1, "name") --> "ctx.users[1].name"
p3 = keypath("ctx", "invalid-key")      --> 'ctx["invalid-key"]'
p4 = keypath()                          --> ""
```

### Transforms

Table transformation and conversion utilities.

#### `invert`

Invert keys/values into new table.

```lua
t = invert({ a = 1, b = 2 }) --> { [1] = "a", [2] = "b" }
```

#### `isempty`

Return true if table has no entries.

```lua
empty = isempty({}) --> true
```

#### `keys`

Return a list of all keys in the table.

```lua
keys = keys({ a = 1, b = 2 }) --> { "a", "b" }
```

#### `map`

Return a new table by mapping each value (keys preserved).

```lua
t = map({ a = 1, b = 2 }, function(v)
  return v * 10
end) --> { a = 10, b = 20 }
```

#### `pairmap`

Return a new table by mapping each key-value pair.

> [!NOTE]
>
> Output keeps original keys; only values are transformed by `fn`.

```lua
t = pairmap({ a = 1, b = 2 }, function(k, v)
  return k .. v
end) --> { a = "a1", b = "b2" }
```

#### `update`

Merge entries from `t2` into `t1` and return `t1`.

```lua
t1 = { a = 1, b = 2 }
update(t1, { b = 3, c = 4 }) --> t1 is { a = 1, b = 3, c = 4 }
```

#### `values`

Return a list of all values in the table.

```lua
vals = values({ a = 1, b = 2 }) --> { 1, 2 }
```
