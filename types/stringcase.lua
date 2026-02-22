---@meta mods.stringcase

---String case conversion helpers.
---## Usage
---
---```lua
---sc = require "mods.stringcase"
---
---print(stringcase.snake("FooBar")) --> "foo_bar"
---```
---@class mods.stringcase
local M = {}

--------------------------------------------------------------------------------
------------------------------------- Basic ------------------------------------
--------------------------------------------------------------------------------

---Convert string to all lowercase.
---
---```lua
---lower("foo_bar-baz") --> "foo_bar-baz"
---lower("FooBar baz")  --> "foobar baz"
---```
---
---@param s string
---@return string
---@nodiscard
function M.lower(s) end

---Convert string to all uppercase.
---
---```lua
---upper("foo_bar-baz") --> "FOO_BAR-BAZ"
---upper("FooBar baz")  --> "FOOBAR BAZ"
---```
---
---@param s string
---@return string
---@nodiscard
function M.upper(s) end

--------------------------------------------------------------------------------
---------------------------------- Word Case -----------------------------------
--------------------------------------------------------------------------------

---Convert string to snake_case.
---
---```lua
---snake("foo_bar-baz") --> "foo_bar_baz"
---snake("FooBar baz")  --> "foo_bar_baz"
---```
---
---@param s string
---@return string
---@nodiscard
function M.snake(s) end

---Convert string to camelCase.
---
---```lua
---camel("foo_bar-baz") --> "fooBarBaz"
---camel("FooBar baz")  --> "fooBarBaz"
---```
---
---@param s string
---@return string
---@nodiscard
function M.camel(s) end

---Normalize to snake_case, then replace underscores with a separator.
---
---```lua
---replace("foo_bar-baz", "-") --> "foo-bar-baz"
---replace("FooBar baz", "-")  --> "foo-bar-baz"
---```
---
---@param s string
---@param sep? string
---@return string
---@nodiscard
function M.replace(s, sep) end

---Get acronym of words in string (first letters only).
---
---```lua
---acronym("foo_bar-baz") --> "FBB"
---acronym("FooBar baz")  --> "FBB"
---```
---
---@param s string
---@return string
---@nodiscard
function M.acronym(s) end

---Convert string to Title Case (first letter of each word capitalized).
---
---```lua
---title("foo_bar-baz") --> "Foo Bar Baz"
---title("FooBar baz")  --> "Foo Bar Baz"
---```
---
---@param s string
---@return string
---@nodiscard
function M.title(s) end

---Convert string to CONSTANT_CASE (uppercase snake_case).
---
---```lua
---constant("foo_bar-baz") --> "FOO_BAR_BAZ"
---constant("FooBar baz")  --> "FOO_BAR_BAZ"
---```
---
---@param s string
---@return string
---@nodiscard
function M.constant(s) end

---Convert string to PascalCase.
---
---```lua
---pascal("foo_bar-baz") --> "FooBarBaz"
---pascal("FooBar baz")  --> "FooBarBaz"
---```
---
---@param s string
---@return string
---@nodiscard
function M.pascal(s) end

---Convert string to kebab-case.
---
---```lua
---kebab("foo_bar-baz") --> "foo-bar-baz"
---kebab("FooBar baz")  --> "foo-bar-baz"
---```
---
---@param s string
---@return string
---@nodiscard
function M.kebab(s) end

---Convert string to dot.case.
---
---```lua
---dot("foo_bar-baz") --> "foo.bar.baz"
---dot("FooBar baz")  --> "foo.bar.baz"
---```
---
---@param s string
---@return string
---@nodiscard
function M.dot(s) end

---Convert string to space case (spaces between words).
---
---```lua
---space("foo_bar-baz") --> "foo bar baz"
---space("FooBar baz")  --> "foo bar baz"
---```
---
---@param s string
---@return string
---@nodiscard
function M.space(s) end

---Convert string to path/case (slashes between words).
---
---```lua
---path("foo_bar-baz") --> "foo/bar/baz"
---path("FooBar baz")  --> "foo/bar/baz"
---```
---
---@param s string
---@return string
---@nodiscard
function M.path(s) end

--------------------------------------------------------------------------------
---------------------------------- Letter Case ---------------------------------
--------------------------------------------------------------------------------

---Swap case of each letter.
---
---```lua
---swap("foo_bar-baz") --> "FOO_BAR-BAZ"
---swap("FooBar baz")  --> "fOObAR BAZ"
---```
---
---@param s string
---@return string
---@nodiscard
function M.swap(s) end

---Capitalize the first letter and lowercase the rest.
---
---```lua
---capital("foo_bar-baz") --> "Foo_bar-baz"
---capital("FooBar baz")  --> "Foobar baz"
---```
---
---@param s string
---@return string
---@nodiscard
function M.capital(s) end

---Convert string to sentence case (first letter uppercase, rest lowercase).
---
---```lua
---sentence("foo_bar-baz") --> "Foo_bar-baz"
---sentence("FooBar baz")  --> "FooBar baz"
---```
---
---@param s string
---@return string
---@nodiscard
function M.sentence(s) end

return M
