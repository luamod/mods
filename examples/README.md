# Examples

Quick, runnable scripts showcasing module usage.

Run from the repo root (no install required):

```sh
lua -e 'package.path="src/?.lua;src/?/init.lua;"..package.path' examples/list.lua
lua -e 'package.path="src/?.lua;src/?/init.lua;"..package.path' examples/set.lua
lua -e 'package.path="src/?.lua;src/?/init.lua;"..package.path' examples/str.lua
lua -e 'package.path="src/?.lua;src/?/init.lua;"..package.path' examples/stringcase.lua
lua -e 'package.path="src/?.lua;src/?/init.lua;"..package.path' examples/tbl.lua
```

If you installed the module (e.g. via [LuaRocks](https://luarocks.org/modules/luamod/mods)), you can run:

```sh
lua examples/list.lua
lua examples/set.lua
lua examples/str.lua
lua examples/stringcase.lua
lua examples/tbl.lua
```
