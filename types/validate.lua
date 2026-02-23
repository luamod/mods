---@meta mods.validate

---@alias modsValidateType
---|type
---|'Boolean'
---|'Function'
---|'Nil'
---|'Number'
---|'String'
---|'Table'
---|'Thread'
---|'Userdata'
---
---|'callable'
---|'Callable'
---|'false'
---|'False'
---|'falsy'
---|'Falsy'
---|'integer'
---|'Integer'
---|'true'
---|'True'
---|'truthy'
---|'Truthy'
---
---|'block'
---|'Block'
---|'char'
---|'Char'
---|'device'
---|'Device'
---|'dir'
---|'Dir'
---|'fifo'
---|'Fifo'
---|'file'
---|'File'
---|'link'
---|'Link'
---|'socket'
---|'Socket'

---
---@ignore
---
---Validation checks for values and filesystem path types.
---entry to customize the error string returned by validators. Templates can use
---<code v-pre>{{expected}}</code>, <code v-pre>{{got}}</code>, and <code v-pre>{{value}}</code>.
---
---@class modsValidateMessages
---@field boolean? string
---@field function? string
---@field nil? string
---@field number? string
---@field string? string
---@field table? string
---@field thread? string
---@field userdata? string
---
---@field callable? string
---@field false? string
---@field falsy? string
---@field integer? string
---@field true? string
---@field truthy? string

---@class modsValidatePathMessages
---@field block? string
---@field char? string
---@field device? string
---@field dir? string
---@field fifo? string
---@field file? string
---@field link? string
---@field socket? string

---@class mods.validate.is
---@field private _name "is"
---@overload fun(v:any, tp?:modsValidateType):(boolean, string?)
local is = {}

---@class mods.validate.isNot
---@field private _name "isnot"
---@overload fun(v:any, tp?:modsValidateType):(boolean, string?)
local is_not = {}

