# Mods

Pure standalone Lua modules.

## What Is Mods?

Mods is a set of small, focused Lua modules for easy embedding.
Minimal dependencies, predictable APIs, and Lua 5.1+ support.
Use modules standalone or together by dropping a single file into your project.

## Documentation

Guides, module overviews, and examples live in the [docs](https://luamod.github.io/mods).

## Installation

### LuaRocks

```sh
luarocks install mods
```

### Clone

```sh
git clone https://github.com/luamod/mods.git
cd mods
```

### Manual copy

Copy individual modules from [`src/mods/`](src/mods) into your project and `require("mods.List")`, `require("mods.str")`, etc.

## Modules

Available modules:

| Module         | Description                                                    |
| -------------- | -------------------------------------------------------------- |
| [`List`]       | Python-style list helpers for mapping, filtering, and slicing. |
| [`Set`]        | Set operations and helpers for unique values.                  |
| [`str`]        | String utility helpers modeled after Python's `str`.           |
| [`tbl`]        | Utility functions for plain Lua tables.                        |
| [`stringcase`] | String case conversion helpers.                                |

> [!NOTE]
> We are still working on adding new modules.

## Examples

See the runnable scripts in [`examples/`](examples).

[`List`]: https://luamod.github.io/mods/modules/list
[`Set`]: https://luamod.github.io/mods/modules/set
[`str`]: https://luamod.github.io/mods/modules/str
[`tbl`]: https://luamod.github.io/mods/modules/tbl
[`stringcase`]: https://luamod.github.io/mods/modules/stringcase
