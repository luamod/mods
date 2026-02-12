--
-- Copying notes:
-- * Copy only the function-level doc block and `quote` function below.
-- * Do not copy this reference section.
--
-- Used in:
-- * src/mods/template.lua
-- * src/mods/validate.lua
--
-- Tests:
-- * spec/_snippets_spec.lua
--

local find = string.find
local gsub = string.gsub

---
---quote strings; stringify other values.
---
---Copied from snippets/quote.lua
---
---IMPORTANT: Keep this function in sync with snippets/quote.lua.
---
local function quote(v)
  if find(v, '"', 1, true) and not find(v, "'", 1, true) then
    return "'" .. v .. "'"
  end
  return '"' .. gsub(v, '"', '\\"') .. '"'
end

return quote
