--[[
  Portions of this module are derived from CPython's pathlib.py.
  Adapted and ported to Lua for this project's API and conventions.
  Source: https://github.com/python/cpython/blob/main/Lib/pathlib/__init__.py
  License: Python Software Foundation License Version 2 (PSF-2.0).
  Copyright (c) 2001 Python Software Foundation; All Rights Reserved.
]]

local mods = require "mods"

local List = mods.List
local runtime = mods.runtime
local str = mods.str
local utils = mods.utils
local is_win = runtime.is_windows
local assert_arg = utils.assert_arg
local rfind = str.rfind

local concat = table.concat
local find = string.find
local fmt = string.format
local getenv = os.getenv
local gmatch = string.gmatch
local gsub = string.gsub
local lower = string.lower
local match = string.match
local sub = string.sub

---@type mods.path
local M = {}

local CURDIR = "."
local DRIVE_SEP = ":"
local PARDIR = ".."
local EXT_SEP = "."
local SEP = is_win and "\\" or "/"

for k, v in pairs(is_win and mods.ntpath or mods.posixpath) do
  M[k] = v
end

---@return string drive, string root, string tail
local function splitroot(p)
  p = is_win and gsub(p, "/", "\\") or p
  local drive, root, tail = M.splitroot(p)
  if sub(drive, 1, 2) == "\\\\" then
    root = "\\"
  end
  return drive, root, tail
end

