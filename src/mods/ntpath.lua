---@diagnostic disable: invisible

--[[
  Portions of this module are derived from CPython's ntpath.py.
  Adapted and ported to Lua for this project's API and conventions.
  Source: https://github.com/python/cpython/blob/main/Lib/ntpath.py
  License: Python Software Foundation License Version 2 (PSF-2.0).
  Copyright (c) 2001 Python Software Foundation; All Rights Reserved.
]]

local assert_arg = require("mods.utils").assert_arg
local splitext = require("mods.path")._splitext
local tbl_count = require("mods.tbl").count

local byte = string.byte
local find = string.find
local gmatch = string.gmatch
local gsub = string.gsub
local lower = string.lower
local match = string.match
local sub = string.sub
local upper = string.upper
local concat = table.concat
local min = math.min

---@type mods.ntpath
local M = {}

local ALT_SEP = "/"
local CURDIR = "."
local DRIVE_SEP = ":"
local EXT_SEP = "."
local MAIN_SEP = "\\"
local PATH_SEPS = "\\/"
local UNC_PREFIX = "\\\\?\\UNC\\"

local function starts_with(s, prefix)
  return sub(s, 1, #prefix) == prefix
end

local function is_sep(c)
  return c == MAIN_SEP or c == ALT_SEP
end

local function norm_seps(path)
  return gsub(path, ALT_SEP, MAIN_SEP)
end

local function rstrip_seps(s)
  local i = #s
  while i > 0 and is_sep(sub(s, i, i)) do
    i = i - 1
  end
  return sub(s, 1, i)
end

local function split_components(path, skip_curdir)
  local out = {}
  for part in gmatch(path, "[^\\]+") do
    if not skip_curdir or (part ~= "" and part ~= CURDIR) then
      out[#out + 1] = part
    end
  end
  return out
end

local function getcwd()
  local ok, lfs = pcall(require, "lfs")
  if ok and lfs and lfs.currentdir then
    return lfs.currentdir()
  end
  return "."
end

local reserved_char_map = {
  ['"'] = true,
  ["*"] = true,
  [":"] = true,
  ["<"] = true,
  [">"] = true,
  ["?"] = true,
  ["|"] = true,
  ["/"] = true,
  ["\\"] = true,
}

local reserved_names = {
  AUX = true,
  CON = true,
  ["CONIN$"] = true,
  ["CONOUT$"] = true,
  NUL = true,
  PRN = true,
}

for i = 1, 9 do
  reserved_names["COM" .. i] = true
  reserved_names["LPT" .. i] = true
end

local function is_reserved_name(name)
  if name == "" then
    return false
  end

  local last = sub(name, -1)
  if last == EXT_SEP or last == " " then
    return name ~= CURDIR and name ~= ".."
  end

  for i = 1, #name do
    local c = sub(name, i, i)
    local b = byte(c)
    if (b and b < 32) or reserved_char_map[c] then
      return true
    end
  end

  local base = match(name, "^[^%.]*") or name
  base = upper(gsub(base, " +$", ""))
  return reserved_names[base] == true
end

function M.normcase(s)
  return lower(norm_seps(s))
end

function M.isabs(path)
  local s = norm_seps(sub(path, 1, 3))
  return sub(s, 2, 3) == DRIVE_SEP .. MAIN_SEP or sub(s, 1, 2) == MAIN_SEP .. MAIN_SEP
end

function M.splitroot(path)
  local normp = norm_seps(path)

  if sub(normp, 1, 1) == MAIN_SEP then
    if sub(normp, 2, 2) == MAIN_SEP then
      local start = upper(sub(normp, 1, 8)) == UNC_PREFIX and 9 or 3
      local index = find(normp, MAIN_SEP, start, true)
      if not index then
        return path, "", ""
      end
      local index2 = find(normp, MAIN_SEP, index + 1, true)
      if not index2 then
        return path, "", ""
      end
      return sub(path, 1, index2 - 1), sub(path, index2, index2), sub(path, index2 + 1)
    end
    return "", sub(path, 1, 1), sub(path, 2)
  end

  if sub(normp, 2, 2) == DRIVE_SEP then
    if sub(normp, 3, 3) == MAIN_SEP then
      return sub(path, 1, 2), sub(path, 3, 3), sub(path, 4)
    end
    return sub(path, 1, 2), "", sub(path, 3)
  end

  return "", "", path
end

function M.splitdrive(path)
  local drive, root, tail = M.splitroot(path)
  return drive, root .. tail
end

function M.join(path, ...)
  local result_drive, result_root, result_path = M.splitroot(path)

  for i = 1, select("#", ...) do
    local p = select(i, ...)
    local p_drive, p_root, p_path = M.splitroot(p)

    if p_root ~= "" then
      if p_drive ~= "" or result_drive == "" then
        result_drive = p_drive
      end
      result_root = p_root
      result_path = p_path
    else
      local skip_append = false
      if p_drive ~= "" and p_drive ~= result_drive then
        if p_drive:lower() ~= result_drive:lower() then
          result_drive = p_drive
          result_root = p_root
          result_path = p_path
          skip_append = true
        else
          result_drive = p_drive
        end
      end

      if not skip_append then
        local last = sub(result_path, -1)
        if result_path ~= "" and not is_sep(last) then
          result_path = result_path .. MAIN_SEP
        end
        result_path = result_path .. p_path
      end
    end
  end

  if result_path ~= "" and result_root == "" and result_drive ~= "" then
    local last = sub(result_drive, -1)
    if not find(DRIVE_SEP .. PATH_SEPS, last, 1, true) then
      return result_drive .. MAIN_SEP .. result_path
    end
  end

  return result_drive .. result_root .. result_path
end

function M.split(path)
  local drive, root, tail = M.splitroot(path)

  local i = #tail
  while i > 0 and not find(PATH_SEPS, sub(tail, i, i), 1, true) do
    i = i - 1
  end

  local head = rstrip_seps(sub(tail, 1, i))
  local last = sub(tail, i + 1)
  return drive .. root .. head, last
end

function M.splitext(path)
  return splitext(path, MAIN_SEP, ALT_SEP, EXT_SEP)
end

function M.basename(path)
  local _, tail = M.split(path)
  return tail
end

function M.dirname(path)
  return (M.split(path))
end

function M.ismount(path)
  path = M.abspath(path)
  local drive, root, rest = M.splitroot(path)
  if drive ~= "" and is_sep(sub(drive, 1, 1)) then
    return rest == ""
  end
  return root ~= "" and rest == ""
end

function M.isreserved(path)
  local _, _, tail = M.splitroot(path)
  tail = norm_seps(tail)

  local parts = split_components(tail)
  for i = #parts, 1, -1 do
    if is_reserved_name(parts[i]) then
      return true
    end
  end

  return false
end

function M.expanduser(path)
  if not starts_with(path, "~") then
    return path
  end

  local i = 2
  local n = #path
  while i <= n and not is_sep(sub(path, i, i)) do
    i = i + 1
  end

  local userhome = os.getenv("USERPROFILE")
  if not userhome or userhome == "" then
    local homepath = os.getenv("HOMEPATH")
    if not homepath or homepath == "" then
      return path
    end
    userhome = M.join(os.getenv("HOMEDRIVE") or "", homepath)
  end

  if i ~= 2 then
    local target_user = sub(path, 2, i - 1)
    local current_user = os.getenv("USERNAME")

    if target_user ~= current_user then
      if current_user ~= M.basename(userhome) then
        return path
      end
      userhome = M.join(M.dirname(userhome), target_user)
    end
  end

  return userhome .. sub(path, i)
end

function M.normpath(path)
  if path == "" then
    return CURDIR
  end

  path = norm_seps(path)
  local drive, root, tail = M.splitroot(path)
  local prefix = drive .. root
  local comps = split_components(tail)
  local out = {}

  for i = 1, #comps do
    local comp = comps[i]
    if comp ~= "" and comp ~= CURDIR then
      if comp ~= ".." then
        out[#out + 1] = comp
      elseif #out > 0 and out[#out] ~= ".." then
        out[#out] = nil
      elseif root == "" then
        out[#out + 1] = comp
      end
    end
  end

  if prefix == "" and #out == 0 then
    out[1] = CURDIR
  end

  return prefix .. concat(out, MAIN_SEP)
end

function M.abspath(path)
  if not M.isabs(path) then
    path = M.join(getcwd(), path)
  end
  return M.normpath(path)
end

function M.relpath(path, start)
  if path == "" then
    error("no path specified")
  end

  start = start or CURDIR

  local start_abs = M.abspath(start)
  local path_abs = M.abspath(path)
  local start_drive, _, start_rest = M.splitroot(start_abs)
  local path_drive, _, path_rest = M.splitroot(path_abs)

  if M.normcase(start_drive) ~= M.normcase(path_drive) then
    local msg = "path is on mount '" .. path_drive .. "', start on mount '" .. start_drive .. "'"
    error(msg)
  end

  local start_list = split_components(start_rest)
  local path_list = split_components(path_rest)

  local i = 1
  while i <= #start_list and i <= #path_list do
    if M.normcase(start_list[i]) ~= M.normcase(path_list[i]) then
      break
    end
    i = i + 1
  end

  local rel = {}
  for _ = i, #start_list do
    rel[#rel + 1] = ".."
  end
  for j = i, #path_list do
    rel[#rel + 1] = path_list[j]
  end

  if #rel == 0 then
    return CURDIR
  end
  return concat(rel, MAIN_SEP)
end

function M.commonpath(paths)
  assert_arg(1, paths, "table", 2)

  if #paths == 0 then
    error("commonpath() arg is an empty sequence", 2)
  end

  local normed = {}
  for i = 1, #paths do
    normed[i] = norm_seps(paths[i])
  end

  local first_drive, first_root, first_tail = M.splitroot(normed[1])
  local first_parts = split_components(first_tail, true)
  local common_len = #first_parts

  local drives = {}
  local roots = {}
  drives[M.normcase(first_drive)] = true
  roots[first_root] = true

  for i = 2, #normed do
    local drive, root, tail = M.splitroot(normed[i])
    drives[M.normcase(drive)] = true
    roots[root] = true

    local parts = split_components(tail, true)
    local n = min(common_len, #parts)
    local j = 1
    while j <= n and M.normcase(first_parts[j]) == M.normcase(parts[j]) do
      j = j + 1
    end
    common_len = j - 1
  end

  local drive_count = tbl_count(drives)
  if drive_count ~= 1 then
    error("Paths don't have the same drive")
  end

  local root_count = tbl_count(roots)
  if root_count ~= 1 then
    if first_drive ~= "" then
      error("Can't mix absolute and relative paths")
    end
    error("Can't mix rooted and not-rooted paths")
  end

  local common = {}
  for i = 1, common_len do
    common[#common + 1] = first_parts[i]
  end

  return first_drive .. first_root .. concat(common, MAIN_SEP)
end

return M
