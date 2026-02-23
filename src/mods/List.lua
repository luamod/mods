local mods = require("mods")

local insert = table.insert
local sort = table.sort
local remove = table.remove
local concat = table.concat
local move = table.move

---@type mods.List
local List = {}
List.__index = List

-- Use a plain table (not `mods.Set`) for fast, low-overhead membership lookups.
local function build_lookup(ls)
  local lookup = {}
  for i = 1, #ls do
    lookup[ls[i]] = true
  end
  return lookup
end

local function collect_by_lookup(self, lookup, include)
  local res = List()
  local ri = 1
  for i = 1, #self do
    local v = self[i]
    local present = lookup[v] ~= nil
    if present == include then
      res[ri] = v
      ri = ri + 1
    end
  end
  return res
end

local function copy_range(self, start_i, end_i)
  local res = List()
  if end_i < start_i then
    return res
  end
  local ri = 1
  for i = start_i, end_i do
    res[ri] = self[i]
    ri = ri + 1
  end
  return res
end

function List:all(pred)
  for i = 1, #self do
    if not pred(self[i]) then
      return false
    end
  end
  return true
end

function List:any(pred)
  for i = 1, #self do
    if pred(self[i]) then
      return true
    end
  end
  return false
end

function List:append(v)
  self[#self + 1] = v
  return self
end

function List:clear()
  for i = #self, 1, -1 do
    self[i] = nil
  end
  return self
end

function List:contains(v)
  return self:index(v) ~= nil
end

function List:copy()
  return copy_range(self, 1, #self)
end

function List:count(v)
  local c = 0
  for i = 1, #self do
    if self[i] == v then
      c = c + 1
    end
  end
  return c
end

function List:difference(ls)
  local lookup = build_lookup(ls)
  return collect_by_lookup(self, lookup, false)
end

function List:drop(n)
  local len = #self
  if n == nil or n <= 0 then
    return copy_range(self, 1, len)
  end
  if n >= len then
    return List()
  end
  return copy_range(self, n + 1, len)
end

function List:extend(ls)
  for i = 1, #ls do
    self[#self + 1] = ls[i]
  end
  return self
end

function List:extract(pred)
  local extracted = List()
  local keep_i = 1
  local extracted_i = 1
  local len = #self
  for i = 1, len do
    local v = self[i]
    if pred(v) then
      extracted[extracted_i] = v
      extracted_i = extracted_i + 1
    else
      self[keep_i] = v
      keep_i = keep_i + 1
    end
  end
  for i = keep_i, len do
    self[i] = nil
  end
  return extracted
end

function List:filter(pred)
  local res = List()
  local ri = 1
  for i = 1, #self do
    local v = self[i]
    if pred(v) then
      res[ri] = v
      ri = ri + 1
    end
  end
  return res
end

function List:first()
  return self[1]
end

function List:flatten()
  local res = List()
  local ri = 1
  for i = 1, #self do
    local v = self[i]
    if type(v) == "table" then
      for j = 1, #v do
        res[ri] = v[j]
        ri = ri + 1
      end
    else
      res[ri] = v
      ri = ri + 1
    end
  end
  return res
end

function List:foreach(fn)
  for i = 1, #self do
    fn(self[i])
  end
end

function List:group_by(fn)
  local res = {}
  local counts = {}
  for i = 1, #self do
    local v = self[i]
    local key = fn(v)
    local bucket = res[key]
    if bucket == nil then
      bucket = List()
      res[key] = bucket
      counts[key] = 1
      bucket[1] = v
    else
      local idx = counts[key] + 1
      counts[key] = idx
      bucket[idx] = v
    end
  end
  return res
end

function List:index(v)
  for i = 1, #self do
    if self[i] == v then
      return i
    end
  end
end

function List:index_if(pred)
  for i = 1, #self do
    if pred(self[i]) then
      return i
    end
  end
  return nil
end

function List:insert(pos, v)
  if v == nil then
    insert(self, pos)
  else
    insert(self, pos, v)
  end
  return self
end

function List:intersection(ls)
  local lookup = build_lookup(ls)
  return collect_by_lookup(self, lookup, true)
end

function List:invert()
  local res = {}
  for i = 1, #self do
    res[self[i]] = i
  end
  return res
end

function List:join(sep)
  return concat(self, sep)
end

function List:last()
  return self[#self]
end

function List:len()
  return #self
end

function List:map(fn)
  local ls = List()
  local ri = 1
  for i = 1, #self do
    ls[ri] = fn(self[i])
    ri = ri + 1
  end
  return ls
end

function List:prepend(v)
  insert(self, 1, v)
  return self
end

function List:reduce(fn, init)
  local len = #self
  if len == 0 then
    return init
  end
  local acc
  local start = 1
  if init == nil then
    acc = self[1]
    start = 2
  else
    acc = init
  end
  for i = start, len do
    acc = fn(acc, self[i])
  end
  return acc
end

function List:remove(v)
  for i = 1, #self do
    if self[i] == v then
      remove(self, i)
      break
    end
  end
  return self
end

function List:reverse()
  local res = List()
  local ri = 1
  for i = #self, 1, -1 do
    res[ri] = self[i]
    ri = ri + 1
  end
  return res
end

List.pop = remove

function List:slice(i, j)
  local len = #self
  local res = List()
  if len == 0 then
    return res
  end
  local start = i or 1
  local finish = j or len
  if start < 0 then
    start = len + start + 1
  end
  if finish < 0 then
    finish = len + finish + 1
  end
  if start < 1 then
    start = 1
  end
  if finish > len then
    finish = len
  end
  if start > finish then
    return res
  end
  if move then
    move(self, start, finish, 1, res)
  else
    return copy_range(self, start, finish)
  end
  return res
end

function List:sort(comp)
  sort(self, comp)
  return self
end

function List:take(n)
  if n == nil or n <= 0 then
    return List()
  end
  local limit = #self
  if n < limit then
    limit = n
  end
  return copy_range(self, 1, limit)
end

function List:uniq()
  local res = List()
  local seen = {}
  local ri = 1
  for i = 1, #self do
    local v = self[i]
    if not seen[v] then
      seen[v] = true
      res[ri] = v
      ri = ri + 1
    end
  end
  return res
end

function List:zip(other)
  local res = List()
  if other == nil then
    return res
  end
  local len = #self
  local other_len = #other
  local limit = len
  if other_len < limit then
    limit = other_len
  end
  local ri = 1
  for i = 1, limit do
    res[ri] = { self[i], other[i] }
    ri = ri + 1
  end
  return res
end

return setmetatable(List, {
  __index = function(t, k)
    if k == "setify" then
      local fn = mods.Set
      rawset(t, k, fn)
      return fn
    end
  end,
  __call = function(_, ls)
    return setmetatable(ls or {}, List)
  end,
})
