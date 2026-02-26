---
desc: "Validation checks for values and filesystem path types."
---

# `validate`

Validation checks for values and filesystem path types.

## Usage

```lua
validate= require "mods.validate"

ok, err = validate.is.number("nope")
--> false, "expected number, got string"

ok, err = validate.is_not.number(3.14)
--> false, "expected not number"
```

> [!IMPORTANT]
>
> Behavior without `tp`:
>
> - `validate()` is equivalent to `validate(nil, "nil")` (passes)
> - `validate(1)` is equivalent to `validate(1, "nil")` (fails with
>   `expected nil, got number`)
>
> Validator access is case-insensitive:
>
> - `validate.is.number` and `validate.IS.Number` are equivalent.
> - Top-level aliases are underscore-insensitive: `validate.is_number`,
>   `validate.IS_NUMBER`, and `validate.isnumber`.
> - Negated validators are available via `is_not`, `isnot`, `isNot`, `not`, and
>   `Not`, including underscore-insensitive top-level aliases (for example,
>   `validate.is_not_number` and `validate.isnotnumber`).

## Dependencies

- [`mods.is`](https://luamod.github.io/mods/modules/is)
- [`lfs`](https://github.com/lunarmodules/luafilesystem) (optional; lazy-loaded
  💤 only for filesystem checks)

## Callable Forms

`validate`, `validate.is`, and `validate.is_not` are all callable.

```lua
ok, err = validate(1, "number")        --> true, nil
ok, err = validate.is("x", "string")   --> true, nil
ok, err = validate.is_not(1, "number") --> false, "expected not number"
```

> [!IMPORTANT]
>
> When `tp` is omitted, the default check is `"nil"`:
>
> - `validate()` is equivalent to `validate(nil, "nil")` (passes)
> - `validate(1)` is equivalent to `validate(1, "nil")` (fails)
>
> Callable namespace aliases are case-insensitive, and negated aliases are
> underscore-insensitive:
>
> - `validate.is`, `validate.IS`
> - `validate.is_not`, `validate.isnot`, `validate.isNot`, `validate["not"]`,
>   `validate.Not`
>
> ```lua
> validate.is(1, "number")     --> true
> validate.IS(1, "number")     --> true
> validate.is_not(1, "number") --> false, "expected not number"
> validate.Not(1, "number")    --> false, "expected not number"
> ```

## Custom Messages

Customize validator error messages through `validate.messages`.

- `validate.messages.positive.<name>` customizes positive checks
- `validate.messages.negative.<name>` customizes negated checks

`<name>` is the validator key (for example: `number`, `string`, `truthy`,
`integer`, `callable`, `file`, `dir`, etc.).

Available placeholders:

- <code v-pre>{{expected}}</code>: The check target (for example `number`,
  `string`, `truthy`).
- <code v-pre>{{got}}</code>: The detected failure kind (usually a Lua type;
  path validators use `invalid path`).
- <code v-pre>{{value}}</code>: The passed value, formatted for display (strings
  are quoted).

```lua
validate.messages.positive.number = "need {{expected}}, got {{got}} (value={{value}})"
validate.messages.negative.number = "must not be {{expected}} (value={{value}})"

ok, err = validate.is.number("x")
--> false, 'need number, got string (value="x")'

ok, err = validate.is_not.number(42)
--> false, "must not be number (value=42)"
```

## Default Messages

By default, validate uses built-in templates unless
`validate.messages.positive.<name>` or `validate.messages.negative.<name>` is
overridden:

- Positive type/value checks (`validate.is.*`):
  `expected {{expected}}, got {{got}}`
- Positive path checks (`validate.is.block`, `char`, `device`, `dir`, `fifo`,
  `file`, `link`, `socket`): `{{value}} is not a valid {{expected}} path`
- Negative checks (`validate.is_not.*`): `expected not {{expected}}`

`integer` uses a more specific default that includes the passed value:

- Positive `integer`: `expected integer, got {{value}}`
- Negative `integer`: `expected non-integer, got {{value}}`

## On Fail Hook

Set `validate.on_fail` to handle failed validations globally.

- If `on_fail` is set, it is called with the rendered error message.
- If `on_fail` returns a truthy value, that value is used as the returned error.
- If `on_fail` returns a falsy value, the default rendered error is returned.
- If `on_fail` is `nil`, validators return `false, err` as usual.

```lua
validate.on_fail = function(errmsg)
  print("validation failed:", errmsg)
  return "custom failure"
end

ok, err = validate.number("x")
--> prints -> validation failed: expected number, got string
--> false, "custom failure"
```

## Functions

**Type Checks**:

| Function                        | Description                                                                                    |
| ------------------------------- | ---------------------------------------------------------------------------------------------- |
| [`boolean`](#boolean)           | Returns `true` when `v` is a boolean. Otherwise returns `false` and an error message.          |
| [`function`](#function)         | Returns `true` when `v` is a function. Otherwise returns `false` and an error message.         |
| [`nil`](#nil)                   | Returns `true` when `v` is `nil`. Otherwise returns `false` and an error message.              |
| [`number`](#number)             | Returns `true` when `v` is a number. Otherwise returns `false` and an error message.           |
| [`string`](#string)             | Returns `true` when `v` is a string. Otherwise returns `false` and an error message.           |
| [`table`](#table)               | Returns `true` when `v` is a table. Otherwise returns `false` and an error message.            |
| [`thread`](#thread)             | Returns `true` when `v` is a thread. Otherwise returns `false` and an error message.           |
| [`userdata`](#userdata)         | Returns `true` when `v` is userdata. Otherwise returns `false` and an error message.           |
| [`not_boolean`](#not-boolean)   | Returns `true` when `v` is **not** a boolean. Otherwise returns `false` and an error message.  |
| [`not_function`](#not-function) | Returns `true` when `v` is **not** a function. Otherwise returns `false` and an error message. |
| [`not_nil`](#not-nil)           | Returns `true` when `v` is **not** `nil`. Otherwise returns `false` and an error message.      |
| [`not_number`](#not-number)     | Returns `true` when `v` is **not** a number. Otherwise returns `false` and an error message.   |
| [`not_string`](#not-string)     | Returns `true` when `v` is **not** a string. Otherwise returns `false` and an error message.   |
| [`not_table`](#not-table)       | Returns `true` when `v` is **not** a table. Otherwise returns `false` and an error message.    |
| [`not_thread`](#not-thread)     | Returns `true` when `v` is **not** a thread. Otherwise returns `false` and an error message.   |
| [`not_userdata`](#not-userdata) | Returns `true` when `v` is **not** userdata. Otherwise returns `false` and an error message.   |

**Value Checks**:

| Function                        | Description                                                                                         |
| ------------------------------- | --------------------------------------------------------------------------------------------------- |
| [`false`](#false)               | Returns `true` when `v` is exactly `false`. Otherwise returns `false` and an error message.         |
| [`true`](#true)                 | Returns `true` when `v` is exactly `true`. Otherwise returns `false` and an error message.          |
| [`falsy`](#falsy)               | Returns `true` when `v` is falsy. Otherwise returns `false` and an error message.                   |
| [`callable`](#callable)         | Returns `true` when `v` is callable. Otherwise returns `false` and an error message.                |
| [`integer`](#integer)           | Returns `true` when `v` is an integer. Otherwise returns `false` and an error message.              |
| [`truthy`](#truthy)             | Returns `true` when `v` is truthy. Otherwise returns `false` and an error message.                  |
| [`not_false`](#not-false)       | Returns `true` when `v` is **not** exactly `false`. Otherwise returns `false` and an error message. |
| [`not_true`](#not-true)         | Returns `true` when `v` is **not** exactly `true`. Otherwise returns `false` and an error message.  |
| [`not_falsy`](#not-falsy)       | Returns `true` when `v` is **not** falsy. Otherwise returns `false` and an error message.           |
| [`not_callable`](#not-callable) | Returns `true` when `v` is **not** callable. Otherwise returns `false` and an error message.        |
| [`not_integer`](#not-integer)   | Returns `true` when `v` is **not** an integer. Otherwise returns `false` and an error message.      |
| [`not_truthy`](#not-truthy)     | Returns `true` when `v` is **not** truthy. Otherwise returns `false` and an error message.          |

**Path Checks**:

| Function            | Description                                                                                             |
| ------------------- | ------------------------------------------------------------------------------------------------------- |
| [`block`](#block)   | Returns `true` when `v` is a block device path. Otherwise returns `false` and an error message.         |
| [`char`](#char)     | Returns `true` when `v` is a char device path. Otherwise returns `false` and an error message.          |
| [`device`](#device) | Returns `true` when `v` is a block or char device path. Otherwise returns `false` and an error message. |
| [`dir`](#dir)       | Returns `true` when `v` is a directory path. Otherwise returns `false` and an error message.            |
| [`fifo`](#fifo)     | Returns `true` when `v` is a FIFO path. Otherwise returns `false` and an error message.                 |
| [`file`](#file)     | Returns `true` when `v` is a file path. Otherwise returns `false` and an error message.                 |
| [`link`](#link)     | Returns `true` when `v` is a symlink path. Otherwise returns `false` and an error message.              |
| [`socket`](#socket) | Returns `true` when `v` is a socket path. Otherwise returns `false` and an error message.               |

### Type Checks

Basic Lua type validators (and their negated variants).

#### `boolean`

Returns `true` when `v` is a boolean. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is.boolean(true) --> true, nil
ok, err = validate.is.boolean(1)    --> false, "expected boolean, got number"
```

#### `function`

Returns `true` when `v` is a function. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is.Function(function() end) --> true, nil
ok, err = validate.is.Function(1)
--> false, "expected function, got number"
```

#### `nil`

Returns `true` when `v` is `nil`. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is.Nil(nil) --> true, nil
ok, err = validate.is.Nil(0)   --> false, "expected nil, got number"
```

#### `number`

Returns `true` when `v` is a number. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is.number(42)  --> true, nil
ok, err = validate.is.number("x") --> false, "expected number, got string"
```

#### `string`

Returns `true` when `v` is a string. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is.string("hello") --> true, nil
ok, err = validate.is.string(1)       --> false, "expected string, got number"
```

#### `table`

Returns `true` when `v` is a table. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is.table({}) --> true, nil
ok, err = validate.is.table(1)  --> false, "expected table, got number"
```

#### `thread`

Returns `true` when `v` is a thread. Otherwise returns `false` and an error
message.

```lua
co = coroutine.create(function() end)
ok, err = validate.is.thread(co) --> true, nil
ok, err = validate.is.thread(1)  --> false, "expected thread, got number"
```

#### `userdata`

Returns `true` when `v` is userdata. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is.userdata(io.stdout) --> true, nil
ok, err = validate.is.userdata(1)         --> false, "expected userdata, got number"
```

#### `not_boolean`

Returns `true` when `v` is **not** a boolean. Otherwise returns `false` and an
error message.

```lua
ok, err = validate.is_not.boolean(1)    --> true, nil
ok, err = validate.is_not.boolean(true) --> false, "expected not boolean"
```

#### `not_function`

Returns `true` when `v` is **not** a function. Otherwise returns `false` and an
error message.

```lua
ok, err = validate.is_not.Function(1)              --> true, nil
ok, err = validate.is_not.Function(function() end) --> false, "expected not function"
```

#### `not_nil`

Returns `true` when `v` is **not** `nil`. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is_not.Nil(0)   --> true, nil
ok, err = validate.is_not.Nil(nil) --> false, "expected not nil"
```

#### `not_number`

Returns `true` when `v` is **not** a number. Otherwise returns `false` and an
error message.

```lua
ok, err = validate.is_not.number("x") --> true, nil
ok, err = validate.is_not.number(42)  --> false, "expected not number"
```

#### `not_string`

Returns `true` when `v` is **not** a string. Otherwise returns `false` and an
error message.

```lua
ok, err = validate.is_not.string(1)       --> true, nil
ok, err = validate.is_not.string("hello") --> false, "expected not string"
```

#### `not_table`

Returns `true` when `v` is **not** a table. Otherwise returns `false` and an
error message.

```lua
ok, err = validate.is_not.table(1)  --> true, nil
ok, err = validate.is_not.table({}) --> false, "expected not table"
```

#### `not_thread`

Returns `true` when `v` is **not** a thread. Otherwise returns `false` and an
error message.

```lua
co = coroutine.create(function() end)
ok, err = validate.is_not.thread(1)  --> true, nil
ok, err = validate.is_not.thread(co) --> false, "expected not thread"
```

#### `not_userdata`

Returns `true` when `v` is **not** userdata. Otherwise returns `false` and an
error message.

```lua
ok, err = validate.is_not.userdata(1)         --> true, nil
ok, err = validate.is_not.userdata(io.stdout) --> false, "expected not userdata"
```

### Value Checks

Value-state validators (exact true/false, truthy/falsy, callable, integer).

#### `false`

Returns `true` when `v` is exactly `false`. Otherwise returns `false` and an
error message.

```lua
ok, err = validate.is.False(false) --> true, nil
ok, err = validate.is.False(true)  --> false, "expected false, got true"
```

#### `true`

Returns `true` when `v` is exactly `true`. Otherwise returns `false` and an
error message.

```lua
ok, err = validate.is.True(true)  --> true, nil
ok, err = validate.is.True(false) --> false, "expected true, got false"
```

#### `falsy`

Returns `true` when `v` is falsy. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is.falsy(false) --> true, nil
ok, err = validate.is.falsy(1)     --> false, "expected falsy, got number"
```

#### `callable`

Returns `true` when `v` is callable. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is.callable(type) --> true, nil
ok, err = validate.is.callable(1)    --> false, "expected callable, got number"
```

#### `integer`

Returns `true` when `v` is an integer. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is.integer(1)   --> true, nil
ok, err = validate.is.integer(1.5) --> false, "expected integer, got 1.5"
```

#### `truthy`

Returns `true` when `v` is truthy. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is.truthy(1)     --> true, nil
ok, err = validate.is.truthy(false) --> false, "expected truthy, got boolean"
```

#### `not_false`

Returns `true` when `v` is **not** exactly `false`. Otherwise returns `false`
and an error message.

```lua
ok, err = validate.is_not.False(true)  --> true, nil
ok, err = validate.is_not.False(false) --> false, "expected not false"
```

#### `not_true`

Returns `true` when `v` is **not** exactly `true`. Otherwise returns `false` and
an error message.

```lua
ok, err = validate.is_not.True(false) --> true, nil
ok, err = validate.is_not.True(true)  --> false, "expected not true"
```

#### `not_falsy`

Returns `true` when `v` is **not** falsy. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is_not.falsy(1)     --> true, nil
ok, err = validate.is_not.falsy(false) --> false, "expected not falsy"
```

#### `not_callable`

Returns `true` when `v` is **not** callable. Otherwise returns `false` and an
error message.

```lua
ok, err = validate.is_not.callable(1)              --> true, nil
ok, err = validate.is_not.callable(function() end) --> false, "expected not callable"
```

#### `not_integer`

Returns `true` when `v` is **not** an integer. Otherwise returns `false` and an
error message.

```lua
ok, err = validate.is_not.integer(1.5) --> true, nil
ok, err = validate.is_not.integer(1)   --> false, "expected non-integer, got 1"
```

#### `not_truthy`

Returns `true` when `v` is **not** truthy. Otherwise returns `false` and an
error message.

```lua
ok, err = validate.is_not.truthy(false) --> true, nil
ok, err = validate.is_not.truthy(1)     --> false, "expected not truthy"
```

### Path Checks

Filesystem path-kind validators backed by LuaFileSystem (`lfs`).

Filesystem path kind checks.

> [!IMPORTANT]
>
> Path checks require **LuaFileSystem**
> ([`lfs`](https://github.com/lunarmodules/luafilesystem)) and raise an error it
> is not installed.

#### `block`

Returns `true` when `v` is a block device path. Otherwise returns `false` and an
error message.

```lua
ok, err = validate.is.block(".")
```

#### `char`

Returns `true` when `v` is a char device path. Otherwise returns `false` and an
error message.

```lua
ok, err = validate.is.char(".")
```

#### `device`

Returns `true` when `v` is a block or char device path. Otherwise returns
`false` and an error message.

```lua
ok, err = validate.is.device(".")
```

#### `dir`

Returns `true` when `v` is a directory path. Otherwise returns `false` and an
error message.

```lua
ok, err = validate.is.dir(".")
```

#### `fifo`

Returns `true` when `v` is a FIFO path. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is.fifo(".")
```

#### `file`

Returns `true` when `v` is a file path. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is.file(".")
```

#### `link`

Returns `true` when `v` is a symlink path. Otherwise returns `false` and an
error message.

```lua
ok, err = validate.is.link(".")
```

#### `socket`

Returns `true` when `v` is a socket path. Otherwise returns `false` and an error
message.

```lua
ok, err = validate.is.socket(".")
```
