# Mods

**Mods** is a pure Lua utility library with predictable APIs, 💤 lazy-loaded
inter-module dependencies, and support for Lua 5.1, 5.2, 5.3, 5.4, and LuaJIT.

> [!IMPORTANT]
>
> This library is not stable yet, and APIs may change between releases.

This project is inspired by
[Penlight (pl)](https://github.com/lunarmodules/Penlight).

If this project helps you, consider starring the repo ⭐.

## Documentation

Guides, module overviews, and examples live in the
[docs](https://luamod.github.io/mods).

## Installation

### LuaRocks

```sh
luarocks install mods
```

### Manual

- **Unix (🐧 Linux / 🍎 macOS)**:

  ```sh
  git clone https://github.com/luamod/mods.git
  cd mods
  mkdir -p /usr/local/share/lua/5.x/
  cp -r src/mods /usr/local/share/lua/5.x/
  ```

- **🪟 Windows**:

  Copy all files from [`src/mods/`](src/mods/) to
  `C:\Program Files\Lua\5.x\lua\mods\`.

> [!IMPORTANT]
>
> Replace `5.x` with your Lua version (for example, `5.4`).

## Modules

| Module         | Description                                                     |
| -------------- | --------------------------------------------------------------- |
| [`is`]         | Type predicates for Lua values and filesystem path kinds.       |
| [`keyword`]    | Lua keyword helpers for reserved-word checks.                   |
| [`List`]       | Python-style list helpers for mapping, filtering, and slicing.  |
| [`operator`]   | Operator helpers as functions.                                  |
| [`repr`]       | Readable Lua value rendering with deterministic table ordering. |
| [`runtime`]    | Lua runtime/version capability flags.                           |
| [`Set`]        | Set operations and helpers for unique values.                   |
| [`str`]        | String utility helpers modeled after Python's `str`.            |
| [`stringcase`] | String case conversion helpers.                                 |
| [`tbl`]        | Utility functions for plain Lua tables.                         |
| [`template`]   | Simple template rendering with value replacement.               |
| [`utils`]      | Common utility helpers.                                         |
| [`validate`]   | Validation helpers for Lua values.                              |

> [!NOTE]
>
> We are still working on adding new modules and improving the docs.

## Acknowledgments

Thanks to these Lua ecosystem projects:

- [lfs](https://github.com/lunarmodules/luafilesystem) for filesystem utilities.
- [inspect](https://github.com/kikito/inspect.lua) for readable table
  representation.
- [busted](https://github.com/lunarmodules/busted) for test framework support.

[`is`]: https://luamod.github.io/mods/modules/is
[`keyword`]: https://luamod.github.io/mods/modules/keyword
[`List`]: https://luamod.github.io/mods/modules/list
[`operator`]: https://luamod.github.io/mods/modules/operator
[`repr`]: https://luamod.github.io/mods/modules/repr
[`runtime`]: https://github.com/luamod/mods/blob/main/src/mods/runtime.lua
[`Set`]: https://luamod.github.io/mods/modules/set
[`str`]: https://luamod.github.io/mods/modules/str
[`stringcase`]: https://luamod.github.io/mods/modules/stringcase
[`tbl`]: https://luamod.github.io/mods/modules/tbl
[`template`]: https://luamod.github.io/mods/modules/template
[`utils`]: https://luamod.github.io/mods/modules/utils
[`validate`]: https://luamod.github.io/mods/modules/validate
