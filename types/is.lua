---@meta mods.is

---@alias modsIsType
---|'boolean'
---|'Boolean'
---|'function'
---|'Function'
---|'nil'
---|'Nil'
---|'number'
---|'Number'
---|'string'
---|'String'
---|'table'
---|'Table'
---|'thread'
---|'Thread'
---|'userdata'
---|'Userdata'
---
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
---|'callable'
---|'Callable'
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

---Type predicates for Lua values and filesystem path kinds.
---
---You can also call `is(v, tp)` with a string type name.
---@class mods.is
---@overload fun(v:any, tp:modsIsType):boolean
local M = {}

---Returns `true` when `v` is a boolean.
---@param v any
---@return boolean ok
---@nodiscard
M.boolean = function(v) end
M.Boolean = M.boolean

---Returns `true` when `v` is a function.
---@param v any
---@return boolean ok
---@nodiscard
M["function"] = function(v) end
M.Function = M["function"]

---Returns `true` when `v` is `nil`.
---@param v any
---@return boolean ok
---@nodiscard
M["nil"] = function(v) end
M.Nil = M["nil"]

---Returns `true` when `v` is a number.
---@param v any
---@return boolean ok
---@nodiscard
M.number = function(v) end
M.Number = M.number

---Returns `true` when `v` is a string.
---@param v any
---@return boolean ok
---@nodiscard
M.string = function(v) end
M.String = M.string

---Returns `true` when `v` is a table.
---@param v any
---@return boolean ok
---@nodiscard
M.table = function(v) end
M.Table = M.table

---Returns `true` when `v` is a thread.
---@param v any
---@return boolean ok
---@nodiscard
M.thread = function(v) end
M.Thread = M.thread

---Returns `true` when `v` is userdata.
---@param v any
---@return boolean ok
---@nodiscard
M.userdata = function(v) end
M.Userdata = M.userdata

---Returns `true` when `v` is exactly `false`.
---@param v any
---@return boolean ok
---@nodiscard
M["false"] = function(v) end
M.False = M["false"]

---Returns `true` when `v` is exactly `true`.
---@param v any
---@return boolean ok
---@nodiscard
M["true"] = function(v) end
M.True = M["true"]

---Returns `true` when `v` is falsy.
---@param v any
---@return boolean ok
---@nodiscard
M.falsy = function(v) end
M.Falsy = M.falsy

---Returns `true` when `v` is callable.
---@param v any
---@return boolean ok
---@nodiscard
M.callable = function(v) end
M.Callable = M.callable

---Returns `true` when `v` is an integer.
---@param v any
---@return boolean ok
---@nodiscard
M.integer = function(v) end
M.Integer = M.integer

---Returns `true` when `v` is truthy.
---@param v any
---@return boolean ok
---@nodiscard
M.truthy = function(v) end
M.Truthy = M.truthy

---Returns `true` when `v` is a block device path.
---
---**Important**: Requires `lfs`.
---@param v any
---@return boolean ok
---@nodiscard
M.block = function(v) end
M.Block = M.block

---Returns `true` when `v` is a char device path.
---
---**Important**: Requires `lfs`.
---@param v any
---@return boolean ok
---@nodiscard
M.char = function(v) end
M.Char = M.char

---Returns `true` when `v` is a block or char device path.
---
---**Important**: Requires `lfs`.
---@param v any
---@return boolean ok
---@nodiscard
M.device = function(v) end
M.Device = M.device

---Returns `true` when `v` is a directory path.
---
---**Important**: Requires `lfs`.
---@param v any
---@return boolean ok
---@nodiscard
M.dir = function(v) end
M.Dir = M.dir

---Returns `true` when `v` is a FIFO path.
---
---**Important**: Requires `lfs`.
---@param v any
---@return boolean ok
---@nodiscard
M.fifo = function(v) end
M.Fifo = M.fifo

---Returns `true` when `v` is a file path.
---
---**Important**: Requires `lfs`.
---@param v any
---@return boolean ok
---@nodiscard
M.file = function(v) end
M.File = M.file

---Returns `true` when `v` is a symlink path.
---
---**Important**: Requires `lfs`.
---@param v any
---@return boolean ok
---@nodiscard
M.link = function(v) end
M.Link = M.link

---Returns `true` when `v` is a socket path.
---
---**Important**: Requires `lfs`.
---@param v any
---@return boolean ok
---@nodiscard
M.socket = function(v) end
M.Socket = M.socket

return M
