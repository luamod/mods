---
editLinkTarget: types/validate.lua
---

# `validate`

Validation predicates for Lua values and filesystem path kinds.

## Import

```lua
local validate = require("mods.validate")
```

## Usage

```lua
local ok, err = validate.is.number("nope")
-- result: false, "expected number, got string"

ok, err = validate.is_not.number(3.14)
-- result: false, "expected not number"
```

> [!NOTE]
> When called without an explicit type (`validate(v, tp)`), `validate` defaults to checking `nil`.
>
> - `validate()` is equivalent to `validate(nil, "nil")`, so it passes.
> - `validate(1)` is equivalent to `validate(1, "nil")`, so it fails with `expected nil, got number`.

> [!IMPORTANT]
> Validator access is case-insensitive.
>
> - `validate.is.number`, `validate.IS.Number`, and `validate.I_s.NuMbEr` are equivalent.
> - Top-level aliases are underscore-insensitive too: `validate.is_number`, `validate.IS_NUMBER`, and `validate.isnumber` are equivalent.
> - Negated validators can be accessed as `is_not`, `isnot`, `isNot`, `not`, or `Not`.
>   Example: `validate.is_not.number`, `validate.isNot.number`, `validate.isnot.number`, `validate.not.number`, `validate.is_not_number`, `validate.isnotnumber`.

## Quick Reference

| Area              | Common checks                                                                   |
| ----------------- | ------------------------------------------------------------------------------- |
| `is` type checks  | `boolean`, `Function`, `Nil`, `number`, `string`, `table`, `thread`, `userdata` |
| `is` value checks | `False`, `True`, `falsy`, `callable`, `integer`, `truthy`                       |
| `is` path checks  | `block`, `char`, `device`, `dir`, `fifo`, `file`, `link`, `socket`              |
| `is_not` checks   | Same names as `is` for type/value checks                                        |

## Custom Messages

Customize validator error messages through `validate.messages`.

- `validate.messages.positive.<name>` customizes positive checks
- `validate.messages.negative.<name>` customizes negated checks

Available placeholders:

| Placeholder                     | Meaning                                                                                                  |
| ------------------------------- | -------------------------------------------------------------------------------------------------------- |
| <code v-pre>{{expected}}</code> | The check target (for example `number`, `string`, `truthy`).                                             |
| <code v-pre>{{got}}</code>      | The detected Lua type (`nil`, `boolean`, `number`, `string`, `table`, `function`, `thread`, `userdata`). |
| <code v-pre>{{value}}</code>    | The passed value, formatted for display (strings are quoted).                                            |

**Example**

```lua
validate.messages.positive.number = "need {{expected}}, got {{got}} (value={{value}})"
validate.messages.negative.number = "must not be {{expected}} (value={{value}})"

local ok, err = validate.is.number("x")
-- result: false, 'need number, got string (value="x")'

ok, err = validate.is_not.number(42)
-- result: false, "must not be number (value=42)"
```

## Default Messages

If you do not override `validate.messages.positive.<name>` or `validate.messages.negative.<name>`, validate uses built-in templates:

- Positive checks (`validate.is.*`): `expected {{expected}}, got {{got}}`
- Negative checks (`validate.is_not.*`): `expected not {{expected}}`

`integer` uses a more specific default that includes the passed value:

- Positive `integer`: `expected integer, got {{value}}`
- Negative `integer`: `expected non-integer, got {{value}}`

## On Fail Hook

Set `validate.on_fail` to handle failed validations globally.

- If `on_fail` is set, it is called with the rendered error message.
- If `on_fail` returns a value, that value is used as the returned error.
- If `on_fail` returns `nil`, the default rendered error is returned.
- If `on_fail` is `nil`, validators return `false, err` as usual.

```lua
validate.on_fail = function(errmsg)
  print("validation failed:", errmsg)
  return "custom failure"
end

local ok, err = validate.number("x")
-- prints: validation failed: expected number, got string
-- result: false, "custom failure"
```

## Functions

### `is`

Positive validators. These checks pass only when the value matches the expected type or predicate.

#### Type Checks

Lua type validators for `boolean`, `function`, `nil`, `number`, `string`, `table`, `thread`, and `userdata`.

##### `boolean(v)`

Returns `true` when `v` is a Lua boolean.

