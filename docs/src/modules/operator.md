---
desc: "Operator helpers as functions."
---

# `operator`

Operator helpers as functions.

## Usage

```lua
operator = require "mods.operator"

print(operator.add(1, 2)) --> 3
```

## Functions

**Arithmetic**:

| Function        | Description                                                        |
| --------------- | ------------------------------------------------------------------ |
| [`add`](#add)   | Add two numbers.                                                   |
| [`sub`](#sub)   | Subtract `b` from `a`.                                             |
| [`mul`](#mul)   | Multiply two numbers.                                              |
| [`div`](#div)   | Divide `a` by `b` using Lua's floating-point division.             |
| [`idiv`](#idiv) | Divide `a` by `b` and return the integer quotient (`//` behavior). |
| [`mod`](#mod)   | Return the modulo remainder of `a` divided by `b`.                 |
| [`pow`](#pow)   | Raise `a` to the power of `b`.                                     |
| [`unm`](#unm)   | Negate a number.                                                   |

**Comparison**:

| Function      | Description                                        |
| ------------- | -------------------------------------------------- |
| [`eq`](#eq)   | Check whether two values are equal.                |
| [`neq`](#neq) | Check whether two values are not equal.            |
| [`lt`](#lt)   | Check whether `a` is strictly less than `b`.       |
| [`le`](#le)   | Check whether `a` is less than or equal to `b`.    |
| [`gt`](#gt)   | Check whether `a` is strictly greater than `b`.    |
| [`ge`](#ge)   | Check whether `a` is greater than or equal to `b`. |

**Logical**:

| Function        | Description                                          |
| --------------- | ---------------------------------------------------- |
| [`land`](#land) | Evaluate `a and b` with Lua short-circuit semantics. |
| [`lor`](#lor)   | Evaluate `a or b` with Lua short-circuit semantics.  |
| [`lnot`](#lnot) | Return the boolean negation of `a`.                  |

**String & Length**:

| Function            | Description                                                      |
| ------------------- | ---------------------------------------------------------------- |
| [`concat`](#concat) | Concatenate two strings.                                         |
| [`len`](#len)       | Return the length of a string or table using Lua's `#` operator. |

**Tables & Calls**:

| Function                | Description                                                    |
| ----------------------- | -------------------------------------------------------------- |
| [`index`](#index)       | Return the value at key/index `k` in table `t`.                |
| [`setindex`](#setindex) | Set `t[k] = v` and return the assigned value.                  |
| [`call`](#call)         | Call a function with variadic arguments and return its result. |

### Arithmetic

Numeric arithmetic operators as functions.

#### `add`

Add two numbers.

```lua
add(1, 2) --> 3
```

#### `sub`

Subtract `b` from `a`.

```lua
sub(5, 3) --> 2
```

#### `mul`

Multiply two numbers.

```lua
mul(3, 4) --> 12
```

#### `div`

Divide `a` by `b` using Lua's floating-point division.

```lua
div(10, 4) --> 2.5
```

#### `idiv`

Divide `a` by `b` and return the integer quotient (`//` behavior).

```lua
idiv(5, 2) --> 2
```

#### `mod`

Return the modulo remainder of `a` divided by `b`.

```lua
mod(5, 2) --> 1
```

#### `pow`

Raise `a` to the power of `b`.

```lua
pow(2, 4) --> 16
```

#### `unm`

Negate a number.

```lua
unm(3) --> -3
```

### Comparison

Equality and ordering comparison operators.

#### `eq`

Check whether two values are equal.

```lua
eq(1, 1) --> true
```

#### `neq`

Check whether two values are not equal.

```lua
neq(1, 2) --> true
```

#### `lt`

Check whether `a` is strictly less than `b`.

```lua
lt(1, 2) --> true
```

#### `le`

Check whether `a` is less than or equal to `b`.

```lua
lte(2, 2) --> true
```

#### `gt`

Check whether `a` is strictly greater than `b`.

```lua
gt(3, 2) --> true
```

#### `ge`

Check whether `a` is greater than or equal to `b`.

```lua
gte(2, 2) --> true
```

### Logical

Boolean logic operators with Lua truthiness semantics.

#### `land`

Evaluate `a and b` with Lua short-circuit semantics.

```lua
land(true, false) --> false
```

#### `lor`

Evaluate `a or b` with Lua short-circuit semantics.

```lua
lor(false, true) --> true
```

#### `lnot`

Return the boolean negation of `a`.

```lua
lnot(true) --> false
```

### String & Length

String concatenation and length operators.

#### `concat`

Concatenate two strings.

```lua
concat("a", "b") --> "ab"
```

#### `len`

Return the length of a string or table using Lua's `#` operator.

```lua
len("abc") --> 3
```

### Tables & Calls

Table indexing helpers and function invocation.

#### `index`

Return the value at key/index `k` in table `t`.

```lua
index({ a = 1 }, "a") --> 1
```

#### `setindex`

Set `t[k] = v` and return the assigned value.

```lua
setindex({}, "a", 1) --> 1
```

#### `call`

Call a function with variadic arguments and return its result.

```lua
call(math.max, 1, 2) --> 2
```
