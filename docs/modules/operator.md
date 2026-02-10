---
editLinkTarget: types/operator.lua
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

:::tabs
== Example

```lua
operator.add(1, 2) -- 3
```

== Signature

```lua
---@param a number
---@param b number
---@return number
---@nodiscard
function add(a, b) end
```

:::

#### `sub(a, b)` {#fn-suba-b}

Returns `a - b`.

:::tabs
== Example

```lua
operator.sub(5, 3) -- 2
```

== Signature

```lua
---@param a number
---@param b number
---@return number
---@nodiscard
function sub(a, b) end
```

:::

#### `mul(a, b)` {#fn-mula-b}

Returns `a * b`.

:::tabs
== Example

```lua
operator.mul(3, 4) -- 12
```

== Signature

```lua
---@param a number
---@param b number
---@return number
---@nodiscard
function mul(a, b) end
```

:::

#### `div(a, b)` {#fn-diva-b}

Returns `a / b`.

:::tabs
== Example

```lua
operator.div(10, 4) -- 2.5
```

== Signature

```lua
---@param a number
---@param b number
---@return number
---@nodiscard
function div(a, b) end
```

:::

#### `idiv(a, b)` {#fn-idiva-b}

Returns integer division `math.floor(a / b)`.

:::tabs
== Example

```lua
operator.idiv(5, 2) -- 2
```

== Signature

```lua
---@param a number
---@param b number
---@return number
---@nodiscard
function idiv(a, b) end
```

:::

#### `mod(a, b)` {#fn-moda-b}

Returns `a % b`.

:::tabs
== Example

```lua
operator.mod(5, 2) -- 1
```

== Signature

```lua
---@param a number
---@param b number
---@return number
---@nodiscard
function mod(a, b) end
```

:::

#### `pow(a, b)` {#fn-powa-b}

Returns `a ^ b`.

:::tabs
== Example

```lua
operator.pow(2, 4) -- 16
```

== Signature

```lua
---@param a number
---@param b number
---@return number
---@nodiscard
function pow(a, b) end
```

:::

#### `unm(a)` {#fn-unma}

Returns `-a`.

:::tabs
== Example

```lua
operator.unm(3) -- -3
```

== Signature

```lua
---@param a number
---@return number
---@nodiscard
function unm(a) end
```

:::

### Comparison

#### `eq(a, b)` {#fn-eqa-b}

Returns `a == b`.

:::tabs
== Example

```lua
operator.eq(1, 1) -- true
```

== Signature

```lua
---@param a any
---@param b any
---@return boolean
---@nodiscard
function eq(a, b) end
```

:::

#### `neq(a, b)` {#fn-neqa-b}

Returns `a ~= b`.

:::tabs
== Example

```lua
operator.neq(1, 2) -- true
```

== Signature

```lua
---@param a any
---@param b any
---@return boolean
---@nodiscard
function neq(a, b) end
```

:::

#### `lt(a, b)` {#fn-lta-b}

Returns `a < b`.

:::tabs
== Example

```lua
operator.lt(1, 2) -- true
```

== Signature

```lua
---@param a number
---@param b number
---@return boolean
---@nodiscard
function lt(a, b) end
```

:::

#### `le(a, b)` {#fn-lea-b}

Returns `a <= b`.

:::tabs
== Example

```lua
operator.lte(2, 2) -- true
```

== Signature

```lua
---@param a number
---@param b number
---@return boolean
---@nodiscard
function le(a, b) end
```

:::

#### `gt(a, b)` {#fn-gta-b}

Returns `a > b`.

:::tabs
== Example

```lua
operator.gt(3, 2) -- true
```

== Signature

```lua
---@param a number
---@param b number
---@return boolean
---@nodiscard
function gt(a, b) end
```

:::

#### `ge(a, b)` {#fn-gea-b}

Returns `a >= b`.

:::tabs
== Example

```lua
operator.gte(2, 2) -- true
```

== Signature

```lua
---@param a number
---@param b number
---@return boolean
---@nodiscard
function ge(a, b) end
```

:::

### Logical

#### `land(a, b)` {#fn-landa-b}

Returns `a and b`.

:::tabs
== Example

```lua
operator.land(true, false) -- false
```

== Signature

```lua
---@param a any
---@param b any
---@return any
---@nodiscard
function land(a, b) end
```

:::

#### `lor(a, b)` {#fn-lora-b}

Returns `a or b`.

:::tabs
== Example

```lua
operator.lor(false, true) -- true
```

== Signature

```lua
---@param a any
---@param b any
---@return any
---@nodiscard
function lor(a, b) end
```

:::

#### `lnot(a)` {#fn-lnota}

Returns `not a`.

:::tabs
== Example

```lua
operator.lnot(true) -- false
```

== Signature

```lua
---@param a any
---@return boolean
---@nodiscard
function lnot(a) end
```

:::

### String & Length

#### `concat(a, b)` {#fn-concata-b}

Returns `a .. b`.

:::tabs
== Example

```lua
operator.concat("a", "b") -- "ab"
```

== Signature

```lua
---@param a string
---@param b string
---@return string
---@nodiscard
function concat(a, b) end
```

:::

#### `len(a)` {#fn-lena}

Returns `#a`.

:::tabs
== Example

```lua
operator.len("abc") -- 3
```

== Signature

```lua
---@param a string|table
---@return integer
---@nodiscard
function len(a) end
```

:::

### Tables & Calls

#### `index(t, k)` {#fn-indext-k}

Returns `t[k]`.

:::tabs
== Example

```lua
operator.index({ a = 1 }, "a") -- 1
```

== Signature

```lua
---@param t table
---@param k any
---@return any
---@nodiscard
function index(t, k) end
```

:::

#### `setindex(t, k, v)` {#fn-setindext-k-v}

Sets `t[k] = v` and returns `v`.

:::tabs
== Example

```lua
operator.setindex({}, "a", 1) -- 1
```

== Signature

```lua
---@param t table
---@param k any
---@param v any
---@return any
---@nodiscard
function setindex(t, k, v) end
```

:::

#### `call(f, ...)` {#fn-callf-...}

Calls `f(...)`.

:::tabs
== Example

```lua
operator.call(math.max, 1, 2) -- 2
```

== Signature

```lua
---@param f fun(...: any): any
---@param ... any
---@return any
---@nodiscard
function call(f, ...) end
```

:::
