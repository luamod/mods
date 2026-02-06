local ok, mod = pcall(require, "mods.List")
local List = ok and mod or nil

---@type mods.Set
local Set = {}
Set.__index = Set

function Set:add(v)
  self[v] = true
  return self
end

function Set:clear()
  for k in pairs(self) do
    self[k] = nil
  end
  return self
end

function Set:copy()
  return Set(self:values())
end

function Set:difference_update(set)
  for k in pairs(set) do
    self[k] = nil
  end
  return self
end

function Set:difference(set)
  local res = Set()
  for k in pairs(self) do
    if not set[k] then
      res[k] = true
    end
  end
  return res
end

function Set:discard(v)
  self[v] = nil
  return self
end

function Set:intersection_update(set)
  for k in pairs(self) do
    if not set[k] then
      self[k] = nil
    end
  end
  return self
end

function Set:intersection(set)
  local res = Set()
  for k, _ in pairs(self) do
    if set[k] then
      res[k] = true
    end
  end
  return res
end

function Set:isdisjoint(set)
  for k in pairs(self) do
    if set[k] then
      return false
    end
  end
  return true
end

function Set.isempty(self)
  return not next(self)
end

function Set:issubset(set)
  for k in pairs(self) do
    if not set[k] then
      return false
    end
  end
  return true
end

function Set:issuperset(set)
  for k in pairs(set) do
    if not self[k] then
      return false
    end
  end
  return true
end

function Set:len()
  local len = 0
  for _ in pairs(self) do
    len = len + 1
  end
  return len
end

function Set:map(fn)
  local set = Set()
  for k in pairs(self) do
    set[fn(k)] = true
  end
  return set
end

function Set:pop()
  local k = next(self)
  if k ~= nil then
    self[k] = nil
    return k
  end
end

Set.remove = Set.discard

function Set:symmetric_difference_update(set)
  for k in pairs(set) do
    self[k] = not self[k] and true or nil
  end
  return self
end

function Set:symmetric_difference(set)
  local res = self:difference(set)
  for k in pairs(set) do
    if not self[k] then
      res[k] = true
    end
  end
  return res
end

function Set:union(set)
  local res = self:copy()
  for k in pairs(set) do
    res[k] = true
  end
  return res
end

function Set:update(other)
  for k, v in pairs(other) do
    self[k] = v
  end
  return self
end

function Set:values()
  local ls = List and List() or {}
  local i = 1
  for k in pairs(self) do
    ls[i] = k
    i = i + 1
  end
  return ls
end

return setmetatable(Set, {
  __call = function(_, t)
    local set = {}
    for _, v in ipairs(t or {}) do
      set[v] = true
    end
    return setmetatable(set, Set)
  end,
})
