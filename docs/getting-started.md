# Getting Started

## Install

:::tabs
== LuaRocks

```sh
luarocks install mods
```

== Git

```sh
git clone git@github.com:luamod/mods.git
```

Then require modules directly from `src/mods`:

```lua
local List = require("mods.List")
local Set = require("mods.Set")
local tbl = require("mods.tbl")
```

== Copy Files

Copy the files you need from `src/mods` into your project and require them.
:::

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

## Modules

<!-- @include: ./modules/index.md -->
