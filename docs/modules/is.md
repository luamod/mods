---
description:
  Type, truthiness, callable, and filesystem path predicates for Lua values.
---

# `is`

Type predicates for Lua values and filesystem path kinds.

Function names exist in both lowercase and capitalized forms (for example,
`is.table` or `is.Table`).

`is` is callable as `is(v, tp)` where `v` is the value and `tp` is any supported
type name.

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

::: code-group

```lua [example.lua]
is.boolean(true)
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function boolean(v) end
```

:::

#### `Function(v)` {#fn-functionv}

Returns `true` when `v` is a function.

::: code-group

```lua [example.lua]
is.Function(function() end)
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function Function(v) end
```

:::

#### `Nil(v)` {#fn-nilv}

Returns `true` when `v` is `nil`.

::: code-group

```lua [example.lua]
is.Nil(nil)
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function Nil(v) end
```

:::

#### `number(v)` {#fn-numberv}

Returns `true` when `v` is a number.

::: code-group

```lua [example.lua]
is.number(3.14)
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function number(v) end
```

:::

#### `string(v)` {#fn-stringv}

Returns `true` when `v` is a string.

::: code-group

```lua [example.lua]
is.string("hello")
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function string(v) end
```

:::

#### `table(v)` {#fn-tablev}

Returns `true` when `v` is a table.

::: code-group

```lua [example.lua]
is.table({})
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function table(v) end
```

:::

#### `thread(v)` {#fn-threadv}

Returns `true` when `v` is a thread.

::: code-group

```lua [example.lua]
is.thread(coroutine.create(function() end))
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function thread(v) end
```

:::

#### `userdata(v)` {#fn-userdatav}

Returns `true` when `v` is userdata.

::: code-group

```lua [example.lua]
is.userdata(io.stdout)
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function userdata(v) end
```

:::

### Value Checks

#### `False(v)` {#fn-falsev}

Returns `true` when `v` is exactly `false`.

::: code-group

```lua [example.lua]
is.False(false)
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function False(v) end
```

:::

#### `True(v)` {#fn-truev}

Returns `true` when `v` is exactly `true`.

::: code-group

```lua [example.lua]
is.True(true)
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function True(v) end
```

:::

#### `falsy(v)` {#fn-falsyv}

Returns `true` when `v` is falsy.

::: code-group

```lua [example.lua]
is.falsy(false)
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function falsy(v) end
```

:::

#### `callable(v)` {#fn-callablev}

Returns `true` when `v` is callable.

::: code-group

```lua [example.lua]
is.callable(function() end)
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function callable(v) end
```

:::

#### `integer(v)` {#fn-integerv}

Returns `true` when `v` is an integer.

::: code-group

```lua [example.lua]
is.integer(42)
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function integer(v) end
```

:::

#### `truthy(v)` {#fn-truthyv}

Returns `true` when `v` is truthy.

::: code-group

```lua [example.lua]
is.truthy("non-empty")
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function truthy(v) end
```

:::

### Path Checks

> [!IMPORTANT]
>
> Path checks require LuaFileSystem
> ([`lfs`](https://github.com/lunarmodules/luafilesystem)).
>
> These functions raise an error if `lfs` is not installed.

#### `block(v)` {#fn-blockv}

Returns `true` when `v` is a block device path.

::: code-group

```lua [example.lua]
is.block("/dev/sda")
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function block(v) end
```

:::

#### `char(v)` {#fn-charv}

Returns `true` when `v` is a char device path.

::: code-group

```lua [example.lua]
is.char("/dev/null")
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function char(v) end
```

:::

#### `device(v)` {#fn-devicev}

Returns `true` when `v` is a block or char device path.

::: code-group

```lua [example.lua]
is.device("/dev/null")
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function device(v) end
```

:::

#### `dir(v)` {#fn-dirv}

Returns `true` when `v` is a directory path.

::: code-group

```lua [example.lua]
is.dir("/tmp")
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function dir(v) end
```

:::

#### `fifo(v)` {#fn-fifov}

Returns `true` when `v` is a FIFO path.

::: code-group

```lua [example.lua]
is.fifo("/path/to/fifo")
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function fifo(v) end
```

:::

#### `file(v)` {#fn-filev}

Returns `true` when `v` is a file path.

::: code-group

```lua [example.lua]
is.file("README.md")
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function file(v) end
```

:::

#### `link(v)` {#fn-linkv}

Returns `true` when `v` is a symlink path.

::: code-group

```lua [example.lua]
is.link("/path/to/link")
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function link(v) end
```

:::

#### `socket(v)` {#fn-socketv}

Returns `true` when `v` is a socket path.

::: code-group

```lua [example.lua]
is.socket("/path/to/socket")
```

```lua [signature.lua]
---@param v any
---@return boolean ok
---@nodiscard
function socket(v) end
```

:::
