# Mods

Mods is a set of pure Lua modules for daily development.
Minimal dependencies, predictable APIs, and support for Lua 5.1, 5.2, 5.3, 5.4, and LuaJIT.

This project is inspired by [Penlight (pl)](https://github.com/lunarmodules/Penlight).

If this project helps you, consider starring the repo ⭐.

## Documentation

Guides, module overviews, and examples live in the [docs](https://luamod.github.io/mods).

## Installation

### LuaRocks

```sh
luarocks install mods
```

### Manual

- **Unix (Linux/macOS)**:

  ```sh
  git clone https://github.com/luamod/mods.git
  cd mods
  mkdir -p /usr/local/share/lua/5.x/
  cp -r src/mods /usr/local/share/lua/5.x/
  ```

- **Windows**:

  Copy all files from `src/mods/` to `C:\Program Files\Lua\5.x\lua\mods\`.

> [!IMPORTANT]
> Replace `5.x` with your Lua version (for example, `5.4`).

## Modules

<!-- Keep this section in sync with docs/modules/index.md. -->

| Module         | Description                                                    |
| -------------- | -------------------------------------------------------------- |
| [`is`]         | Type predicates for Lua values and filesystem path kinds.      |
| [`List`]       | Python-style list helpers for mapping, filtering, and slicing. |
| [`operator`]   | Operator helpers as functions.                                 |
| [`Set`]        | Set operations and helpers for unique values.                  |
| [`str`]        | String utility helpers modeled after Python's `str`.           |
| [`stringcase`] | String case conversion helpers.                                |
| [`tbl`]        | Utility functions for plain Lua tables.                        |
| [`template`]   | Simple template rendering with value replacement.              |
| [`utils`]      | Common utility helpers.                                        |
| [`validate`]   | Validation helpers for Lua values.                             |

> [!NOTE]
> We are still working on adding new modules and improving the docs.

## Acknowledgments

Thanks to these Lua ecosystem projects:

- [LuaFileSystem (`lfs`)](https://github.com/lunarmodules/luafilesystem)
- [`inspect.lua` (`inspect`)](https://github.com/kikito/inspect.lua)
- [Busted (`busted`)](https://github.com/lunarmodules/busted)

[`is`]: https://luamod.github.io/mods/modules/is
[`List`]: https://luamod.github.io/mods/modules/list
[`operator`]: https://luamod.github.io/mods/modules/operator
[`Set`]: https://luamod.github.io/mods/modules/set
[`str`]: https://luamod.github.io/mods/modules/str
[`stringcase`]: https://luamod.github.io/mods/modules/stringcase
[`tbl`]: https://luamod.github.io/mods/modules/tbl
[`template`]: https://luamod.github.io/mods/modules/template
[`utils`]: https://luamod.github.io/mods/modules/utils
[`validate`]: https://luamod.github.io/mods/modules/validate
