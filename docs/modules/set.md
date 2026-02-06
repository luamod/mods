# Set

`mods.Set` is a Python-style set class providing common operations to create, modify, and query collections of unique values.

## Create

```lua
local Set = require("mods.Set")

local s = Set({ "a", "b", "a" })
```

## Core Behavior

- Sets are represented as tables with values as keys and `true` as the value.
- Most methods return a new `Set`, while mutators return `self`.

## Methods

### Query

- `isdisjoint(set) -> boolean`
- `isempty() -> boolean`
- `issubset(set) -> boolean`
- `issuperset(set) -> boolean`
- `len() -> integer`

### Transform (New Set)

- `copy() -> Set`
- `difference(set) -> Set`
- `intersection(set) -> Set`
- `map(fn) -> Set`
- `symmetric_difference(set) -> Set`
- `union(set) -> Set`
- `values() -> List`

### Mutate (In Place)

- `add(v)`
- `clear()`
- `difference_update(set)`
- `discard(v)`
- `remove(v)` (alias of `discard`)
- `intersection_update(set)`
- `pop() -> any`
- `symmetric_difference_update(set)`
- `update(set)`

## Examples

```lua
local Set = require("mods.Set")

local s = Set({ "a", "b" })
local t = Set({ "b", "c" })

local u = s:union(t)             -- { a = true, b = true, c = true }
local i = s:intersection(t)      -- { b = true }
local d = s:difference(t)        -- { a = true }
```
