---
description: "Filesystem I/O and metadata operations."
---

# `fs`

Filesystem I/O and metadata operations.

## Usage

```lua
fs = require "mods.fs"

fs.mkdir("tmp/cache/app", true)
```

## Functions

| Function   | Description                                        |
| ---------- | -------------------------------------------------- |
| `getcwd`   | Alias of `lfs.currentdir`                          |
| `isblock`  | Alias of [`mods.is.block`](/modules/is#fn-block)   |
| `ischar`   | Alias of [`mods.is.char`](/modules/is#fn-char)     |
| `isdevice` | Alias of [`mods.is.device`](/modules/is#fn-device) |
| `isdir`    | Alias of [`mods.is.dir`](/modules/is#fn-dir)       |
| `isfifo`   | Alias of [`mods.is.fifo`](/modules/is#fn-fifo)     |
| `isfile`   | Alias of [`mods.is.file`](/modules/is#fn-file)     |
| `islink`   | Alias of [`mods.is.link`](/modules/is#fn-link)     |
| `issocket` | Alias of [`mods.is.socket`](/modules/is#fn-socket) |
| `lstat`    | Alias of `lfs.symlinkattributes`                   |
| `rmdir`    | Alias of `lfs.rmdir`                               |
| `stat`     | Alias of `lfs.attributes`                          |
