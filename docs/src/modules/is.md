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
> Function names are case-insensitive.
>
> ```lua
> is.table({})  --> true
> is.Table({})  --> true
> is.tAbLe({})  --> true
> ```

## `is()`

`is` is also callable as `is(value, type)` to check if a value is of a given
type.

```lua
is("hello", "string") --> true
is("hello", "String") --> true
is("hello", "STRING") --> true
```

## Functions

**Type Checks**:

| Function                      | Description                            |
| ----------------------------- | -------------------------------------- |
| [`boolean(v)`](#fn-boolean)   | Returns `true` when `v` is a boolean.  |
| [`function(v)`](#fn-function) | Returns `true` when `v` is a function. |
| [`nil(v)`](#fn-nil)           | Returns `true` when `v` is `nil`.      |
| [`number(v)`](#fn-number)     | Returns `true` when `v` is a number.   |
| [`string(v)`](#fn-string)     | Returns `true` when `v` is a string.   |
| [`table(v)`](#fn-table)       | Returns `true` when `v` is a table.    |
| [`thread(v)`](#fn-thread)     | Returns `true` when `v` is a thread.   |
| [`userdata(v)`](#fn-userdata) | Returns `true` when `v` is userdata.   |

**Value Checks**:

| Function                      | Description                                 |
| ----------------------------- | ------------------------------------------- |
| [`false(v)`](#fn-false)       | Returns `true` when `v` is exactly `false`. |
| [`true(v)`](#fn-true)         | Returns `true` when `v` is exactly `true`.  |
| [`falsy(v)`](#fn-falsy)       | Returns `true` when `v` is falsy.           |
| [`callable(v)`](#fn-callable) | Returns `true` when `v` is callable.        |
| [`integer(v)`](#fn-integer)   | Returns `true` when `v` is an integer.      |
| [`truthy(v)`](#fn-truthy)     | Returns `true` when `v` is truthy.          |

**Path Checks**:

| Function                  | Description                                             |
| ------------------------- | ------------------------------------------------------- |
| [`block(v)`](#fn-block)   | Returns `true` when `v` is a block device path.         |
| [`char(v)`](#fn-char)     | Returns `true` when `v` is a char device path.          |
| [`device(v)`](#fn-device) | Returns `true` when `v` is a block or char device path. |
| [`dir(v)`](#fn-dir)       | Returns `true` when `v` is a directory path.            |
| [`fifo(v)`](#fn-fifo)     | Returns `true` when `v` is a FIFO path.                 |
| [`file(v)`](#fn-file)     | Returns `true` when `v` is a file path.                 |
| [`link(v)`](#fn-link)     | Returns `true` when `v` is a symlink path.              |
| [`socket(v)`](#fn-socket) | Returns `true` when `v` is a socket path.               |

### Type Checks

Core Lua type checks (`type(v)` family). <a id="fn-boolean"></a>

#### `boolean(v)`

Returns `true` when `v` is a boolean.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.boolean(true)
```

<a id="fn-function"></a>

#### `function(v)`

Returns `true` when `v` is a function.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.Function(function() end)
```

<a id="fn-nil"></a>

#### `nil(v)`

Returns `true` when `v` is `nil`.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.Nil(nil)
```

<a id="fn-number"></a>

#### `number(v)`

Returns `true` when `v` is a number.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.number(3.14)
```

<a id="fn-string"></a>

#### `string(v)`

Returns `true` when `v` is a string.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.string("hello")
```

<a id="fn-table"></a>

#### `table(v)`

Returns `true` when `v` is a table.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.table({})
```

<a id="fn-thread"></a>

#### `thread(v)`

Returns `true` when `v` is a thread.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.thread(coroutine.create(function() end))
```

<a id="fn-userdata"></a>

#### `userdata(v)`

Returns `true` when `v` is userdata.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.userdata(io.stdout)
```

### Value Checks

Truthiness, exact-value, and callable checks. <a id="fn-false"></a>

#### `false(v)`

Returns `true` when `v` is exactly `false`.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.False(false)
```

<a id="fn-true"></a>

#### `true(v)`

Returns `true` when `v` is exactly `true`.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.True(true)
```

<a id="fn-falsy"></a>

#### `falsy(v)`

Returns `true` when `v` is falsy.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.falsy(false)
```

<a id="fn-callable"></a>

#### `callable(v)`

Returns `true` when `v` is callable.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.callable(function() end)
```

<a id="fn-integer"></a>

#### `integer(v)`

Returns `true` when `v` is an integer.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.integer(42)
```

<a id="fn-truthy"></a>

#### `truthy(v)`

Returns `true` when `v` is truthy.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.truthy("non-empty")
```

### Path Checks

Filesystem path kind checks.

> [!IMPORTANT]
>
> Path checks require **LuaFileSystem**
> ([`lfs`](https://github.com/lunarmodules/luafilesystem)) and raise an error it
> is not installed. <a id="fn-block"></a>

#### `block(v)`

Returns `true` when `v` is a block device path.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.block("/dev/sda")
```

<a id="fn-char"></a>

#### `char(v)`

Returns `true` when `v` is a char device path.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.char("/dev/null")
```

<a id="fn-device"></a>

#### `device(v)`

Returns `true` when `v` is a block or char device path.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.device("/dev/null")
```

<a id="fn-dir"></a>

#### `dir(v)`

Returns `true` when `v` is a directory path.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.dir("/tmp")
```

<a id="fn-fifo"></a>

#### `fifo(v)`

Returns `true` when `v` is a FIFO path.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.fifo("/path/to/fifo")
```

<a id="fn-file"></a>

#### `file(v)`

Returns `true` when `v` is a file path.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.file("README.md")
```

<a id="fn-link"></a>

#### `link(v)`

Returns `true` when `v` is a symlink path.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.link("/path/to/link")
```

<a id="fn-socket"></a>

#### `socket(v)`

Returns `true` when `v` is a socket path.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
is.socket("/path/to/socket")
```
