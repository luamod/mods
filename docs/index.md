---
layout: home
hero:
  name: Mods
  text: Pure standalone Lua modules.
  tagline: Simple building blocks for Lua projects.
  actions:
    - theme: brand
      text: Get Started
      link: /getting-started
    - theme: alt
      text: Browse Modules
      link: /modules/
---

## What is Mods?

Mods is a collection of small, focused Lua modules designed to be easy to use and easy to embed.

## Modules

- `mods.List`: helpers for sequences → /modules/list
- `mods.Set`: unique values + set ops → /modules/set
- `mods.tbl`: table utilities → /modules/tbl

## Why Mods

- Minimal dependencies
- Clear, consistent APIs
- Works across Lua 5.1+

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

- Minimal dependencies
- Clear, consistent APIs
- Portable across Lua runtimes

## Next steps

Start with the docs once we add them.
