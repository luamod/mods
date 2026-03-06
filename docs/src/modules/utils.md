---
description: "Small shared utility helpers used by modules in this library."
---

# `utils`

Small shared utility helpers used by modules in this library.

## Usage

```lua
utils = require "mods.utils"

print(utils.quote('hello "world"')) --> 'hello "world"'
```

## Functions

<a id="fn-quote"></a>

### `quote(v)`

Smart-quote a string for readable Lua-like output.

**Parameters**:

- `v` (`string`): String to quote.

**Return**:

- `out` (`string`): Quoted string.

**Example**:

```lua
print(utils.quote('He said "hi"')) -- 'He said "hi"'
print(utils.quote('say "hi" and \\'bye\\'')) -- "say \"hi\" and 'bye'"
```

<a id="fn-keypath"></a>

### `keypath(...)`

Format a key chain as a Lua-like table access path.

**Parameters**:

- `...` (`any`): Additional arguments.

**Return**:

- `path` (`string`): Rendered key path.

**Example**:

```lua
p1 = utils.keypath("t", "a", "b", "c")        --> "t.a.b.c"
p2 = utils.keypath("ctx", "users", 1, "name") --> "ctx.users[1].name"
p3 = utils.keypath("ctx", "invalid-key")      --> 'ctx["invalid-key"]'
p4 = utils.keypath()                          --> ""
```

<a id="fn-assert-arg"></a>

### `assert_arg(argn, v, tp?, level?, msg?)`

Assert argument value using [`mods.validate`](/modules/validate) and raise a Lua
error on failure.

**Parameters**:

- `argn` (`integer`): Argument index for error context.
- `v` (`T`): Value to check.
- `tp?` (`modsIsType`): Validator name (defaults to `"truthy"`).
- `level?` (`integer`): Optional error level for `error(...)` (defaults to `2`).
- `msg?` (`string`): Optional override template passed to
  [`mods.validate`](/modules/validate).

**Return**:

- `v` (`T`): Same input value on success.

**Example**:

```lua
utils.assert_arg(1, "ok", "string") --> "ok"
utils.assert_arg(2, 123, "string")
--> raises: bad argument #2 (expected string, got number)
utils.assert_arg(3, "x", "number", 2, "need {{expected}}, got {{got}}")
--> raises: bad argument #3 (need number, got string)
```

> [!NOTE]
>
> When the caller function name is available, error text includes
> `to '<function>'` (Lua-style bad argument context).
