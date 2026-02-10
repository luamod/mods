local floor = math.floor

---@type mods.operator
local M = {}

-- stylua: ignore start
function M.add(a, b) return a + b end
function M.sub(a, b) return a - b end
function M.mul(a, b) return a * b end
function M.div(a, b) return a / b end
function M.idiv(a, b) return floor(a / b) end
function M.mod(a, b) return a % b end
function M.pow(a, b) return a ^ b end
function M.unm(a) return -a end

function M.eq(a, b) return a == b end
function M.neq(a, b) return a ~= b end
function M.lt(a, b) return a < b end
function M.le(a, b) return a <= b end
function M.gt(a, b) return a > b end
function M.ge(a, b) return a >= b end

function M.land(a, b) return a and b end
function M.lor(a, b) return a or b end
function M.lnot(a) return not a end

function M.concat(a, b) return a .. b end
function M.len(a) return #a end

function M.index(t, k) return t[k] end
function M.setindex(t, k, v) t[k] = v return v end
function M.call(f, ...) return f(...) end

return M
