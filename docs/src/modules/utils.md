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
