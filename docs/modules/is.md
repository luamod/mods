---
editLinkTarget: types/is.lua
---

# is

Type predicates for Lua values and filesystem path kinds. You can also call `is(v, tp)` with a string type name.

## Quick Reference

| Function                       | Description                                             |
| ------------------------------ | ------------------------------------------------------- |
| [`boolean(v)`](#fn-booleanv)   | Returns `true` when `v` is a boolean.                   |
| [`function(v)`](#fn-functionv) | Returns `true` when `v` is a function.                  |
| [`nil(v)`](#fn-nilv)           | Returns `true` when `v` is `nil`.                       |
| [`number(v)`](#fn-numberv)     | Returns `true` when `v` is a number.                    |
| [`string(v)`](#fn-stringv)     | Returns `true` when `v` is a string.                    |
| [`table(v)`](#fn-tablev)       | Returns `true` when `v` is a table.                     |
| [`thread(v)`](#fn-threadv)     | Returns `true` when `v` is a thread.                    |
| [`userdata(v)`](#fn-userdatav) | Returns `true` when `v` is userdata.                    |
| [`false(v)`](#fn-falsev)       | Returns `true` when `v` is exactly `false`.             |
| [`true(v)`](#fn-truev)         | Returns `true` when `v` is exactly `true`.              |
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
== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function boolean(v) end
```

:::

#### `function(v)` {#fn-functionv}

Returns `true` when `v` is a function.

:::tabs
== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function function(v) end
```

:::

#### `nil(v)` {#fn-nilv}

Returns `true` when `v` is `nil`.

:::tabs
== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function nil(v) end
```

:::

#### `number(v)` {#fn-numberv}

Returns `true` when `v` is a number.

:::tabs
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
== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function userdata(v) end
```

:::

#### `false(v)` {#fn-falsev}

Returns `true` when `v` is exactly `false`.

:::tabs
== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function false(v) end
```

:::

#### `true(v)` {#fn-truev}

Returns `true` when `v` is exactly `true`.

:::tabs
== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function true(v) end
```

:::

#### `falsy(v)` {#fn-falsyv}

Returns `true` when `v` is falsy.

:::tabs
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

**Important**: Requires `lfs`.

:::tabs
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

**Important**: Requires `lfs`.

:::tabs
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

**Important**: Requires `lfs`.

:::tabs
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

**Important**: Requires `lfs`.

:::tabs
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

**Important**: Requires `lfs`.

:::tabs
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

**Important**: Requires `lfs`.

:::tabs
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

**Important**: Requires `lfs`.

:::tabs
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

**Important**: Requires `lfs`.

:::tabs
== Signature

```lua
---@param v any
---@return boolean ok
---@nodiscard
function socket(v) end
```

:::
