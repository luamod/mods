local mods = require("mods")

---@type mods.tbl
local M = {}

function M.clear(t)
  for k in pairs(t) do
    t[k] = nil
  end
end

function M.copy(t)
  local res = {}
  for k, v in pairs(t) do
    res[k] = v
  end
  return res
end

function M.count(t)
  local len = 0
  for _ in pairs(t) do
    len = len + 1
  end
  return len
end

local function deepcopy(v, seen)
  if type(v) ~= "table" then
    return v
  end

  local cached = seen[v]
  if cached ~= nil then
    return cached
  end

  local res = {}
  seen[v] = res
  for k, v_ in pairs(v) do
    res[deepcopy(k, seen)] = deepcopy(v_, seen)
  end

  local mt = getmetatable(v)
  if mt ~= nil then
    return setmetatable(res, mt)
  end
  return res
end

function M.deepcopy(t)
  return deepcopy(t, {})
end

function M.filter(t, pred)
  local res = {}
  for k, v in pairs(t) do
    if pred(v) then
      res[k] = v
    end
  end
  return res
end

function M.find(t, v)
  for k, v_ in pairs(t) do
    if v == v_ then
      return k
    end
  end
end

function M.find_if(t, pred)
  for k, v in pairs(t) do
    if pred(v, k) then
      return v, k
    end
  end
  return nil
end

function M.get(t, ...)
  local v = t
  local n = select("#", ...)
  for i = 1, n do
    local k = select(i, ...)
    if v[k] == nil then
      return
    end
    v = v[k]
  end
  return v
end

function M.invert(t)
  local res = {}
  for k, v in pairs(t) do
    res[v] = k
  end
  return res
end

function M.isempty(t)
  return not next(t)
end

function M.keys(t)
  local ls = mods.List()
  local i = 1
  for k in pairs(t) do
    ls[i] = k
    i = i + 1
  end
  return ls
end

function M.map(t, fn)
  local res = {}
  for k, v in pairs(t) do
    res[k] = fn(v)
  end
  return res
end

function M.pairmap(t, fn)
  local res = {}
  for k, v in pairs(t) do
    res[k] = fn(k, v)
  end
  return res
end

function M.update(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end

function M.values(t)
  local ls = mods.List()
  local i = 1
  for _, v in pairs(t) do
    ls[i] = v
    i = i + 1
  end
  return ls
end

return M
