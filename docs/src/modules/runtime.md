---
desc:
  "A tiny module that exposes Lua runtime metadata and version compatibility
  flags."
---

# `runtime`

A tiny module that exposes Lua runtime metadata and version compatibility flags.

## Usage

```lua
runtime = require "mods.runtime"

print(runtime.version)     --> "Lua 5.x"
print(runtime.version_num) --> 501 | 502 | 503 | 504
print(runtime.is_lua54)    --> true | false
```
