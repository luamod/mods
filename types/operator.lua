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
---operator.add(1, 2) -- 3
---```
---@param a number
---@param b number
---@return number
---@nodiscard
function M.add(a, b) end

---Returns `a - b`.
---
---**Example:**
---```lua
---operator.sub(5, 3) -- 2
---```
---@param a number
---@param b number
---@return number
---@nodiscard
function M.sub(a, b) end

---Returns `a * b`.
---
---**Example:**
---```lua
---operator.mul(3, 4) -- 12
---```
---@param a number
---@param b number
---@return number
---@nodiscard
function M.mul(a, b) end

---Returns `a / b`.
---
---**Example:**
---```lua
---operator.div(10, 4) -- 2.5
---```
---@param a number
---@param b number
---@return number
---@nodiscard
function M.div(a, b) end

---Returns integer division `math.floor(a / b)`.
---
---**Example:**
---```lua
---operator.idiv(5, 2) -- 2
---```
---@param a number
---@param b number
---@return number
---@nodiscard
function M.idiv(a, b) end

---Returns `a % b`.
---
---**Example:**
---```lua
---operator.mod(5, 2) -- 1
---```
---@param a number
---@param b number
---@return number
---@nodiscard
function M.mod(a, b) end

---Returns `a ^ b`.
---
---**Example:**
---```lua
---operator.pow(2, 4) -- 16
---```
---@param a number
---@param b number
---@return number
---@nodiscard
function M.pow(a, b) end

---Returns `-a`.
---
---**Example:**
---```lua
---operator.unm(3) -- -3
---```
---@param a number
---@return number
---@nodiscard
function M.unm(a) end

--------------------------------------------------------------------------------
---------------------------------- Comparison ----------------------------------
--------------------------------------------------------------------------------

---Returns `a == b`.
---
---**Example:**
---```lua
---operator.eq(1, 1) -- true
---```
---@param a any
---@param b any
---@return boolean
---@nodiscard
function M.eq(a, b) end

---Returns `a ~= b`.
---
---**Example:**
---```lua
---operator.neq(1, 2) -- true
---```
---@param a any
---@param b any
---@return boolean
---@nodiscard
function M.neq(a, b) end

---Returns `a < b`.
---
---**Example:**
---```lua
---operator.lt(1, 2) -- true
---```
---@param a number
---@param b number
---@return boolean
---@nodiscard
function M.lt(a, b) end

---Returns `a <= b`.
---
---**Example:**
---```lua
---operator.lte(2, 2) -- true
---```
---@param a number
---@param b number
---@return boolean
---@nodiscard
function M.le(a, b) end

---Returns `a > b`.
---
---**Example:**
---```lua
---operator.gt(3, 2) -- true
---```
---@param a number
---@param b number
---@return boolean
---@nodiscard
function M.gt(a, b) end

---Returns `a >= b`.
---
---**Example:**
---```lua
---operator.gte(2, 2) -- true
---```
---@param a number
---@param b number
---@return boolean
---@nodiscard
function M.ge(a, b) end

--------------------------------------------------------------------------------
------------------------------------ Logical -----------------------------------
--------------------------------------------------------------------------------

---Returns `a and b`.
---
---**Example:**
---```lua
---operator.land(true, false) -- false
---```
---@param a any
---@param b any
---@return any
---@nodiscard
function M.land(a, b) end

---Returns `a or b`.
---
---**Example:**
---```lua
---operator.lor(false, true) -- true
---```
---@param a any
---@param b any
---@return any
---@nodiscard
function M.lor(a, b) end

---Returns `not a`.
---
---**Example:**
---```lua
---operator.lnot(true) -- false
---```
---@param a any
---@return boolean
---@nodiscard
function M.lnot(a) end

--------------------------------------------------------------------------------
------------------------------- String & Length --------------------------------
--------------------------------------------------------------------------------

---Returns `a .. b`.
---
---**Example:**
---```lua
---operator.concat("a", "b") -- "ab"
---```
---@param a string
---@param b string
---@return string
---@nodiscard
function M.concat(a, b) end

---Returns `#a`.
---
---**Example:**
---```lua
---operator.len("abc") -- 3
---```
---@param a string|table
---@return integer
---@nodiscard
function M.len(a) end

--------------------------------------------------------------------------------
-------------------------------- Tables & Calls --------------------------------
--------------------------------------------------------------------------------

---Returns `t[k]`.
---
---**Example:**
---```lua
---operator.index({ a = 1 }, "a") -- 1
---```
---@param t table
---@param k any
---@return any
---@nodiscard
function M.index(t, k) end

---Sets `t[k] = v` and returns `v`.
---
---**Example:**
---```lua
---operator.setindex({}, "a", 1) -- 1
---```
---@param t table
---@param k any
---@param v any
---@return any
---@nodiscard
function M.setindex(t, k, v) end

---Calls `f(...)`.
---
---**Example:**
---```lua
---operator.call(math.max, 1, 2) -- 2
---```
---@param f fun(...: any): any
---@param ... any
---@return any
---@nodiscard
function M.call(f, ...) end

return M
