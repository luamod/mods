local mods = require("mods")

local gsub = string.gsub
local match = string.match

---@type mods.keyword
local M = {}

-- stylua: ignore
local kwlist = {
  "and"   , "break" , "do"  , "else"    , "elseif",
  "end"   , "false" , "for" , "function", "if"    ,
  "in"    , "local" , "nil" , "not"     , "or"    ,
  "repeat", "return", "then", "true"    , "until" , "while",
}

if _VERSION ~= "Lua 5.1" then
  table.insert(kwlist, "goto")
  table.sort(kwlist)
end

-- Use a plain lookup table for hot-path membership checks; avoid Set overhead.
local kwset = {}
for i = 1, #kwlist do
  kwset[kwlist[i]] = true
end

local function iskeyword(s)
  return kwset[s] == true
end

M.iskeyword = iskeyword

function M.isidentifier(s)
  return type(s) == "string" and not iskeyword(s) and match(s, "^[%a_][%w_]*$") ~= nil
end

function M.kwlist()
  return mods.List(kwlist):copy()
end

function M.kwset()
  return mods.Set(kwlist)
end

function M.normalize_identifier(v)
  if v == "" then
    return "_"
  end

  local vt = type(v)
  local out = v
  if vt == "boolean" then
    out = tostring(v)
  elseif vt ~= "string" then
    out = vt .. "_"
  end

  out = gsub(out, "^%s+", "") -- Trim leading whitespace.
  out = gsub(out, "%s+$", "") -- Trim trailing whitespace.
  out = gsub(out, "[^%w_]", "_") -- Replace non-identifier characters with underscores.

  if out == "" then
    return "_"
  elseif match(out, "^%d") then
    out = "_" .. out
  elseif iskeyword(out) then
    out = out .. "_"
  end

  return out
end

return M
