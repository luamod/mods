# Mods

Pure standalone Lua modules.

## What Is Mods?

Mods is a collection of small, focused Lua modules designed to be easy to use and easy to embed.

## Why Mods

- Minimal dependencies and small footprint
- Designed to use standalone or as a collection: drop a single file into your project without extra dependencies
- Familiar, predictable API patterns across modules
- Works across Lua 5.1+

## Modules

<!-- @include: ./modules/index.md -->

## Start Fast

```lua
local List = require("mods.List")
local Set = require("mods.Set")
local tbl = require("mods.tbl")

local l = List({ "a", "b", "a" })
local u = l:uniq()      -- { "a", "b" }
local s = Set({ "a", "b" })
local k = tbl.keys({ a = 1, b = 2 })
```
