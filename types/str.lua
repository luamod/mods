---@meta mods.str

---
---String utility helpers modeled after Python's `str`.
---
---## Usage
---
---```lua
---str = require "mods.str"
---
---print(str.capitalize("hello world")) --> "Hello world"
---```
---
---## Dependencies
---
---Dependencies below are lazy-loaded 💤 on first access.
---
---* [`mods.keyword`](https://luamod.github.io/mods/modules/keyword)
---* [`mods.List`](https://luamod.github.io/mods/modules/list)
---* [`mods.stringcase`](https://luamod.github.io/mods/modules/stringcase)
---
---@class mods.str
local M = {}

--------------------------------------------------------------------------------
----------------------------------- Formatting ---------------------------------
--------------------------------------------------------------------------------

---
---Return copy with first character capitalized and the rest lowercased.
---
---```lua
---s = capitalize("hello WORLD")
-----result: "Hello world"
---```
---
---@param s string
---@return string
---@nodiscard
function M.capitalize(s) end

---
---Center string within width, padded with fill characters.
---
---```lua
---s = center("hi", 6, "-")
-----result: "--hi--"
---```
---
---@param s string
---@param width integer
---@param fillchar? string
---@return string
---@nodiscard
function M.center(s, width, fillchar) end

---
---Count non-overlapping occurrences of a substring.
---
---```lua
---n = count("aaaa", "aa")
-----result: 2
---
---n = count("aaaa", "a", 2, -1)
-----result: 2
---
---n = count("abcd", "")
-----result: 5
---```
---
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer
---@nodiscard
function M.count(s, sub, start, stop) end

---
---Return true if string ends with suffix.
---
---> [!NOTE]
---> If suffix is a list, returns `true` when any suffix matches.
---
---```lua
---ok = endswith("hello.lua", ".lua")
-----result: true
---```
---
---@param s string
---@param suffix string|string[]
---@param start? integer
---@param stop? integer
---@return boolean
---@nodiscard
function M.endswith(s, suffix, start, stop) end

---
---Expand tabs to spaces using given tabsize.
---
---```lua
---s = expandtabs("a\tb", 4)
-----result: "a   b"
---```
---
---@param s string
---@param tabsize? integer
---@return string
---@nodiscard
function M.expandtabs(s, tabsize) end

---
---Return lowest index of substring or nil if not found.
---
---```lua
---i = find("hello", "ll")
-----result: 3
---```
---
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer?
---@nodiscard
function M.find(s, sub, start, stop) end

---
---Format string with mapping (key-based) replacement.
---
---```lua
---s = format_map("hi {name}", { name = "bob" })
-----result: "hi bob"
---```
---
---@param s string
---@param mapping table
---@return string
---@nodiscard
function M.format_map(s, mapping) end

--------------------------------------------------------------------------------
---------------------------------- Predicates ----------------------------------
--------------------------------------------------------------------------------

---
---Return true if all characters are alphanumeric and string is non-empty.
---
---```lua
---ok = isalnum("abc123")
-----result: true
---```
---
--->[!NOTE]
--->Lua letters are ASCII by default, so non-ASCII letters are not alphanumeric.
--->
--->```lua
---> isalnum("á1")` --> `false`
--->```
---@param s string
---@return boolean
---@nodiscard
function M.isalnum(s) end

---
---Return true if all characters are alphabetic and string is non-empty.
---
---```lua
---ok = isalpha("abc")
-----result: true
---```
---
--->[!NOTE]
--->Lua letters are ASCII by default, so non-ASCII letters are not alphabetic.
--->
--->```lua
---> isalpha("á")` --> `false`
--->```
---@param s string
---@return boolean
---@nodiscard
function M.isalpha(s) end

---
---Return true if all characters are ASCII and string is non-empty.
---
---```lua
---ok = isascii("hello")
-----result: true
---```
---
--->[!NOTE]
--->The empty string returns `true`.
---@param s string
---@return boolean
---@nodiscard
function M.isascii(s) end

---
---Return true if all characters are decimal characters and string is non-empty.
---
---```lua
---ok = isdecimal("123")
-----result: true
---```
---
---@param s string
---@return boolean
---@nodiscard
function M.isdecimal(s) end

---
---Return true if all characters are digits and string is non-empty.
---
---```lua
---ok = isdigit("123")
-----result: true
---```
---
---@param s string
---@return boolean
---@nodiscard
function M.isdigit(s) end

---
---Return true if string is a valid identifier and not a reserved keyword.
---
---```lua
---ok = isidentifier("foo_bar")
-----result: true
---
---ok = isidentifier("2var")
-----result: false
---
---ok = isidentifier("end")
-----result: false (keyword)
---```
---
---@param s string
---@return boolean
---@nodiscard
function M.isidentifier(s) end

---
---Return true if all cased characters are lowercase and there is at least one cased character.
---
---```lua
---ok = islower("hello")
-----result: true
---```
---
---@param s string
---@return boolean
---@nodiscard
function M.islower(s) end

---
---Return true if all characters are numeric and string is non-empty.
---
---```lua
---ok = isnumeric("123")
-----result: true
---```
---
---@param s string
---@return boolean
---@nodiscard
function M.isnumeric(s) end

---
---Return true if all characters are printable and string is non-empty.
---
---```lua
---ok = isprintable("abc!")
-----result: true
---```
---
--->[!NOTE]
--->The empty string returns `true`.
---@param s string
---@return boolean
---@nodiscard
function M.isprintable(s) end

---
---Return true if all characters are whitespace and string is non-empty.
---
---```lua
---ok = isspace(" \t")
-----result: true
---```
---
---@param s string
---@return boolean
---@nodiscard
function M.isspace(s) end

---
---Return true if string is titlecased.
---
---```lua
---ok = istitle("Hello World")
-----result: true
---```
---
---@param s string
---@return boolean
---@nodiscard
function M.istitle(s) end

---
---Return true if all cased characters are uppercase and there is at least one cased character.
---
---```lua
---ok = isupper("HELLO")
-----result: true
---```
---
---@param s string
---@return boolean
---@nodiscard
function M.isupper(s) end

--------------------------------------------------------------------------------
------------------------------------ Layout ------------------------------------
--------------------------------------------------------------------------------

---
---Join an iterable of strings using this string as separator.
---
---```lua
---s = join(",", { "a", "b", "c" })
-----result: "a,b,c"
---```
---
---@param sep string
---@param ls string[]
---@return string
---@nodiscard
function M.join(sep, ls) end

---
---Left-justify string in a field of given width.
---
---```lua
---s = ljust("hi", 5, ".")
-----result: "hi..."
---```
---
---@param s string
---@param width integer
---@param fillchar? string
---@return string
---@nodiscard
function M.ljust(s, width, fillchar) end

---
---Return lowercased copy.
---
---```lua
---s = lower("HeLLo")
-----result: "hello"
---```
---
---@param s string
---@return string
---@nodiscard
function M.lower(s) end

---
---Remove leading characters (default: whitespace).
---
---```lua
---s = lstrip("  hello")
-----result: "hello"
---```
---
---@param s string
---@param chars? string
---@return string
---@nodiscard
function M.lstrip(s, chars) end

---
---Remove trailing characters (default: whitespace).
---
---```lua
---s = rstrip("hello  ")
-----result: "hello"
---```
---
---@param s string
---@param chars? string
---@return string
---@nodiscard
function M.rstrip(s, chars) end

---
---Remove leading and trailing characters (default: whitespace).
---
---```lua
---s = strip("  hello  ")
-----result: "hello"
---```
---
---@param s string
---@param chars? string
---@return string
---@nodiscard
function M.strip(s, chars) end

--------------------------------------------------------------------------------
------------------------------- Split & Replace --------------------------------
--------------------------------------------------------------------------------

---
---Partition string into head, sep, tail from left.
---
---```lua
---a, b, c = partition("a-b-c", "-")
-----result: "a", "-", "b-c"
---```
---
---@param s string
---@param sep string
---@return string,string,string
---@nodiscard
function M.partition(s, sep) end

---
---Remove prefix if present.
---
---```lua
---s = removeprefix("foobar", "foo")
-----result: "bar"
---```
---
---@param s string
---@param prefix string
---@return string
---@nodiscard
function M.removeprefix(s, prefix) end

---
---Remove suffix if present.
---
---```lua
---s = removesuffix("foobar", "bar")
-----result: "foo"
---```
---
---@param s string
---@param suffix string
---@return string
---@nodiscard
function M.removesuffix(s, suffix) end

---
---Return a copy of the string with all occurrences of a substring replaced.
---
---```lua
---s = replace("a-b-c", "-", "_", 1)
-----result: "a_b-c"
---```
---
---@param s string
---@param old string
---@param new string
---@param count? integer
---@return string
---@nodiscard
function M.replace(s, old, new, count) end

---
---Return highest index of substring or nil if not found.
---
---```lua
---i = rfind("ababa", "ba")
-----result: 4
---```
---
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer?
---@nodiscard
function M.rfind(s, sub, start, stop) end

---
---Like rfind but raises on failure (placeholder).
---
---```lua
---i = rindex("ababa", "ba")
-----result: 4
---```
---
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer
---@nodiscard
function M.rindex(s, sub, start, stop) end

---
---Right-justify string in a field of given width.
---
---```lua
---s = rjust("hi", 5, ".")
-----result: "...hi"
---```
---
---@param s string
---@param width integer
---@param fillchar? string
---@return string
---@nodiscard
function M.rjust(s, width, fillchar) end

---
---Partition string into head, sep, tail from right.
---
---```lua
---a, b, c = rpartition("a-b-c", "-")
-----result: "a-b", "-", "c"
---```
---
---@param s string
---@param sep string
---@return string,string,string
---@nodiscard
function M.rpartition(s, sep) end

---
---Split from the right by separator, up to maxsplit.
---
---```lua
---parts = rsplit("a,b,c", ",", 1)
-----result: { "a,b", "c" }
---```
---
---@param s string
---@param sep? string
---@param maxsplit? integer
---@return mods.List
---@nodiscard
function M.rsplit(s, sep, maxsplit) end

---
---Split by separator (or whitespace) up to maxsplit.
---
---```lua
---parts = split("a,b,c", ",")
-----result: { "a", "b", "c" }
---```
---
---@param s string
---@param sep? string
---@param maxsplit? integer
---@return mods.List
---@nodiscard
function M.split(s, sep, maxsplit) end

---
---Split on line boundaries.
---
---```lua
---lines = splitlines("a\nb\r\nc")
-----result: { "a", "b", "c" }
---```
---
---@param s string
---@param keepends? boolean
---@return mods.List
---@nodiscard
function M.splitlines(s, keepends) end

--------------------------------------------------------------------------------
------------------------------ Casing & Transform ------------------------------
--------------------------------------------------------------------------------

---
---Return a copy with case of alphabetic characters swapped.
---
---```lua
---s = swapcase("AbC")
-----result: "aBc"
---```
---
---@param s string
---@return string
---@nodiscard
function M.swapcase(s) end

---
---Return true if string starts with prefix.
---
---> [!NOTE]
---> If prefix is a list, returns `true` when any prefix matches.
---
---```lua
---ok = startswith("hello.lua", "he")
-----result: true
---```
---
---@param s string
---@param prefix string|string[]
---@param start? integer
---@param stop? integer
---@return boolean
---@nodiscard
function M.startswith(s, prefix, start, stop) end

---
---Return titlecased copy.
---
---```lua
---s = title("hello world")
-----result: "Hello World"
---```
---
---@param s string
---@return string
---@nodiscard
function M.title(s) end

---
---Translate characters using a mapping table.
---
---```lua
---map = { [string.byte("a")] = "b", ["c"] = false }
---s = translate("abc", map)
-----result: "bb"
---```
---
---@param s string
---@param table_map table
---@return string
---@nodiscard
function M.translate(s, table_map) end

---
---Return uppercased copy.
---
---```lua
---s = upper("Hello")
-----result: "HELLO"
---```
---
---@param s string
---@return string
---@nodiscard
function M.upper(s) end

---
---Pad numeric string on the left with zeros.
---
---```lua
---s = zfill("42", 5)
-----result: "00042"
---```
---
---@param s string
---@param width integer
---@return string
---@nodiscard
function M.zfill(s, width) end

return M
