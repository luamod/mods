---
desc: "Type predicates for Lua values and filesystem path kinds."
---

# `is`

Type predicates for Lua values and filesystem path kinds.

## Usage

```lua
is = require "mods.is"

ok = is.number(3.14)       --> true
ok = is("hello", "string") --> true
ok = is.table({})          --> true
```

> [!NOTE]
>
> Function names exist in both lowercase and capitalized forms, and `is` is also
> callable as `is(v, tp)`.
>
> ```lua
> is.table({})          --> true
> is.Table({})          --> true
> is("hello", "string") --> true
> is("hello", "String") --> true
> ```

## Functions

**Type Checks**:

| Function                | Description                            |
| ----------------------- | -------------------------------------- |
| [`boolean`](#boolean)   | Returns `true` when `v` is a boolean.  |
| [`Function`](#function) | Returns `true` when `v` is a function. |
| [`Nil`](#nil)           | Returns `true` when `v` is `nil`.      |
| [`number`](#number)     | Returns `true` when `v` is a number.   |
| [`string`](#string)     | Returns `true` when `v` is a string.   |
| [`table`](#table)       | Returns `true` when `v` is a table.    |
| [`thread`](#thread)     | Returns `true` when `v` is a thread.   |
| [`userdata`](#userdata) | Returns `true` when `v` is userdata.   |

**Value Checks**:

| Function                | Description                                 |
| ----------------------- | ------------------------------------------- |
| [`False`](#false)       | Returns `true` when `v` is exactly `false`. |
| [`True`](#true)         | Returns `true` when `v` is exactly `true`.  |
| [`falsy`](#falsy)       | Returns `true` when `v` is falsy.           |
| [`callable`](#callable) | Returns `true` when `v` is callable.        |
| [`integer`](#integer)   | Returns `true` when `v` is an integer.      |
| [`truthy`](#truthy)     | Returns `true` when `v` is truthy.          |

**Path Checks**:

| Function            | Description                                             |
| ------------------- | ------------------------------------------------------- |
| [`block`](#block)   | Returns `true` when `v` is a block device path.         |
| [`char`](#char)     | Returns `true` when `v` is a char device path.          |
| [`device`](#device) | Returns `true` when `v` is a block or char device path. |
| [`dir`](#dir)       | Returns `true` when `v` is a directory path.            |
| [`fifo`](#fifo)     | Returns `true` when `v` is a FIFO path.                 |
| [`file`](#file)     | Returns `true` when `v` is a file path.                 |
| [`link`](#link)     | Returns `true` when `v` is a symlink path.              |
| [`socket`](#socket) | Returns `true` when `v` is a socket path.               |

### Type Checks

Core Lua type checks (`type(v)` family).

#### `boolean`

Returns `true` when `v` is a boolean.

```lua
is.boolean(true)
```

#### `Function`

Returns `true` when `v` is a function.

```lua
is.Function(function() end)
```

#### `Nil`

Returns `true` when `v` is `nil`.

```lua
is.Nil(nil)
```

#### `number`

Returns `true` when `v` is a number.

```lua
is.number(3.14)
```

#### `string`

Returns `true` when `v` is a string.

```lua
is.string("hello")
```

#### `table`

Returns `true` when `v` is a table.

```lua
is.table({})
```

#### `thread`

Returns `true` when `v` is a thread.

```lua
is.thread(coroutine.create(function() end))
```

#### `userdata`

Returns `true` when `v` is userdata.

```lua
is.userdata(io.stdout)
```

### Value Checks

Truthiness, exact-value, and callable checks.

#### `False`

Returns `true` when `v` is exactly `false`.

```lua
is.False(false)
```

#### `True`

Returns `true` when `v` is exactly `true`.

```lua
is.True(true)
```

#### `falsy`

Returns `true` when `v` is falsy.

```lua
is.falsy(false)
```

#### `callable`

Returns `true` when `v` is callable.

```lua
is.callable(function() end)
```

#### `integer`

Returns `true` when `v` is an integer.

```lua
is.integer(42)
```

#### `truthy`

Returns `true` when `v` is truthy.

```lua
is.truthy("non-empty")
```

### Path Checks

Filesystem path kind checks.

> [!IMPORTANT]
>
> Path checks require **LuaFileSystem**
> ([`lfs`](https://github.com/lunarmodules/luafilesystem)) and raise an error it
> is not installed.

#### `block`

Returns `true` when `v` is a block device path.

Raises an error if [`lfs`](https://github.com/lunarmodules/luafilesystem) is not
installed.

```lua
is.block("/dev/sda")
```

#### `char`

Returns `true` when `v` is a char device path.

```lua
is.char("/dev/null")
```

#### `device`

Returns `true` when `v` is a block or char device path.

```lua
is.device("/dev/null")
```

#### `dir`

Returns `true` when `v` is a directory path.

```lua
is.dir("/tmp")
```

#### `fifo`

Returns `true` when `v` is a FIFO path.

```lua
is.fifo("/path/to/fifo")
```

#### `file`

Returns `true` when `v` is a file path.

```lua
is.file("README.md")
```

#### `link`

Returns `true` when `v` is a symlink path.

```lua
is.link("/path/to/link")
```

#### `socket`

Returns `true` when `v` is a socket path.

```lua
is.socket("/path/to/socket")
```
