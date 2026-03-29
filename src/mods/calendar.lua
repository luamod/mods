local mods = require "mods"

local List = mods.List
local str = mods.str
local utils = mods.utils

local assert_arg = utils.assert_arg
local validate = utils.validate
local ljust = str.ljust

local floor = math.floor
local sub = string.sub
local fmt = string.format
local concat = table.concat

---@type mods.calendar
---@diagnostic disable-next-line: missing-fields
local M = {}

-- stylua: ignore
local months = {
  "January", "February", "March"    , "April"  , "May"     , "June"    ,
  "July"   , "August"  , "September", "October", "November", "December",
}
local month_lengths = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
local days = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" }

-- stylua: ignore start
for i, v in ipairs(months) do M[v:upper()] = i end
for i, v in ipairs(days)   do M[v:upper()] = i end
-- stylua: ignore end

local default_firstweekday = M.MONDAY

-- Return a positive modulo result for negative offsets too.
local function posmod(a, b)
  local r = a % b
  return r < 0 and r + b or r
end

-- Divide and round toward negative infinity.
local function floor_div(a, b)
  local q = a / b
  return q >= 0 and floor(q) or -floor(-q)
end

local function validate_month(month)
  assert_arg(1, month, "integer")
  if month < 1 or month > 12 then
    error(fmt("bad month number %s; must be 1-12", month), 3)
  end
  return month
end

local function validate_weekday(firstweekday)
  if firstweekday < 1 or firstweekday > 7 then
    error(fmt("bad weekday number %s; must be 1 (Monday) to 7 (Sunday)", firstweekday), 3)
  end
  return firstweekday
end

local function resolve_firstweekday(index, firstweekday)
  if firstweekday == nil then
    return default_firstweekday
  end
  assert_arg(index, firstweekday, "integer")
  return validate_weekday(firstweekday)
end

local function format_weekheader(firstweekday, width)
  local parts = {}
  for i = 0, 6 do
    local name = days[((firstweekday - 1 + i) % 7) + 1]
    parts[#parts + 1] = ljust(sub(name, 1, width), width)
  end
  return concat(parts, " ")
end

local function is_leap(year)
  return year % 4 == 0 and (year % 100 ~= 0 or year % 400 == 0)
end

local function monthlen(year, month)
  return (month == 2 and is_leap(year)) and 29 or month_lengths[month]
end

-- Convert a Gregorian calendar date to days since the Unix epoch.
-- Based on a civil-date to serial-day algorithm using 400-year eras.
local function days_from_civil(year, month, day)
  year = month <= 2 and year - 1 or year
  local era = floor_div(year >= 0 and year or year - 399, 400)
  local yoe = year - era * 400
  local mp = month + (month > 2 and -3 or 9)
  local doy = floor((153 * mp + 2) / 5) + day - 1
  local doe = yoe * 365 + floor(yoe / 4) - floor(yoe / 100) + doy
  return era * 146097 + doe - 719468
end

function M.listweekdays(firstweekday)
  firstweekday = resolve_firstweekday(1, firstweekday)
  local out = List()
  for i = 0, 6 do
    out[#out + 1] = ((firstweekday - 1 + i) % 7) + 1
  end
  return out
end

function M.getfirstweekday()
  return default_firstweekday
end

function M.setfirstweekday(firstweekday)
  assert_arg(1, firstweekday, "integer")
  default_firstweekday = validate_weekday(firstweekday)
end

function M.isleap(year)
  assert_arg(1, year, "integer")
  return is_leap(year)
end

function M.leapdays(y1, y2)
  assert_arg(1, y1, "integer")
  assert_arg(2, y2, "integer")
  y1 = y1 - 1
  y2 = y2 - 1
  return (floor_div(y2, 4) - floor_div(y1, 4))
    - (floor_div(y2, 100) - floor_div(y1, 100))
    + (floor_div(y2, 400) - floor_div(y1, 400))
end

function M.weekday(year, month, day)
  assert_arg(1, year, "integer")
  assert_arg(2, month, "integer")
  assert_arg(3, day, "integer")
  validate_month(month)
  if day < 1 or day > monthlen(year, month) then
    error(fmt("bad day number %s for %d-%02d", tostring(day), year, month), 2)
  end
  return posmod(days_from_civil(year, month, day) + 3, 7) + 1
end

function M.monthrange(year, month)
  assert_arg(1, year, "integer")
  assert_arg(2, month, "integer")
  validate_month(month)
  return M.weekday(year, month, 1), monthlen(year, month)
end

function M.weekheader(width, firstweekday)
  assert_arg(1, width, "integer", true)
  width = width or 2
  if width < 1 then
    error("bad argument #1 to 'weekheader' (width must be a positive integer)", 2)
  end
  return format_weekheader(resolve_firstweekday(2, firstweekday), width)
end

M.days = List(days)
M.months = List(months)

return setmetatable(M, {
  __index = function(_, k)
    if k == "firstweekday" then
      return default_firstweekday
    end
  end,
  __newindex = function(_, k, v)
    if k == "firstweekday" then
      validate("calendar.firstweekday", v, "integer")
      default_firstweekday = validate_weekday(v)
    end
  end,
})
