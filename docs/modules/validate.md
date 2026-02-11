---
editLinkTarget: types/validate.lua
---

# `validate`

Validation error message templates keyed by lowercase type name. Override any
entry to customize the error string returned by validators. Templates can use
`{{expected}}`, `{{got}}`, and `{{value}}`.

**Example:**

```lua
local validate = require("mods.validate")
local messages = validate.messages
messages.is.number = "should be {{expected}}, got {{got}} (passed={{value}})"
local ok, err = validate.Number("nope")
--result: 'should be number, got string (passed="nope")'

messages.is_not.number = "should not be {{expected}}, got {{got}} (passed={{value}})"
ok, err = validate.is_not.Number(3.14)
--result: 'should not be number, got number (passed=3.14)'
```

## Quick Reference

**Type Checks**

| Function                         | Description                                                                   |
| -------------------------------- | ----------------------------------------------------------------------------- |
| [`boolean(v)`](#fn-booleanv)     | Returns `true` when `v` is a boolean. Otherwise returns `false` and an error  |
| [`boolean(v)`](#fn-booleanv-2)   | Returns `true` when `v` is **not** a boolean. Otherwise returns `false` and   |
| [`Function(v)`](#fn-functionv)   | Returns `true` when `v` is a function. Otherwise returns `false` and an error |
| [`Function(v)`](#fn-functionv-2) | Returns `true` when `v` is **not** a function. Otherwise returns `false` and  |
| [`Nil(v)`](#fn-nilv)             | Returns `true` when `v` is `nil`. Otherwise returns `false` and an error      |
| [`Nil(v)`](#fn-nilv-2)           | Returns `true` when `v` is **not** `nil`. Otherwise returns `false` and an    |
| [`number(v)`](#fn-numberv)       | Returns `true` when `v` is a number. Otherwise returns `false` and an error   |
| [`number(v)`](#fn-numberv-2)     | Returns `true` when `v` is **not** a number. Otherwise returns `false` and    |
| [`string(v)`](#fn-stringv)       | Returns `true` when `v` is a string. Otherwise returns `false` and an error   |
| [`string(v)`](#fn-stringv-2)     | Returns `true` when `v` is **not** a string. Otherwise returns `false` and    |
| [`table(v)`](#fn-tablev)         | Returns `true` when `v` is a table. Otherwise returns `false` and an error    |
| [`table(v)`](#fn-tablev-2)       | Returns `true` when `v` is **not** a table. Otherwise returns `false` and an  |
| [`thread(v)`](#fn-threadv)       | Returns `true` when `v` is a thread. Otherwise returns `false` and an error   |
| [`thread(v)`](#fn-threadv-2)     | Returns `true` when `v` is **not** a thread. Otherwise returns `false` and    |
| [`userdata(v)`](#fn-userdatav)   | Returns `true` when `v` is userdata. Otherwise returns `false` and an error   |
| [`userdata(v)`](#fn-userdatav-2) | Returns `true` when `v` is **not** userdata. Otherwise returns `false` and    |

**Value Checks**

| Function                         | Description                                                                   |
| -------------------------------- | ----------------------------------------------------------------------------- |
| [`False(v)`](#fn-falsev)         | Returns `true` when `v` is exactly `false`. Otherwise returns `false` and an  |
| [`False(v)`](#fn-falsev-2)       | Returns `true` when `v` is **not** exactly `false`. Otherwise returns         |
| [`True(v)`](#fn-truev)           | Returns `true` when `v` is exactly `true`. Otherwise returns `false` and an   |
| [`True(v)`](#fn-truev-2)         | Returns `true` when `v` is **not** exactly `true`. Otherwise returns `false`  |
| [`falsy(v)`](#fn-falsyv)         | Returns `true` when `v` is falsy. Otherwise returns `false` and an error      |
| [`falsy(v)`](#fn-falsyv-2)       | Returns `true` when `v` is **not** falsy. Otherwise returns `false` and an    |
| [`callable(v)`](#fn-callablev)   | Returns `true` when `v` is callable. Otherwise returns `false` and an error   |
| [`callable(v)`](#fn-callablev-2) | Returns `true` when `v` is **not** callable. Otherwise returns `false` and    |
| [`integer(v)`](#fn-integerv)     | Returns `true` when `v` is an integer. Otherwise returns `false` and an error |
| [`integer(v)`](#fn-integerv-2)   | Returns `true` when `v` is **not** an integer. Otherwise returns `false` and  |
| [`truthy(v)`](#fn-truthyv)       | Returns `true` when `v` is truthy. Otherwise returns `false` and an error     |
| [`truthy(v)`](#fn-truthyv-2)     | Returns `true` when `v` is **not** truthy. Otherwise returns `false` and an   |

**Path Checks**

| Function                   | Description                                                                    |
| -------------------------- | ------------------------------------------------------------------------------ |
| [`block(v)`](#fn-blockv)   | Returns `true` when `v` is a block device path. Otherwise returns `false` and  |
| [`char(v)`](#fn-charv)     | Returns `true` when `v` is a char device path. Otherwise returns `false` and   |
| [`device(v)`](#fn-devicev) | Returns `true` when `v` is a block or char device path. Otherwise returns      |
| [`dir(v)`](#fn-dirv)       | Returns `true` when `v` is a directory path. Otherwise returns `false` and an  |
| [`fifo(v)`](#fn-fifov)     | Returns `true` when `v` is a FIFO path. Otherwise returns `false` and an error |
| [`file(v)`](#fn-filev)     | Returns `true` when `v` is a file path. Otherwise returns `false` and an error |
| [`link(v)`](#fn-linkv)     | Returns `true` when `v` is a symlink path. Otherwise returns `false` and an    |
| [`socket(v)`](#fn-socketv) | Returns `true` when `v` is a socket path. Otherwise returns `false` and an     |

## Functions

### Type Checks

#### `boolean(v)` {#fn-booleanv}

Returns `true` when `v` is a boolean. Otherwise returns `false` and an error
message.

:::tabs
== Example

```lua
assert(validate.boolean(true))
```

== Aliases

- `boolean`
- `is.boolean`
- `is_boolean`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function boolean(v) end
```

:::

#### `boolean(v)` {#fn-booleanv-2}

Returns `true` when `v` is **not** a boolean. Otherwise returns `false` and
an error message.

:::tabs
== Example

```lua
assert(validate.is_not.boolean(123))
```

== Aliases

- `is_not.boolean`
- `is_not.Boolean`
- `isnot.boolean`
- `isnot.Boolean`
- `isNot.boolean`
- `isNot.Boolean`
- `not.boolean`
- `not.Boolean`
- `Not.boolean`
- `Not.Boolean`
- `is_not_boolean`
- `is_not_Boolean`
- `isnot_boolean`
- `isnot_Boolean`
- `isnotboolean`
- `isnotBoolean`
- `isNot_boolean`
- `isNot_Boolean`
- `isNotboolean`
- `isNotBoolean`
- `not_boolean`
- `not_Boolean`
- `notboolean`
- `notBoolean`
- `Not_boolean`
- `Not_Boolean`
- `Notboolean`
- `NotBoolean`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function boolean(v) end
```

:::

#### `Function(v)` {#fn-functionv}

Returns `true` when `v` is a function. Otherwise returns `false` and an error
message.

:::tabs
== Example

```lua
assert(validate.Function(function() end))
```

== Aliases

- `Function`
- `function`
- `is.Function`
- `is.function`
- `is_Function`
- `is_function`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function Function(v) end
```

:::

#### `Function(v)` {#fn-functionv-2}

Returns `true` when `v` is **not** a function. Otherwise returns `false` and
an error message.

:::tabs
== Example

```lua
assert(validate.is_not.Function("abc"))
```

== Aliases

- `is_not.Function`
- `is_not.function`
- `isnot.Function`
- `isnot.function`
- `isNot.Function`
- `isNot.function`
- `not.Function`
- `not.function`
- `Not.Function`
- `Not.function`
- `is_not_Function`
- `is_not_function`
- `isnot_Function`
- `isnot_function`
- `isnotFunction`
- `isnotfunction`
- `isNot_Function`
- `isNot_function`
- `isNotFunction`
- `isNotfunction`
- `not_Function`
- `not_function`
- `notFunction`
- `notfunction`
- `Not_Function`
- `Not_function`
- `NotFunction`
- `Notfunction`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function Function(v) end
```

:::

#### `Nil(v)` {#fn-nilv}

Returns `true` when `v` is `nil`. Otherwise returns `false` and an error
message.

:::tabs
== Example

```lua
assert(validate.Nil(nil))
```

== Aliases

- `Nil`
- `nil`
- `is.Nil`
- `is.nil`
- `is_Nil`
- `is_nil`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function Nil(v) end
```

:::

#### `Nil(v)` {#fn-nilv-2}

Returns `true` when `v` is **not** `nil`. Otherwise returns `false` and an
error message.

:::tabs
== Example

```lua
assert(validate.is_not.Nil(123))
```

== Aliases

- `is_not.Nil`
- `is_not.nil`
- `isnot.Nil`
- `isnot.nil`
- `isNot.Nil`
- `isNot.nil`
- `not.Nil`
- `not.nil`
- `Not.Nil`
- `Not.nil`
- `is_not_Nil`
- `is_not_nil`
- `isnot_Nil`
- `isnot_nil`
- `isnotNil`
- `isnotnil`
- `isNot_Nil`
- `isNot_nil`
- `isNotNil`
- `isNotnil`
- `not_Nil`
- `not_nil`
- `notNil`
- `notnil`
- `Not_Nil`
- `Not_nil`
- `NotNil`
- `Notnil`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function Nil(v) end
```

:::

#### `number(v)` {#fn-numberv}

Returns `true` when `v` is a number. Otherwise returns `false` and an error
message.

:::tabs
== Example

```lua
assert(validate.number(3.14))
```

== Aliases

- `number`
- `is.number`
- `is_number`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function number(v) end
```

:::

#### `number(v)` {#fn-numberv-2}

Returns `true` when `v` is **not** a number. Otherwise returns `false` and
an error message.

:::tabs
== Example

```lua
assert(validate.is_not.number("3.14"))
```

== Aliases

- `is_not.number`
- `is_not.Number`
- `isnot.number`
- `isnot.Number`
- `isNot.number`
- `isNot.Number`
- `not.number`
- `not.Number`
- `Not.number`
- `Not.Number`
- `is_not_number`
- `is_not_Number`
- `isnot_number`
- `isnot_Number`
- `isnotnumber`
- `isnotNumber`
- `isNot_number`
- `isNot_Number`
- `isNotnumber`
- `isNotNumber`
- `not_number`
- `not_Number`
- `notnumber`
- `notNumber`
- `Not_number`
- `Not_Number`
- `Notnumber`
- `NotNumber`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function number(v) end
```

:::

#### `string(v)` {#fn-stringv}

Returns `true` when `v` is a string. Otherwise returns `false` and an error
message.

:::tabs
== Example

```lua
assert(validate.string("hello"))
```

== Aliases

- `string`
- `is.string`
- `is_string`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function string(v) end
```

:::

#### `string(v)` {#fn-stringv-2}

Returns `true` when `v` is **not** a string. Otherwise returns `false` and
an error message.

:::tabs
== Example

```lua
assert(validate.is_not.string(false))
```

== Aliases

- `is_not.string`
- `is_not.String`
- `isnot.string`
- `isnot.String`
- `isNot.string`
- `isNot.String`
- `not.string`
- `not.String`
- `Not.string`
- `Not.String`
- `is_not_string`
- `is_not_String`
- `isnot_string`
- `isnot_String`
- `isnotstring`
- `isnotString`
- `isNot_string`
- `isNot_String`
- `isNotstring`
- `isNotString`
- `not_string`
- `not_String`
- `notstring`
- `notString`
- `Not_string`
- `Not_String`
- `Notstring`
- `NotString`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function string(v) end
```

:::

#### `table(v)` {#fn-tablev}

Returns `true` when `v` is a table. Otherwise returns `false` and an error
message.

:::tabs
== Example

```lua
assert(validate.table({}))
```

== Aliases

- `table`
- `is.table`
- `is_table`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function table(v) end
```

:::

#### `table(v)` {#fn-tablev-2}

Returns `true` when `v` is **not** a table. Otherwise returns `false` and an
error message.

:::tabs
== Example

```lua
assert(validate.is_not.table(false))
```

== Aliases

- `is_not.table`
- `is_not.Table`
- `isnot.table`
- `isnot.Table`
- `isNot.table`
- `isNot.Table`
- `not.table`
- `not.Table`
- `Not.table`
- `Not.Table`
- `is_not_table`
- `is_not_Table`
- `isnot_table`
- `isnot_Table`
- `isnottable`
- `isnotTable`
- `isNot_table`
- `isNot_Table`
- `isNottable`
- `isNotTable`
- `not_table`
- `not_Table`
- `nottable`
- `notTable`
- `Not_table`
- `Not_Table`
- `Nottable`
- `NotTable`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function table(v) end
```

:::

#### `thread(v)` {#fn-threadv}

Returns `true` when `v` is a thread. Otherwise returns `false` and an error
message.

:::tabs
== Example

```lua
local co = coroutine.create(function() end)
assert(validate.thread(co))
```

== Aliases

- `thread`
- `is.thread`
- `is_thread`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function thread(v) end
```

:::

#### `thread(v)` {#fn-threadv-2}

Returns `true` when `v` is **not** a thread. Otherwise returns `false` and
an error message.

:::tabs
== Example

```lua
assert(validate.is_not.thread(function() end))
```

== Aliases

- `is_not.thread`
- `isnot.thread`
- `isNot.thread`
- `not.thread`
- `Not.thread`
- `is_not_thread`
- `isnot_thread`
- `isNot_thread`
- `not_thread`
- `Not_thread`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function thread(v) end
```

:::

#### `userdata(v)` {#fn-userdatav}

Returns `true` when `v` is userdata. Otherwise returns `false` and an error
message.

:::tabs
== Example

```lua
assert(validate.userdata(io.stdout))
```

== Aliases

- `userdata`
- `is.userdata`
- `is_userdata`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function userdata(v) end
```

:::

#### `userdata(v)` {#fn-userdatav-2}

Returns `true` when `v` is **not** userdata. Otherwise returns `false` and
an error message.

:::tabs
== Example

```lua
assert(validate.is_not.userdata({}))
```

== Aliases

- `is_not.userdata`
- `is_not.Userdata`
- `isnot.userdata`
- `isnot.Userdata`
- `isNot.userdata`
- `isNot.Userdata`
- `not.userdata`
- `not.Userdata`
- `Not.userdata`
- `Not.Userdata`
- `is_not_userdata`
- `is_not_Userdata`
- `isnot_userdata`
- `isnot_Userdata`
- `isnotuserdata`
- `isnotUserdata`
- `isNot_userdata`
- `isNot_Userdata`
- `isNotuserdata`
- `isNotUserdata`
- `not_userdata`
- `not_Userdata`
- `notuserdata`
- `notUserdata`
- `Not_userdata`
- `Not_Userdata`
- `Notuserdata`
- `NotUserdata`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function userdata(v) end
```

:::

### Value Checks

#### `False(v)` {#fn-falsev}

Returns `true` when `v` is exactly `false`. Otherwise returns `false` and an
error message.

:::tabs
== Example

```lua
assert(validate.False(false))
```

== Aliases

- `False`
- `false`
- `is.False`
- `is.false`
- `is_False`
- `is_false`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function False(v) end
```

:::

#### `False(v)` {#fn-falsev-2}

Returns `true` when `v` is **not** exactly `false`. Otherwise returns
`false` and an error message.

:::tabs
== Example

```lua
assert(validate.is_not.False(true))
```

== Aliases

- `is_not.False`
- `is_not.false`
- `isnot.False`
- `isnot.false`
- `isNot.False`
- `isNot.false`
- `not.False`
- `not.false`
- `Not.False`
- `Not.false`
- `is_not_False`
- `is_not_false`
- `isnot_False`
- `isnot_false`
- `isnotFalse`
- `isnotfalse`
- `isNot_False`
- `isNot_false`
- `isNotFalse`
- `isNotfalse`
- `not_False`
- `not_false`
- `notFalse`
- `notfalse`
- `Not_False`
- `Not_false`
- `NotFalse`
- `Notfalse`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function False(v) end
```

:::

#### `True(v)` {#fn-truev}

Returns `true` when `v` is exactly `true`. Otherwise returns `false` and an
error message.

:::tabs
== Example

```lua
assert(validate.True(true))
```

== Aliases

- `True`
- `true`
- `is.True`
- `is.true`
- `is_True`
- `is_true`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function True(v) end
```

:::

#### `True(v)` {#fn-truev-2}

Returns `true` when `v` is **not** exactly `true`. Otherwise returns `false`
and an error message.

:::tabs
== Example

```lua
assert(validate.is_not.True(false))
```

== Aliases

- `is_not.True`
- `is_not.true`
- `isnot.True`
- `isnot.true`
- `isNot.True`
- `isNot.true`
- `not.True`
- `not.true`
- `Not.True`
- `Not.true`
- `is_not_True`
- `is_not_true`
- `isnot_True`
- `isnot_true`
- `isnotTrue`
- `isnottrue`
- `isNot_True`
- `isNot_true`
- `isNotTrue`
- `isNottrue`
- `not_True`
- `not_true`
- `notTrue`
- `nottrue`
- `Not_True`
- `Not_true`
- `NotTrue`
- `Nottrue`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function True(v) end
```

:::

#### `falsy(v)` {#fn-falsyv}

Returns `true` when `v` is falsy. Otherwise returns `false` and an error
message.

:::tabs
== Example

```lua
assert(validate.falsy(false))
```

== Aliases

- `falsy`
- `is.falsy`
- `is_falsy`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function falsy(v) end
```

:::

#### `falsy(v)` {#fn-falsyv-2}

Returns `true` when `v` is **not** falsy. Otherwise returns `false` and an
error message.

:::tabs
== Example

```lua
assert(validate.is_not.falsy(true))
```

== Aliases

- `is_not.falsy`
- `is_not.Falsy`
- `isnot.falsy`
- `isnot.Falsy`
- `isNot.falsy`
- `isNot.Falsy`
- `not.falsy`
- `not.Falsy`
- `Not.falsy`
- `Not.Falsy`
- `is_not_falsy`
- `is_not_Falsy`
- `isnot_falsy`
- `isnot_Falsy`
- `isnotfalsy`
- `isnotFalsy`
- `isNot_falsy`
- `isNot_Falsy`
- `isNotfalsy`
- `isNotFalsy`
- `not_falsy`
- `not_Falsy`
- `notfalsy`
- `notFalsy`
- `Not_falsy`
- `Not_Falsy`
- `Notfalsy`
- `NotFalsy`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function falsy(v) end
```

:::

#### `callable(v)` {#fn-callablev}

Returns `true` when `v` is callable. Otherwise returns `false` and an error
message.

:::tabs
== Example

```lua
assert(validate.callable(function() end))
```

== Aliases

- `callable`
- `is.callable`
- `is_callable`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function callable(v) end
```

:::

#### `callable(v)` {#fn-callablev-2}

Returns `true` when `v` is **not** callable. Otherwise returns `false` and
an error message.

:::tabs
== Example

```lua
assert(validate.is_not.callable({}))
```

== Aliases

- `is_not.callable`
- `is_not.Callable`
- `isnot.callable`
- `isnot.Callable`
- `isNot.callable`
- `isNot.Callable`
- `not.callable`
- `not.Callable`
- `Not.callable`
- `Not.Callable`
- `is_not_callable`
- `is_not_Callable`
- `isnot_callable`
- `isnot_Callable`
- `isnotcallable`
- `isnotCallable`
- `isNot_callable`
- `isNot_Callable`
- `isNotcallable`
- `isNotCallable`
- `not_callable`
- `not_Callable`
- `notcallable`
- `notCallable`
- `Not_callable`
- `Not_Callable`
- `Notcallable`
- `NotCallable`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function callable(v) end
```

:::

#### `integer(v)` {#fn-integerv}

Returns `true` when `v` is an integer. Otherwise returns `false` and an error
message.

:::tabs
== Example

```lua
assert(validate.integer(42))
```

== Aliases

- `integer`
- `is.integer`
- `is_integer`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function integer(v) end
```

:::

#### `integer(v)` {#fn-integerv-2}

Returns `true` when `v` is **not** an integer. Otherwise returns `false` and
an error message.

:::tabs
== Example

```lua
assert(validate.is_not.integer(13.4))
```

== Aliases

- `is_not.integer`
- `is_not.Integer`
- `isnot.integer`
- `isnot.Integer`
- `isNot.integer`
- `isNot.Integer`
- `not.integer`
- `not.Integer`
- `Not.integer`
- `Not.Integer`
- `is_not_integer`
- `is_not_Integer`
- `isnot_integer`
- `isnot_Integer`
- `isnotinteger`
- `isnotInteger`
- `isNot_integer`
- `isNot_Integer`
- `isNotinteger`
- `isNotInteger`
- `not_integer`
- `not_Integer`
- `notinteger`
- `notInteger`
- `Not_integer`
- `Not_Integer`
- `Notinteger`
- `NotInteger`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function integer(v) end
```

:::

#### `truthy(v)` {#fn-truthyv}

Returns `true` when `v` is truthy. Otherwise returns `false` and an error
message.

:::tabs
== Example

```lua
assert(validate.truthy("non-empty"))
```

== Aliases

- `truthy`
- `is.truthy`
- `is_truthy`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function truthy(v) end
```

:::

#### `truthy(v)` {#fn-truthyv-2}

Returns `true` when `v` is **not** truthy. Otherwise returns `false` and an
error message.

:::tabs
== Example

```lua
assert(validate.is_not.truthy(nil))
```

== Aliases

- `is_not.truthy`
- `is_not.Truthy`
- `isnot.truthy`
- `isnot.Truthy`
- `isNot.truthy`
- `isNot.Truthy`
- `not.truthy`
- `not.Truthy`
- `Not.truthy`
- `Not.Truthy`
- `is_not_truthy`
- `is_not_Truthy`
- `isnot_truthy`
- `isnot_Truthy`
- `isnottruthy`
- `isnotTruthy`
- `isNot_truthy`
- `isNot_Truthy`
- `isNottruthy`
- `isNotTruthy`
- `not_truthy`
- `not_Truthy`
- `nottruthy`
- `notTruthy`
- `Not_truthy`
- `Not_Truthy`
- `Nottruthy`
- `NotTruthy`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function truthy(v) end
```

:::

### Path Checks

#### `block(v)` {#fn-blockv}

Returns `true` when `v` is a block device path. Otherwise returns `false` and
an error message.

> [!IMPORTANT]
> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).

:::tabs
== Example

```lua
assert(validate.block("/dev/sda"))
```

== Aliases

- `block`
- `is.block`
- `is_block`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function block(v) end
```

:::

#### `char(v)` {#fn-charv}

Returns `true` when `v` is a char device path. Otherwise returns `false` and
an error message.

> [!IMPORTANT]
> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).

:::tabs
== Example

```lua
assert(validate.char("/dev/null"))
```

== Aliases

- `char`
- `is.char`
- `is_char`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function char(v) end
```

:::

#### `device(v)` {#fn-devicev}

Returns `true` when `v` is a block or char device path. Otherwise returns
`false` and an error message.

> [!IMPORTANT]
> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).

:::tabs
== Example

```lua
assert(validate.device("/dev/null"))
```

== Aliases

- `device`
- `is.device`
- `is_device`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function device(v) end
```

:::

#### `dir(v)` {#fn-dirv}

Returns `true` when `v` is a directory path. Otherwise returns `false` and an
error message.

> [!IMPORTANT]
> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).

:::tabs
== Example

```lua
assert(validate.dir("/tmp"))
```

== Aliases

- `dir`
- `is.dir`
- `is_dir`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function dir(v) end
```

:::

#### `fifo(v)` {#fn-fifov}

Returns `true` when `v` is a FIFO path. Otherwise returns `false` and an error
message.

> [!IMPORTANT]
> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).

:::tabs
== Example

```lua
assert(validate.fifo("/path/to/fifo"))
```

== Aliases

- `fifo`
- `is.fifo`
- `is_fifo`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function fifo(v) end
```

:::

#### `file(v)` {#fn-filev}

Returns `true` when `v` is a file path. Otherwise returns `false` and an error
message.

> [!IMPORTANT]
> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).

:::tabs
== Example

```lua
assert(validate.file("README.md"))
```

== Aliases

- `file`
- `is.file`
- `is_file`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function file(v) end
```

:::

#### `link(v)` {#fn-linkv}

Returns `true` when `v` is a symlink path. Otherwise returns `false` and an
error message.

> [!IMPORTANT]
> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).

:::tabs
== Example

```lua
assert(validate.link("/path/to/link"))
```

== Aliases

- `link`
- `is.link`
- `is_link`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function link(v) end
```

:::

#### `socket(v)` {#fn-socketv}

Returns `true` when `v` is a socket path. Otherwise returns `false` and an
error message.

> [!IMPORTANT]
> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).

:::tabs
== Example

```lua
assert(validate.socket("/path/to/socket"))
```

== Aliases

- `socket`
- `is.socket`
- `is_socket`

== Signature

```lua
---@param v any
---@return boolean ok
---@return string? err
---@nodiscard
function socket(v) end
```

:::
