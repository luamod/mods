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

---Validation error message templates keyed by lowercase type name. Override any
---entry to customize the error string returned by validators. Templates can use
---`{{expected}}`, `{{got}}`, and `{{value}}`.
---
---**Example:**
---```lua
---local validate = require("mods.validate")
---local messages = validate.messages
---messages.is.number = "should be {{expected}}, got {{got}} (passed={{value}})"
---local ok, err = validate.Number("nope")
-----result: 'should be number, got string (passed="nope")'
---
---messages.is_not.number = "should not be {{expected}}, got {{got}} (passed={{value}})"
---ok, err = validate.is_not.Number(3.14)
-----result: 'should not be number, got number (passed=3.14)'
---```
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

---Validation predicates for Lua values and filesystem path kinds.
---
---Function names exist in both lowercase and capitalized forms (for example,
---`assert(validate.table` or `validate.Table`).)
---
---`validate` is callable as `validate(v, tp)` where `v` is the value and `tp`
---is any supported type name.
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
---@field on_fail? fun(errmsg:string):any Optional callback invoked when a validation check fails.
---@overload fun(v:any, tp?:modsValidateType):(boolean, string?)
local M = {}

--------------------------------------------------------------------------------
---------------------------------- Type Checks ---------------------------------
--------------------------------------------------------------------------------

---Returns `true` when `v` is a boolean. Otherwise returns `false` and an error
---message.
---
---**Example:**
---```lua
---assert(validate.boolean(true))
---```
---@param v any
---@return boolean ok
---@return string? err
is.boolean = function(v) end
is.Boolean = is.boolean

---Returns `true` when `v` is **not** a boolean. Otherwise returns `false` and
---an error message.
---
---**Example:**
---```lua
---assert(validate.is_not.boolean(123))
---```
---
---**Aliases:**
---`is_not.boolean`, `is_not.Boolean`, `isnot.boolean`, `isnot.Boolean`, `isNot.boolean`, `isNot.Boolean`, `not.boolean`, `not.Boolean`, `Not.boolean`, `Not.Boolean`, `is_not_boolean`, `is_not_Boolean`, `isnot_boolean`, `isnot_Boolean`, `isnotboolean`, `isnotBoolean`, `isNot_boolean`, `isNot_Boolean`, `isNotboolean`, `isNotBoolean`, `not_boolean`, `not_Boolean`, `notboolean`, `notBoolean`, `Not_boolean`, `Not_Boolean`, `Notboolean`, `NotBoolean`
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

---Returns `true` when `v` is a function. Otherwise returns `false` and an error
---message.
---
---**Example:**
---```lua
---assert(validate.Function(function() end))
---```
---@param v any
---@return boolean ok
---@return string? err
is.Function = function(v) end
is["function"] = is.Function

---Returns `true` when `v` is **not** a function. Otherwise returns `false` and
---an error message.
---
---**Example:**
---```lua
---assert(validate.is_not.Function("abc"))
---```
---
---**Aliases:**
---`is_not.Function`, `is_not.function`, `isnot.Function`, `isnot.function`, `isNot.Function`, `isNot.function`, `not.Function`, `not.function`, `Not.Function`, `Not.function`, `is_not_Function`, `is_not_function`, `isnot_Function`, `isnot_function`, `isnotFunction`, `isnotfunction`, `isNot_Function`, `isNot_function`, `isNotFunction`, `isNotfunction`, `not_Function`, `not_function`, `notFunction`, `notfunction`, `Not_Function`, `Not_function`, `NotFunction`, `Notfunction`
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

---Returns `true` when `v` is `nil`. Otherwise returns `false` and an error
---message.
---
---**Example:**
---```lua
---assert(validate.Nil(nil))
---```
---@param v any
---@return boolean ok
---@return string? err
is.Nil = function(v) end
is["nil"] = is.Nil

---Returns `true` when `v` is **not** `nil`. Otherwise returns `false` and an
---error message.
---
---**Example:**
---```lua
---assert(validate.is_not.Nil(123))
---```
---
---**Aliases:**
---`is_not.Nil`, `is_not.nil`, `isnot.Nil`, `isnot.nil`, `isNot.Nil`, `isNot.nil`, `not.Nil`, `not.nil`, `Not.Nil`, `Not.nil`, `is_not_Nil`, `is_not_nil`, `isnot_Nil`, `isnot_nil`, `isnotNil`, `isnotnil`, `isNot_Nil`, `isNot_nil`, `isNotNil`, `isNotnil`, `not_Nil`, `not_nil`, `notNil`, `notnil`, `Not_Nil`, `Not_nil`, `NotNil`, `Notnil`
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

