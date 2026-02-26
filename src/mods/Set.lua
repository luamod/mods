local mods = require("mods")

local next = next
local pairs = pairs

local tbl_map = {
  update = "update",
  values = "keys",
  len = "count",
  isempty = "isempty",
}

---@type mods.Set
local Set = {}
Set.__index = Set

local function new()
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
  local set = new()
  for k in pairs(self) do
    set[k] = true
  end
  return set
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

function Set:contains(v)
  return self[v] ~= nil
end

function Set:map(fn)
  local set = new()
  for k in pairs(self) do
    set[fn(k)] = true
  end
  return set
end

function Set:pop()
  local k = next(self)
  if k == nil then
    return
  end
  self[k] = nil
  return k
end

function Set:remove(v)
  self[v] = nil
  return self
end

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

Set.__add = Set.union

return setmetatable(Set, {
  __index = function(t, k)
    local fname = tbl_map[k]
    if fname then
      local fn = mods.tbl[fname]
      rawset(t, k, fn)
      return fn
    end
  end,
  __call = function(_, t)
    local set = new()
    if t == nil then
      return set
    end
    for i = 1, #t do
      set[t[i]] = true
    end
    return set
  end,
})
