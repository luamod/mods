local rfind = require("mods.str").rfind

local sub = string.sub

---@type mods.path
local M = {}

---Split extension from a path.
---Follows Python `genericpath._splitext` semantics.
---@param path string
---@param sep string
---@param altsep? string
---@param extsep string
---@return string root
---@return string ext
function M._splitext(path, sep, altsep, extsep)
  local sep_index = rfind(path, sep) or 0
  if altsep then
    local altsep_index = rfind(path, altsep) or 0
    sep_index = altsep_index > sep_index and altsep_index or sep_index
  end

  local dot_index = rfind(path, extsep) or 0
  if dot_index > sep_index then
    local filename_index = sep_index + 1
    while filename_index < dot_index do
      if sub(path, filename_index, filename_index) ~= extsep then
        return sub(path, 1, dot_index - 1), sub(path, dot_index)
      end
      filename_index = filename_index + 1
    end
  end

  return path, ""
end

return M