---Returns `true` when `v` is a number. Otherwise returns `false` and an error
---message.
---
---**Example:**
---```lua
---assert(validate.number(3.14))
---```
---@param v any
---@return boolean ok
---@return string? err
is.number = function(v) end
is.Number = is.number

---Returns `true` when `v` is **not** a number. Otherwise returns `false` and
---an error message.
---
---**Example:**
---```lua
---assert(validate.is_not.number("3.14"))
---```
---
---**Aliases:**
---`is_not.number`, `is_not.Number`, `isnot.number`, `isnot.Number`, `isNot.number`, `isNot.Number`, `not.number`, `not.Number`, `Not.number`, `Not.Number`, `is_not_number`, `is_not_Number`, `isnot_number`, `isnot_Number`, `isnotnumber`, `isnotNumber`, `isNot_number`, `isNot_Number`, `isNotnumber`, `isNotNumber`, `not_number`, `not_Number`, `notnumber`, `notNumber`, `Not_number`, `Not_Number`, `Notnumber`, `NotNumber`
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

---Returns `true` when `v` is a string. Otherwise returns `false` and an error
---message.
---
---**Example:**
---```lua
---assert(validate.string("hello"))
---```
---@param v any
---@return boolean ok
---@return string? err
is.string = function(v) end
is.String = is.string

---Returns `true` when `v` is **not** a string. Otherwise returns `false` and
---an error message.
---
---**Example:**
---```lua
---assert(validate.is_not.string(false))
---```
---
---**Aliases:**
---`is_not.string`, `is_not.String`, `isnot.string`, `isnot.String`, `isNot.string`, `isNot.String`, `not.string`, `not.String`, `Not.string`, `Not.String`, `is_not_string`, `is_not_String`, `isnot_string`, `isnot_String`, `isnotstring`, `isnotString`, `isNot_string`, `isNot_String`, `isNotstring`, `isNotString`, `not_string`, `not_String`, `notstring`, `notString`, `Not_string`, `Not_String`, `Notstring`, `NotString`
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

---Returns `true` when `v` is a table. Otherwise returns `false` and an error
---message.
---
---**Example:**
---```lua
---assert(validate.table({}))
---```
---@param v any
---@return boolean ok
---@return string? err
is.table = function(v) end
is.Table = is.table

---Returns `true` when `v` is **not** a table. Otherwise returns `false` and an
---error message.
---
---**Example:**
---```lua
---assert(validate.is_not.table(false))
---```
---
---**Aliases:**
---`is_not.table`, `is_not.Table`, `isnot.table`, `isnot.Table`, `isNot.table`, `isNot.Table`, `not.table`, `not.Table`, `Not.table`, `Not.Table`, `is_not_table`, `is_not_Table`, `isnot_table`, `isnot_Table`, `isnottable`, `isnotTable`, `isNot_table`, `isNot_Table`, `isNottable`, `isNotTable`, `not_table`, `not_Table`, `nottable`, `notTable`, `Not_table`, `Not_Table`, `Nottable`, `NotTable`
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

---Returns `true` when `v` is a thread. Otherwise returns `false` and an error
---message.
---
---**Example:**
---```lua
---local co = coroutine.create(function() end)
---assert(validate.thread(co))
---```
---@param v any
---@return boolean ok
---@return string? err
is.thread = function(v) end
is.Thread = is.thread

---Returns `true` when `v` is **not** a thread. Otherwise returns `false` and
---an error message.
---
---**Example:**
---```lua
---assert(validate.is_not.thread(function() end))
---```
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

---Returns `true` when `v` is userdata. Otherwise returns `false` and an error
---message.
---
---**Example:**
---```lua
---assert(validate.userdata(io.stdout))
---```
---@param v any
---@return boolean ok
---@return string? err
is.userdata = function(v) end
is.Userdata = is.userdata

---Returns `true` when `v` is **not** userdata. Otherwise returns `false` and
---an error message.
---
---**Example:**
---```lua
---assert(validate.is_not.userdata({}))
---```
---
---**Aliases:**
---`is_not.userdata`, `is_not.Userdata`, `isnot.userdata`, `isnot.Userdata`, `isNot.userdata`, `isNot.Userdata`, `not.userdata`, `not.Userdata`, `Not.userdata`, `Not.Userdata`, `is_not_userdata`, `is_not_Userdata`, `isnot_userdata`, `isnot_Userdata`, `isnotuserdata`, `isnotUserdata`, `isNot_userdata`, `isNot_Userdata`, `isNotuserdata`, `isNotUserdata`, `not_userdata`, `not_Userdata`, `notuserdata`, `notUserdata`, `Not_userdata`, `Not_Userdata`, `Notuserdata`, `NotUserdata`
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

