local tbl = require("mods.tbl")

local ipairs = ipairs
local next = next
local pairs = pairs

---@type mods.Set
local Set = {}
Set.__index = Set

local function new_set()
  return setmetatable({}, Set)
end

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
  return setmetatable(tbl.copy(self), Set)
end

function Set:difference_update(set)
  for k in pairs(set) do
    self[k] = nil
  end
  return self
end

function Set:difference(set)
  return self:copy():difference_update(set)
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
  return self:copy():intersection_update(set)
end

function Set:isdisjoint(set)
  for k in pairs(self) do
    if set[k] then
      return false
    end
  end
  return true
end

Set.isempty = tbl.isempty

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

Set.len = tbl.count

function Set:map(fn)
  local set = new_set()
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
  return self:copy():symmetric_difference_update(set)
end

function Set:union(set)
  return self:copy():update(set)
end

Set.update = tbl.update

Set.values = tbl.keys

return setmetatable(Set, {
  __call = function(_, t)
    local set = new_set()
    for _, v in ipairs(t or {}) do
      set[v] = true
    end
    return set
  end,
})
