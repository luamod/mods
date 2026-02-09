---
editLinkTarget: types/is.lua
---

# `is`

Type predicates for Lua values and filesystem path kinds. You can also call `is(v, tp)` with a string type name.

## Quick Reference

| Function                       | Description                                             |
| ------------------------------ | ------------------------------------------------------- |
| [`boolean(v)`](#fn-booleanv)   | Returns `true` when `v` is a boolean.                   |
| [`Function(v)`](#fn-functionv) | Returns `true` when `v` is a function.                  |
| [`Nil(v)`](#fn-nilv)           | Returns `true` when `v` is `nil`.                       |
| [`number(v)`](#fn-numberv)     | Returns `true` when `v` is a number.                    |
| [`string(v)`](#fn-stringv)     | Returns `true` when `v` is a string.                    |
| [`table(v)`](#fn-tablev)       | Returns `true` when `v` is a table.                     |
| [`thread(v)`](#fn-threadv)     | Returns `true` when `v` is a thread.                    |
| [`userdata(v)`](#fn-userdatav) | Returns `true` when `v` is userdata.                    |
| [`False(v)`](#fn-falsev)       | Returns `true` when `v` is exactly `false`.             |
| [`True(v)`](#fn-truev)         | Returns `true` when `v` is exactly `true`.              |
| [`falsy(v)`](#fn-falsyv)       | Returns `true` when `v` is falsy.                       |
| [`callable(v)`](#fn-callablev) | Returns `true` when `v` is callable.                    |
| [`integer(v)`](#fn-integerv)   | Returns `true` when `v` is an integer.                  |
| [`truthy(v)`](#fn-truthyv)     | Returns `true` when `v` is truthy.                      |
| [`block(v)`](#fn-blockv)       | Returns `true` when `v` is a block device path.         |
| [`char(v)`](#fn-charv)         | Returns `true` when `v` is a char device path.          |
| [`device(v)`](#fn-devicev)     | Returns `true` when `v` is a block or char device path. |
| [`dir(v)`](#fn-dirv)           | Returns `true` when `v` is a directory path.            |
| [`fifo(v)`](#fn-fifov)         | Returns `true` when `v` is a FIFO path.                 |
| [`file(v)`](#fn-filev)         | Returns `true` when `v` is a file path.                 |
| [`link(v)`](#fn-linkv)         | Returns `true` when `v` is a symlink path.              |
| [`socket(v)`](#fn-socketv)     | Returns `true` when `v` is a socket path.               |

## Functions

#### `boolean(v)` {#fn-booleanv}

Returns `true` when `v` is a boolean.

:::tabs
== Example

```lua
is.boolean(true)
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function boolean(v) end
```

:::

#### `Function(v)` {#fn-functionv}

Returns `true` when `v` is a function.

:::tabs
== Example

```lua
is.Function(function() end)
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function Function(v) end
```

:::

#### `Nil(v)` {#fn-nilv}

Returns `true` when `v` is `nil`.

:::tabs
== Example

```lua
is.Nil(nil)
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function Nil(v) end
```

:::

#### `number(v)` {#fn-numberv}

Returns `true` when `v` is a number.

:::tabs
== Example

```lua
is.number(3.14)
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function number(v) end
```

:::

#### `string(v)` {#fn-stringv}

Returns `true` when `v` is a string.

:::tabs
== Example

```lua
is.string("hello")
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function string(v) end
```

:::

#### `table(v)` {#fn-tablev}

Returns `true` when `v` is a table.

:::tabs
== Example

```lua
is.table({})
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function table(v) end
```

:::

#### `thread(v)` {#fn-threadv}

Returns `true` when `v` is a thread.

:::tabs
== Example

```lua
is.thread(coroutine.create(function() end))
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function thread(v) end
```

:::

#### `userdata(v)` {#fn-userdatav}

Returns `true` when `v` is userdata.

:::tabs
== Example

```lua
is.userdata(io.stdout)
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function userdata(v) end
```

:::

#### `False(v)` {#fn-falsev}

Returns `true` when `v` is exactly `false`.

:::tabs
== Example

```lua
is.False(false)
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function False(v) end
```

:::

#### `True(v)` {#fn-truev}

Returns `true` when `v` is exactly `true`.

:::tabs
== Example

```lua
is.True(true)
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function True(v) end
```

:::

#### `falsy(v)` {#fn-falsyv}

Returns `true` when `v` is falsy.

:::tabs
== Example

```lua
is.falsy(false)
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function falsy(v) end
```

:::

#### `callable(v)` {#fn-callablev}

Returns `true` when `v` is callable.

:::tabs
== Example

```lua
is.callable(function() end)
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function callable(v) end
```

:::

#### `integer(v)` {#fn-integerv}

Returns `true` when `v` is an integer.

:::tabs
== Example

```lua
is.integer(42)
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function integer(v) end
```

:::

#### `truthy(v)` {#fn-truthyv}

Returns `true` when `v` is truthy.

:::tabs
== Example

```lua
is.truthy("non-empty")
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function truthy(v) end
```

:::

#### `block(v)` {#fn-blockv}

Returns `true` when `v` is a block device path.

Raises an error if [`lfs`](https://github.com/lunarmodules/luafilesystem) is not installed.

> [!IMPORTANT]
> Requires [`lfs`](https://github.com/lunarmodules/luafilesystem).

:::tabs
== Example

```lua
is.block("/dev/sda")
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function block(v) end
```

:::

#### `char(v)` {#fn-charv}

Returns `true` when `v` is a char device path.

Raises an error if [`lfs`](https://github.com/lunarmodules/luafilesystem) is not installed.

> [!IMPORTANT]
> Requires [`lfs`](https://github.com/lunarmodules/luafilesystem).

:::tabs
== Example

```lua
is.char("/dev/null")
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function char(v) end
```

:::

#### `device(v)` {#fn-devicev}

Returns `true` when `v` is a block or char device path.

Raises an error if [`lfs`](https://github.com/lunarmodules/luafilesystem) is not installed.

> [!IMPORTANT]
> Requires [`lfs`](https://github.com/lunarmodules/luafilesystem).

:::tabs
== Example

```lua
is.device("/dev/null")
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function device(v) end
```

:::

#### `dir(v)` {#fn-dirv}

Returns `true` when `v` is a directory path.

Raises an error if [`lfs`](https://github.com/lunarmodules/luafilesystem) is not installed.

> [!IMPORTANT]
> Requires [`lfs`](https://github.com/lunarmodules/luafilesystem).

:::tabs
== Example

```lua
is.dir("/tmp")
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function dir(v) end
```

:::

#### `fifo(v)` {#fn-fifov}

Returns `true` when `v` is a FIFO path.

Raises an error if [`lfs`](https://github.com/lunarmodules/luafilesystem) is not installed.

> [!IMPORTANT]
> Requires [`lfs`](https://github.com/lunarmodules/luafilesystem).

:::tabs
== Example

```lua
is.fifo("/path/to/fifo")
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function fifo(v) end
```

:::

#### `file(v)` {#fn-filev}

Returns `true` when `v` is a file path.

Raises an error if [`lfs`](https://github.com/lunarmodules/luafilesystem) is not installed.

> [!IMPORTANT]
> Requires [`lfs`](https://github.com/lunarmodules/luafilesystem).

:::tabs
== Example

```lua
is.file("README.md")
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function file(v) end
```

:::

#### `link(v)` {#fn-linkv}

Returns `true` when `v` is a symlink path.

Raises an error if [`lfs`](https://github.com/lunarmodules/luafilesystem) is not installed.

> [!IMPORTANT]
> Requires [`lfs`](https://github.com/lunarmodules/luafilesystem).

:::tabs
== Example

```lua
is.link("/path/to/link")
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function link(v) end
```

:::

#### `socket(v)` {#fn-socketv}

Returns `true` when `v` is a socket path.

Raises an error if [`lfs`](https://github.com/lunarmodules/luafilesystem) is not installed.

> [!IMPORTANT]
> Requires [`lfs`](https://github.com/lunarmodules/luafilesystem).

:::tabs
== Example

```lua
is.socket("/path/to/socket")
```

== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function socket(v) end
```

:::
