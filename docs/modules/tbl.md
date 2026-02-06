# tbl

`mods.tbl` is a collection of utility functions for working with plain Lua tables.

## Usage

```lua
local tbl = require("mods.tbl")
```

## Functions

### `clear(t) -> nil`

Removes all entries from the table.

```lua
local t = { a = 1, b = 2 }
tbl.clear(t)
-- t is {}
```

### `copy(t) -> t`

Creates a shallow copy of the table.

```lua
local t = { a = 1, b = 2 }
local c = tbl.copy(t)
-- c is { a = 1, b = 2 }
```

### `count(t) -> integer`

Returns the number of keys in the table.

```lua
local n = tbl.count({ a = 1, b = 2 })
-- n == 2
```

### `deepcopy(v) -> v`

Creates a deep copy of a value. Tables are copied recursively.

```lua
local t = { a = { b = 1 } }
local c = tbl.deepcopy(t)
-- c.a is a new table
```

### `filter(t, pred) -> table`

Filters entries by a value predicate.

```lua
local even = tbl.filter({ a = 1, b = 2, c = 3 }, function(v)
  return v % 2 == 0
end)
-- even is { b = 2 }
```

### `find(t, v) -> key?`

Finds the first key whose value equals `v`.

```lua
local k = tbl.find({ a = 1, b = 2, c = 2 }, 2)
-- k is "b" or "c"
```

### `find_if(t, pred) -> v?, k?`

Finds the first value/key pair matching `pred`.

```lua
local v, k = tbl.find_if({ a = 1, b = 2 }, function(v, k)
  return k == "b" and v == 2
end)
-- v == 2, k == "b"
```

### `get(t, ...) -> any`

Safely gets a nested value by keys. If no keys are provided, returns `t`.

```lua
local t = { a = { b = { c = 1 } } }
local v = tbl.get(t, "a", "b", "c")
-- v == 1
```

### `invert(t) -> table`

Inverts keys and values into a new table.

```lua
local inv = tbl.invert({ a = 1, b = 2 })
-- inv is { [1] = "a", [2] = "b" }
```

### `isempty(t) -> boolean`

Returns true if the table has no entries.

```lua
local ok = tbl.isempty({})
-- ok == true
```

### `keys(t) -> List`

Returns a list of all keys.

```lua
local keys = tbl.keys({ a = 1, b = 2 })
-- keys is { "a", "b" }
```

### `map(t, fn) -> table`

Maps each value through `fn` (keys preserved).

```lua
local out = tbl.map({ a = 1, b = 2 }, function(v)
  return v * 10
end)
-- out is { a = 10, b = 20 }
```

### `pairmap(t, fn) -> table`

Maps each key/value pair through `fn` (keys preserved).

```lua
local out = tbl.pairmap({ a = 1, b = 2 }, function(k, v)
  return k .. v
end)
-- out is { a = "a1", b = "b2" }
```

### `update(t1, t2) -> t1`

Merges entries from `t2` into `t1` and returns `t1`.

```lua
local t1 = { a = 1, b = 2 }
tbl.update(t1, { b = 3, c = 4 })
-- t1 is { a = 1, b = 3, c = 4 }
```

### `values(t) -> List`

Returns a list of all values.

```lua
local vals = tbl.values({ a = 1, b = 2 })
-- vals is { 1, 2 }
```
