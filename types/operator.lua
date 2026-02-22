---@meta mods.operator

---Operator helpers as functions.
---## Usage
---
---```lua
---operator = require "mods.operator"
---
---print(operator.add(1, 2)) -->> 3
---```
---@class mods.operator
local M = {}

--------------------------------------------------------------------------------
---------------------------------- Arithmetic ----------------------------------
--------------------------------------------------------------------------------
---Numeric arithmetic operators as functions.

---Add two numbers.
---
---```lua
---add(1, 2) --> 3
---```
---@param a number
---@param b number
---@return number sum
---@nodiscard
function M.add(a, b) end

---Subtract `b` from `a`.
---
---```lua
---sub(5, 3) --> 2
---```
---@param a number
---@param b number
---@return number difference
---@nodiscard
function M.sub(a, b) end

---Multiply two numbers.
---
---```lua
---mul(3, 4) --> 12
---```
---@param a number
---@param b number
---@return number product
---@nodiscard
function M.mul(a, b) end

---Divide `a` by `b` using Lua's floating-point division.
---
---```lua
---div(10, 4) --> 2.5
---```
---@param a number
---@param b number
---@return number quotient
---@nodiscard
function M.div(a, b) end

---Divide `a` by `b` and return the integer quotient (`//` behavior).
---
---```lua
---idiv(5, 2) --> 2
---```
---@param a number
---@param b number
---@return integer quotient
---@nodiscard
function M.idiv(a, b) end

---Return the modulo remainder of `a` divided by `b`.
---
---```lua
---mod(5, 2) --> 1
---```
---@param a number
---@param b number
---@return number remainder
---@nodiscard
function M.mod(a, b) end

---Raise `a` to the power of `b`.
---
---```lua
---pow(2, 4) --> 16
---```
---@param a number
---@param b number
---@return number power
---@nodiscard
function M.pow(a, b) end

---Negate a number.
---
---```lua
---unm(3) --> -3
---```
---@param a number
---@return number negated
---@nodiscard
function M.unm(a) end

--------------------------------------------------------------------------------
---------------------------------- Comparison ----------------------------------
--------------------------------------------------------------------------------
---Equality and ordering comparison operators.

---Check whether two values are equal.
---
---```lua
---eq(1, 1) --> true
---```
---@param a any
---@param b any
---@return boolean isEqual
---@nodiscard
function M.eq(a, b) end

---Check whether two values are not equal.
---
---```lua
---neq(1, 2) --> true
---```
---@param a any
---@param b any
---@return boolean isNotEqual
---@nodiscard
function M.neq(a, b) end

---Check whether `a` is strictly less than `b`.
---
---```lua
---lt(1, 2) --> true
---```
---@param a number
---@param b number
---@return boolean isLess
---@nodiscard
function M.lt(a, b) end

---Check whether `a` is less than or equal to `b`.
---
---```lua
---lte(2, 2) --> true
---```
---@param a number
---@param b number
---@return boolean isLessOrEqual
---@nodiscard
function M.le(a, b) end

---Check whether `a` is strictly greater than `b`.
---
---```lua
---gt(3, 2) --> true
---```
---@param a number
---@param b number
---@return boolean isGreater
---@nodiscard
function M.gt(a, b) end

---Check whether `a` is greater than or equal to `b`.
---
---```lua
---gte(2, 2) --> true
---```
---@param a number
---@param b number
---@return boolean isGreaterOrEqual
---@nodiscard
function M.ge(a, b) end

--------------------------------------------------------------------------------
------------------------------------ Logical -----------------------------------
--------------------------------------------------------------------------------
---Boolean logic operators with Lua truthiness semantics.

---Evaluate `a and b` with Lua short-circuit semantics.
---
---```lua
---land(true, false) --> false
---```
---@generic T1,T2
---@param a T1
---@param b T2
---@return T1|T2 andValue
---@nodiscard
function M.land(a, b) end

---Evaluate `a or b` with Lua short-circuit semantics.
---
---```lua
---lor(false, true) --> true
---```
---@generic T1,T2
---@param a T1
---@param b T2
---@return T1|T2 orValue
---@nodiscard
function M.lor(a, b) end

---Return the boolean negation of `a`.
---
---```lua
---lnot(true) --> false
---```
---@param a any
---@return boolean isNot
---@nodiscard
function M.lnot(a) end

--------------------------------------------------------------------------------
------------------------------- String & Length --------------------------------
--------------------------------------------------------------------------------
---String concatenation and length operators.

---Concatenate two strings.
---
---```lua
---concat("a", "b") --> "ab"
---```
---@param a string
---@param b string
---@return string concatenated
---@nodiscard
function M.concat(a, b) end

---Return the length of a string or table using Lua's `#` operator.
---
---```lua
---len("abc") --> 3
---```
---@param a string|table
---@return integer length
---@nodiscard
function M.len(a) end

--------------------------------------------------------------------------------
-------------------------------- Tables & Calls --------------------------------
--------------------------------------------------------------------------------
---Table indexing helpers and function invocation.

---Return the value at key/index `k` in table `t`.
---
---```lua
---index({ a = 1 }, "a") --> 1
---```
---@generic T
---@param t table
---@param k T
---@return T value
---@nodiscard
function M.index(t, k) end

---Set `t[k] = v` and return the assigned value.
---
---```lua
---setindex({}, "a", 1) --> 1
---```
---@generic T
---@param t table
---@param k any
---@param v T
---@return T value
---@nodiscard
function M.setindex(t, k, v) end

---Call a function with variadic arguments and return its result.
---
---```lua
---call(math.max, 1, 2) --> 2
---```
---@generic T,T2
---@param f fun(...:T):T2
---@param ... T
---@return T2 result
---@nodiscard
function M.call(f, ...) end

return M
