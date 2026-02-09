---@meta mods.str

---String utility helpers modeled after Python's `str`.
---@class mods.str
local M = {}

--------------------------------------------------------------------------------
----------------------------------- Formatting ---------------------------------
--------------------------------------------------------------------------------

---Return copy with first character capitalized and the rest lowercased.
---
---**Example:**
---```lua
---local s = capitalize("hello WORLD")
-----result: "Hello world"
---```
---@param s string
---@return string
---@nodiscard
function M.capitalize(s) end

---Center string within width, padded with fill characters.
---
---**Example:**
---```lua
---local s = center("hi", 6, "-")
-----result: "--hi--"
---```
---@param s string
---@param width integer
---@param fillchar? string
---@return string
---@nodiscard
function M.center(s, width, fillchar) end

---Count non-overlapping occurrences of a substring.
---
---**Example:**
---```lua
---local n = count("aaaa", "aa")
-----result: 2
---```
---```lua
---local n = count("aaaa", "a", 2, -1)
-----result: 2
---```
---```lua
---local n = count("abcd", "")
-----result: 5
---```
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer
---@nodiscard
function M.count(s, sub, start, stop) end

---Return true if string ends with suffix.
---If suffix is a list, return true if any suffix matches.
---
---**Example:**
---```lua
---local ok = endswith("hello.lua", ".lua")
-----result: true
---```
---@param s string
---@param suffix string|string[]
---@param start? integer
---@param stop? integer
---@return boolean
---@nodiscard
function M.endswith(s, suffix, start, stop) end

---Expand tabs to spaces using given tabsize.
---
---**Example:**
---```lua
---local s = expandtabs("a\tb", 4)
-----result: "a   b"
---```
---@param s string
---@param tabsize? integer
---@return string
---@nodiscard
function M.expandtabs(s, tabsize) end

---Return lowest index of substring or nil if not found.
---
---**Example:**
---```lua
---local i = find("hello", "ll")
-----result: 3
---```
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer?
---@nodiscard
function M.find(s, sub, start, stop) end

---Format string with mapping (key-based) replacement.
---
---**Example:**
---```lua
---local s = format_map("hi {name}", { name = "bob" })
-----result: "hi bob"
---```
---@param s string
---@param mapping table
---@return string
---@nodiscard
function M.format_map(s, mapping) end

--------------------------------------------------------------------------------
---------------------------------- Predicates ----------------------------------
--------------------------------------------------------------------------------

---Return true if all characters are alphanumeric and string is non-empty.
---
---**Example:**
---```lua
---local ok = isalnum("abc123")
-----result: true
---```
---
--->[!NOTE]
--->Lua letters are ASCII by default, so non-ASCII letters are not alphanumeric.
--->
--->```lua
---> isalnum("á1")` --> `false`
---```
---@param s string
---@return boolean
---@nodiscard
function M.isalnum(s) end

---Return true if all characters are alphabetic and string is non-empty.
---
---**Example:**
---```lua
---local ok = isalpha("abc")
-----result: true
---```
---
--->[!NOTE]
--->Lua letters are ASCII by default, so non-ASCII letters are not alphabetic.
--->
--->```lua
---> isalpha("á")` --> `false`
---```
---@param s string
---@return boolean
---@nodiscard
function M.isalpha(s) end

---Return true if all characters are ASCII and string is non-empty.
---
---**Example:**
---```lua
---local ok = isascii("hello")
-----result: true
---```
---
--->[!NOTE]
--->The empty string returns `true`.
---@param s string
---@return boolean
---@nodiscard
function M.isascii(s) end

---Return true if all characters are decimal characters and string is non-empty.
---
---**Example:**
---```lua
---local ok = isdecimal("123")
-----result: true
---```
---@param s string
---@return boolean
---@nodiscard
function M.isdecimal(s) end

---Return true if all characters are digits and string is non-empty.
---
---**Example:**
---```lua
---local ok = isdigit("123")
-----result: true
---```
---
---@param s string
---@return boolean
---@nodiscard
function M.isdigit(s) end

