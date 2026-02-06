local upper = string.upper
local lower = string.lower
local gsub = string.gsub
local sub = string.sub

---Converts camelCase or mixed separators to underscores
---e.g. "fooBar-Baz qux" -> "foo_bar_baz_qux"
local function normalize(s)
  s = gsub(s, "(%l)(%u)", "%1_%2")
  s = gsub(s, "[%s%-_]+", "_")
  return s
end

---Applies a function to each "word" in the string
---repl receives (first_letter, rest_of_word) and should return transformed string
---A word is defined as a letter followed by optional alphanumeric chars
local function map(s, repl)
  return gsub(s, "(%a)([%w]*)", repl)
end

---@type mods.stringcase
local M = { upper = upper, lower = lower }

-- stylua: ignore start
local function snake(s)        return lower(normalize(s)) end
local function camel(s)        return (gsub(lower(normalize(s)), "_(%a)", upper)) end
local function replace(s, sep) return (gsub(snake(s), "_", sep or "")) end

function M.acronym(s)  return (gsub(map(normalize(s), function(f) return upper(f) end), "_", "")) end
function M.title(s)    return (gsub(map(normalize(s), function(f, r) return upper(f) .. lower(r) end), "_", " ")) end
function M.constant(s) return upper(snake(s)) end
function M.pascal(s)   return (gsub(camel(s), "^(%a)", upper)) end
function M.kebab(s)    return replace(s, "-") end
function M.dot(s)      return replace(s, ".") end
function M.space(s)    return replace(s, " ") end
function M.path(s)     return replace(s, "/") end
function M.swap(s)     return (gsub(s, "%a", function(c) return lower(c) == c and upper(c) or lower(c) end)) end
function M.capital(s)  return upper(sub(s, 1, 1)) .. lower(sub(s, 2)) end
function M.sentence(s) return upper(sub(lower(s), 1, 1)) .. sub(s, 2) end
-- stylua: ignore end

M.snake, M.camel, M.replace = snake, camel, replace

return M
