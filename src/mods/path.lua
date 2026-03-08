local runtime = require "mods.runtime"
local str = require "mods.str"

local path = require(runtime.is_windows and "mods.ntpath" or "mods.posixpath")
local rfind = str.rfind
local sub = string.sub

---@type mods.path
local M = {}

for k, v in pairs(path) do
  M[k] = v
end

---@diagnostic disable: invisible
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

return M
