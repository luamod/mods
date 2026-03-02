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

| Function                | Description                             |
| ----------------------- | --------------------------------------- |
| [`clear(t)`](#fn-clear) | Remove all entries from the table.      |
| [`count(t)`](#fn-count) | Return the number of keys in the table. |

**Copying**:

| Function                      | Description                         |
| ----------------------------- | ----------------------------------- |
| [`copy(t)`](#fn-copy)         | Create a shallow copy of the table. |
| [`deepcopy(v)`](#fn-deepcopy) | Create a deep copy of a value.      |

**Query**:

| Function                          | Description                                                      |
| --------------------------------- | ---------------------------------------------------------------- |
| [`filter(t, pred)`](#fn-filter)   | Filter entries by a value predicate.                             |
| [`find(t, v)`](#fn-find)          | Find the first key whose value equals the given value.           |
| [`same(a, b)`](#fn-same)          | Return `true` if two tables have the same keys and equal values. |
| [`find_if(t, pred)`](#fn-find-if) | Find first value and key matching predicate.                     |
| [`get(t, ...)`](#fn-get)          | Safely get nested value by keys.                                 |
| [`keypath(...)`](#fn-keypath)     | Format a key chain as a Lua-like table access path.              |

**Transforms**:

| Function                        | Description                                                |
| ------------------------------- | ---------------------------------------------------------- |
| [`invert(t)`](#fn-invert)       | Invert keys/values into new table.                         |
| [`isempty(t)`](#fn-isempty)     | Return true if table has no entries.                       |
| [`keys(t)`](#fn-keys)           | Return a list of all keys in the table.                    |
| [`map(t, fn)`](#fn-map)         | Return a new table by mapping each value (keys preserved). |
| [`pairmap(t, fn)`](#fn-pairmap) | Return a new table by mapping each key-value pair.         |
| [`update(t1, t2)`](#fn-update)  | Merge entries from `t2` into `t1` and return `t1`.         |
| [`values(t)`](#fn-values)       | Return a list of all values in the table.                  |

### Basics

Core table utilities for clearing and counting. <a id="fn-clear"></a>

#### `clear(t)`

Remove all entries from the table.

**Parameters**:

- `t` (`table`): Target table.

**Return**:

- `none` (`nil`)

**Example**:

```lua
t = { a = 1, b = 2 }
clear(t) --> t = {}
```

<a id="fn-count"></a>

#### `count(t)`

Return the number of keys in the table.

**Parameters**:

- `t` (`table`): Input table.

**Return**:

- `count` (`integer`): Number of keys in `t`.

**Example**:

```lua
n = count({ a = 1, b = 2 }) --> 2
```

### Copying

Shallow and deep copy helpers. <a id="fn-copy"></a>

#### `copy(t)`

Create a shallow copy of the table.

**Parameters**:

- `t` (`T`): Source table.

**Return**:

- `copy` (`T`): Shallow-copied table.

**Example**:

```lua
t = copy({ a = 1, b = 2 }) --> { a = 1, b = 2 }
```

<a id="fn-deepcopy"></a>

#### `deepcopy(v)`

Create a deep copy of a value.

**Parameters**:

- `v` (`T`): Input value.

**Return**:

- `copy` (`T`): Deep-copied value.

**Example**:

```lua
t = deepcopy({ a = { b = 1 } }) --> { a = { b = 1 } }
n = deepcopy(42) --> 42
```

> [!NOTE]
>
> If `v` is a table, all nested tables are copied recursively; other types are
> returned as-is.

### Query

Read-only lookup and selection helpers. <a id="fn-filter"></a>

#### `filter(t, pred)`

Filter entries by a value predicate.

**Parameters**:

- `t` (`table`): Input table.
- `pred` (`fun(v:any):boolean`): Value predicate.

**Return**:

- `filtered` (`table`): Table containing entries where `pred(v)` is true.

**Example**:

```lua
even = filter({ a = 1, b = 2, c = 3 }, function(v)
  return v % 2 == 0
end) --> { b = 2 }
```

<a id="fn-find"></a>

#### `find(t, v)`

Find the first key whose value equals the given value.

**Parameters**:

- `t` (`{[T1]:T2}`): Input table.
- `v` (`T2`): Value to find.

**Return**:

- `key` (`T1?`): First matching key, or `nil` when not found.

**Example**:

```lua
key = find({ a = 1, b = 2, c = 2 }, 2) --> "b" or "c"
```

<a id="fn-same"></a>

#### `same(a, b)`

Return `true` if two tables have the same keys and equal values.

**Parameters**:

- `a` (`table`): Left table.
- `b` (`table`): Right table.

**Return**:

- `ok` (`boolean`): True when both tables have the same keys and values.

**Example**:

```lua
ok = same({ a = 1, b = 2 }, { b = 2, a = 1 }) --> true
ok = same({ a = {} }, { a = {} })             --> false
```

<a id="fn-find-if"></a>

#### `find_if(t, pred)`

Find first value and key matching predicate.

**Parameters**:

- `t` (`table`): Input table.
- `pred` (`fun(v:T1,k:T2):boolean`): Predicate function.

**Return**:

- `v` (`T1?`): First matching value, or `nil` when not found.
- `k` (`T2?`): Key for the first matching value, or `nil` when not found.

**Example**:

```lua
v, k = find_if({ a = 1, b = 2 }, function(v, k)
  return k == "b" and v == 2
end) --> 2, "b"
```

<a id="fn-get"></a>

#### `get(t, ...)`

Safely get nested value by keys.

**Parameters**:

- `t` (`table`): Root table.
- `...` (`any`): Additional arguments.

**Return**:

- `value` (`any`): Nested value, or `nil` when any key is missing.

**Example**:

```lua
t = { a = { b = { c = 1 } } }
v1 = get(t, "a", "b", "c") --> 1
v2 = get(t)                --> { a = { b = { c = 1 } } }
```

> [!NOTE]
>
> If no keys are provided, returns the input table.

<a id="fn-keypath"></a>

#### `keypath(...)`

Format a key chain as a Lua-like table access path.

**Parameters**:

- `...` (`any`): Additional arguments.

**Return**:

- `path` (`string`): Rendered key path.

**Example**:

```lua
p1 = keypath("t", "a", "b", "c")        --> "t.a.b.c"
p2 = keypath("ctx", "users", 1, "name") --> "ctx.users[1].name"
p3 = keypath("ctx", "invalid-key")      --> 'ctx["invalid-key"]'
p4 = keypath()                          --> ""
```

### Transforms

Table transformation and conversion utilities. <a id="fn-invert"></a>

#### `invert(t)`

Invert keys/values into new table.

**Parameters**:

- `t` (`{[T1]:T2}`): Input table.

**Return**:

- `inverted` (`{[T2]:T1}`): Inverted table (`value -> key`).

**Example**:

```lua
t = invert({ a = 1, b = 2 }) --> { [1] = "a", [2] = "b" }
```

<a id="fn-isempty"></a>

#### `isempty(t)`

Return true if table has no entries.

**Parameters**:

- `t` (`table`): Input table.

**Return**:

- `ok` (`boolean`): True when `t` has no entries.

**Example**:

```lua
empty = isempty({}) --> true
```

<a id="fn-keys"></a>

#### `keys(t)`

Return a list of all keys in the table.

**Parameters**:

- `t` (`{[T]:any}`): Input table.

**Return**:

- `keys` (`mods.List<T>`): List of keys in `t`.

**Example**:

```lua
keys = keys({ a = 1, b = 2 }) --> { "a", "b" }
```

<a id="fn-map"></a>

#### `map(t, fn)`

Return a new table by mapping each value (keys preserved).

**Parameters**:

- `t` (`{[T1]:T2}`): Input table.
- `fn` (`fun(v:T2):T3`): Mapping function.

**Return**:

- `mapped` (`{[T1]:T3}`): New table with mapped values.

**Example**:

```lua
t = map({ a = 1, b = 2 }, function(v)
  return v * 10
end) --> { a = 10, b = 20 }
```

<a id="fn-pairmap"></a>

#### `pairmap(t, fn)`

Return a new table by mapping each key-value pair.

**Parameters**:

- `t` (`{[T1]:T2}`): Input table.
- `fn` (`fun(k:T1,`): v:T2):T3 Key-value mapping function.

**Return**:

- `mapped` (`{[T1]:T3}`): New table with mapped values.

**Example**:

```lua
t = pairmap({ a = 1, b = 2 }, function(k, v)
  return k .. v
end) --> { a = "a1", b = "b2" }
```

> [!NOTE]
>
> Output keeps original keys; only values are transformed by `fn`.

<a id="fn-update"></a>

#### `update(t1, t2)`

Merge entries from `t2` into `t1` and return `t1`.

**Parameters**:

- `t1` (`T`): Target table.
- `t2` (`table`): Source table.

**Return**:

- `t1` (`T`): Updated `t1` table.

**Example**:

```lua
t1 = { a = 1, b = 2 }
update(t1, { b = 3, c = 4 }) --> t1 is { a = 1, b = 3, c = 4 }
```

<a id="fn-values"></a>

#### `values(t)`

Return a list of all values in the table.

**Parameters**:

- `t` (`{[any]:T}`): Input table.

**Return**:

- `values` (`mods.List<T>`): List of values in `t`.

**Example**:

```lua
vals = values({ a = 1, b = 2 }) --> { 1, 2 }
```
