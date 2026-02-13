local List = require("mods.List")
local utils = require("mods.utils")

local byte = string.byte
local char = string.char
local concat = table.concat
local find = string.find
local floor = math.floor
local gmatch = string.gmatch
local gsub = string.gsub
local lower = string.lower
local match = string.match
local rep = string.rep
local sub = string.sub
local upper = string.upper

---@type mods.str
local M = {}

local function norm_range(s, start, stop)
  local len = #s
  if start == nil then
    start = 1
  elseif start < 0 then
    start = len + start + 1
  end

  if stop == nil then
    stop = len
  elseif stop < 0 then
    stop = len + stop + 1
  end

  if start < 1 then
    start = 1
  end
  if stop > len then
    stop = len
  end

  return start, stop
end

local function escape_class(s)
  return gsub(s, "([%%%]%^%-])", "%%%1")
end

local function is_nonempty_match(s, pattern)
  return #s > 0 and match(s, pattern) ~= nil
end

local function first_char_or_space(fillchar)
  return fillchar and sub(fillchar, 1, 1) or " "
end

local function split_whitespace_words(s)
  local parts = {}
  for w in gmatch(s, "%S+") do
    parts[#parts + 1] = w
  end
  return parts
end

local function norm_range_exclusive(s, start, stop)
  local len = #s
  local a = start
  local b = stop

  if a == nil then
    a = 1
  elseif a < 0 then
    a = len + a + 1
  end

  if b == nil then
    b = len + 1
  elseif b < 0 then
    b = len + b + 1
  end

  if a < 1 then
    a = 1
  elseif a > len + 1 then
    a = len + 1
  end

  if b < 1 then
    b = 1
  elseif b > len + 1 then
    b = len + 1
  end

  return a, b
end

function M.capitalize(s)
  return upper(sub(s, 1, 1)) .. lower(sub(s, 2))
end

function M.center(s, width, fillchar)
  local len = #s
  if width <= len then
    return s
  end
  local pad = width - len
  local left = floor(pad / 2)
  local right = pad - left
  local fc = first_char_or_space(fillchar)
  return rep(fc, left) .. s .. rep(fc, right)
end

function M.count(s, subp, start, stop)
  local a, b = norm_range_exclusive(s, start, stop)
  if b <= a then
    return 0
  end
  local slice = sub(s, a, b - 1)
  if subp == "" then
    return (b - a) + 1
  end

  local n = 0
  local pos = 1
  local sublen = #subp
  while true do
    local i = find(slice, subp, pos, true)
    if not i then
      break
    end
    n = n + 1
    pos = i + sublen
  end
  return n
end

function M.expandtabs(s, tabsize)
  local ts = tabsize or 8
  if ts <= 0 then
    return gsub(s, "\t", "")
  end

  local out = {}
  local col = 0
  for i = 1, #s do
    local c = sub(s, i, i)
    if c == "\t" then
      local spaces = ts - (col % ts)
      out[#out + 1] = rep(" ", spaces)
      col = col + spaces
    else
      out[#out + 1] = c
      col = (c == "\n" or c == "\r") and 0 or (col + 1)
    end
  end
  return concat(out)
end

function M.endswith(s, suffix, start, stop)
  if type(suffix) == "table" then
    for i = 1, #suffix do
      if M.endswith(s, suffix[i], start, stop) then
        return true
      end
    end
    return false
  end

  local a, b = norm_range_exclusive(s, start, stop)
  if suffix == "" then
    return a <= b
  end

  local slen = #suffix
  if b - a < slen then
    return false
  end

  local endpos = b - 1
  local startpos = endpos - slen + 1
  if startpos < a then
    return false
  end

  return sub(s, startpos, endpos) == suffix
end

function M.find(s, subp, start, stop)
  local a, b = norm_range_exclusive(s, start, stop)
  if subp == "" then
    return a <= b and a or nil
  end
  if b <= a then
    return nil
  end
  local i = find(s, subp, a, true)
  if not i then
    return nil
  end
  if i + #subp - 1 >= b then
    return nil
  end
  return i
end

function M.format_map(s, mapping)
  return gsub(s, "{(.-)}", function(k)
    local v = mapping[k]
    if v == nil then
      return "nil"
    end
    return tostring(v)
  end)
end

function M.isalnum(s)
  return is_nonempty_match(s, "^[%a%d]+$")
end

function M.isalpha(s)
  return is_nonempty_match(s, "^%a+$")
end

function M.isascii(s)
  local len = #s
  for i = 1, len do
    if byte(s, i) > 127 then
      return false
    end
  end
  return true
end

function M.isdecimal(s)
  return is_nonempty_match(s, "^%d+$")
end

function M.isdigit(s)
  return is_nonempty_match(s, "^%d+$")
end

M.isidentifier = utils.isidentifier

function M.islower(s)
  local has = false
  for i = 1, #s do
    local c = sub(s, i, i)
    if match(c, "%a") then
      if c ~= lower(c) then
        return false
      end
      has = true
    end
  end
  return has
end

function M.isnumeric(s)
  return is_nonempty_match(s, "^%d+$")
end

function M.isprintable(s)
  local len = #s
  for i = 1, len do
    local b = byte(s, i)
    if b < 32 or b > 126 then
      return false
    end
  end
  return true
end

function M.isspace(s)
  return is_nonempty_match(s, "^%s+$")
end

function M.istitle(s)
  local has = false
  for word in gmatch(s, "%a+") do
    local first = sub(word, 1, 1)
    local rest = sub(word, 2)
    if first ~= upper(first) or rest ~= lower(rest) then
      return false
    end
    has = true
  end
  return has
end

function M.isupper(s)
  local has = false
  for i = 1, #s do
    local c = sub(s, i, i)
    if match(c, "%a") then
      if c ~= upper(c) then
        return false
      end
      has = true
    end
  end
  return has
end

function M.join(sep, list)
  return concat(list, sep)
end

function M.ljust(s, width, fillchar)
  local len = #s
  if width <= len then
    return s
  end
  local fc = first_char_or_space(fillchar)
  return s .. rep(fc, width - len)
end

M.lower = lower

function M.lstrip(s, chars)
  if chars == nil then
    return gsub(s, "^%s+", "")
  end
  if chars == "" then
    return s
  end
  local set = escape_class(chars)
  return gsub(s, "^[" .. set .. "]+", "")
end

function M.rstrip(s, chars)
  if chars == nil then
    return gsub(s, "%s+$", "")
  end
  if chars == "" then
    return s
  end
  local set = escape_class(chars)
  return gsub(s, "[" .. set .. "]+$", "")
end

function M.strip(s, chars)
  if chars == "" then
    return s
  end
  return M.lstrip(M.rstrip(s, chars), chars)
end

function M.partition(s, sep)
  if sep == "" then
    error("empty separator")
  end
  local i, j = find(s, sep, 1, true)
  if not i then
    return s, "", ""
  end
  return sub(s, 1, i - 1), sep, sub(s, j + 1)
end

function M.removeprefix(s, prefix)
  if prefix ~= "" and sub(s, 1, #prefix) == prefix then
    return sub(s, #prefix + 1)
  end
  return s
end

function M.removesuffix(s, suffix)
  if suffix ~= "" and sub(s, -#suffix) == suffix then
    return sub(s, 1, #s - #suffix)
  end
  return s
end

function M.replace(s, old, new, count)
  if count == 0 then
    return s
  end

  if count == nil or count < 0 then
    count = -1
  end

  if old == "" then
    local len = #s
    local limit = count
    if limit < 0 then
      limit = len + 1
    end
    if limit == 0 then
      return s
    end
    local out = {}
    out[#out + 1] = new
    local n = 1
    for i = 1, len do
      out[#out + 1] = sub(s, i, i)
      if n < limit then
        out[#out + 1] = new
        n = n + 1
      end
    end
    return concat(out)
  end

  local out = {}
  local start = 1
  local n = 0
  while true do
    local i, j = find(s, old, start, true)
    if not i or (count >= 0 and n >= count) then
      break
    end
    out[#out + 1] = sub(s, start, i - 1)
    out[#out + 1] = new
    start = j + 1
    n = n + 1
  end
  out[#out + 1] = sub(s, start)
  return concat(out)
end

function M.rfind(s, subp, start, stop)
  local a, b = norm_range(s, start, stop)
  if subp == "" then
    return b
  end
  if b < a then
    return nil
  end
  local slice = sub(s, a, b)
  local last
  local pos = 1
  while true do
    local i = find(slice, subp, pos, true)
    if not i then
      break
    end
    last = i
    pos = i + 1
  end
  if not last then
    return nil
  end
  return a + last - 1
end

function M.rindex(s, subp, start, stop)
  local i = M.rfind(s, subp, start, stop)
  if i == nil then
    error("substring not found")
  end
  return i
end

function M.rjust(s, width, fillchar)
  local len = #s
  if width <= len then
    return s
  end
  local fc = first_char_or_space(fillchar)
  return rep(fc, width - len) .. s
end

function M.rpartition(s, sep)
  if sep == "" then
    error("empty separator")
  end
  local i, j = nil, nil
  local pos = 1
  while true do
    local a, b = find(s, sep, pos, true)
    if not a then
      break
    end
    i, j = a, b
    pos = a + 1
  end
  if not i then
    return "", "", s
  end
  return sub(s, 1, i - 1), sep, sub(s, j + 1)
end

function M.rsplit(s, sep, maxsplit)
  if sep == nil then
    local parts = split_whitespace_words(s)
    if maxsplit == nil or maxsplit < 0 or #parts <= maxsplit + 1 then
      return parts
    end
    local keep = maxsplit + 1
    local out = {}
    local start = #parts - keep + 1
    out[1] = concat(parts, " ", 1, start - 1)
    for i = start, #parts do
      out[#out + 1] = parts[i]
    end
    return out
  end

  if sep == "" then
    error("empty separator")
  end

  local splits = maxsplit or -1
  if splits == 0 then
    return { s }
  end

  local parts = {}
  local pos = #s
  while pos > 0 and (splits < 0 or #parts < splits) do
    local i, j = nil, nil
    local search = 1
    while true do
      local a, b = find(s, sep, search, true)
      if not a or b > pos then
        break
      end
      i, j = a, b
      search = a + 1
    end
    if not i then
      break
    end
    parts[#parts + 1] = sub(s, j + 1, pos)
    pos = i - 1
  end

  parts[#parts + 1] = sub(s, 1, pos)
  local out = List()
  for i = #parts, 1, -1 do
    out[#out + 1] = parts[i]
  end
  return out
end

function M.split(s, sep, maxsplit)
  if sep == nil then
    local parts = split_whitespace_words(s)
    if maxsplit == nil or maxsplit < 0 or #parts <= maxsplit + 1 then
      return parts
    end
    local out = List()
    local keep = maxsplit + 1
    for i = 1, keep - 1 do
      out[#out + 1] = parts[i]
    end
    out[#out + 1] = concat(parts, " ", keep, #parts)
    return out
  end

  if sep == "" then
    error("empty separator")
  end

  local splits = maxsplit or -1
  if splits == 0 then
    return { s }
  end

  local parts = {}
  local pos = 1
  while true do
    local i, j = find(s, sep, pos, true)
    if not i or (splits >= 0 and #parts >= splits) then
      break
    end
    parts[#parts + 1] = sub(s, pos, i - 1)
    pos = j + 1
  end
  parts[#parts + 1] = sub(s, pos)
  return parts
end

function M.splitlines(s, keepends)
  local len = #s
  local out = List()
  local i = 1
  while i <= len do
    local j = i
    while j <= len do
      local c = sub(s, j, j)
      if c == "\n" or c == "\r" then
        break
      end
      j = j + 1
    end

    if j > len then
      out[#out + 1] = sub(s, i)
      break
    end

    local line = sub(s, i, j - 1)
    local e = j
    if sub(s, j, j) == "\r" and sub(s, j + 1, j + 1) == "\n" then
      e = j + 1
    end

    if keepends then
      out[#out + 1] = sub(s, i, e)
    else
      out[#out + 1] = line
    end

    i = e + 1
  end
  return out
end

function M.swapcase(s)
  local len = #s
  if len == 0 then
    return s
  end
  local out = {}
  for i = 1, len do
    local c = sub(s, i, i)
    if match(c, "%a") then
      if c == lower(c) then
        out[#out + 1] = upper(c)
      else
        out[#out + 1] = lower(c)
      end
    else
      out[#out + 1] = c
    end
  end
  return concat(out)
end

function M.startswith(s, prefix, start, stop)
  if type(prefix) == "table" then
    for i = 1, #prefix do
      if M.startswith(s, prefix[i], start, stop) then
        return true
      end
    end
    return false
  end

  local a, b = norm_range_exclusive(s, start, stop)
  if prefix == "" then
    return a <= b
  end

  local plen = #prefix
  if b - a < plen then
    return false
  end

  return sub(s, a, a + plen - 1) == prefix
end

function M.title(s)
  return gsub(lower(s), "(%a)([%w]*)", function(f, r)
    return upper(f) .. lower(r)
  end)
end

function M.translate(s, table_map)
  local out = {}
  for i = 1, #s do
    local b = byte(s, i)
    local c = char(b)
    local v = table_map[b]
    if v == nil then
      v = table_map[c]
    end

    if v == nil then
      out[#out + 1] = c
    elseif v == false then
      out[#out + 1] = ""
    elseif type(v) == "number" then
      out[#out + 1] = char(v)
    else
      out[#out + 1] = tostring(v)
    end
  end
  return concat(out)
end

M.upper = upper

function M.zfill(s, width)
  local len = #s
  if width <= len then
    return s
  end
  local sign = sub(s, 1, 1)
  if sign == "+" or sign == "-" then
    return sign .. rep("0", width - len) .. sub(s, 2)
  end
  return rep("0", width - len) .. s
end

return M
