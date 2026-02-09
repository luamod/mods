local type = type
local getmt = getmetatable

local lfs

local function require_lfs()
  if lfs then
    return lfs
  end
  local ok, mod = pcall(require, "lfs")
  if not ok then
    error("lfs is required for path-type checks", 2)
  end
  lfs = mod
  return lfs
end

local function attrs(...)
  local mod = require_lfs()
  attrs = mod.attributes
  return attrs(...)
end

local function symlinkattrs(...)
  local mod = require_lfs()
  symlinkattrs = mod.symlinkattributes
  return symlinkattrs(...)
end

---@type mods.is
local M = {}

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

function M.device(v)
  if type(v) ~= "string" then
    return false
  end
  local mode = attrs(v, "mode")
  return mode == "char device" or mode == "block device"
end


-- stylua: ignore start
function M.boolean(v) return type(v) == "boolean" end
function M.Function(v) return type(v) == "function" end
function M.Nil(v) return type(v) == "nil" end
function M.number(v) return type(v) == "number" end
function M.string(v) return type(v) == "string" end
function M.table(v) return type(v) == "table" end
function M.thread(v) return type(v) == "thread" end
function M.userdata(v) return type(v) == "userdata" end

function M.False(v) return v == false  end
function M.falsy(v) return not v and true or false end
function M.integer(v) return type(v) == "number" and v % 1 == 0 end
function M.True(v) return v == true end
function M.truthy(v) return v and true or false end

function M.block(v) return type(v) == "string" and attrs(v, "mode") == "block device" end
function M.char(v) return type(v) == "string" and attrs(v, "mode") == "char device" end
function M.dir(v) return type(v) == "string" and attrs(v, "mode") == "directory" end
function M.fifo(v) return type(v) == "string" and attrs(v, "mode") == "named pipe" end
function M.file(v) return type(v) == "string" and attrs(v, "mode") == "file" end
function M.link(v) return type(v) == "string" and symlinkattrs(v, "mode") == "link" end
function M.socket(v) return type(v) == "string" and attrs(v, "mode") == "socket" end
-- stylua: ignore end

local function capitalize(s)
  return s:gsub("^%l", string.upper)
end

local aliases = {}
for k in pairs(M) do
  aliases[#aliases + 1] = k
end

for _, v in ipairs(aliases) do
  M[v:lower()] = M[v]
  M[capitalize(v)] = M[v]
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
