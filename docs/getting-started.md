# Getting Started

## Install

```sh
luarocks install mods
```

Or use the repo directly:

```lua
local List = require("mods.List")
local Set = require("mods.Set")
local tbl = require("mods.tbl")
```

## Basic Usage

```lua
local List = require("mods.List")
local Set = require("mods.Set")
local tbl = require("mods.tbl")

local l = List({ "a", "b", "a" })
local s = Set({ "a", "b" })

local u = l:uniq()       -- { "a", "b" }
local keys = tbl.keys({ a = 1, b = 2 })
```

## Next Steps

- Explore modules: `/modules/`
- Browse List, Set, and tbl docs
