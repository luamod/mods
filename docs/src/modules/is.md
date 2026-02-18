---
description:
  Type, truthiness, callable, and filesystem path predicates for Lua values.
---

# `is`

Type predicates for Lua values and filesystem paths.

## Import

```lua
local mods = require("mods")
local is = mods.is
```

## Usage

```lua
local ok

ok = is.number(3.14) --> true
ok = is("hello", "string") --> true
ok = is.Table({}) --> true
```

> [!NOTE]
>
> - Function names exist in both lowercase and capitalized forms (for example,
>   `is.table` or `is.Table`).
> - `is` is callable as `is(v, tp)` where `v` is the value and `tp` is any
>   supported type name.

## Quick Reference

**Type Checks**:

| Function                       | Description                            |
| ------------------------------ | -------------------------------------- |
| [`boolean(v)`](#fn-booleanv)   | Returns `true` when `v` is a boolean.  |
| [`Function(v)`](#fn-functionv) | Returns `true` when `v` is a function. |
| [`Nil(v)`](#fn-nilv)           | Returns `true` when `v` is `nil`.      |
| [`number(v)`](#fn-numberv)     | Returns `true` when `v` is a number.   |
| [`string(v)`](#fn-stringv)     | Returns `true` when `v` is a string.   |
| [`table(v)`](#fn-tablev)       | Returns `true` when `v` is a table.    |
| [`thread(v)`](#fn-threadv)     | Returns `true` when `v` is a thread.   |
| [`userdata(v)`](#fn-userdatav) | Returns `true` when `v` is userdata.   |

**Value Checks**:

| Function                       | Description                                 |
| ------------------------------ | ------------------------------------------- |
| [`False(v)`](#fn-falsev)       | Returns `true` when `v` is exactly `false`. |
| [`True(v)`](#fn-truev)         | Returns `true` when `v` is exactly `true`.  |
| [`falsy(v)`](#fn-falsyv)       | Returns `true` when `v` is falsy.           |
| [`callable(v)`](#fn-callablev) | Returns `true` when `v` is callable.        |
| [`integer(v)`](#fn-integerv)   | Returns `true` when `v` is an integer.      |
| [`truthy(v)`](#fn-truthyv)     | Returns `true` when `v` is truthy.          |

**Path Checks**:

| Function                   | Description                                             |
| -------------------------- | ------------------------------------------------------- |
| [`block(v)`](#fn-blockv)   | Returns `true` when `v` is a block device path.         |
| [`char(v)`](#fn-charv)     | Returns `true` when `v` is a char device path.          |
| [`device(v)`](#fn-devicev) | Returns `true` when `v` is a block or char device path. |
| [`dir(v)`](#fn-dirv)       | Returns `true` when `v` is a directory path.            |
| [`fifo(v)`](#fn-fifov)     | Returns `true` when `v` is a FIFO path.                 |
| [`file(v)`](#fn-filev)     | Returns `true` when `v` is a file path.                 |
| [`link(v)`](#fn-linkv)     | Returns `true` when `v` is a symlink path.              |
| [`socket(v)`](#fn-socketv) | Returns `true` when `v` is a socket path.               |

## Functions

### Type Checks

#### `boolean(v)` {#fn-booleanv}

Returns `true` when `v` is a boolean.

```lua
is.boolean(true) --> true
```

#### `Function(v)` {#fn-functionv}

Returns `true` when `v` is a function.

```lua
is.Function(function() end) --> true
```

#### `Nil(v)` {#fn-nilv}

Returns `true` when `v` is `nil`.

```lua
is.Nil(nil) --> true
```

#### `number(v)` {#fn-numberv}

Returns `true` when `v` is a number.

```lua
is.number(3.14) --> true
```

#### `string(v)` {#fn-stringv}

Returns `true` when `v` is a string.

```lua
is.string("hello") --> true
```

#### `table(v)` {#fn-tablev}

Returns `true` when `v` is a table.

```lua
is.table({}) --> true
```

#### `thread(v)` {#fn-threadv}

Returns `true` when `v` is a thread.

```lua
is.thread(coroutine.create(function() end)) --> true
```

#### `userdata(v)` {#fn-userdatav}

Returns `true` when `v` is userdata.

```lua
is.userdata(io.stdout) --> true
```

### Value Checks

#### `False(v)` {#fn-falsev}

Returns `true` when `v` is exactly `false`.

```lua
is.False(false) --> true
```

#### `True(v)` {#fn-truev}

Returns `true` when `v` is exactly `true`.

```lua
is.True(true) --> true
```

#### `falsy(v)` {#fn-falsyv}

Returns `true` when `v` is falsy.

```lua
is.falsy(false) --> true
```

#### `callable(v)` {#fn-callablev}

Returns `true` when `v` is callable.

```lua
is.callable(function() end) --> true
```

#### `integer(v)` {#fn-integerv}

Returns `true` when `v` is an integer.

```lua
is.integer(42) --> true
```

#### `truthy(v)` {#fn-truthyv}

Returns `true` when `v` is truthy.

```lua
is.truthy("non-empty") --> true
```

### Path Checks

> [!IMPORTANT]
>
> Path checks require **LuaFileSystem**
> ([`lfs`](https://github.com/lunarmodules/luafilesystem)).
>
> These functions raise an error if `lfs` is not installed.

#### `block(v)` {#fn-blockv}

Returns `true` when `v` is a block device path.

```lua
is.block("/dev/sda")
```

#### `char(v)` {#fn-charv}

Returns `true` when `v` is a char device path.

```lua
is.char("/dev/null")
```

#### `device(v)` {#fn-devicev}

Returns `true` when `v` is a block or char device path.

```lua
is.device("/dev/null")
```

#### `dir(v)` {#fn-dirv}

Returns `true` when `v` is a directory path.

```lua
is.dir("/tmp")
```

#### `fifo(v)` {#fn-fifov}

Returns `true` when `v` is a FIFO path.

```lua
is.fifo("/path/to/fifo")
```

#### `file(v)` {#fn-filev}

Returns `true` when `v` is a file path.

```lua
is.file("README.md")
```

#### `link(v)` {#fn-linkv}

Returns `true` when `v` is a symlink path.

```lua
is.link("/path/to/link")
```

#### `socket(v)` {#fn-socketv}

Returns `true` when `v` is a socket path.

```lua
is.socket("/path/to/socket")
```
