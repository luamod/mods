---
description: "Lexical path operations for Windows/NT-style paths."
---

# `ntpath`

Lexical path operations for Windows/NT-style paths.

> 💡Python `ntpath`-style behavior, ported to Lua.

## Usage

```lua
ntpath = require "mods.ntpath"

print(ntpath.join([[C:\]], "Users", "me"))    --> "C:\Users\me"
print(ntpath.normcase([[A/B\C]]))             --> [[a\b\c]]
print(ntpath.splitdrive([[C:\Users\me]]))     --> "C:", [[\Users\me]]
print(ntpath.isreserved([[C:\Temp\CON.txt]])) --> true
```

---

> ✨ Same API as [`mods.path`](/modules/path), but with Windows/NT path
> semantics.
