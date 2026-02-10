---@meta mods.operator

---Operator helpers as functions.
---@class mods.operator
local M = {}

--------------------------------------------------------------------------------
---------------------------------- Arithmetic ----------------------------------
--------------------------------------------------------------------------------

---Returns `a + b`.
---
---**Example:**
---```lua
---add(1, 2) -- 3
---```
---@param a number
---@param b number
---@return number sum
---@nodiscard
function M.add(a, b) end

---Returns `a - b`.
---
---**Example:**
---```lua
---sub(5, 3) -- 2
---```
---@param a number
---@param b number
---@return number difference
---@nodiscard
function M.sub(a, b) end

---Returns `a * b`.
---
---**Example:**
---```lua
---mul(3, 4) -- 12
---```
---@param a number
---@param b number
---@return number product
---@nodiscard
function M.mul(a, b) end

---Returns `a / b`.
---
---**Example:**
---```lua
---div(10, 4) -- 2.5
---```
---@param a number
---@param b number
---@return number quotient
---@nodiscard
function M.div(a, b) end

---Returns integer division `math.floor(a / b)`.
---
---**Example:**
---```lua
---idiv(5, 2) -- 2
---```
---@param a number
---@param b number
---@return integer quotient
---@nodiscard
function M.idiv(a, b) end

---Returns `a % b`.
---
---**Example:**
---```lua
---mod(5, 2) -- 1
---```
---@param a number
---@param b number
---@return number remainder
---@nodiscard
function M.mod(a, b) end

---Returns `a ^ b`.
---
---**Example:**
---```lua
---pow(2, 4) -- 16
---```
---@param a number
---@param b number
---@return number power
---@nodiscard
function M.pow(a, b) end

---Returns `-a`.
---
---**Example:**
---```lua
---unm(3) -- -3
---```
---@param a number
---@return number negated
---@nodiscard
function M.unm(a) end

--------------------------------------------------------------------------------
---------------------------------- Comparison ----------------------------------
--------------------------------------------------------------------------------

---Returns `a == b`.
---
---**Example:**
---```lua
---eq(1, 1) -- true
---```
---@param a any
---@param b any
---@return boolean isEqual
---@nodiscard
function M.eq(a, b) end

---Returns `a ~= b`.
---
---**Example:**
---```lua
---neq(1, 2) -- true
---```
---@param a any
---@param b any
---@return boolean isNotEqual
---@nodiscard
function M.neq(a, b) end

---Returns `a < b`.
---
---**Example:**
---```lua
---lt(1, 2) -- true
---```
---@param a number
---@param b number
---@return boolean isLess
---@nodiscard
function M.lt(a, b) end

---Returns `a <= b`.
---
---**Example:**
---```lua
---lte(2, 2) -- true
---```
---@param a number
---@param b number
---@return boolean isLessOrEqual
---@nodiscard
function M.le(a, b) end

---Returns `a > b`.
---
---**Example:**
---```lua
---gt(3, 2) -- true
---```
---@param a number
---@param b number
---@return boolean isGreater
---@nodiscard
function M.gt(a, b) end

---Returns `a >= b`.
---
---**Example:**
---```lua
---gte(2, 2) -- true
---```
---@param a number
---@param b number
---@return boolean isGreaterOrEqual
---@nodiscard
function M.ge(a, b) end

--------------------------------------------------------------------------------
------------------------------------ Logical -----------------------------------
--------------------------------------------------------------------------------

---Returns `a and b`.
---
---**Example:**
---```lua
---land(true, false) -- false
---```
---@generic T1,T2
---@param a T1
---@param b T2
---@return T1|T2 andValue
---@nodiscard
function M.land(a, b) end

---Returns `a or b`.
---
---**Example:**
---```lua
---lor(false, true) -- true
---```
---@generic T1,T2
---@param a T1
---@param b T2
---@return T1|T2 orValue
---@nodiscard
function M.lor(a, b) end

---Returns `not a`.
---
---**Example:**
---```lua
---lnot(true) -- false
---```
---@param a any
---@return boolean isNot
---@nodiscard
function M.lnot(a) end

--------------------------------------------------------------------------------
------------------------------- String & Length --------------------------------
--------------------------------------------------------------------------------

---Returns `a .. b`.
---
---**Example:**
---```lua
---concat("a", "b") -- "ab"
---```
---@param a string
---@param b string
---@return string concatenated
---@nodiscard
function M.concat(a, b) end

---Returns `#a`.
---
---**Example:**
---```lua
---len("abc") -- 3
---```
---@param a string|table
---@return integer length
---@nodiscard
function M.len(a) end

--------------------------------------------------------------------------------
-------------------------------- Tables & Calls --------------------------------
--------------------------------------------------------------------------------

---Returns `t[k]`.
---
---**Example:**
---```lua
---index({ a = 1 }, "a") -- 1
---```
---@generic T
---@param t table
---@param k T
---@return T value
---@nodiscard
function M.index(t, k) end

---Sets `t[k] = v` and returns `v`.
---
---**Example:**
---```lua
---setindex({}, "a", 1) -- 1
---```
---@generic T
---@param t table
---@param k any
---@param v T
---@return T value
---@nodiscard
function M.setindex(t, k, v) end

---Calls `f(...)`.
---
---**Example:**
---```lua
---call(math.max, 1, 2) -- 2
---```
---@generic T,T2
---@param f fun(...:T):T2
---@param ... T
---@return T2 result
---@nodiscard
function M.call(f, ...) end

return M
