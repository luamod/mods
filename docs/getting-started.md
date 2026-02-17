---
description: Install Mods and use modules through the shared `mods` entrypoint.
---

# Getting Started

## Install

:::tabs

== LuaRocks

```sh
luarocks install mods
```

== Manual

- **Unix (🐧 Linux / 🍎 macOS)**:

  ```sh
  git clone https://github.com/luamod/mods.git
  cd mods
  mkdir -p /usr/local/share/lua/5.x/
  cp -r src/mods /usr/local/share/lua/5.x/
  ```

- **🪟 Windows**:

  Copy all files from `src/mods/` to `C:\Program Files\Lua\5.x\lua\mods\`.

> [!IMPORTANT]
>
> Replace `5.x` with your Lua version (for example, `5.4`).

:::

> [!NOTE]
>
> [LLS](https://github.com/LuaLS/lua-language-server) type stubs are available
> in [`types/`](https://github.com/luamod/mods/tree/main/types).

## Basic Usage

```lua
local mods = require("mods")

local l = mods.List({ "a", "b", "a" })
local s = mods.Set({ "a", "b" })

local u = l:uniq()
local keys = mods.tbl.keys({ a = 1, b = 2 })
```

> [!NOTE]
>
> Direct module imports such as `require("mods.str")` remain supported for
> compatibility.
