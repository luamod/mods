--[[
  Portions of this module are derived from CPython's posixpath.py.
  Adapted and ported to Lua for this project's API and conventions.
  Source: https://github.com/python/cpython/blob/main/Lib/posixpath.py
  License: Python Software Foundation License Version 2 (PSF-2.0).
  Copyright (c) 2001 Python Software Foundation; All Rights Reserved.
]]

local mods = require "mods"

local assert_arg = mods.utils.assert_arg

local concat = table.concat
local getenv = os.getenv
local char = string.char
local gmatch = string.gmatch
local gsub = string.gsub
local match = string.match
local min = math.min
local sub = string.sub

local path = {}
path = setmetatable(path, {
  __index = function(_, k)
    path = mods.path
    return path[k]
  end,
})

---@type mods.posixpath
local M = {}

local CURDIR = "."
local PARDIR = ".."
local SEP = "/"

local function getcwd()
  getcwd = mods.fs.getcwd
  return getcwd()
end

local function has_prefix(s, prefix)
  return sub(s, 1, #prefix) == prefix
end

local function split_components(tail)
  local out = {}
  for part in gmatch(tail, "[^/]+") do
    out[#out + 1] = part
  end
  return out
end

function M.normcase(s)
  return assert_arg(1, s, "string")
end

function M.isabs(p)
  assert_arg(1, p, "string")
  return has_prefix(p, "/")
end

function M.join(p, ...)
  assert_arg(1, p, "string")
  for i = 1, select("#", ...) do
    local b = select(i, ...)
    assert_arg(i + 1, b, "string")
    if has_prefix(b, "/") or p == "" then
      p = b
    elseif sub(p, -1) == "/" then
      p = p .. b
    else
      p = p .. "/" .. b
    end
  end
  return p
end

function M.split(p)
  assert_arg(1, p, "string")
  local i = match(p, "^.*()/")
  if i == nil then
    i = 0
  end

  local head = sub(p, 1, i)
  local tail = sub(p, i + 1)
  if head ~= "" and not match(head, "^/+$") then
    head = gsub(head, "/+$", "")
  end

  return head, tail
end

function M.splitext(p)
  assert_arg(1, p, "string")
  return path._splitext(p, SEP, nil, ".")
end

function M.splitdrive(p)
  assert_arg(1, p, "string")
  return "", p
end

function M.splitroot(p)
  assert_arg(1, p, "string")
  if sub(p, 1, 1) ~= "/" then
    return "", "", p
  end
  if sub(p, 2, 2) ~= "/" or sub(p, 3, 3) == "/" then
    return "", "/", sub(p, 2)
  end
  return "", "//", sub(p, 3)
end

function M.basename(p)
  assert_arg(1, p, "string")
  local _, tail = M.split(p)
  return tail
end

function M.dirname(p)
  assert_arg(1, p, "string")
  return (M.split(p))
end

function M.home()
  local home = getenv("HOME")
  if not home or home == "" then
    return nil, "home directory is not set"
  end
  return home
end

function M.expanduser(p)
  assert_arg(1, p, "string")
  if not has_prefix(p, "~") then
    return p
  end
  local home, err = M.home()
  if not home then
    return nil, err
  end
  if p == "~" then
    return home
  end
  if has_prefix(p, "~/") then
    return gsub(home, "/+$", "") .. sub(p, 2)
  end
  return p
end

function M.normpath(p)
  assert_arg(1, p, "string")
  if p == "" then
    return CURDIR
  end

  local _, initial_slashes, tail = M.splitroot(p)
  local comps = split_components(tail)
  local out = {}
  for i = 1, #comps do
    local comp = comps[i]
    if comp ~= "" and comp ~= CURDIR then
      if comp ~= PARDIR or (initial_slashes == "" and #out == 0) or (#out > 0 and out[#out] == "..") then
        out[#out + 1] = comp
      elseif #out > 0 then
        out[#out] = nil
      end
    end
  end

  local res = initial_slashes .. concat(out, SEP)
  return res ~= "" and res or CURDIR
end

function M.abspath(p)
  assert_arg(1, p, "string")
  return M.normpath(M.join(getcwd(), p))
end

function M.relpath(p, start)
  assert_arg(1, p, "string")
  if start ~= nil then
    assert_arg(2, start, "string")
  end
  if p == "" then
    return nil, "no path specified"
  end
  start = start or CURDIR

  local apath = M.abspath(p)
  local astart = M.abspath(start)

  local _, _, tail_path = M.splitroot(apath)
  local _, _, tail_start = M.splitroot(astart)

  local pparts = split_components(tail_path)
  local sparts = split_components(tail_start)

  local i = 1
  while i <= #pparts and i <= #sparts and pparts[i] == sparts[i] do
    i = i + 1
  end

  local out = {}
  for _ = i, #sparts do
    out[#out + 1] = PARDIR
  end
  for j = i, #pparts do
    out[#out + 1] = pparts[j]
  end

  return #out == 0 and CURDIR or concat(out, SEP)
end

function M.from_uri(uri)
  assert_arg(1, uri, "string")

  local body = match(uri, "^file://(.*)$")
  if not body then
    return nil, "invalid file uri"
  end

  local authority, rest = match(body, "^([^/]*)(/.*)$")
  if authority then
    if authority ~= "" and authority ~= "localhost" then
      return nil, "unsupported file uri authority"
    end
    body = rest
  end

  body = gsub(body, "%%(%x%x)", function(hex)
    return char(tonumber(hex, 16))
  end)

  if not M.isabs(body) then
    return nil, "uri is not absolute"
  end

  return body
end

function M.commonpath(paths)
  assert_arg(1, paths, "table")
  if #paths == 0 then
    return nil, "paths list is empty"
  end

  local normed = {}
  local first_abs = nil
  for i = 1, #paths do
    assert_arg(i, paths[i], "string")
    local p = paths[i]
    if p ~= "" then
      p = M.normpath(p)
    end
    normed[i] = p
    local abs = M.isabs(p)
    if first_abs == nil then
      first_abs = abs
    elseif first_abs ~= abs then
      return nil, "can't mix absolute and relative paths"
    end
  end

  local _, root, tail = M.splitroot(normed[1])
  local prefix = split_components(tail)
  for i = 2, #normed do
    local _, ri, ti = M.splitroot(normed[i])
    if ri ~= root then
      root = "/"
    end
    local parts = split_components(ti)
    local maxn = min(#prefix, #parts)
    local j = 1
    while j <= maxn and prefix[j] == parts[j] do
      j = j + 1
    end
    for k = #prefix, j, -1 do
      prefix[k] = nil
    end
  end

  local body = concat(prefix, "/")
  if body == "" then
    return root ~= "" and root or ""
  end
  if root == "" then
    return body
  end
  return root .. body
end

return setmetatable(M, {
  __index = function(t, k)
    local v = path[k]
    t[k] = v
    return v
  end,
})