---Returns `true` when `v` is exactly `false`. Otherwise returns `false` and an
---error message.
---
---**Example:**
---```lua
---assert(validate.False(false))
---```
---@param v any
---@return boolean ok
---@return string? err
is.False = function(v) end
is["false"] = is.False

---Returns `true` when `v` is **not** exactly `false`. Otherwise returns
---`false` and an error message.
---
---**Example:**
---```lua
---assert(validate.is_not.False(true))
---```
---
---**Aliases:**
---`is_not.False`, `is_not.false`, `isnot.False`, `isnot.false`, `isNot.False`, `isNot.false`, `not.False`, `not.false`, `Not.False`, `Not.false`, `is_not_False`, `is_not_false`, `isnot_False`, `isnot_false`, `isnotFalse`, `isnotfalse`, `isNot_False`, `isNot_false`, `isNotFalse`, `isNotfalse`, `not_False`, `not_false`, `notFalse`, `notfalse`, `Not_False`, `Not_false`, `NotFalse`, `Notfalse`
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

---Returns `true` when `v` is exactly `true`. Otherwise returns `false` and an
---error message.
---
---**Example:**
---```lua
---assert(validate.True(true))
---```
---@param v any
---@return boolean ok
---@return string? err
is.True = function(v) end
is["true"] = is.True

---Returns `true` when `v` is **not** exactly `true`. Otherwise returns `false`
---and an error message.
---
---**Example:**
---```lua
---assert(validate.is_not.True(false))
---```
---
---**Aliases:**
---`is_not.True`, `is_not.true`, `isnot.True`, `isnot.true`, `isNot.True`, `isNot.true`, `not.True`, `not.true`, `Not.True`, `Not.true`, `is_not_True`, `is_not_true`, `isnot_True`, `isnot_true`, `isnotTrue`, `isnottrue`, `isNot_True`, `isNot_true`, `isNotTrue`, `isNottrue`, `not_True`, `not_true`, `notTrue`, `nottrue`, `Not_True`, `Not_true`, `NotTrue`, `Nottrue`
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

---Returns `true` when `v` is falsy. Otherwise returns `false` and an error
---message.
---
---**Example:**
---```lua
---assert(validate.falsy(false))
---```
---@param v any
---@return boolean ok
---@return string? err
is.falsy = function(v) end
is.Falsy = is.falsy

---Returns `true` when `v` is **not** falsy. Otherwise returns `false` and an
---error message.
---
---**Example:**
---```lua
---assert(validate.is_not.falsy(true))
---```
---
---**Aliases:**
---`is_not.falsy`, `is_not.Falsy`, `isnot.falsy`, `isnot.Falsy`, `isNot.falsy`, `isNot.Falsy`, `not.falsy`, `not.Falsy`, `Not.falsy`, `Not.Falsy`, `is_not_falsy`, `is_not_Falsy`, `isnot_falsy`, `isnot_Falsy`, `isnotfalsy`, `isnotFalsy`, `isNot_falsy`, `isNot_Falsy`, `isNotfalsy`, `isNotFalsy`, `not_falsy`, `not_Falsy`, `notfalsy`, `notFalsy`, `Not_falsy`, `Not_Falsy`, `Notfalsy`, `NotFalsy`
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

---Returns `true` when `v` is callable. Otherwise returns `false` and an error
---message.
---
---**Example:**
---```lua
---assert(validate.callable(function() end))
---```
---@param v any
---@return boolean ok
---@return string? err
is.callable = function(v) end
is.Callable = is.callable

---Returns `true` when `v` is **not** callable. Otherwise returns `false` and
---an error message.
---
---**Example:**
---```lua
---assert(validate.is_not.callable({}))
---```
---
---**Aliases:**
---`is_not.callable`, `is_not.Callable`, `isnot.callable`, `isnot.Callable`, `isNot.callable`, `isNot.Callable`, `not.callable`, `not.Callable`, `Not.callable`, `Not.Callable`, `is_not_callable`, `is_not_Callable`, `isnot_callable`, `isnot_Callable`, `isnotcallable`, `isnotCallable`, `isNot_callable`, `isNot_Callable`, `isNotcallable`, `isNotCallable`, `not_callable`, `not_Callable`, `notcallable`, `notCallable`, `Not_callable`, `Not_Callable`, `Notcallable`, `NotCallable`
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

---Returns `true` when `v` is an integer. Otherwise returns `false` and an error
---message.
---
---**Example:**
---```lua
---assert(validate.integer(42))
---```
---@param v any
---@return boolean ok
---@return string? err
is.integer = function(v) end
is.Integer = is.integer

