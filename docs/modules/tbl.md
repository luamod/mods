# tbl

`mods.tbl` is a collection of utility functions for working with plain Lua tables.

## Usage

```lua
local tbl = require("mods.tbl")
```

## Functions

- `clear(t) -> nil`
- `copy(t) -> t`
- `count(t) -> integer`
- `deepcopy(v) -> v`
- `filter(t, pred) -> table`
- `find(t, v) -> key?`
- `find_if(t, pred) -> v?, k?`
- `get(t, ...) -> any`
- `invert(t) -> table`
- `isempty(t) -> boolean`
- `keys(t) -> List`
- `map(t, fn) -> table`
- `pairmap(t, fn) -> table`
- `update(t1, t2) -> t1`
- `values(t) -> List`

## Examples

```lua
local tbl = require("mods.tbl")

local t = { a = 1, b = 2 }
local keys = tbl.keys(t)         -- { "a", "b" }
local vals = tbl.values(t)       -- { 1, 2 }
local inv = tbl.invert(t)        -- { [1] = "a", [2] = "b" }
```
