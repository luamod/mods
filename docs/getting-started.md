---
title: Getting Started
description: Install Mods and use modules through the shared `mods` entrypoint.
---

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

> [!NOTE]
> [LLS](https://github.com/LuaLS/lua-language-server) type stubs are available in [`types/`](https://github.com/luamod/mods/tree/main/types).

## Basic Usage

```lua
local mods = require("mods")

local l = mods.List({ "a", "b", "a" })
local s = mods.Set({ "a", "b" })

local u = l:uniq()
local keys = mods.tbl.keys({ a = 1, b = 2 })
```

> [!NOTE]
> Direct module imports such as `require("mods.str")` remain supported for compatibility.
