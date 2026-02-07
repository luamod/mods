---@meta mods.stringcase

---@class mods.stringcase
local M = {}

---Convert string to all lowercase.
---
---**Example:**
---```lua
---lower("Hello World") --> "hello world"
---```
---
---@param s string
---@return string
---@nodiscard
function M.lower(s) end

---Convert string to all uppercase.
---
---**Example:**
---```lua
---upper("Hello World") --> "HELLO WORLD"
---```
---
---@param s string
---@return string
---@nodiscard
function M.upper(s) end

---Convert string to snake_case.
---
---**Example:**
---```lua
---snake("Hello World") --> "hello_world"
---```
---
---@param s string
---@return string
---@nodiscard
function M.snake(s) end

---Convert string to camelCase.
---
---**Example:**
---```lua
---camel("Hello World") --> "helloWorld"
---```
---
---@param s string
---@return string
---@nodiscard
function M.camel(s) end

---Replace underscores in snake_case with a given separator (default empty).
---
---**Example:**
---```lua
---replace("hello_world", "-") --> "hello-world"
---```
---
---@param s string
---@param sep? string
---@return string
---@nodiscard
function M.replace(s, sep) end

---Get acronym of words in string (first letters only).
---
---**Example:**
---```lua
---acronym("Hyper Text Markup Language") --> "HTML"
---```
---
---@param s string
---@return string
---@nodiscard
function M.acronym(s) end

---Convert string to Title Case (first letter of each word capitalized).
---
---**Example:**
---```lua
---title("hello world") --> "Hello World"
---```
---
---@param s string
---@return string
---@nodiscard
function M.title(s) end

---Convert string to CONSTANT_CASE (uppercase snake_case).
---
---**Example:**
---```lua
---constant("hello world") --> "HELLO_WORLD"
---```
---
---@param s string
---@return string
---@nodiscard
function M.constant(s) end

---Convert string to PascalCase.
---
---**Example:**
---```lua
---pascal("hello world") --> "HelloWorld"
---```
---
---@param s string
---@return string
---@nodiscard
function M.pascal(s) end

---Convert string to kebab-case.
---
---**Example:**
---```lua
---kebab("hello world") --> "hello-world"
---```
---
---@param s string
---@return string
---@nodiscard
function M.kebab(s) end

---Convert string to dot.case.
---
---**Example:**
---```lua
---dot("hello world") --> "hello.world"
---```
---
---@param s string
---@return string
---@nodiscard
function M.dot(s) end

---Convert string to space case (spaces between words).
---
---**Example:**
---```lua
---space("hello_world") --> "hello world"
---```
---
---@param s string
---@return string
---@nodiscard
function M.space(s) end

---Convert string to path/case (slashes between words).
---
---**Example:**
---```lua
---path("hello world") --> "hello/world"
---```
---
---@param s string
---@return string
---@nodiscard
function M.path(s) end

---Swap case of each letter.
---
---**Example:**
---```lua
---swap("Hello World") --> "hELLO wORLD"
---```
---
---@param s string
---@return string
---@nodiscard
function M.swap(s) end

---Capitalize the first letter and lowercase the rest.
---
---**Example:**
---```lua
---capital("hELLO") --> "Hello"
---```
---
---@param s string
---@return string
---@nodiscard
function M.capital(s) end

---Convert string to sentence case (first letter uppercase, rest lowercase).
---
---**Example:**
---```lua
---sentence("hELLO WORLD") --> "Hello world"
---```
---
---@param s string
---@return string
---@nodiscard
function M.sentence(s) end

return M
