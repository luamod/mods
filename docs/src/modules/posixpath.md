---
description: "Lexical path operations for POSIX-style paths."
---

# `posixpath`

Lexical path operations for POSIX-style paths.

> 💡 Python `posixpath`-style behavior, ported to Lua.

## Usage

```lua
posixpath = require "mods.posixpath"

print(posixpath.join("/usr", "bin"))               --> "/usr/bin"
print(posixpath.normpath("/a//./b/.."))            --> "/a"
print(posixpath.splitext("archive.tar.gz"))        --> "archive.tar", ".gz"
print(posixpath.relpath("/usr/local/bin", "/usr")) --> "local/bin"
```

> ✨ Same API as [`mods.path`](/modules/path), but with POSIX path semantics.
