---@meta mods.stringcase

---String case conversion helpers.
---@class mods.stringcase
local M = {}

--------------------------------------------------------------------------------
------------------------------------- Basic ------------------------------------
--------------------------------------------------------------------------------

---Convert string to all lowercase.
---
---**Example:**
---```lua
---lower("foo_bar-baz") --> "foo_bar-baz"
---lower("FooBar baz") --> "foobar baz"
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
---upper("foo_bar-baz") --> "FOO_BAR-BAZ"
---upper("FooBar baz") --> "FOOBAR BAZ"
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
---**Example:**
---```lua
---snake("foo_bar-baz") --> "foo_bar_baz"
---snake("FooBar baz") --> "foo_bar_baz"
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
---camel("foo_bar-baz") --> "fooBarBaz"
---camel("FooBar baz") --> "fooBarBaz"
---```
---
---@param s string
---@return string
---@nodiscard
function M.camel(s) end

---Normalize to snake_case, then replace underscores with a separator.
---
---**Example:**
---```lua
---replace("foo_bar-baz", "-") --> "foo-bar-baz"
---replace("FooBar baz", "-") --> "foo-bar-baz"
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
---acronym("foo_bar-baz") --> "FBB"
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
---title("foo_bar-baz") --> "Foo Bar Baz"
---title("FooBar baz") --> "Foo Bar Baz"
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
---constant("foo_bar-baz") --> "FOO_BAR_BAZ"
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
---pascal("foo_bar-baz") --> "FooBarBaz"
---pascal("FooBar baz") --> "FooBarBaz"
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
---kebab("foo_bar-baz") --> "foo-bar-baz"
---kebab("FooBar baz") --> "foo-bar-baz"
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
---dot("foo_bar-baz") --> "foo.bar.baz"
---dot("FooBar baz") --> "foo.bar.baz"
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
---space("foo_bar-baz") --> "foo bar baz"
---space("FooBar baz") --> "foo bar baz"
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
---path("foo_bar-baz") --> "foo/bar/baz"
---path("FooBar baz") --> "foo/bar/baz"
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
---**Example:**
---```lua
---swap("foo_bar-baz") --> "FOO_BAR-BAZ"
---swap("FooBar baz") --> "fOObAR BAZ"
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
---capital("foo_bar-baz") --> "Foo_bar-baz"
---capital("FooBar baz") --> "Foobar baz"
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
---sentence("foo_bar-baz") --> "Foo_bar-baz"
---sentence("FooBar baz") --> "FooBar baz"
---```
---
---@param s string
---@return string
---@nodiscard
function M.sentence(s) end

return M