```lua
local ok, err = validate.is.boolean(true) -- true
ok, err = validate.is.boolean(1)
-- result: false, "expected boolean, got number"
```

##### `Function(v)`

Returns `true` when `v` is a function value.

```lua
local ok, err = validate.is.Function(function() end) -- true
ok, err = validate.is.Function("hello")
-- result: false, "expected function, got string"
```

##### `Nil(v)`

Returns `true` when `v` is `nil`.

```lua
local ok, err = validate.is.Nil(nil) -- true
ok, err = validate.is.Nil(0)
-- result: false, "expected nil, got number"
```

##### `number(v)`

Returns `true` when `v` is a number.

```lua
local ok, err = validate.is.number(3.14) -- true
ok, err = validate.is.number("3.14")
-- result: false, "expected number, got string"
```

##### `string(v)`

Returns `true` when `v` is a string.

```lua
local ok, err = validate.is.string("hello") -- true
ok, err = validate.is.string(false)
-- result: false, "expected string, got boolean"
```

##### `table(v)`

Returns `true` when `v` is a table.

```lua
local ok, err = validate.is.table({}) -- true
ok, err = validate.is.table("x")
-- result: false, "expected table, got string"
```

##### `thread(v)`

Returns `true` when `v` is a coroutine thread.

```lua
local ok, err = validate.is.thread(coroutine.create(function() end)) -- true
ok, err = validate.is.thread(function() end)
-- result: false, "expected thread, got function"
```

##### `userdata(v)`

Returns `true` when `v` is a userdata value.

```lua
local ok, err = validate.is.userdata(io.stdout) -- true
ok, err = validate.is.userdata({})
-- result: false, "expected userdata, got table"
```

#### Value Checks

Predicate validators for common truth/value semantics.

##### `False(v)`

Returns `true` when `v` is exactly `false`.

```lua
local ok, err = validate.is.False(false) -- true
ok, err = validate.is.False(true)
-- result: false, "expected false, got true"
```

##### `True(v)`

Returns `true` when `v` is exactly `true`.

```lua
local ok, err = validate.is.True(true) -- true
ok, err = validate.is.True(false)
-- result: false, "expected true, got false"
```

##### `falsy(v)`

Returns `true` when `v` is `false` or `nil`.

```lua
local ok, err = validate.is.falsy(false) -- true
ok, err = validate.is.falsy(1)
-- result: false, "expected falsy, got number"
```

##### `callable(v)`

Returns `true` when `v` can be called (function or callable table).

```lua
local ok, err = validate.is.callable(function() end) -- true
ok, err = validate.is.callable({})
-- result: false, "expected callable, got table"
```

##### `integer(v)`

Returns `true` when `v` is a whole number.

```lua
local ok, err = validate.is.integer(42) -- true
ok, err = validate.is.integer(4.2)
-- result: false, "expected integer, got 4.2"
```

##### `truthy(v)`

Returns `true` when `v` is neither `false` nor `nil`.

```lua
local ok, err = validate.is.truthy("non-empty") -- true
ok, err = validate.is.truthy(nil)
-- result: false, "expected truthy, got nil"
```

#### Path Checks

Filesystem kind validators for paths.

::: warning IMPORTANT
Requires `lfs` (LuaFileSystem).
:::

##### `block(path)`

Returns `true` when `path` points to a block device.

```lua
local ok, err = validate.is.block("/dev/sda") -- true
ok, err = validate.is.block(123)
-- result: false, "expected block, got number"
```

##### `char(path)`

Returns `true` when `path` points to a character device.

```lua
local ok, err = validate.is.char("/dev/null") -- true
ok, err = validate.is.char(123)
-- result: false, "expected char, got number"
```

##### `device(path)`

Returns `true` when `path` points to any device node.

```lua
local ok, err = validate.is.device("/dev/null") -- true
ok, err = validate.is.device(123)
-- result: false, "expected device, got number"
```

##### `dir(path)`

Returns `true` when `path` points to a directory.

```lua
local ok, err = validate.is.dir("/tmp") -- true
ok, err = validate.is.dir(123)
-- result: false, "expected dir, got number"
```

##### `fifo(path)`

Returns `true` when `path` points to a FIFO (named pipe).

