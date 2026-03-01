---@meta mods.operator

---
---Operator helpers as functions.
---
---## Usage
---
---```lua
---operator = require "mods.operator"
---
---print(operator.add(1, 2)) --> 3
---```
---
---@class mods.operator
local M = {}

--------------------------------------------------------------------------------
---------------------------------- Arithmetic ----------------------------------
--------------------------------------------------------------------------------
---
---Numeric arithmetic operators as functions.
---

---
---Add two numbers.
---
---```lua
---add(1, 2) --> 3
---```
---
---@param a number Left numeric value.
---@param b number Right numeric value.
---@return number sum Sum of `a` and `b`.
---@nodiscard
function M.add(a, b) end

---
---Subtract `b` from `a`.
---
---```lua
---sub(5, 3) --> 2
---```
---
---@param a number Left numeric value.
---@param b number Right numeric value.
---@return number difference Difference `a - b`.
---@nodiscard
function M.sub(a, b) end

---
---Multiply two numbers.
---
---```lua
---mul(3, 4) --> 12
---```
---
---@param a number Left numeric value.
---@param b number Right numeric value.
---@return number product Product `a * b`.
---@nodiscard
function M.mul(a, b) end

---
---Divide `a` by `b` using Lua's floating-point division.
---
---```lua
---div(10, 4) --> 2.5
---```
---
---@param a number Dividend value.
---@param b number Divisor value.
---@return number quotient Quotient `a / b`.
---@nodiscard
function M.div(a, b) end

---
---Divide `a` by `b` and return the floor-division quotient.
---
---```lua
---idiv(5, 2) --> 2
---```
---
---@param a number Dividend value.
---@param b number Divisor value.
---@return integer quotient Floor-division result.
---@nodiscard
function M.idiv(a, b) end

---
---Return the modulo remainder of `a` divided by `b`.
---
---```lua
---mod(5, 2) --> 1
---```
---
---@param a number Dividend value.
---@param b number Divisor value.
---@return number remainder Remainder of `a % b`.
---@nodiscard
function M.mod(a, b) end

---
---Raise `a` to the power of `b`.
---
---```lua
---pow(2, 4) --> 16
---```
---
---@param a number Base value.
---@param b number Exponent value.
---@return number power Result of `a ^ b`.
---@nodiscard
function M.pow(a, b) end

---
---Negate a number.
---
---```lua
---unm(3) --> -3
---```
---
---@param a number Input numeric value.
---@return number negated Result of `-a`.
---@nodiscard
function M.unm(a) end

--------------------------------------------------------------------------------
---------------------------------- Comparison ----------------------------------
--------------------------------------------------------------------------------
---
---Equality and ordering comparison operators.
---

---
---Check whether two values are equal.
---
---```lua
---eq(1, 1) --> true
---```
---
---@param a any Left value.
---@param b any Right value.
---@return boolean isEqual True when `a == b`.
---@nodiscard
function M.eq(a, b) end

---
---Check whether two values are not equal.
---
---```lua
---neq(1, 2) --> true
---```
---
---@param a any Left value.
---@param b any Right value.
---@return boolean isNotEqual True when `a ~= b`.
---@nodiscard
function M.neq(a, b) end

---
---Check whether `a` is strictly less than `b`.
---
---```lua
---lt(1, 2) --> true
---```
---
---@param a number Left numeric value.
---@param b number Right numeric value.
---@return boolean isLess True when `a < b`.
---@nodiscard
function M.lt(a, b) end

---
---Check whether `a` is less than or equal to `b`.
---
---```lua
---le(2, 2) --> true
---```
---
---@param a number Left numeric value.
---@param b number Right numeric value.
---@return boolean isLessOrEqual True when `a <= b`.
---@nodiscard
function M.le(a, b) end

---
---Check whether `a` is strictly greater than `b`.
---
---```lua
---gt(3, 2) --> true
---```
---
---@param a number Left numeric value.
---@param b number Right numeric value.
---@return boolean isGreater True when `a > b`.
---@nodiscard
function M.gt(a, b) end

---
---Check whether `a` is greater than or equal to `b`.
---
---```lua
---ge(2, 2) --> true
---```
---
---@param a number Left numeric value.
---@param b number Right numeric value.
---@return boolean isGreaterOrEqual True when `a >= b`.
---@nodiscard
function M.ge(a, b) end

--------------------------------------------------------------------------------
------------------------------------ Logical -----------------------------------
--------------------------------------------------------------------------------
---
---Boolean logic operators with Lua truthiness semantics.
---

---
---Evaluate `a and b` with Lua short-circuit semantics.
---
---```lua
---land(true, false) --> false
---```
---
---@generic T1,T2
---@param a T1 First operand.
---@param b T2 Second operand.
---@return T1|T2 andValue Result of `a and b`.
---@nodiscard
function M.land(a, b) end

---
---Evaluate `a or b` with Lua short-circuit semantics.
---
---```lua
---lor(false, true) --> true
---```
---
---@generic T1,T2
---@param a T1 First operand.
---@param b T2 Second operand.
---@return T1|T2 orValue Result of `a or b`.
---@nodiscard
function M.lor(a, b) end

---
---Return the boolean negation of `a`.
---
---```lua
---lnot(true) --> false
---```
---
---@param a any Input value.
---@return boolean isNot Result of `not a`.
---@nodiscard
function M.lnot(a) end

--------------------------------------------------------------------------------
------------------------------- String & Length --------------------------------
--------------------------------------------------------------------------------
---
---String concatenation and length operators.
---

---
---Concatenate two strings.
---
---```lua
---concat("a", "b") --> "ab"
---```
---
---@param a string Left string.
---@param b string Right string.
---@return string concatenated Concatenated result `a .. b`.
---@nodiscard
function M.concat(a, b) end

---
---Return the length of a string or table using Lua's `#` operator.
---
---```lua
---len("abc") --> 3
---```
---
---@param a string|table Value supporting Lua's `#` operator.
---@return integer length Length computed by `#a`.
---@nodiscard
function M.len(a) end

--------------------------------------------------------------------------------
-------------------------------- Tables & Calls --------------------------------
--------------------------------------------------------------------------------
---
---Table indexing helpers and function invocation.
---

---
---Return the value at key/index `k` in table `t`.
---
---```lua
---index({ a = 1 }, "a") --> 1
---```
---
---@generic T
---@param t table Source table.
---@param k T Key/index value.
---@return T value Value stored at `t[k]`.
---@nodiscard
function M.index(t, k) end

---
---Set `t[k] = v` and return the assigned value.
---
---```lua
---setindex({}, "a", 1) --> 1
---```
---
---@generic T
---@param t table Target table.
---@param k any Key/index value.
---@param v T Value to set.
---@return T value Assigned value `v`.
---@nodiscard
function M.setindex(t, k, v) end

---
---Call a function with variadic arguments and return its result.
---
---```lua
---call(math.max, 1, 2) --> 2
---```
---
---@generic T1,T2
---@param f fun(...:T1):T2 Function to call.
---@param ... T1 Additional arguments.
---@return T2 result Return value(s) from `f(...)`.
---@nodiscard
function M.call(f, ...) end

return M
