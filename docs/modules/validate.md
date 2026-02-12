---
editLinkTarget: types/validate.lua
---

# `validate`

Validation checks for values and filesystem path types.

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

## Callable Forms

All three are callable:

- `validate(v, tp?)`
- `validate.is(v, tp?)`
- `validate.is_not(v, tp?)`

Callable access is also alias/case flexible:

- `validate.is`, `validate.IS`
- `validate.is_not`, `validate.isnot`, `validate.isNot`, `validate.not`, `validate.Not`

```lua
local ok, err

ok, err = validate(1, "number")        -- true
ok, err = validate.is(1, "number")     -- true
ok, err = validate.IS(1, "number")     -- true
ok, err = validate.is_not(1, "number") -- false, "expected not number"
ok, err = validate.Not(1, "number")    -- false, "expected not number"
```

## Quick Reference

| Area                  | Common checks                                                                                                                                                                                                                                                                                                                                                                                          |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `is` (type)           | [`boolean`](#is-boolean), [`function`](#is-function), [`nil`](#is-nil), [`number`](#is-number), [`string`](#is-string), [`table`](#is-table), [`thread`](#is-thread), [`userdata`](#is-userdata)                                                                                                                                                                                                       |
| `is` (value)          | [`false`](#is-false), [`true`](#is-true), [`falsy`](#is-falsy), [`callable`](#is-callable), [`integer`](#is-integer), [`truthy`](#is-truthy)                                                                                                                                                                                                                                                           |
| `is` (path)           | [`block`](#is-block), [`char`](#is-char), [`device`](#is-device), [`dir`](#is-dir), [`fifo`](#is-fifo), [`file`](#is-file), [`link`](#is-link), [`socket`](#is-socket)                                                                                                                                                                                                                                 |
| `is_not` (type/value) | [`boolean`](#is-not-boolean), [`function`](#is-not-function), [`nil`](#is-not-nil), [`number`](#is-not-number), [`string`](#is-not-string), [`table`](#is-not-table), [`thread`](#is-not-thread), [`userdata`](#is-not-userdata), [`false`](#is-not-false), [`true`](#is-not-true), [`falsy`](#is-not-falsy), [`callable`](#is-not-callable), [`integer`](#is-not-integer), [`truthy`](#is-not-truthy) |

## Custom Messages

Customize validator error messages through `validate.messages`.

- `validate.messages.positive.<name>` customizes positive checks
- `validate.messages.negative.<name>` customizes negated checks

`<name>` is the validator key (for example: `number`, `string`, `truthy`, `integer`, `callable`, `file`, `dir`, etc.).

Available placeholders:

| Placeholder                     | Meaning                                                                             |
| ------------------------------- | ----------------------------------------------------------------------------------- |
| <code v-pre>{{expected}}</code> | The check target (for example `number`, `string`, `truthy`).                        |
| <code v-pre>{{got}}</code>      | The detected failure kind (usually a Lua type; path validators use `invalid path`). |
| <code v-pre>{{value}}</code>    | The passed value, formatted for display (strings are quoted).                       |

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

By default, validate uses built-in templates unless `validate.messages.positive.<name>` or `validate.messages.negative.<name>` is overridden:

- Positive type/value checks (`validate.is.*`): <code v-pre>expected {{expected}}, got {{got}}</code>
- Positive path checks (`validate.is.block`, `char`, `device`, `dir`, `fifo`, `file`, `link`, `socket`): <code v-pre>{{value}} is not a valid {{expected}} path</code>
- Negative checks (`validate.is_not.*`): <code v-pre>expected not {{expected}}</code>

`integer` uses a more specific default that includes the passed value:

- Positive `integer`: <code v-pre>expected integer, got {{value}}</code>
- Negative `integer`: <code v-pre>expected non-integer, got {{value}}</code>

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

local ok, err = validate.number("x")
-- prints: validation failed: expected number, got string
-- result: false, "custom failure"
```

## Functions

### `is`

Positive validators. These checks pass only when the value matches the expected type or check.

#### Type Checks

Lua type validators for [`boolean`](#is-boolean), [`function`](#is-function), [`nil`](#is-nil), [`number`](#is-number), [`string`](#is-string), [`table`](#is-table), [`thread`](#is-thread), and [`userdata`](#is-userdata).

##### `boolean(v)` {#is-boolean}

Returns `true` when `v` is a Lua boolean.

```lua
local ok, err = validate.is.boolean(true) -- true
ok, err = validate.is.boolean(1)
-- result: false, "expected boolean, got number"
```

##### `function(v)` {#is-function}

Returns `true` when `v` is a function value.

```lua
local ok, err = validate.is.Function(function() end) -- true
ok, err = validate.is.Function("hello")
-- result: false, "expected function, got string"
```

##### `nil(v)` {#is-nil}

Returns `true` when `v` is `nil`.

```lua
local ok, err = validate.is.Nil(nil) -- true
ok, err = validate.is.Nil(0)
-- result: false, "expected nil, got number"
```

##### `number(v)` {#is-number}

Returns `true` when `v` is a number.

```lua
local ok, err = validate.is.number(3.14) -- true
ok, err = validate.is.number("3.14")
-- result: false, "expected number, got string"
```

##### `string(v)` {#is-string}

Returns `true` when `v` is a string.

```lua
local ok, err = validate.is.string("hello") -- true
ok, err = validate.is.string(false)
-- result: false, "expected string, got boolean"
```

##### `table(v)` {#is-table}

Returns `true` when `v` is a table.

```lua
local ok, err = validate.is.table({}) -- true
ok, err = validate.is.table("x")
-- result: false, "expected table, got string"
```

##### `thread(v)` {#is-thread}

Returns `true` when `v` is a coroutine thread.

```lua
local ok, err = validate.is.thread(coroutine.create(function() end)) -- true
ok, err = validate.is.thread(function() end)
-- result: false, "expected thread, got function"
```

##### `userdata(v)` {#is-userdata}

Returns `true` when `v` is a userdata value.

```lua
local ok, err = validate.is.userdata(io.stdout) -- true
ok, err = validate.is.userdata({})
-- result: false, "expected userdata, got table"
```

#### Value Checks

Validators for common truth/value semantics.

##### `false(v)` {#is-false}

Returns `true` when `v` is exactly `false`.

```lua
local ok, err = validate.is.False(false) -- true
ok, err = validate.is.False(true)
-- result: false, "expected false, got true"
```

##### `true(v)` {#is-true}

Returns `true` when `v` is exactly `true`.

```lua
local ok, err = validate.is.True(true) -- true
ok, err = validate.is.True(false)
-- result: false, "expected true, got false"
```

##### `falsy(v)` {#is-falsy}

Returns `true` when `v` is `false` or `nil`.

```lua
local ok, err = validate.is.falsy(false) -- true
ok, err = validate.is.falsy(1)
-- result: false, "expected falsy, got number"
```

##### `callable(v)` {#is-callable}

Returns `true` when `v` can be called (function or callable table).

```lua
local ok, err = validate.is.callable(function() end) -- true
ok, err = validate.is.callable({})
-- result: false, "expected callable, got table"
```

##### `integer(v)` {#is-integer}

Returns `true` when `v` is a whole number.

```lua
local ok, err = validate.is.integer(42) -- true
ok, err = validate.is.integer(4.2)
-- result: false, "expected integer, got 4.2"
```

##### `truthy(v)` {#is-truthy}

Returns `true` when `v` is neither `false` nor `nil`.

```lua
local ok, err = validate.is.truthy("non-empty") -- true
ok, err = validate.is.truthy(nil)
-- result: false, "expected truthy, got nil"
```

#### Path Checks

Filesystem kind validators for paths.

> [!IMPORTANT]
> Requires `lfs` (LuaFileSystem).

##### `block(path)` {#is-block}

Returns `true` when `path` points to a block device.

```lua
local ok, err = validate.is.block("/dev/sda") -- true
ok, err = validate.is.block(false)
-- result: false, "false is not a valid block path"
ok, err = validate.is.block("/dev/null")
-- result: false, '"/dev/null" is not a valid block path'
```

##### `char(path)` {#is-char}

Returns `true` when `path` points to a character device.

```lua
local ok, err = validate.is.char("/dev/null") -- true
ok, err = validate.is.char(nil)
-- result: false, "nil is not a valid char path"
ok, err = validate.is.char("/tmp")
-- result: false, '"/tmp" is not a valid char path'
```

##### `device(path)` {#is-device}

Returns `true` when `path` points to any device node.

```lua
local ok, err = validate.is.device("/dev/null") -- true
ok, err = validate.is.device(true)
-- result: false, "true is not a valid device path"
ok, err = validate.is.device("README.md")
-- result: false, '"README.md" is not a valid device path'
```

##### `dir(path)` {#is-dir}

Returns `true` when `path` points to a directory.

```lua
local ok, err = validate.is.dir("/tmp") -- true
ok, err = validate.is.dir(0)
-- result: false, "0 is not a valid dir path"
ok, err = validate.is.dir("README.md")
-- result: false, '"README.md" is not a valid dir path'
```

##### `fifo(path)` {#is-fifo}

Returns `true` when `path` points to a FIFO (named pipe).

```lua
local ok, err = validate.is.fifo("/path/to/fifo") -- true
ok, err = validate.is.fifo(7)
-- result: false, "7 is not a valid fifo path"
ok, err = validate.is.fifo("README.md")
-- result: false, '"README.md" is not a valid fifo path'
```

##### `file(path)` {#is-file}

Returns `true` when `path` points to a regular file.

```lua
local ok, err = validate.is.file("README.md") -- true
ok, err = validate.is.file(42)
-- result: false, "42 is not a valid file path"
ok, err = validate.is.file("src")
-- result: false, '"src" is not a valid file path'
```

##### `link(path)` {#is-link}

Returns `true` when `path` points to a symbolic link.

```lua
local ok, err = validate.is.link("/path/to/link") -- true
ok, err = validate.is.link(99)
-- result: false, "99 is not a valid link path"
ok, err = validate.is.link("README.md")
-- result: false, '"README.md" is not a valid link path'
```

##### `socket(path)` {#is-socket}

Returns `true` when `path` points to a socket.

```lua
local ok, err = validate.is.socket("/path/to/socket") -- true
ok, err = validate.is.socket(500)
-- result: false, "500 is not a valid socket path"
ok, err = validate.is.socket("README.md")
-- result: false, '"README.md" is not a valid socket path'
```

### `is_not`

Negated validators. These checks pass only when the value does not match the expected type or check.

> [!IMPORTANT]
> `is_not` supports type and value checks. Path checks are available on [`is`](#is) only.

#### Type Checks

Negated Lua type validators.

##### `boolean(v)` {#is-not-boolean}

Returns `true` when `v` is not a Lua boolean.

```lua
local ok, err = validate.is_not.boolean(123) -- true
ok, err = validate.is_not.boolean(true)
-- result: false, "expected not boolean"
```

##### `function(v)` {#is-not-function}

Returns `true` when `v` is not a function value.

```lua
local ok, err = validate.is_not.Function("abc") -- true
ok, err = validate.is_not.Function(function() end)
-- result: false, "expected not function"
```

##### `nil(v)` {#is-not-nil}

Returns `true` when `v` is not `nil`.

```lua
local ok, err = validate.is_not.Nil(123) -- true
ok, err = validate.is_not.Nil(nil)
-- result: false, "expected not nil"
```

##### `number(v)` {#is-not-number}

Returns `true` when `v` is not a number.

```lua
local ok, err = validate.is_not.number("3.14") -- true
ok, err = validate.is_not.number(3.14)
-- result: false, "expected not number"
```

##### `string(v)` {#is-not-string}

Returns `true` when `v` is not a string.

```lua
local ok, err = validate.is_not.string(false) -- true
ok, err = validate.is_not.string("hello")
-- result: false, "expected not string"
```

##### `table(v)` {#is-not-table}

Returns `true` when `v` is not a table.

```lua
local ok, err = validate.is_not.table(false) -- true
ok, err = validate.is_not.table({})
-- result: false, "expected not table"
```

##### `thread(v)` {#is-not-thread}

Returns `true` when `v` is not a coroutine thread.

```lua
local ok, err = validate.is_not.thread(function() end) -- true
ok, err = validate.is_not.thread(coroutine.create(function() end))
-- result: false, "expected not thread"
```

##### `userdata(v)` {#is-not-userdata}

Returns `true` when `v` is not a userdata value.

```lua
local ok, err = validate.is_not.userdata({}) -- true
ok, err = validate.is_not.userdata(io.stdout)
-- result: false, "expected not userdata"
```

#### Value Checks

Negated validators for common truth/value semantics.

##### `false(v)` {#is-not-false}

Returns `true` when `v` is not exactly `false`.

```lua
local ok, err = validate.is_not.False(true) -- true
ok, err = validate.is_not.False(false)
-- result: false, "expected not false"
```

##### `true(v)` {#is-not-true}

Returns `true` when `v` is not exactly `true`.

```lua
local ok, err = validate.is_not.True(false) -- true
ok, err = validate.is_not.True(true)
-- result: false, "expected not true"
```

##### `falsy(v)` {#is-not-falsy}

Returns `true` when `v` is neither `false` nor `nil`.

```lua
local ok, err = validate.is_not.falsy(true) -- true
ok, err = validate.is_not.falsy(nil)
-- result: false, "expected not falsy"
```

##### `callable(v)` {#is-not-callable}

Returns `true` when `v` cannot be called.

```lua
local ok, err = validate.is_not.callable({}) -- true
ok, err = validate.is_not.callable(function() end)
-- result: false, "expected not callable"
```

##### `integer(v)` {#is-not-integer}

Returns `true` when `v` is not a whole number.

```lua
local ok, err = validate.is_not.integer(13.4) -- true
ok, err = validate.is_not.integer(13)
-- result: false, "expected non-integer, got 13"
```

##### `truthy(v)` {#is-not-truthy}

Returns `true` when `v` is `false` or `nil`.

```lua
local ok, err = validate.is_not.truthy(nil) -- true
ok, err = validate.is_not.truthy(1)
-- result: false, "expected not truthy"
```
