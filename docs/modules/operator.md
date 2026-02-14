---
title: operator
description:
  Operator helpers exposed as functions for arithmetic, comparison, logic, and
  indexing.
---

# `operator`

Operator helpers as functions.

## Quick Reference

**Arithmetic**

| Function                    | Description                                   |
| --------------------------- | --------------------------------------------- |
| [`add(a, b)`](#fn-adda-b)   | Returns `a + b`.                              |
| [`sub(a, b)`](#fn-suba-b)   | Returns `a - b`.                              |
| [`mul(a, b)`](#fn-mula-b)   | Returns `a * b`.                              |
| [`div(a, b)`](#fn-diva-b)   | Returns `a / b`.                              |
| [`idiv(a, b)`](#fn-idiva-b) | Returns integer division `math.floor(a / b)`. |
| [`mod(a, b)`](#fn-moda-b)   | Returns `a % b`.                              |
| [`pow(a, b)`](#fn-powa-b)   | Returns `a ^ b`.                              |
| [`unm(a)`](#fn-unma)        | Returns `-a`.                                 |

**Comparison**

| Function                  | Description       |
| ------------------------- | ----------------- |
| [`eq(a, b)`](#fn-eqa-b)   | Returns `a == b`. |
| [`neq(a, b)`](#fn-neqa-b) | Returns `a ~= b`. |
| [`lt(a, b)`](#fn-lta-b)   | Returns `a < b`.  |
| [`le(a, b)`](#fn-lea-b)   | Returns `a <= b`. |
| [`gt(a, b)`](#fn-gta-b)   | Returns `a > b`.  |
| [`ge(a, b)`](#fn-gea-b)   | Returns `a >= b`. |

**Logical**

| Function                    | Description        |
| --------------------------- | ------------------ |
| [`land(a, b)`](#fn-landa-b) | Returns `a and b`. |
| [`lor(a, b)`](#fn-lora-b)   | Returns `a or b`.  |
| [`lnot(a)`](#fn-lnota)      | Returns `not a`.   |

**String & Length**

| Function                        | Description       |
| ------------------------------- | ----------------- |
| [`concat(a, b)`](#fn-concata-b) | Returns `a .. b`. |
| [`len(a)`](#fn-lena)            | Returns `#a`.     |

**Tables & Calls**

| Function                                 | Description                      |
| ---------------------------------------- | -------------------------------- |
| [`index(t, k)`](#fn-indext-k)            | Returns `t[k]`.                  |
| [`setindex(t, k, v)`](#fn-setindext-k-v) | Sets `t[k] = v` and returns `v`. |
| [`call(f, ...)`](#fn-callf-...)          | Calls `f(...)`.                  |

## Functions

### Arithmetic

#### `add(a, b)` {#fn-adda-b}

Returns `a + b`.

:::tabs == Example

```lua
add(1, 2) -- 3
```

== Signature

```lua
---@param a number
---@param b number
---@return number sum
---@nodiscard
function add(a, b) end
```

:::

#### `sub(a, b)` {#fn-suba-b}

Returns `a - b`.

:::tabs == Example

```lua
sub(5, 3) -- 2
```

== Signature

```lua
---@param a number
---@param b number
---@return number difference
---@nodiscard
function sub(a, b) end
```

:::

#### `mul(a, b)` {#fn-mula-b}

Returns `a * b`.

:::tabs == Example

```lua
mul(3, 4) -- 12
```

== Signature

```lua
---@param a number
---@param b number
---@return number product
---@nodiscard
function mul(a, b) end
```

:::

#### `div(a, b)` {#fn-diva-b}

Returns `a / b`.

:::tabs == Example

```lua
div(10, 4) -- 2.5
```

== Signature

```lua
---@param a number
---@param b number
---@return number quotient
---@nodiscard
function div(a, b) end
```

:::

#### `idiv(a, b)` {#fn-idiva-b}

Returns integer division `math.floor(a / b)`.

:::tabs == Example

```lua
idiv(5, 2) -- 2
```

== Signature

```lua
---@param a number
---@param b number
---@return integer quotient
---@nodiscard
function idiv(a, b) end
```

:::

#### `mod(a, b)` {#fn-moda-b}

Returns `a % b`.

:::tabs == Example

```lua
mod(5, 2) -- 1
```

== Signature

```lua
---@param a number
---@param b number
---@return number remainder
---@nodiscard
function mod(a, b) end
```

:::

#### `pow(a, b)` {#fn-powa-b}

Returns `a ^ b`.

:::tabs == Example

```lua
pow(2, 4) -- 16
```

== Signature

```lua
---@param a number
---@param b number
---@return number power
---@nodiscard
function pow(a, b) end
```

:::

#### `unm(a)` {#fn-unma}

Returns `-a`.

:::tabs == Example

```lua
unm(3) -- -3
```

== Signature

```lua
---@param a number
---@return number negated
---@nodiscard
function unm(a) end
```

:::

### Comparison

#### `eq(a, b)` {#fn-eqa-b}

Returns `a == b`.

:::tabs == Example

```lua
eq(1, 1) -- true
```

== Signature

```lua
---@param a any
---@param b any
---@return boolean isEqual
---@nodiscard
function eq(a, b) end
```

:::

#### `neq(a, b)` {#fn-neqa-b}

Returns `a ~= b`.

:::tabs == Example

```lua
neq(1, 2) -- true
```

== Signature

```lua
---@param a any
---@param b any
---@return boolean isNotEqual
---@nodiscard
function neq(a, b) end
```

:::

#### `lt(a, b)` {#fn-lta-b}

Returns `a < b`.

:::tabs == Example

```lua
lt(1, 2) -- true
```

== Signature

```lua
---@param a number
---@param b number
---@return boolean isLess
---@nodiscard
function lt(a, b) end
```

:::

#### `le(a, b)` {#fn-lea-b}

Returns `a <= b`.

:::tabs == Example

```lua
lte(2, 2) -- true
```

== Signature

```lua
---@param a number
---@param b number
---@return boolean isLessOrEqual
---@nodiscard
function le(a, b) end
```

:::

#### `gt(a, b)` {#fn-gta-b}

Returns `a > b`.

:::tabs == Example

```lua
gt(3, 2) -- true
```

== Signature

```lua
---@param a number
---@param b number
---@return boolean isGreater
---@nodiscard
function gt(a, b) end
```

:::

#### `ge(a, b)` {#fn-gea-b}

Returns `a >= b`.

:::tabs == Example

```lua
gte(2, 2) -- true
```

== Signature

```lua
---@param a number
---@param b number
---@return boolean isGreaterOrEqual
---@nodiscard
function ge(a, b) end
```

:::

### Logical

#### `land(a, b)` {#fn-landa-b}

Returns `a and b`.

:::tabs == Example

```lua
land(true, false) -- false
```

== Signature

```lua
---@generic T1,T2
---@param a T1
---@param b T2
---@return T1|T2 andValue
---@nodiscard
function land(a, b) end
```

:::

#### `lor(a, b)` {#fn-lora-b}

Returns `a or b`.

:::tabs == Example

```lua
lor(false, true) -- true
```

== Signature

```lua
---@generic T1,T2
---@param a T1
---@param b T2
---@return T1|T2 orValue
---@nodiscard
function lor(a, b) end
```

:::

#### `lnot(a)` {#fn-lnota}

Returns `not a`.

:::tabs == Example

```lua
lnot(true) -- false
```

== Signature

```lua
---@param a any
---@return boolean isNot
---@nodiscard
function lnot(a) end
```

:::

### String & Length

#### `concat(a, b)` {#fn-concata-b}

Returns `a .. b`.

:::tabs == Example

```lua
concat("a", "b") -- "ab"
```

== Signature

```lua
---@param a string
---@param b string
---@return string concatenated
---@nodiscard
function concat(a, b) end
```

:::

#### `len(a)` {#fn-lena}

Returns `#a`.

:::tabs == Example

```lua
len("abc") -- 3
```

== Signature

```lua
---@param a string|table
---@return integer length
---@nodiscard
function len(a) end
```

:::

### Tables & Calls

#### `index(t, k)` {#fn-indext-k}

Returns `t[k]`.

:::tabs == Example

```lua
index({ a = 1 }, "a") -- 1
```

== Signature

```lua
---@generic T
---@param t table
---@param k T
---@return T value
---@nodiscard
function index(t, k) end
```

:::

#### `setindex(t, k, v)` {#fn-setindext-k-v}

Sets `t[k] = v` and returns `v`.

:::tabs == Example

```lua
setindex({}, "a", 1) -- 1
```

== Signature

```lua
---@generic T
---@param t table
---@param k any
---@param v T
---@return T value
---@nodiscard
function setindex(t, k, v) end
```

:::

#### `call(f, ...)` {#fn-callf-...}

Calls `f(...)`.

:::tabs == Example

```lua
call(math.max, 1, 2) -- 2
```

== Signature

```lua
---@generic T,T2
---@param f fun(...:T):T2
---@param ... T
---@return T2 result
---@nodiscard
function call(f, ...) end
```

:::
