# Mods

Pure standalone Lua modules.

## Install

Clone the repo and require modules directly from `src/mods`:

```lua
local List = require("mods.List")
local Set = require("mods.Set")
local tbl = require("mods.tbl")
```

## Modules

- `mods.List`: list helpers (map/filter/slice, etc.)
- `mods.Set`: unique-value set operations
- `mods.tbl`: utility functions for plain Lua tables

## Tests

```sh
busted
```

## Docs

```sh
npm install
npm run dev
```

Then open the VitePress dev server URL shown in the terminal.
