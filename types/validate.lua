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
---For more info, see [Custom Messages docs](https://luamod.github.io/mods/modules/validate#custom-messages).
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

---Validation predicates for Lua values and filesystem paths.
---Names are case-insensitive (for example: `validate.table`, `validate.Table`).
---`validate(v, tp)` checks `v` against any supported type name.
---
---For comprehensive docs and examples, see [validate docs](https://luamod.github.io/mods/modules/validate).
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
---For more info, see [On Fail Hook docs](https://luamod.github.io/mods/modules/validate#on-fail-hook).
---
---@field on_fail? fun(errmsg:string):any
---@overload fun(v:any, tp?:modsValidateType):(boolean, string?)
local M = {}

--------------------------------------------------------------------------------
---------------------------------- Type Checks ---------------------------------
--------------------------------------------------------------------------------

---Returns `true` when `v` is a boolean. Otherwise returns `false` and an error
---message.
---
---@param v any
---@return boolean ok
---@return string? err
is.boolean = function(v) end
is.Boolean = is.boolean

---Returns `true` when `v` is **not** a boolean. Otherwise returns `false` and
---an error message.
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

---Returns `true` when `v` is a function. Otherwise returns `false` and an error
---message.
---
---@param v any
---@return boolean ok
---@return string? err
is.Function = function(v) end
is["function"] = is.Function

---Returns `true` when `v` is **not** a function. Otherwise returns `false` and
---an error message.
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

---Returns `true` when `v` is `nil`. Otherwise returns `false` and an error
---message.
---
---@param v any
---@return boolean ok
---@return string? err
is.Nil = function(v) end
is["nil"] = is.Nil

---Returns `true` when `v` is **not** `nil`. Otherwise returns `false` and an
---error message.
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

---Returns `true` when `v` is a number. Otherwise returns `false` and an error
---message.
---
---@param v any
---@return boolean ok
---@return string? err
is.number = function(v) end
is.Number = is.number

---Returns `true` when `v` is **not** a number. Otherwise returns `false` and
---an error message.
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

---Returns `true` when `v` is a string. Otherwise returns `false` and an error
---message.
---
---@param v any
---@return boolean ok
---@return string? err
is.string = function(v) end
is.String = is.string

---Returns `true` when `v` is **not** a string. Otherwise returns `false` and
---an error message.
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

---Returns `true` when `v` is a table. Otherwise returns `false` and an error
---message.
---
---@param v any
---@return boolean ok
---@return string? err
is.table = function(v) end
is.Table = is.table

---Returns `true` when `v` is **not** a table. Otherwise returns `false` and an
---error message.
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

---Returns `true` when `v` is a thread. Otherwise returns `false` and an error
---message.
---
---@param v any
---@return boolean ok
---@return string? err
is.thread = function(v) end
is.Thread = is.thread

---Returns `true` when `v` is **not** a thread. Otherwise returns `false` and
---an error message.
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

---Returns `true` when `v` is userdata. Otherwise returns `false` and an error
---message.
---
---@param v any
---@return boolean ok
---@return string? err
is.userdata = function(v) end
is.Userdata = is.userdata

---Returns `true` when `v` is **not** userdata. Otherwise returns `false` and
---an error message.
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

---Returns `true` when `v` is exactly `false`. Otherwise returns `false` and an
---error message.
---
---@param v any
---@return boolean ok
---@return string? err
is.False = function(v) end
is["false"] = is.False

---Returns `true` when `v` is **not** exactly `false`. Otherwise returns
---`false` and an error message.
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

---Returns `true` when `v` is exactly `true`. Otherwise returns `false` and an
---error message.
---
---@param v any
---@return boolean ok
---@return string? err
is.True = function(v) end
is["true"] = is.True

---Returns `true` when `v` is **not** exactly `true`. Otherwise returns `false`
---and an error message.
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

---Returns `true` when `v` is falsy. Otherwise returns `false` and an error
---message.
---
---@param v any
---@return boolean ok
---@return string? err
is.falsy = function(v) end
is.Falsy = is.falsy

---Returns `true` when `v` is **not** falsy. Otherwise returns `false` and an
---error message.
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

---Returns `true` when `v` is callable. Otherwise returns `false` and an error
---message.
---
---@param v any
---@return boolean ok
---@return string? err
is.callable = function(v) end
is.Callable = is.callable

---Returns `true` when `v` is **not** callable. Otherwise returns `false` and
---an error message.
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

---Returns `true` when `v` is an integer. Otherwise returns `false` and an error
---message.
---
---@param v any
---@return boolean ok
---@return string? err
is.integer = function(v) end
is.Integer = is.integer

---Returns `true` when `v` is **not** an integer. Otherwise returns `false` and
---an error message.
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

---Returns `true` when `v` is truthy. Otherwise returns `false` and an error
---message.
---
---@param v any
---@return boolean ok
---@return string? err
is.truthy = function(v) end
is.Truthy = is.truthy

---Returns `true` when `v` is **not** truthy. Otherwise returns `false` and an
---error message.
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

---Returns `true` when `v` is a block device path. Otherwise returns `false` and
---an error message.
---
---**IMPORTANT:** Requires `lfs` (LuaFileSystem).
---
---@param v any
---@return boolean ok
---@return string? err
is.block = function(v) end
is.Block = is.block

---Returns `true` when `v` is a char device path. Otherwise returns `false` and
---an error message.
---
---**IMPORTANT:** Requires `lfs` (LuaFileSystem).
---
---@param v any
---@return boolean ok
---@return string? err
is.char = function(v) end
is.Char = is.char

---Returns `true` when `v` is a block or char device path. Otherwise returns
---`false` and an error message.
---
---**IMPORTANT:** Requires `lfs` (LuaFileSystem).
---
---@param v any
---@return boolean ok
---@return string? err
is.device = function(v) end
is.Device = is.device

---Returns `true` when `v` is a directory path. Otherwise returns `false` and an
---error message.
---
---**IMPORTANT:** Requires `lfs` (LuaFileSystem).
---
---@param v any
---@return boolean ok
---@return string? err
is.dir = function(v) end
is.Dir = is.dir

---Returns `true` when `v` is a FIFO path. Otherwise returns `false` and an error
---message.
---
---**IMPORTANT:** Requires `lfs` (LuaFileSystem).
---
---@param v any
---@return boolean ok
---@return string? err
is.fifo = function(v) end
is.Fifo = is.fifo

---Returns `true` when `v` is a file path. Otherwise returns `false` and an error
---message.
---
---**IMPORTANT:** Requires `lfs` (LuaFileSystem).
---
---@param v any
---@return boolean ok
---@return string? err
is.file = function(v) end
is.File = is.file

---Returns `true` when `v` is a symlink path. Otherwise returns `false` and an
---error message.
---
---**IMPORTANT:** Requires `lfs` (LuaFileSystem).
---
---@param v any
---@return boolean ok
---@return string? err
is.link = function(v) end
is.Link = is.link

---Returns `true` when `v` is a socket path. Otherwise returns `false` and an
---error message.
---
---**IMPORTANT:** Requires `lfs` (LuaFileSystem).
---
---@param v any
---@return boolean ok
---@return string? err
is.socket = function(v) end
is.Socket = is.socket

return M
