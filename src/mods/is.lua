local type = type
local getmt = getmetatable
local lfs

-- luacheck: push ignore 631
---@alias mods.lfs.attributes fun(filepath:string, request_name?:LuaFileSystem.AttributeName):(string|integer|LuaFileSystem.AttributeMode)
---@alias mods.lfs.symlinkattributes fun(filepath:string, request_name?:LuaFileSystem.AttributeName):LuaFileSystem.Attributes
-- luacheck: pop

local function get_lfs()
  if lfs then
    return lfs
  end

  local ok, mod = pcall(require, "lfs")
  if not ok then
    error("lfs is required for filesystem operations")
  end

  lfs = mod
  return mod
end

---@type mods.lfs.attributes
local function attrs(filepath, request_name)
  attrs = get_lfs().attributes
  return attrs(filepath, request_name)
end

---@type mods.lfs.symlinkattributes
local function symlinkattrs(filepath, request_name)
  symlinkattrs = get_lfs().symlinkattributes
  return symlinkattrs(filepath, request_name)
end

---@type mods.is
local M = {}

-------------------
--- Type checks ---
-------------------

-- stylua: ignore start
function M.boolean(v)  return type(v) == "boolean"  end
function M.number(v)   return type(v) == "number"   end
function M.string(v)   return type(v) == "string"   end
function M.table(v)    return type(v) == "table"    end
function M.thread(v)   return type(v) == "thread"   end
function M.userdata(v) return type(v) == "userdata" end

M["nil"]      = function (v) return type(v) == "nil"      end
M["function"] = function (v) return type(v) == "function" end
-- stylua: ignore end

--------------------
--- Value checks ---
--------------------

-- stylua: ignore start
function M.falsy(v)   return not v and true or false            end
function M.integer(v) return type(v) == "number" and v % 1 == 0 end
function M.truthy(v)  return v and true or false                end

M["false"] = function (v) return v == false end
M["true"]  = function (v) return v == true  end
-- stylua: ignore end

function M.callable(v)
  if type(v) == "function" then
    return true
  end
  local mt = getmt(v)
  if mt and type(mt.__call) == "function" then
    return true
  end
  return false
end

-------------------
--- Path checks ---
-------------------

M._path_checks = { "path", "block", "char", "dir", "fifo", "file", "link", "socket", "device" }

local function islink(p)
  return symlinkattrs(p, "mode") == "link"
end

function M.device(v)
  if type(v) ~= "string" then
    return false
  end
  local file_mode = attrs(v, "mode")
  return file_mode == "char device" or file_mode == "block device"
end

-- stylua: ignore start
function M.block(v)  return type(v) == "string" and attrs(v, "mode") == "block device"     end
function M.char(v)   return type(v) == "string" and attrs(v, "mode") == "char device"      end
function M.dir(v)    return type(v) == "string" and attrs(v, "mode") == "directory"        end
function M.fifo(v)   return type(v) == "string" and attrs(v, "mode") == "named pipe"       end
function M.file(v)   return type(v) == "string" and attrs(v, "mode") == "file"             end
function M.socket(v) return type(v) == "string" and attrs(v, "mode") == "socket"           end
function M.link(v)   return type(v) == "string" and islink(v)                              end
function M.path(v)   return type(v) == "string" and (attrs(v, "mode") ~= nil or islink(v)) end
-- stylua: ignore end

--------------------------------
--- Alias setup and dispatch ---
--------------------------------

return setmetatable(M, {
  __index = function(t, k)
    if type(k) == "string" then
      return rawget(t, k:lower())
    end
  end,
  __call = function(_, v, tp)
    local fn = M[tp]
    if fn then
      return fn(v)
    end
    return type(v) == tp
  end,
})
