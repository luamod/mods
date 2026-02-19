local fs = require("mods._fs")

local type = type
local getmt = getmetatable
local mode = fs.mode
local link_mode = fs.link_mode

---@type mods.is
local M = {}

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

function M.Device(v)
  if type(v) ~= "string" then
    return false
  end
  local file_mode = mode(v)
  return file_mode == "char device" or file_mode == "block device"
end

-- stylua: ignore start
function M.Boolean(v) return type(v) == "boolean" end
function M.Function(v) return type(v) == "function" end
function M.Nil(v) return type(v) == "nil" end
function M.Number(v) return type(v) == "number" end
function M.String(v) return type(v) == "string" end
function M.Table(v) return type(v) == "table" end
function M.Thread(v) return type(v) == "thread" end
function M.Userdata(v) return type(v) == "userdata" end

function M.False(v) return v == false  end
function M.Falsy(v) return not v and true or false end
function M.Integer(v) return type(v) == "number" and v % 1 == 0 end
function M.True(v) return v == true end
function M.Truthy(v) return v and true or false end

function M.Block(v) return type(v) == "string" and mode(v) == "block device" end
function M.Char(v) return type(v) == "string" and mode(v) == "char device" end
function M.Dir(v) return type(v) == "string" and mode(v) == "directory" end
function M.Fifo(v) return type(v) == "string" and mode(v) == "named pipe" end
function M.File(v) return type(v) == "string" and mode(v) == "file" end
function M.Link(v) return type(v) == "string" and link_mode(v) == "link" end
function M.Socket(v) return type(v) == "string" and mode(v) == "socket" end
-- stylua: ignore end

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
