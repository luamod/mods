---@meta mods.calendar

---@alias modsCalendarWeekday 1|2|3|4|5|6|7

---
---Calendar and date helpers.
---
---## Usage
---
---```lua
---cal = require "mods.calendar"
---
---print(cal.weekday(2026, 3, 26)) --> 4
---```
---
---@class mods.calendar
---@field JANUARY    1
---@field FEBRUARY   2
---@field MARCH      3
---@field APRIL      4
---@field MAY        5
---@field JUNE       6
---@field JULY       7
---@field AUGUST     8
---@field SEPTEMBER  9
---@field OCTOBER   10
---@field NOVEMBER  11
---@field DECEMBER  12
---
---@field MONDAY    1
---@field TUESDAY   2
---@field WEDNESDAY 3
---@field THURSDAY  4
---@field FRIDAY    5
---@field SATURDAY  6
---@field SUNDAY    7
---
---Month names indexed from `1` to `12`.
---
---```lua
---print(cal.months[1])  --> January
---print(cal.months[12]) --> December
---```
---@field months mods.List<string>
---
---Weekday names indexed from `1` (Monday) to `7` (Sunday).
---
---```lua
---print(cal.days[1]) --> Monday
---print(cal.days[7]) --> Sunday
---```
---@field days mods.List<string>
---
---The default first weekday field.
---
---```lua
---print(cal.firstweekday) --> 1
---cal.firstweekday = cal.SUNDAY
---print(cal.firstweekday) --> 7
---```
---
---> [!NOTE]
--->
---> Reading or writing this property is equivalent to calling
---> `getfirstweekday()` or `setfirstweekday()`.
---
---@field firstweekday modsCalendarWeekday
local M = {}

---
---Return the default first weekday.
---
---```lua
---print(cal.getfirstweekday()) --> 1
---```
---
---> [!NOTE]
--->
---> This returns the same value as `cal.firstweekday`.
---
---@return modsCalendarWeekday firstweekday
---@nodiscard
function M.getfirstweekday() end

---
---Set the default first weekday.
---
---```lua
---cal.setfirstweekday(cal.SUNDAY)
---```
---
---> [!NOTE]
--->
---> This updates the same value as
---> `cal.firstweekday = ...`.
---
---@param firstweekday modsCalendarWeekday
function M.setfirstweekday(firstweekday) end

---
---Return weekday numbers for one full week as a `List`.
---
---```lua
---days = cal.listweekdays()              -->  {1, 2, 3, 4, 5, 6, 7}
---days = cal.listweekdays(cal.SUNDAY)    -->  {7, 1, 2, 3, 4, 5, 6}
---days = cal.listweekdays(cal.WEDNESDAY) -->  {3, 4, 5, 6, 7, 1, 2}
---```
---
---@section Lists
---@param firstweekday? modsCalendarWeekday
---@return mods.List<integer> weekdays
---@nodiscard
function M.listweekdays(firstweekday) end

---
---Return `true` for leap years.
---
---```lua
---print(cal.isleap(2024)) --> true
---```
---
---@section Calendar Calculations
---@param year integer
---@return boolean isLeap
---@nodiscard
function M.isleap(year) end

---
---Return the number of leap years from `y1` up to but not including `y2`.
---
---```lua
---print(cal.leapdays(2000, 2025)) --> 7
---```
---
---@section Calendar Calculations
---@param y1 integer
---@param y2 integer
---@return integer count
---@nodiscard
function M.leapdays(y1, y2) end

---
---Return weekday number where Monday is `1` and Sunday is `7`.
---
---```lua
---print(cal.weekday(2026, 3, 26)) --> 4
---```
---
---@section Calendar Calculations
---@param year integer
---@param month integer
---@param day integer
---@return modsCalendarWeekday weekday
---@nodiscard
function M.weekday(year, month, day) end

---
---Return the first weekday and number of days for a month.
---
---```lua
---wday, ndays = cal.monthrange(2026, 2)
---print(wday, ndays) --> 7 28
---```
---
---@section Calendar Calculations
---@param year integer
---@param month integer
---@return modsCalendarWeekday weekday
---@return integer ndays
---@nodiscard
function M.monthrange(year, month) end

---
---Return the formatted weekday header string.
---
---```lua
---print(cal.weekheader(1, cal.SUNDAY)) --> "S M T W T F S"
---print(cal.weekheader(2, cal.SUNDAY)) --> "Su Mo Tu We Th Fr Sa"
---print(cal.weekheader(3, cal.SUNDAY)) --> "Sun Mon Tue Wed Thu Fri Sat"
---```
---
---@section Formatting
---@param width? integer
---@param firstweekday? modsCalendarWeekday
---@return string header
---@nodiscard
function M.weekheader(width, firstweekday) end

return M