---Return true if string is a valid identifier and not a reserved keyword.
---
---**Example:**
---```lua
---local ok = isidentifier("foo_bar")
-----result: true
---
---ok = isidentifier("2var")
-----result: false
---
---ok = isidentifier("end")
-----result: false (keyword)
---```
---@param s string
---@return boolean
---@nodiscard
function M.isidentifier(s) end

---Return true if all cased characters are lowercase and there is at least one cased character.
---
---**Example:**
---```lua
---local ok = islower("hello")
-----result: true
---```
---@param s string
---@return boolean
---@nodiscard
function M.islower(s) end

---Return true if all characters are numeric and string is non-empty.
---
---**Example:**
---```lua
---local ok = isnumeric("123")
-----result: true
---```
---
---@param s string
---@return boolean
---@nodiscard
function M.isnumeric(s) end

---Return true if all characters are printable and string is non-empty.
---
---**Example:**
---```lua
---local ok = isprintable("abc!")
-----result: true
---```
---
--->[!NOTE]
--->The empty string returns `true`.
---@param s string
---@return boolean
---@nodiscard
function M.isprintable(s) end

---Return true if all characters are whitespace and string is non-empty.
---
---**Example:**
---```lua
---local ok = isspace(" \t")
-----result: true
---```
---@param s string
---@return boolean
---@nodiscard
function M.isspace(s) end

---Return true if string is titlecased.
---
---**Example:**
---```lua
---local ok = istitle("Hello World")
-----result: true
---```
---@param s string
---@return boolean
---@nodiscard
function M.istitle(s) end

---Return true if all cased characters are uppercase and there is at least one cased character.
---
---**Example:**
---```lua
---local ok = isupper("HELLO")
-----result: true
---```
---@param s string
---@return boolean
---@nodiscard
function M.isupper(s) end

--------------------------------------------------------------------------------
------------------------------------ Layout ------------------------------------
--------------------------------------------------------------------------------

---Join an iterable of strings using this string as separator.
---
---**Example:**
---```lua
---local s = join(",", { "a", "b", "c" })
-----result: "a,b,c"
---```
---@param sep string
---@param ls string[]
---@return string
---@nodiscard
function M.join(sep, ls) end

---Left-justify string in a field of given width.
---
---**Example:**
---```lua
---local s = ljust("hi", 5, ".")
-----result: "hi..."
---```
---@param s string
---@param width integer
---@param fillchar? string
---@return string
---@nodiscard
function M.ljust(s, width, fillchar) end

---Return lowercased copy.
---
---**Example:**
---```lua
---local s = lower("HeLLo")
-----result: "hello"
---```
---@param s string
---@return string
---@nodiscard
function M.lower(s) end

---Remove leading characters (default: whitespace).
---
---**Example:**
---```lua
---local s = lstrip("  hello")
-----result: "hello"
---```
---@param s string
---@param chars? string
---@return string
---@nodiscard
function M.lstrip(s, chars) end

---Remove trailing characters (default: whitespace).
---
---**Example:**
---```lua
---local s = rstrip("hello  ")
-----result: "hello"
---```
---@param s string
---@param chars? string
---@return string
---@nodiscard
function M.rstrip(s, chars) end

---Remove leading and trailing characters (default: whitespace).
---
---**Example:**
---```lua
---local s = strip("  hello  ")
-----result: "hello"
---```
---@param s string
---@param chars? string
---@return string
---@nodiscard
function M.strip(s, chars) end

--------------------------------------------------------------------------------
------------------------------- Split & Replace --------------------------------
--------------------------------------------------------------------------------

---Partition string into head, sep, tail from left.
---
---**Example:**
---```lua
---local a, b, c = partition("a-b-c", "-")
-----result: "a", "-", "b-c"
---```
---@param s string
---@param sep string
---@return string,string,string
---@nodiscard
function M.partition(s, sep) end

---Remove prefix if present.
---
---**Example:**
---```lua
---local s = removeprefix("foobar", "foo")
-----result: "bar"
---```
---@param s string
---@param prefix string
---@return string
---@nodiscard
function M.removeprefix(s, prefix) end

---Remove suffix if present.
---
---**Example:**
---```lua
---local s = removesuffix("foobar", "bar")
-----result: "foo"
---```
---@param s string
---@param suffix string
---@return string
---@nodiscard
function M.removesuffix(s, suffix) end

