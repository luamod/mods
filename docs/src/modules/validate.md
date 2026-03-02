---
desc: "Validation checks for values and filesystem path types."
---

# `validate`

Validation checks for values and filesystem path types.

## Usage

```lua
local validate = require "mods.validate"

ok, err = validate.number("nope") --> false, "expected number, got string"
ok, err = validate(123, "number") --> true, nil
```

## `validate()`

`validate(v, tp)` dispatches to the registered validator `tp`. If `tp` is
omitted, it defaults to `"truthy"`.

```lua
validate()         --> false, "expected truthy value, got no value"
validate(1)        --> true, nil
validate(1, "nil") --> false, "expected nil, got number"
```

## Validator Names

Validator names are case-insensitive for field access.

```lua
validate.number(1) --> true, nil
validate.NumBer(1) --> true, nil
```

`tp` in `validate(v, tp)` is matched as-is (case-sensitive):

```lua
validate(1, "number") --> true, nil
validate(1, "NuMbEr") --> false, "expected NuMbEr, got number"
```

## Functions

**Type Checks**:

| Function                      | Description                                                                                  |
| ----------------------------- | -------------------------------------------------------------------------------------------- |
| [`boolean(v)`](#fn-boolean)   | Returns `true` when `v` is a boolean. Otherwise returns `false` and an error message.        |
| [`function(v)`](#fn-function) | Returns `true` when `v` is a function. Otherwise returns `false` and an error message.       |
| [`nil(v)`](#fn-nil)           | Returns `true` when `v` is `nil`. Otherwise returns `false` and an error message.            |
| [`number(v)`](#fn-number)     | Returns `true` when `v` is a number. Otherwise returns `false` and an error message.         |
| [`string(v)`](#fn-string)     | Returns `true` when `v` is a string. Otherwise returns `false` and an error message.         |
| [`table(v)`](#fn-table)       | Returns `true` when `v` is a table. Otherwise returns `false` and an error message.          |
| [`thread(v)`](#fn-thread)     | Returns `true` when `v` is a thread. Otherwise returns `false` and an error message.         |
| [`userdata(v)`](#fn-userdata) | Returns `true` when `v` is a userdata value. Otherwise returns `false` and an error message. |

**Value Checks**:

| Function                      | Description                                                                                 |
| ----------------------------- | ------------------------------------------------------------------------------------------- |
| [`false(v)`](#fn-false)       | Returns `true` when `v` is exactly `false`. Otherwise returns `false` and an error message. |
| [`true(v)`](#fn-true)         | Returns `true` when `v` is exactly `true`. Otherwise returns `false` and an error message.  |
| [`falsy(v)`](#fn-falsy)       | Returns `true` when `v` is falsy. Otherwise returns `false` and an error message.           |
| [`callable(v)`](#fn-callable) | Returns `true` when `v` is callable. Otherwise returns `false` and an error message.        |
| [`integer(v)`](#fn-integer)   | Returns `true` when `v` is an integer. Otherwise returns `false` and an error message.      |
| [`truthy(v)`](#fn-truthy)     | Returns `true` when `v` is truthy. Otherwise returns `false` and an error message.          |

**Path Checks**:

| Function                  | Description                                                                                             |
| ------------------------- | ------------------------------------------------------------------------------------------------------- |
| [`block(v)`](#fn-block)   | Returns `true` when `v` is a block device path. Otherwise returns `false` and an error message.         |
| [`char(v)`](#fn-char)     | Returns `true` when `v` is a char device path. Otherwise returns `false` and an error message.          |
| [`device(v)`](#fn-device) | Returns `true` when `v` is a block or char device path. Otherwise returns `false` and an error message. |
| [`dir(v)`](#fn-dir)       | Returns `true` when `v` is a directory path. Otherwise returns `false` and an error message.            |
| [`fifo(v)`](#fn-fifo)     | Returns `true` when `v` is a FIFO path. Otherwise returns `false` and an error message.                 |
| [`file(v)`](#fn-file)     | Returns `true` when `v` is a file path. Otherwise returns `false` and an error message.                 |
| [`link(v)`](#fn-link)     | Returns `true` when `v` is a symlink path. Otherwise returns `false` and an error message.              |
| [`socket(v)`](#fn-socket) | Returns `true` when `v` is a socket path. Otherwise returns `false` and an error message.               |

**Validator API**:

| Function                                      | Description                                        |
| --------------------------------------------- | -------------------------------------------------- |
| [`register(name, check, msg?)`](#fn-register) | Register or override a validator function by name. |

### Type Checks

Basic Lua type validators (and their negated variants). <a id="fn-boolean"></a>

#### `boolean(v)`

Returns `true` when `v` is a boolean. Otherwise returns `false` and an error
message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.boolean(true) --> true, nil
ok, err = validate.boolean(1)    --> false, "expected boolean, got number"
```

<a id="fn-function"></a>

#### `function(v)`

Returns `true` when `v` is a function. Otherwise returns `false` and an error
message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.Function(function() end) --> true, nil
ok, err = validate.Function(1)
--> false, "expected function, got number"
```

<a id="fn-nil"></a>

#### `nil(v)`

Returns `true` when `v` is `nil`. Otherwise returns `false` and an error
message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.Nil(nil) --> true, nil
ok, err = validate.Nil(0)   --> false, "expected nil, got number"
```

<a id="fn-number"></a>

#### `number(v)`

Returns `true` when `v` is a number. Otherwise returns `false` and an error
message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.number(42)  --> true, nil
ok, err = validate.number("x") --> false, "expected number, got string"
```

<a id="fn-string"></a>

#### `string(v)`

Returns `true` when `v` is a string. Otherwise returns `false` and an error
message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.string("hello") --> true, nil
ok, err = validate.string(1)       --> false, "expected string, got number"
```

<a id="fn-table"></a>

#### `table(v)`

Returns `true` when `v` is a table. Otherwise returns `false` and an error
message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.table({}) --> true, nil
ok, err = validate.table(1)  --> false, "expected table, got number"
```

<a id="fn-thread"></a>

#### `thread(v)`

Returns `true` when `v` is a thread. Otherwise returns `false` and an error
message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
co = coroutine.create(function() end)
ok, err = validate.thread(co) --> true, nil
ok, err = validate.thread(1)  --> false, "expected thread, got number"
```

<a id="fn-userdata"></a>

#### `userdata(v)`

Returns `true` when `v` is a userdata value. Otherwise returns `false` and an
error message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.userdata(io.stdout) --> true, nil
ok, err = validate.userdata(1)         --> false, "expected userdata, got number"
```

### Value Checks

Value-state validators (exact true/false, truthy/falsy, callable, integer).
<a id="fn-false"></a>

#### `false(v)`

Returns `true` when `v` is exactly `false`. Otherwise returns `false` and an
error message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.False(false) --> true, nil
ok, err = validate.False(true)  --> false, "expected false, got true"
```

<a id="fn-true"></a>

#### `true(v)`

Returns `true` when `v` is exactly `true`. Otherwise returns `false` and an
error message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.True(true)  --> true, nil
ok, err = validate.True(false) --> false, "expected true, got false"
```

<a id="fn-falsy"></a>

#### `falsy(v)`

Returns `true` when `v` is falsy. Otherwise returns `false` and an error
message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.falsy(false) --> true, nil
ok, err = validate.falsy(1)     --> false, "expected falsy, got number"
```

<a id="fn-callable"></a>

#### `callable(v)`

Returns `true` when `v` is callable. Otherwise returns `false` and an error
message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.callable(type) --> true, nil
ok, err = validate.callable(1)    --> false, "expected callable, got number"
```

<a id="fn-integer"></a>

#### `integer(v)`

Returns `true` when `v` is an integer. Otherwise returns `false` and an error
message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.integer(1)   --> true, nil
ok, err = validate.integer(1.5) --> false, "expected integer, got 1.5"
```

<a id="fn-truthy"></a>

#### `truthy(v)`

Returns `true` when `v` is truthy. Otherwise returns `false` and an error
message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.truthy(1)     --> true, nil
ok, err = validate.truthy(false) --> false, "expected truthy, got boolean"
```

### Path Checks

Filesystem path-kind validators backed by LuaFileSystem (`lfs`).

> [!IMPORTANT]
>
> Path checks require **LuaFileSystem**
> ([`lfs`](https://github.com/lunarmodules/luafilesystem)) and raise an error if
> it is not installed. <a id="fn-block"></a>

#### `block(v)`

Returns `true` when `v` is a block device path. Otherwise returns `false` and an
error message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.block(".")
```

<a id="fn-char"></a>

#### `char(v)`

Returns `true` when `v` is a char device path. Otherwise returns `false` and an
error message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.char(".")
```

<a id="fn-device"></a>

#### `device(v)`

Returns `true` when `v` is a block or char device path. Otherwise returns
`false` and an error message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.device(".")
```

<a id="fn-dir"></a>

#### `dir(v)`

Returns `true` when `v` is a directory path. Otherwise returns `false` and an
error message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.dir(".")
```

<a id="fn-fifo"></a>

#### `fifo(v)`

Returns `true` when `v` is a FIFO path. Otherwise returns `false` and an error
message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.fifo(".")
```

<a id="fn-file"></a>

#### `file(v)`

Returns `true` when `v` is a file path. Otherwise returns `false` and an error
message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.file(".")
```

<a id="fn-link"></a>

#### `link(v)`

Returns `true` when `v` is a symlink path. Otherwise returns `false` and an
error message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.link(".")
```

<a id="fn-socket"></a>

#### `socket(v)`

Returns `true` when `v` is a socket path. Otherwise returns `false` and an error
message.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.
- `err` (`string?`): Error message when the check fails.

**Example**:

```lua
ok, err = validate.socket(".")
```

### Validator API

<a id="fn-register"></a>

#### `register(name, check, msg?)`

Register or override a validator function by name.

**Parameters**:

- `name` (`string`): Validator name.
- `check` (`fun(v:any):(ok:boolean)`): Validator function.
- `msg?` (`string`): Optional default message template.

**Return**:

- `none` (`nil`)

**Example**:

```lua
validate.register("odd", function(v)
  return type(v) == "number" and v % 2 == 1
end, "{{value}} does not satisfy {{expected}}")

ok, err = validate.odd(3)     --> true, nil
ok, err = validate.odd("x")   --> false, '"x" does not satisfy odd'
ok, err = validate(2, "odd")  --> false, "2 does not satisfy odd"
```

> [!NOTE]
>
> - If `msg` is provided, it becomes the default message template for that
>   validator.
> - If `msg` is omitted, failures use: `expected {{expected}}, got {{got}}`.

## Fields

### `messages`

Custom error-message templates for validator failures. Set
`validate.messages.<name>`, where `<name>` is a validator name (for example:
`number`, `truthy`, `file`). The template is used only when validation fails and
an error message is returned.

```lua
validate.messages.number = "need {{expected}}, got {{got}}"
ok, err = validate.number("x") --> false, "need number, got string"
```

**Placeholders**:

- <code v-pre>{{expected}}</code>: The check target (for example `number`,
  `string`, `truthy`).
- <code v-pre>{{got}}</code>: The detected failure kind (usually a Lua type;
  path validators use `invalid path`).
- <code v-pre>{{value}}</code>: The passed value, formatted for display (strings
  are quoted).

> [!NOTE]
>
> When the passed value is `nil`, rendered value text uses `no value`.
>
> ```lua
> validate.messages.truthy = "expected {{expected}} value, got {{value}}"
> validate.truthy(nil) --> false, "expected truthy value, got no value"
> ```
>
> **Default Messages**:

- Type checks: <code v-pre>expected {{expected}}, got {{got}}</code>
- Value checks: <code v-pre>expected {{expected}} value, got {{value}}</code>
- Path checks: <code v-pre>{{value}} is not a valid {{expected}} path</code>
