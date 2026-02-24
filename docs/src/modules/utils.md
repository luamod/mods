---
desc: "Small shared utility helpers used by modules in this library."
---

# `utils`

Small shared utility helpers used by modules in this library.

## Usage

```lua
utils = require "mods.utils"

print(utils.quote('hello "world"')) --> 'hello "world"'
```

## Functions

### `quote`

Smart-quote a string for readable Lua-like output.

```lua
print(utils.quote('He said "hi"')) -- 'He said "hi"'
print(utils.quote('say "hi" and \\'bye\\'')) -- "say \"hi\" and 'bye'"
```

### `repr`

Render any Lua value as a string.

> [!NOTE]
>
> Uses [`inspect`](https://github.com/kikito/inspect.lua) when available,
> otherwise falls back to
> [`mods.repr`](https://luamod.github.io/mods/modules/repr).

```lua
print(utils.repr({ a = 1 })) --> {
--                                 a = 1
--                               }
```
