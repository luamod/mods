local splitext = require("mods.path")._splitext

---@type mods.posixpath
local M = {}

local concat = table.concat
local getenv = os.getenv
local gmatch = string.gmatch
local gsub = string.gsub
local match = string.match
local min = math.min
local sub = string.sub

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

local function splitpath(path)
  local i = match(path, "^.*()/")
  if i == nil then
    i = 0
  end

  local head = sub(path, 1, i)
  local tail = sub(path, i + 1)
  if head ~= "" and not match(head, "^/+$") then
    head = gsub(head, "/+$", "")
  end

  return head, tail
end

local function splitroot(path)
  if sub(path, 1, 1) ~= "/" then
    return "", "", path
  end
  if sub(path, 2, 2) ~= "/" or sub(path, 3, 3) == "/" then
    return "", "/", sub(path, 2)
  end
  return "", "//", sub(path, 3)
end

local function getcwd()
  local ok, lfs = pcall(require, "lfs")
  if ok and lfs and lfs.currentdir then
    return lfs.currentdir()
  end
  return "."
end

function M.normcase(s)
  return s
end

function M.isabs(path)
  return has_prefix(path, "/")
end

function M.join(a, ...)
  local path = a
  for i = 1, select("#", ...) do
    local b = select(i, ...)
    if has_prefix(b, "/") or path == "" then
      path = b
    elseif sub(path, -1) == "/" then
      path = path .. b
    else
      path = path .. "/" .. b
    end
  end
  return path
end

M.split = splitpath

function M.splitext(path)
  return splitext(path, "/", nil, ".")
end

function M.splitdrive(path)
  return "", path
end

M.splitroot = splitroot

function M.basename(path)
  local _, tail = splitpath(path)
  return tail
end

function M.dirname(path)
  return (splitpath(path))
end

function M.expanduser(path)
  if not has_prefix(path, "~") then
    return path
  end
  local home = getenv("HOME")
  if not home or home == "" then
    return path
  end
  if path == "~" then
    return home
  end
  if has_prefix(path, "~/") then
    return gsub(home, "/+$", "") .. sub(path, 2)
  end
  return path
end

function M.normpath(path)
  if path == "" then
    return "."
  end

  local _, initial_slashes, tail = splitroot(path)
  local comps = split_components(tail)
  local out = {}
  for i = 1, #comps do
    local comp = comps[i]
    if comp ~= "" and comp ~= "." then
      if comp ~= ".." or (initial_slashes == "" and #out == 0) or (#out > 0 and out[#out] == "..") then
        out[#out + 1] = comp
      elseif #out > 0 then
        out[#out] = nil
      end
    end
  end

  local res = initial_slashes .. concat(out, "/")
  return res ~= "" and res or "."
end

function M.abspath(path)
  if not M.isabs(path) then
    path = M.join(getcwd(), path)
  end
  return M.normpath(path)
end

function M.relpath(path, start)
  if path == "" then
    error("no path specified", 2)
  end
  start = start or "."

  local apath = M.abspath(path)
  local astart = M.abspath(start)

  local _, _, tail_path = splitroot(apath)
  local _, _, tail_start = splitroot(astart)

  local pparts = split_components(tail_path)
  local sparts = split_components(tail_start)

  local i = 1
  while i <= #pparts and i <= #sparts and pparts[i] == sparts[i] do
    i = i + 1
  end

  local out = {}
  for _ = i, #sparts do
    out[#out + 1] = ".."
  end
  for j = i, #pparts do
    out[#out + 1] = pparts[j]
  end

  return #out == 0 and "." or concat(out, "/")
end

function M.commonpath(paths)
  if #paths == 0 then
    return ""
  end

  local normed = {}
  local first_abs = nil
  for i = 1, #paths do
    local raw = paths[i]
    local p = raw == "" and "" or M.normpath(raw)
    normed[i] = p
    local abs = M.isabs(p)
    if first_abs == nil then
      first_abs = abs
    elseif first_abs ~= abs then
      error("can't mix absolute and relative paths", 2)
    end
  end

  local _, root, tail = splitroot(normed[1])
  local prefix = split_components(tail)
  for i = 2, #normed do
    local _, ri, ti = splitroot(normed[i])
    if ri ~= root then
      return ""
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

return M
