---@diagnostic disable: invisible

local tbl = require "mods.tbl"
local utils = require "mods.utils"

local quote = utils.quote
local concat = table.concat

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
  local set = setmetatable({}, Set)
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

function Set:join(sep, quoted)
  local out = {}
  for v in pairs(self) do
    local i = #out + 1
    if v == self then
      out[i] = "<self>"
    elseif quoted and type(v) == "string" then
      out[i] = quote(v)
    else
      out[i] = tostring(v)
    end
  end
  return concat(out, sep)
end

function Set:tostring()
  return "{ " .. self:join(", ", true) .. " }"
end

function Set:map(fn)
  local set = setmetatable({}, Set)
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

Set.equals = tbl.same
Set.isempty = tbl.isempty
Set.len = tbl.count
Set.update = tbl.update
Set.values = tbl.keys

Set.__add = Set.union
Set.__band = Set.intersection
Set.__bor = Set.union
Set.__bxor = Set.symmetric_difference
Set.__eq = tbl.same
Set.__le = Set.issubset
Set.__lt = function(a, b)
  return a:issubset(b) and not a:issuperset(b)
end
Set.__sub = Set.difference
Set.__tostring = Set.tostring

return setmetatable(Set, {
  __call = function(_, t)
    local set = setmetatable({}, Set)
    if t == nil then
      return set
    end
    for i = 1, #t do
      set[t[i]] = true
    end
    return set
  end,
})