---@return string drive, string root, string[] tail
local function parse_path(p)
  local drive, root, tail_ = splitroot(p)
  local tail = {}
  for part in gmatch(tail_, "[^" .. SEP .. "]+") do
    if part ~= CURDIR then
      tail[#tail + 1] = part
    end
  end
  return drive, root, tail
end

local function ignore_case(case_sensitive)
  return case_sensitive == false or (case_sensitive == nil and is_win)
end

local function parts_equal(a, b, case_sensitive)
  if ignore_case(case_sensitive) then
    return M.normcase(a) == M.normcase(b)
  end
  return a == b
end

local function name_of(p)
  local _, _, tail = parse_path(p)
  return tail[#tail] or ""
end

local function relative_parts(p, other)
  local drive, root, tail = parse_path(p)
  local other_drive, other_root, other_tail = parse_path(other)

  if not parts_equal(drive .. root, other_drive .. other_root) then
    return
  end
  if #other_tail > #tail then
    return
  end

  for i = 1, #other_tail do
    if not parts_equal(tail[i], other_tail[i]) then
      return
    end
  end

  local out = {}
  for i = #other_tail + 1, #tail do
    out[#out + 1] = tail[i]
  end
  return out
end

local function match_part(name, pattern, case_sensitive)
  if ignore_case(case_sensitive) then
    name = lower(name)
    pattern = lower(pattern)
  end
  local s = gsub(pattern, "([%^%$%(%)%%%.%[%]%+%-])", "%%%1"):gsub("%*", ".*"):gsub("%?", ".")
  return match(name, "^" .. s .. "$") ~= nil
end

local function expandvars(getenv_fn, str, pattern, prefix, suffix)
  return gsub(str, pattern, function(name)
    local v = getenv_fn(name)
    return v and v or (prefix .. name .. suffix)
  end)
end

function M._splitext(p, sep, altsep, extsep)
  local sep_index = rfind(p, sep) or 0
  if altsep then
    local altsep_index = rfind(p, altsep) or 0
    sep_index = altsep_index > sep_index and altsep_index or sep_index
  end

  local dot_index = rfind(p, extsep) or 0
  if dot_index > sep_index then
    local filename_index = sep_index + 1
    while filename_index < dot_index do
      if sub(p, filename_index, filename_index) ~= extsep then
        return sub(p, 1, dot_index - 1), sub(p, dot_index)
      end
      filename_index = filename_index + 1
    end
  end

  return p, ""
end

function M.anchor(p)
  assert_arg(1, p, "string")
  local drive, root = splitroot(p)
  return drive .. root
end

function M.as_posix(p)
  assert_arg(1, p, "string")
  return (gsub(p, "\\", "/"))
end

function M.dirnames(p)
  assert_arg(1, p, "string")
  local drive, root, tail = parse_path(p)
  local out = {}
  for i = #tail - 1, 0, -1 do
    local parts = {}
    for j = 1, i do
      parts[j] = tail[j]
    end
    local value = drive .. root .. concat(parts, SEP)
    out[#out + 1] = value ~= "" and value or CURDIR
  end
  return List(out)
end

function M.drive(p)
  assert_arg(1, p, "string")
  return (splitroot(p))
end

function M.expandvars(p)
  assert_arg(1, p, "string")
  local res = expandvars(getenv, p, "%${([^}]*)}", "${", "}")
  res = expandvars(getenv, res, "%$([%w_]+)", "$", "")
  return is_win and mods.ntpath._expand_percent_vars(res) or res
end

function M.is_relative_to(p, other)
  assert_arg(1, p, "string")
  assert_arg(2, other, "string")
  return relative_parts(p, other) ~= nil
end

function M.match(p, pattern, case_sensitive)
  assert_arg(1, p, "string")
  assert_arg(2, pattern, "string")

  local path_drive, path_root, path_tail = parse_path(p)
  local pattern_drive, pattern_root, pattern_tail = parse_path(pattern)
  local path_anchor = path_drive .. path_root
  local pattern_anchor = pattern_drive .. pattern_root

  if pattern_anchor == "" and #pattern_tail == 0 then
    return false
  end
  if #path_tail < #pattern_tail then
    return false
  end
  if
    pattern_anchor ~= "" and (not match_part(path_anchor, pattern_anchor, case_sensitive) or #path_tail > #pattern_tail)
  then
    return false
  end

  local offset = #path_tail - #pattern_tail
  for i = 1, #pattern_tail do
    if not match_part(path_tail[offset + i], pattern_tail[i], case_sensitive) then
      return false
    end
  end

  return true
end

function M.parts(p)
  assert_arg(1, p, "string")
  local drive, root, tail = parse_path(p)
  local out = {}
  local anchor = drive .. root
  if anchor ~= "" then
    out[#out + 1] = anchor
  end
  for i = 1, #tail do
    out[#out + 1] = tail[i]
  end
  return List(out)
end

function M.relative_to(p, other, walk_up)
  assert_arg(1, p, "string")
  assert_arg(2, other, "string")
  local parts = relative_parts(p, other)
  if parts then
    return #parts == 0 and CURDIR or concat(parts, SEP)
  end

  if not walk_up then
    return nil, fmt("'%s' is not in the subpath of '%s'", p, other)
  end

  local drive, root, tail = parse_path(p)
  local other_drive, other_root, other_tail = parse_path(other)

  if not parts_equal(drive .. root, other_drive .. other_root) then
    return nil, fmt("'%s' is not in the subpath of '%s'", p, other)
  end

  local common = 0
  local max = #tail < #other_tail and #tail or #other_tail
  for i = 1, max do
    if not parts_equal(tail[i], other_tail[i]) then
      break
    end
    common = i
  end

  parts = {}
  for _ = 1, #other_tail - common do
    parts[#parts + 1] = PARDIR
  end
  for i = common + 1, #tail do
    parts[#parts + 1] = tail[i]
  end

  return concat(parts, SEP)
end

function M.with_name(p, name)
  assert_arg(1, p, "string")
  assert_arg(2, name, "string")

  local has_sep = find(name, "/", 1, true) or (is_win and find(name, "\\", 1, true))
  if name == "" or name == CURDIR or has_sep then
    return nil, fmt("invalid name '%s'", name)
  end

  local drive, root, tail = parse_path(p)
  if #tail == 0 then
    return nil, fmt("'%s' has an empty name", p)
  end

  if is_win and drive == "" and root == "" and #tail == 1 and find(name, DRIVE_SEP, 1, true) ~= nil then
    return ".\\" .. name
  end

  tail[#tail] = name
  return drive .. root .. concat(tail, SEP)
end

function M.with_stem(p, stem)
  assert_arg(1, p, "string")
  assert_arg(2, stem, "string")
  if stem == "" then
    return nil, fmt("'%s' has an empty stem", p)
  end
  local _, ext = M.splitext(name_of(p))
  return M.with_name(p, stem .. ext)
end

function M.with_suffix(p, suffix)
  assert_arg(1, p, "string")
  assert_arg(2, suffix, "string")
  if suffix ~= "" and sub(suffix, 1, 1) ~= EXT_SEP then
    return nil, fmt("invalid suffix '%s'", suffix)
  end
  local stem = M.stem(p)
  if stem == "" then
    return nil, fmt("'%s' has an empty name", p)
  end
  return M.with_name(p, stem .. suffix)
end

function M.root(p)
  assert_arg(1, p, "string")
  local _, root = splitroot(p)
  return root
end

function M.stem(p)
  assert_arg(1, p, "string")
  return (M.splitext(name_of(p)))
end

function M.suffixes(p)
  assert_arg(1, p, "string")
  local suffixes = List()
  local stem, ext = M.splitext(name_of(p))
  while ext ~= "" do
    suffixes[#suffixes + 1] = ext
    stem, ext = M.splitext(stem)
  end
  return suffixes:reverse()
end

if _TEST then
  local ntpath = mods.ntpath
  local posixpath = mods.posixpath
  local function set_semantics(win)
    is_win, SEP = win, win and "\\" or "/"
    mods.tbl.update(M, win and ntpath or posixpath)
  end

  ---@diagnostic disable: inject-field
  -- stylua: ignore start
  function M._set_windows_semantics() set_semantics(true) end
  function M._set_posix_semantics() set_semantics(false) end
  getenv = function(name) return os.getenv(name) end
end

return M
