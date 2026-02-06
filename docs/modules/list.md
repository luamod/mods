# List

`mods.List` is a Python-style list class providing common operations to create, modify, and query sequences of values.

## Create

```lua
local List = require("mods.List")

local l = List({ "a", "b", "c" })
```

## Core Behavior

- List indices are 1-based (Lua default).
- Most methods return a new `List` (pure operations), while mutators return `self`.

## Methods

### Query

- `all(pred) -> boolean`
- `any(pred) -> boolean`
- `contains(v) -> boolean`
- `count(v) -> integer`
- `first() -> any`
- `index(v) -> any, integer?`
- `index_if(pred) -> integer?`
- `last() -> any`
- `len() -> integer`

### Transform (New List)

- `copy() -> List`
- `difference(ls) -> List`
- `drop(n) -> List`
- `extract(pred) -> List` (also removes from original)
- `filter(pred) -> List`
- `flatten() -> List`
- `group_by(fn) -> table<any, List>`
- `intersection(ls) -> List`
- `invert() -> table`
- `map(fn) -> List`
- `reverse() -> List`
- `setify() -> table` (values become keys with `true`)
- `slice(i?, j?) -> List`
- `take(n) -> List`
- `uniq() -> List`
- `zip(other) -> List<{[integer]: any}>`

### Mutate (In Place)

- `append(v)`
- `clear()`
- `extend(ls)`
- `insert(pos, v)`
- `insert(v)`
- `pop()`
- `pop(pos)`
- `prepend(v)`
- `reduce(fn, init?) -> any` (returns accumulator)
- `remove(v)`
- `sort(comp?)`

## Examples

```lua
local List = require("mods.List")

local l = List({ "a", "b", "a", "c" })

local u = l:uniq()      -- { "a", "b", "c" }
local s = l:setify()    -- { a = true, b = true, c = true }
local t = l:slice(2, 3) -- { "b", "a" }
```