---Returns `true` when `v` is **not** an integer. Otherwise returns `false` and
---an error message.
---
---**Example:**
---```lua
---assert(validate.is_not.integer(13.4))
---```
---
---**Aliases:**
---`is_not.integer`, `is_not.Integer`, `isnot.integer`, `isnot.Integer`, `isNot.integer`, `isNot.Integer`, `not.integer`, `not.Integer`, `Not.integer`, `Not.Integer`, `is_not_integer`, `is_not_Integer`, `isnot_integer`, `isnot_Integer`, `isnotinteger`, `isnotInteger`, `isNot_integer`, `isNot_Integer`, `isNotinteger`, `isNotInteger`, `not_integer`, `not_Integer`, `notinteger`, `notInteger`, `Not_integer`, `Not_Integer`, `Notinteger`, `NotInteger`
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

---Returns `true` when `v` is truthy. Otherwise returns `false` and an error
---message.
---
---**Example:**
---```lua
---assert(validate.truthy("non-empty"))
---```
---@param v any
---@return boolean ok
---@return string? err
is.truthy = function(v) end
is.Truthy = is.truthy

---Returns `true` when `v` is **not** truthy. Otherwise returns `false` and an
---error message.
---
---**Example:**
---```lua
---assert(validate.is_not.truthy(nil))
---```
---
---**Aliases:**
---`is_not.truthy`, `is_not.Truthy`, `isnot.truthy`, `isnot.Truthy`, `isNot.truthy`, `isNot.Truthy`, `not.truthy`, `not.Truthy`, `Not.truthy`, `Not.Truthy`, `is_not_truthy`, `is_not_Truthy`, `isnot_truthy`, `isnot_Truthy`, `isnottruthy`, `isnotTruthy`, `isNot_truthy`, `isNot_Truthy`, `isNottruthy`, `isNotTruthy`, `not_truthy`, `not_Truthy`, `nottruthy`, `notTruthy`, `Not_truthy`, `Not_Truthy`, `Nottruthy`, `NotTruthy`
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

---Returns `true` when `v` is a block device path. Otherwise returns `false` and
---an error message.
---
---> [!IMPORTANT]
---> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).
---
---**Example:**
---```lua
---assert(validate.block("/dev/sda"))
---```
---@param v any
---@return boolean ok
---@return string? err
is.block = function(v) end
is.Block = is.block

---Returns `true` when `v` is a char device path. Otherwise returns `false` and
---an error message.
---
---> [!IMPORTANT]
---> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).
---
---**Example:**
---```lua
---assert(validate.char("/dev/null"))
---```
---@param v any
---@return boolean ok
---@return string? err
is.char = function(v) end
is.Char = is.char

---Returns `true` when `v` is a block or char device path. Otherwise returns
---`false` and an error message.
---
---> [!IMPORTANT]
---> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).
---
---**Example:**
---```lua
---assert(validate.device("/dev/null"))
---```
---@param v any
---@return boolean ok
---@return string? err
is.device = function(v) end
is.Device = is.device

---Returns `true` when `v` is a directory path. Otherwise returns `false` and an
---error message.
---
---> [!IMPORTANT]
---> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).
---
---**Example:**
---```lua
---assert(validate.dir("/tmp"))
---```
---@param v any
---@return boolean ok
---@return string? err
is.dir = function(v) end
is.Dir = is.dir

---Returns `true` when `v` is a FIFO path. Otherwise returns `false` and an error
---message.
---
---> [!IMPORTANT]
---> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).
---
---**Example:**
---```lua
---assert(validate.fifo("/path/to/fifo"))
---```
---@param v any
---@return boolean ok
---@return string? err
is.fifo = function(v) end
is.Fifo = is.fifo

---Returns `true` when `v` is a file path. Otherwise returns `false` and an error
---message.
---
---> [!IMPORTANT]
---> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).
---
---**Example:**
---```lua
---assert(validate.file("README.md"))
---```
---@param v any
---@return boolean ok
---@return string? err
is.file = function(v) end
is.File = is.file

---Returns `true` when `v` is a symlink path. Otherwise returns `false` and an
---error message.
---
---> [!IMPORTANT]
---> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).
---
---**Example:**
---```lua
---assert(validate.link("/path/to/link"))
---```
---@param v any
---@return boolean ok
---@return string? err
is.link = function(v) end
is.Link = is.link

---Returns `true` when `v` is a socket path. Otherwise returns `false` and an
---error message.
---
---> [!IMPORTANT]
---> Requires `lfs` ([LuaFileSystem](https://github.com/lunarmodules/luafilesystem)).
---
---**Example:**
---```lua
---assert(validate.socket("/path/to/socket"))
---```
---@param v any
---@return boolean ok
---@return string? err
is.socket = function(v) end
is.Socket = is.socket

return M