```lua
local ok, err = validate.is.fifo("/path/to/fifo") -- true
ok, err = validate.is.fifo(123)
-- result: false, "expected fifo, got number"
```

##### `file(path)`

Returns `true` when `path` points to a regular file.

```lua
local ok, err = validate.is.file("README.md") -- true
ok, err = validate.is.file(123)
-- result: false, "expected file, got number"
```

##### `link(path)`

Returns `true` when `path` points to a symbolic link.

```lua
local ok, err = validate.is.link("/path/to/link") -- true
ok, err = validate.is.link(123)
-- result: false, "expected link, got number"
```

##### `socket(path)`

Returns `true` when `path` points to a socket.

```lua
local ok, err = validate.is.socket("/path/to/socket") -- true
ok, err = validate.is.socket(123)
-- result: false, "expected socket, got number"
```

### `is_not`

Negated validators. These checks pass only when the value does not match the expected type or predicate.

> [!IMPORTANT]
> `is_not` supports type and value checks. Path checks are available on `is` only.

#### Type Checks

Negated Lua type validators.

##### `boolean(v)`

Returns `true` when `v` is not a Lua boolean.

```lua
local ok, err = validate.is_not.boolean(123) -- true
ok, err = validate.is_not.boolean(true)
-- result: false, "expected not boolean"
```

##### `Function(v)`

Returns `true` when `v` is not a function value.

```lua
local ok, err = validate.is_not.Function("abc") -- true
ok, err = validate.is_not.Function(function() end)
-- result: false, "expected not function"
```

##### `Nil(v)`

Returns `true` when `v` is not `nil`.

```lua
local ok, err = validate.is_not.Nil(123) -- true
ok, err = validate.is_not.Nil(nil)
-- result: false, "expected not nil"
```

##### `number(v)`

Returns `true` when `v` is not a number.

```lua
local ok, err = validate.is_not.number("3.14") -- true
ok, err = validate.is_not.number(3.14)
-- result: false, "expected not number"
```

##### `string(v)`

Returns `true` when `v` is not a string.

```lua
local ok, err = validate.is_not.string(false) -- true
ok, err = validate.is_not.string("hello")
-- result: false, "expected not string"
```

##### `table(v)`

Returns `true` when `v` is not a table.

```lua
local ok, err = validate.is_not.table(false) -- true
ok, err = validate.is_not.table({})
-- result: false, "expected not table"
```

##### `thread(v)`

Returns `true` when `v` is not a coroutine thread.

```lua
local ok, err = validate.is_not.thread(function() end) -- true
ok, err = validate.is_not.thread(coroutine.create(function() end))
-- result: false, "expected not thread"
```

##### `userdata(v)`

Returns `true` when `v` is not a userdata value.

```lua
local ok, err = validate.is_not.userdata({}) -- true
ok, err = validate.is_not.userdata(io.stdout)
-- result: false, "expected not userdata"
```

#### Value Checks

Negated predicate validators for common truth/value semantics.

##### `False(v)`

Returns `true` when `v` is not exactly `false`.

```lua
local ok, err = validate.is_not.False(true) -- true
ok, err = validate.is_not.False(false)
-- result: false, "expected not false"
```

##### `True(v)`

Returns `true` when `v` is not exactly `true`.

```lua
local ok, err = validate.is_not.True(false) -- true
ok, err = validate.is_not.True(true)
-- result: false, "expected not true"
```

##### `falsy(v)`

Returns `true` when `v` is neither `false` nor `nil`.

```lua
local ok, err = validate.is_not.falsy(true) -- true
ok, err = validate.is_not.falsy(nil)
-- result: false, "expected not falsy"
```

##### `callable(v)`

Returns `true` when `v` cannot be called.

```lua
local ok, err = validate.is_not.callable({}) -- true
ok, err = validate.is_not.callable(function() end)
-- result: false, "expected not callable"
```

##### `integer(v)`

Returns `true` when `v` is not a whole number.

```lua
local ok, err = validate.is_not.integer(13.4) -- true
ok, err = validate.is_not.integer(13)
-- result: false, "expected non-integer, got 13"
```

##### `truthy(v)`

Returns `true` when `v` is `false` or `nil`.

```lua
local ok, err = validate.is_not.truthy(nil) -- true
ok, err = validate.is_not.truthy(1)
-- result: false, "expected not truthy"
```