---
---Validation checks for values and filesystem path types.
---
---## Usage
---
---```lua [.lua]
---validate= require "mods.validate"
---
---ok, err = validate.is.number("nope")
-----> false, "expected number, got string"
---
---ok, err = validate.is_not.number(3.14)
-----> false, "expected not number"
---```
---
---> [!IMPORTANT]
--->
---> Behavior without `tp`:
--->
---> * `validate()` is equivalent to `validate(nil, "nil")` (passes)
---> * `validate(1)` is equivalent to `validate(1, "nil")` (fails with
--->   `expected nil, got number`)
--->
---> Validator access is case-insensitive:
--->
---> * `validate.is.number` and `validate.IS.Number` are equivalent.
---> * Top-level aliases are underscore-insensitive:
--->   `validate.is_number`, `validate.IS_NUMBER`, and `validate.isnumber`.
---> * Negated validators are available via `is_not`, `isnot`, `isNot`, `not`,
--->   and `Not`, including underscore-insensitive top-level aliases (for
--->   example, `validate.is_not_number` and `validate.isnotnumber`).
---
---## Dependencies
---
---Dependencies below are lazy-loaded 💤 on first access.
---
---* [`lfs`](https://github.com/lunarmodules/luafilesystem) (optional; required
---  only for filesystem/path checks)
---* [`mods.is`](https://luamod.github.io/mods/modules/is)
---
---## Callable Forms
---
---`validate`, `validate.is`, and `validate.is_not` are all callable.
---
---```lua
---ok, err = validate(1, "number")        --> true, nil
---ok, err = validate.is("x", "string")   --> true, nil
---ok, err = validate.is_not(1, "number") --> false, "expected not number"
---```
---
---> [!IMPORTANT]
--->
---> When `tp` is omitted, the default check is `"nil"`:
--->
---> * `validate()` is equivalent to `validate(nil, "nil")` (passes)
---> * `validate(1)` is equivalent to `validate(1, "nil")` (fails)
--->
---> Callable namespace aliases are case-insensitive, and negated aliases are
---> underscore-insensitive:
--->
---> * `validate.is`, `validate.IS`
---> * `validate.is_not`, `validate.isnot`, `validate.isNot`,
---> `validate["not"]`, `validate.Not`
--->
---> ```lua
---> validate.is(1, "number")     --> true
---> validate.IS(1, "number")     --> true
---> validate.is_not(1, "number") --> false, "expected not number"
---> validate.Not(1, "number")    --> false, "expected not number"
---> ```
---
---## Custom Messages
---
---Customize validator error messages through `validate.messages`.
---
---* `validate.messages.positive.<name>` customizes positive checks
---* `validate.messages.negative.<name>` customizes negated checks
---
---`<name>` is the validator key (for example: `number`, `string`, `truthy`,
---`integer`, `callable`, `file`, `dir`, etc.).
---
---Available placeholders:
---
---* <code v-pre>{{expected}}</code>: The check target (for example `number`,
---  `string`, `truthy`).
---* <code v-pre>{{got}}</code>: The detected failure kind (usually a Lua type;
---  path validators use `invalid path`).
---* <code v-pre>{{value}}</code>: The passed value, formatted for display (strings
---  are quoted).
---
---### Example
---
---```lua
---validate.messages.positive.number = "need {{expected}}, got {{got}} (value={{value}})"
---validate.messages.negative.number = "must not be {{expected}} (value={{value}})"
---
---ok, err = validate.is.number("x")
-----> false, 'need number, got string (value="x")'
---
---ok, err = validate.is_not.number(42)
-----> false, "must not be number (value=42)"
---```
---
---## Default Messages
---
---By default, validate uses built-in templates unless
---`validate.messages.positive.<name>` or `validate.messages.negative.<name>` is
---overridden:
---
---- Positive type/value checks (`validate.is.*`):
---  `expected {{expected}}, got {{got}}`
---- Positive path checks (`validate.is.block`, `char`, `device`, `dir`, `fifo`,
---  `file`, `link`, `socket`): `{{value}} is not a valid {{expected}} path`
---- Negative checks (`validate.is_not.*`): `expected not {{expected}}`
---
---`integer` uses a more specific default that includes the passed value:
---
---- Positive `integer`: `expected integer, got {{value}}`
---- Negative `integer`: `expected non-integer, got {{value}}`
---
---## On Fail Hook
---
---Set `validate.on_fail` to handle failed validations globally.
---
---- If `on_fail` is set, it is called with the rendered error message.
---- If `on_fail` returns a truthy value, that value is used as the returned error.
---- If `on_fail` returns a falsy value, the default rendered error is returned.
---- If `on_fail` is `nil`, validators return `false, err` as usual.
---
---```lua
---validate.on_fail = function(errmsg)
---  print("validation failed:", errmsg)
---  return "custom failure"
---end
---
---ok, err = validate.number("x")
-----> prints -> validation failed: expected number, got string
-----> false, "custom failure"
---```
---
---@class mods.validate:mods.validate.is
---@field private _name "is"
---@field messages {positive:(modsValidateMessages|modsValidatePathMessages),negative:modsValidateMessages}
---@field is mods.validate.is
---@field Not mods.validate.isNot
---@field not mods.validate.isNot
---@field is_not mods.validate.isNot
---@field isNot mods.validate.isNot
---@field IsNot mods.validate.isNot
---
---Optional callback invoked when a validation check fails.
---Receives the rendered error message.
---* If it returns a truthy value, that value is used as the returned error.
---* If it returns a falsy value, the default rendered error is returned.
---
---@field on_fail? fun(errmsg:string):any
---@overload fun(v:any, tp?:modsValidateType):(boolean, string?)
local M = {}

--------------------------------------------------------------------------------
---------------------------------- Type Checks ---------------------------------
--------------------------------------------------------------------------------
---
---Basic Lua type validators (and their negated variants).
---

---
---Returns `true` when `v` is a boolean. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.boolean(true) --> true, nil
---ok, err = validate.is.boolean(1)    --> false, "expected boolean, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.boolean = function(v) end
is.Boolean = is.boolean

---
---@name function
---
---Returns `true` when `v` is a function. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.Function(function() end) --> true, nil
---ok, err = validate.is.Function(1)
-----> false, "expected function, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.Function = function(v) end
is["function"] = is.Function

---
---@name nil
---
---Returns `true` when `v` is `nil`. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.Nil(nil) --> true, nil
---ok, err = validate.is.Nil(0)   --> false, "expected nil, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.Nil = function(v) end
is["nil"] = is.Nil

---
---Returns `true` when `v` is a number. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.number(42)  --> true, nil
---ok, err = validate.is.number("x") --> false, "expected number, got string"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.number = function(v) end
is.Number = is.number

---
---Returns `true` when `v` is a string. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.string("hello") --> true, nil
---ok, err = validate.is.string(1)       --> false, "expected string, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.string = function(v) end
is.String = is.string

---
---Returns `true` when `v` is a table. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.table({}) --> true, nil
---ok, err = validate.is.table(1)  --> false, "expected table, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.table = function(v) end
is.Table = is.table

---
---Returns `true` when `v` is a thread. Otherwise returns `false` and an error
---message.
---
---```lua
---co = coroutine.create(function() end)
---ok, err = validate.is.thread(co) --> true, nil
---ok, err = validate.is.thread(1)  --> false, "expected thread, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.thread = function(v) end
is.Thread = is.thread

---
---Returns `true` when `v` is userdata. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.userdata(io.stdout) --> true, nil
---ok, err = validate.is.userdata(1)         --> false, "expected userdata, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.userdata = function(v) end
is.Userdata = is.userdata

---
---@name not_boolean
---
---Returns `true` when `v` is **not** a boolean. Otherwise returns `false` and
---an error message.
---
---```lua
---ok, err = validate.is_not.boolean(1)    --> true, nil
---ok, err = validate.is_not.boolean(true) --> false, "expected not boolean"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is_not.boolean = function(v) end
is_not.Boolean = is_not.boolean
M.is_not_boolean = is_not.boolean
M.isNotBoolean = is_not.boolean
M.not_boolean = is_not.boolean
M.notBoolean = is_not.boolean
M.NotBoolean = is_not.boolean

---
---@name not_function
---
---Returns `true` when `v` is **not** a function. Otherwise returns `false` and
---an error message.
---
---```lua
---ok, err = validate.is_not.Function(1)              --> true, nil
---ok, err = validate.is_not.Function(function() end) --> false, "expected not function"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is_not.Function = function(v) end
is_not["function"] = is_not.Function
M.is_not_function = is_not.Function
M.isNotFunction = is_not.Function
M.not_function = is_not.Function
M.notFunction = is_not.Function
M.NotFunction = is_not.Function

---
---@name not_nil
---
---Returns `true` when `v` is **not** `nil`. Otherwise returns `false` and an
---error message.
---
---```lua
---ok, err = validate.is_not.Nil(0)   --> true, nil
---ok, err = validate.is_not.Nil(nil) --> false, "expected not nil"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is_not.Nil = function(v) end
is_not["nil"] = is_not.Nil
M.is_not_nil = is_not.Nil
M.isNotNil = is_not.Nil
M.not_nil = is_not.Nil
M.notNil = is_not.Nil
M.NotNil = is_not.Nil

---
---@name not_number
---
---Returns `true` when `v` is **not** a number. Otherwise returns `false` and
---an error message.
---
---```lua
---ok, err = validate.is_not.number("x") --> true, nil
---ok, err = validate.is_not.number(42)  --> false, "expected not number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is_not.number = function(v) end
is_not.Number = is_not.number
M.is_not_number = is_not.number
M.isNotNumber = is_not.number
M.not_number = is_not.number
M.notNumber = is_not.number
M.NotNumber = is_not.number

---
---@name not_string
---
---Returns `true` when `v` is **not** a string. Otherwise returns `false` and
---an error message.
---
---```lua
---ok, err = validate.is_not.string(1)       --> true, nil
---ok, err = validate.is_not.string("hello") --> false, "expected not string"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is_not.string = function(v) end
is_not.String = is_not.string
M.is_not_string = is_not.string
M.isNotString = is_not.string
M.not_string = is_not.string
M.notString = is_not.string
M.NotString = is_not.string

---
---@name not_table
---
---Returns `true` when `v` is **not** a table. Otherwise returns `false` and an
---error message.
---
---```lua
---ok, err = validate.is_not.table(1)  --> true, nil
---ok, err = validate.is_not.table({}) --> false, "expected not table"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is_not.table = function(v) end
is_not.Table = is_not.table
M.is_not_table = is_not.table
M.isNotTable = is_not.table
M.not_table = is_not.table
M.notTable = is_not.table
M.NotTable = is_not.table

---
---@name not_thread
---
---Returns `true` when `v` is **not** a thread. Otherwise returns `false` and
---an error message.
---
---```lua
---co = coroutine.create(function() end)
---ok, err = validate.is_not.thread(1)  --> true, nil
---ok, err = validate.is_not.thread(co) --> false, "expected not thread"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is_not.thread = function(v) end
is_not.Thread = is_not.thread
M.is_not_thread = is_not.thread
M.isNotThread = is_not.thread
M.not_thread = is_not.thread
M.notThread = is_not.thread
M.NotThread = is_not.thread

---
---@name not_userdata
---
---Returns `true` when `v` is **not** userdata. Otherwise returns `false` and
---an error message.
---
---```lua
---ok, err = validate.is_not.userdata(1)         --> true, nil
---ok, err = validate.is_not.userdata(io.stdout) --> false, "expected not userdata"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is_not.userdata = function(v) end
is_not.Userdata = is_not.userdata
M.is_not_userdata = is_not.userdata
M.isNotUserdata = is_not.userdata
M.not_userdata = is_not.userdata
M.notUserdata = is_not.userdata
M.NotUserdata = is_not.userdata

--------------------------------------------------------------------------------
--------------------------------- Value Checks ---------------------------------
--------------------------------------------------------------------------------
---
---Value-state validators (exact true/false, truthy/falsy, callable, integer).
---

---
---@name false
---
---Returns `true` when `v` is exactly `false`. Otherwise returns `false` and an
---error message.
---
---```lua
---ok, err = validate.is.False(false) --> true, nil
---ok, err = validate.is.False(true)  --> false, "expected false, got true"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.False = function(v) end
is["false"] = is.False

---
---@name true
---
---Returns `true` when `v` is exactly `true`. Otherwise returns `false` and an
---error message.
---
---```lua
---ok, err = validate.is.True(true)  --> true, nil
---ok, err = validate.is.True(false) --> false, "expected true, got false"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.True = function(v) end
is["true"] = is.True

---
---Returns `true` when `v` is falsy. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.falsy(false) --> true, nil
---ok, err = validate.is.falsy(1)     --> false, "expected falsy, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.falsy = function(v) end
is.Falsy = is.falsy

---
---Returns `true` when `v` is callable. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.callable(type) --> true, nil
---ok, err = validate.is.callable(1)    --> false, "expected callable, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.callable = function(v) end
is.Callable = is.callable

---
---Returns `true` when `v` is an integer. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.integer(1)   --> true, nil
---ok, err = validate.is.integer(1.5) --> false, "expected integer, got 1.5"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.integer = function(v) end
is.Integer = is.integer

---
---Returns `true` when `v` is truthy. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.truthy(1)     --> true, nil
---ok, err = validate.is.truthy(false) --> false, "expected truthy, got boolean"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.truthy = function(v) end
is.Truthy = is.truthy

---
---@name not_false
---
---Returns `true` when `v` is **not** exactly `false`. Otherwise returns
---`false` and an error message.
---
---```lua
---ok, err = validate.is_not.False(true)  --> true, nil
---ok, err = validate.is_not.False(false) --> false, "expected not false"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is_not.False = function(v) end
is_not["false"] = is_not.False
M.is_not_false = is_not.False
M.isNotFalse = is_not.False
M.not_false = is_not.False
M.notFalse = is_not.False
M.NotFalse = is_not.False

---
---@name not_true
---
---Returns `true` when `v` is **not** exactly `true`. Otherwise returns `false`
---and an error message.
---
---```lua
---ok, err = validate.is_not.True(false) --> true, nil
---ok, err = validate.is_not.True(true)  --> false, "expected not true"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is_not.True = function(v) end
is_not["true"] = is_not.True
M.is_not_true = is_not.True
M.isNotTrue = is_not.True
M.not_true = is_not.True
M.notTrue = is_not.True
M.NotTrue = is_not.True

---
---@name not_falsy
---
---Returns `true` when `v` is **not** falsy. Otherwise returns `false` and an
---error message.
---
---```lua
---ok, err = validate.is_not.falsy(1)     --> true, nil
---ok, err = validate.is_not.falsy(false) --> false, "expected not falsy"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is_not.falsy = function(v) end
is_not.Falsy = is_not.falsy
M.is_not_falsy = is_not.falsy
M.isNotFalsy = is_not.falsy
M.not_falsy = is_not.falsy
M.notFalsy = is_not.falsy
M.NotFalsy = is_not.falsy

---
---@name not_callable
---
---Returns `true` when `v` is **not** callable. Otherwise returns `false` and
---an error message.
---
---```lua
---ok, err = validate.is_not.callable(1)              --> true, nil
---ok, err = validate.is_not.callable(function() end) --> false, "expected not callable"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is_not.callable = function(v) end
is_not.Callable = is_not.callable
M.is_not_callable = is_not.callable
M.isNotCallable = is_not.callable
M.not_callable = is_not.callable
M.notCallable = is_not.callable
M.NotCallable = is_not.callable

---
---@name not_integer
---
---Returns `true` when `v` is **not** an integer. Otherwise returns `false` and
---an error message.
---
---```lua
---ok, err = validate.is_not.integer(1.5) --> true, nil
---ok, err = validate.is_not.integer(1)   --> false, "expected non-integer, got 1"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is_not.integer = function(v) end
is_not.Integer = is_not.integer
M.is_not_integer = is_not.integer
M.isNotInteger = is_not.integer
M.not_integer = is_not.integer
M.notInteger = is_not.integer
M.NotInteger = is_not.integer

---
---@name not_truthy
---Returns `true` when `v` is **not** truthy. Otherwise returns `false` and an
---error message.
---
---```lua
---ok, err = validate.is_not.truthy(false) --> true, nil
---ok, err = validate.is_not.truthy(1)     --> false, "expected not truthy"
---```
---
---@param v any
---@return boolean ok
---@return string? err
is_not.truthy = function(v) end
is_not.Truthy = is_not.truthy
M.is_not_truthy = is_not.truthy
M.isNotTruthy = is_not.truthy
M.not_truthy = is_not.truthy
M.notTruthy = is_not.truthy
M.NotTruthy = is_not.truthy

--------------------------------------------------------------------------------
--------------------------------- Path Checks ----------------------------------
--------------------------------------------------------------------------------
---
---Filesystem path-kind validators backed by LuaFileSystem (`lfs`).
---
---Filesystem path kind checks.
---
---> [!IMPORTANT]
--->
---> Path checks require **LuaFileSystem**
---> ([`lfs`](https://github.com/lunarmodules/luafilesystem))
---> and raise an error it is not installed.

---
---Returns `true` when `v` is a block device path. Otherwise returns `false`
--- and an error message.
---
---```lua
---ok, err = validate.is.block(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.block = function(v) end
is.Block = is.block

---
---Returns `true` when `v` is a char device path. Otherwise returns `false` and
---an error message.
---
---```lua
---ok, err = validate.is.char(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.char = function(v) end
is.Char = is.char

---
---Returns `true` when `v` is a block or char device path. Otherwise returns
---`false` and an error message.
---
---```lua
---ok, err = validate.is.device(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.device = function(v) end
is.Device = is.device

---
---Returns `true` when `v` is a directory path. Otherwise returns `false` and an
---error message.
---
---```lua
---ok, err = validate.is.dir(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.dir = function(v) end
is.Dir = is.dir

---
---Returns `true` when `v` is a FIFO path. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.fifo(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.fifo = function(v) end
is.Fifo = is.fifo

---
---Returns `true` when `v` is a file path. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.file(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.file = function(v) end
is.File = is.file

---
---Returns `true` when `v` is a symlink path. Otherwise returns `false` and an
---error message.
---
---```lua
---ok, err = validate.is.link(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.link = function(v) end
is.Link = is.link

---
---Returns `true` when `v` is a socket path. Otherwise returns `false` and an
---error message.
---
---```lua
---ok, err = validate.is.socket(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
is.socket = function(v) end
is.Socket = is.socket

return M
