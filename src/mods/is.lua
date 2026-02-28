local type = type
local getmt = getmetatable
local lfs

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

local function attrs(path, field)
  attrs = get_lfs().attributes
  return attrs(path, field)
end

local function slattrs(path, field)
  slattrs = get_lfs().symlinkattributes
  return slattrs(path, field)
end

---@type mods.is
local M = {}

-------------------
--- Type checks ---
-------------------

-- stylua: ignore start
function M.Boolean(v)  return type(v) == "boolean"  end
function M.Function(v) return type(v) == "function" end
function M.Nil(v)      return type(v) == "nil"      end
function M.Number(v)   return type(v) == "number"   end
function M.String(v)   return type(v) == "string"   end
function M.Table(v)    return type(v) == "table"    end
function M.Thread(v)   return type(v) == "thread"   end
function M.Userdata(v) return type(v) == "userdata" end
-- stylua: ignore end

--------------------
--- Value checks ---
--------------------

-- stylua: ignore start
function M.False(v)   return v == false                         end
function M.Falsy(v)   return not v and true or false            end
function M.Integer(v) return type(v) == "number" and v % 1 == 0 end
function M.True(v)    return v == true                          end
function M.Truthy(v)  return v and true or false                end
-- stylua: ignore end

function M.Callable(v)
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

function M.Device(v)
  if type(v) ~= "string" then
    return false
  end
  local file_mode = attrs(v, "mode")
  return file_mode == "char device" or file_mode == "block device"
end

-- stylua: ignore start
function M.Block(v)  return type(v) == "string" and attrs(v, "mode")   == "block device" end
function M.Char(v)   return type(v) == "string" and attrs(v, "mode")   == "char device"  end
function M.Dir(v)    return type(v) == "string" and attrs(v, "mode")   == "directory"    end
function M.Fifo(v)   return type(v) == "string" and attrs(v, "mode")   == "named pipe"   end
function M.File(v)   return type(v) == "string" and attrs(v, "mode")   == "file"         end
function M.Socket(v) return type(v) == "string" and attrs(v, "mode")   == "socket"       end
function M.Link(v)   return type(v) == "string" and slattrs(v, "mode") == "link"         end
-- stylua: ignore end

--------------------------------
--- Alias setup and dispatch ---
--------------------------------

local aliases = {}
for k in pairs(M) do
  aliases[#aliases + 1] = k
end

for _, v in ipairs(aliases) do
  M[v:lower()] = M[v]
end

return setmetatable(M, {
  __call = function(_, v, tp)
    local fn = M[tp]
    if fn then
      return fn(v)
    elseif type(v) == tp then
      return true
    end
    return false
  end,
})