---Return a copy of the string with all occurrences of a substring replaced.
---
---**Example:**
---```lua
---local s = replace("a-b-c", "-", "_", 1)
-----result: "a_b-c"
---```
---@param s string
---@param old string
---@param new string
---@param count? integer
---@return string
---@nodiscard
function M.replace(s, old, new, count) end

---Return highest index of substring or nil if not found.
---
---**Example:**
---```lua
---local i = rfind("ababa", "ba")
-----result: 4
---```
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer?
---@nodiscard
function M.rfind(s, sub, start, stop) end

---Like rfind but raises on failure (placeholder).
---
---**Example:**
---```lua
---local i = rindex("ababa", "ba")
-----result: 4
---```
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer
---@nodiscard
function M.rindex(s, sub, start, stop) end

---Right-justify string in a field of given width.
---
---**Example:**
---```lua
---local s = rjust("hi", 5, ".")
-----result: "...hi"
---```
---@param s string
---@param width integer
---@param fillchar? string
---@return string
---@nodiscard
function M.rjust(s, width, fillchar) end

---Partition string into head, sep, tail from right.
---
---**Example:**
---```lua
---local a, b, c = rpartition("a-b-c", "-")
-----result: "a-b", "-", "c"
---```
---@param s string
---@param sep string
---@return string,string,string
---@nodiscard
function M.rpartition(s, sep) end

---Split from the right by separator, up to maxsplit.
---
---**Example:**
---```lua
---local parts = rsplit("a,b,c", ",", 1)
-----result: { "a,b", "c" }
---```
---@param s string
---@param sep? string
---@param maxsplit? integer
---@return mods.List|string[]
---@nodiscard
function M.rsplit(s, sep, maxsplit) end

---Split by separator (or whitespace) up to maxsplit.
---
---**Example:**
---```lua
---local parts = split("a,b,c", ",")
-----result: { "a", "b", "c" }
---```
---@param s string
---@param sep? string
---@param maxsplit? integer
---@return mods.List|string[]
---@nodiscard
function M.split(s, sep, maxsplit) end

---Split on line boundaries.
---
---**Example:**
---```lua
---local lines = splitlines("a\nb\r\nc")
-----result: { "a", "b", "c" }
---```
---@param s string
---@param keepends? boolean
---@return mods.List|string[]
---@nodiscard
function M.splitlines(s, keepends) end

--------------------------------------------------------------------------------
------------------------------ Casing & Transform ------------------------------
--------------------------------------------------------------------------------

---Return a copy with case of alphabetic characters swapped.
---
---**Example:**
---```lua
---local s = swapcase("AbC")
-----result: "aBc"
---```
---@param s string
---@return string
---@nodiscard
function M.swapcase(s) end

---Return true if string starts with prefix.
---If prefix is a list, return true if any prefix matches.
---
---**Example:**
---```lua
---local ok = startswith("hello.lua", "he")
-----result: true
---```
---@param s string
---@param prefix string|string[]
---@param start? integer
---@param stop? integer
---@return boolean
---@nodiscard
function M.startswith(s, prefix, start, stop) end

---Return titlecased copy.
---
---**Example:**
---```lua
---local s = title("hello world")
-----result: "Hello World"
---```
---@param s string
---@return string
---@nodiscard
function M.title(s) end

---Translate characters using a mapping table.
---
---**Example:**
---```lua
---local map = { [string.byte("a")] = "b", ["c"] = false }
---local s = translate("abc", map)
-----result: "bb"
---```
---@param s string
---@param table_map table
---@return string
---@nodiscard
function M.translate(s, table_map) end

---Return uppercased copy.
---
---**Example:**
---```lua
---local s = upper("Hello")
-----result: "HELLO"
---```
---@param s string
---@return string
---@nodiscard
function M.upper(s) end

---Pad numeric string on the left with zeros.
---
---**Example:**
---```lua
---local s = zfill("42", 5)
-----result: "00042"
---```
---@param s string
---@param width integer
---@return string
---@nodiscard
function M.zfill(s, width) end

return M
