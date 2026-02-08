---
editLinkTarget: types/str.lua
---

# str

String utility helpers modeled after Python's `str`.

## Quick Reference

| Function                                                                  | Description                                                                                  |
| ------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| [`capitalize(s)`](#fn-capitalizes)                                        | Return copy with first character capitalized and the rest lowercased.                        |
| [`center(s, width, fillchar)`](#fn-centers-width-fillchar)                | Center string within width, padded with fill characters.                                     |
| [`count(s, sub, start, stop)`](#fn-counts-sub-start-stop)                 | Count non-overlapping occurrences of a substring.                                            |
| [`endswith(s, suffix, start, stop)`](#fn-endswiths-suffix-start-stop)     | Return true if string ends with suffix.                                                      |
| [`expandtabs(s, tabsize)`](#fn-expandtabss-tabsize)                       | Expand tabs to spaces using given tabsize.                                                   |
| [`find(s, sub, start, stop)`](#fn-finds-sub-start-stop)                   | Return lowest index of substring or nil if not found.                                        |
| [`map(s, mapping)`](#fn-maps-mapping)                                     | Format string with mapping (key-based) replacement.                                          |
| [`isalnum(s)`](#fn-isalnums)                                              | Return true if all characters are alphanumeric and string is non-empty.                      |
| [`isalpha(s)`](#fn-isalphas)                                              | Return true if all characters are alphabetic and string is non-empty.                        |
| [`isascii(s)`](#fn-isasciis)                                              | Return true if all characters are ASCII and string is non-empty.                             |
| [`isdecimal(s)`](#fn-isdecimals)                                          | Return true if all characters are decimal characters and string is non-empty.                |
| [`isdigit(s)`](#fn-isdigits)                                              | Return true if all characters are digits and string is non-empty.                            |
| [`isidentifier(s)`](#fn-isidentifiers)                                    | Return true if string is a valid identifier and not a reserved keyword.                      |
| [`islower(s)`](#fn-islowers)                                              | Return true if all cased characters are lowercase and there is at least one cased character. |
| [`isnumeric(s)`](#fn-isnumerics)                                          | Return true if all characters are numeric and string is non-empty.                           |
| [`isprintable(s)`](#fn-isprintables)                                      | Return true if all characters are printable and string is non-empty.                         |
| [`isspace(s)`](#fn-isspaces)                                              | Return true if all characters are whitespace and string is non-empty.                        |
| [`istitle(s)`](#fn-istitles)                                              | Return true if string is titlecased.                                                         |
| [`isupper(s)`](#fn-isuppers)                                              | Return true if all cased characters are uppercase and there is at least one cased character. |
| [`join(sep, ls)`](#fn-joinsep-ls)                                         | Join an iterable of strings using this string as separator.                                  |
| [`ljust(s, width, fillchar)`](#fn-ljusts-width-fillchar)                  | Left-justify string in a field of given width.                                               |
| [`lower(s)`](#fn-lowers)                                                  | Return lowercased copy.                                                                      |
| [`lstrip(s, chars)`](#fn-lstrips-chars)                                   | Remove leading characters (default: whitespace).                                             |
| [`rstrip(s, chars)`](#fn-rstrips-chars)                                   | Remove trailing characters (default: whitespace).                                            |
| [`strip(s, chars)`](#fn-strips-chars)                                     | Remove leading and trailing characters (default: whitespace).                                |
| [`partition(s, sep)`](#fn-partitions-sep)                                 | Partition string into head, sep, tail from left.                                             |
| [`removeprefix(s, prefix)`](#fn-removeprefixs-prefix)                     | Remove prefix if present.                                                                    |
| [`removesuffix(s, suffix)`](#fn-removesuffixs-suffix)                     | Remove suffix if present.                                                                    |
| [`replace(s, old, new, count)`](#fn-replaces-old-new-count)               | Return a copy of the string with all occurrences of a substring replaced.                    |
| [`rfind(s, sub, start, stop)`](#fn-rfinds-sub-start-stop)                 | Return highest index of substring or nil if not found.                                       |
| [`rindex(s, sub, start, stop)`](#fn-rindexs-sub-start-stop)               | Like rfind but raises on failure (placeholder).                                              |
| [`rjust(s, width, fillchar)`](#fn-rjusts-width-fillchar)                  | Right-justify string in a field of given width.                                              |
| [`rpartition(s, sep)`](#fn-rpartitions-sep)                               | Partition string into head, sep, tail from right.                                            |
| [`rsplit(s, sep, maxsplit)`](#fn-rsplits-sep-maxsplit)                    | Split from the right by separator, up to maxsplit.                                           |
| [`split(s, sep, maxsplit)`](#fn-splits-sep-maxsplit)                      | Split by separator (or whitespace) up to maxsplit.                                           |
| [`splitlines(s, keepends)`](#fn-splitliness-keepends)                     | Split on line boundaries.                                                                    |
| [`swapcase(s)`](#fn-swapcases)                                            | Return a copy with case of alphabetic characters swapped.                                    |
| [`startswith(s, prefix, start, stop)`](#fn-startswiths-prefix-start-stop) | Return true if string starts with prefix.                                                    |
| [`title(s)`](#fn-titles)                                                  | Return titlecased copy.                                                                      |
| [`translate(s, table_map)`](#fn-translates-table_map)                     | Translate characters using a mapping table.                                                  |
| [`upper(s)`](#fn-uppers)                                                  | Return uppercased copy.                                                                      |
| [`zfill(s, width)`](#fn-zfills-width)                                     | Pad numeric string on the left with zeros.                                                   |

## Functions

<a id="fn-capitalizes"></a>

#### `capitalize(s)`

Return copy with first character capitalized and the rest lowercased.

:::tabs
== Example

```lua
local s = capitalize("hello WORLD")
--result: "Hello world"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function capitalize(s) end
```

:::

<a id="fn-centers-width-fillchar"></a>

#### `center(s, width, fillchar)`

Center string within width, padded with fill characters.

:::tabs
== Example

```lua
local s = center("hi", 6, "-")
--result: "--hi--"
```

== Signature

```lua
---@param s string
---@param width integer
---@param fillchar? string
---@return string
---@nodiscard
function center(s, width, fillchar) end
```

:::

<a id="fn-counts-sub-start-stop"></a>

#### `count(s, sub, start, stop)`

Count non-overlapping occurrences of a substring.

:::tabs
== Example

```lua
local n = count("aaaa", "aa")
--result: 2
```

```lua
local n = count("aaaa", "a", 2, -1)
--result: 2
```

```lua
local n = count("abcd", "")
--result: 5
```

== Signature

```lua
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer
---@nodiscard
function count(s, sub, start, stop) end
```

:::

<a id="fn-endswiths-suffix-start-stop"></a>

#### `endswith(s, suffix, start, stop)`

Return true if string ends with suffix.
If suffix is a list, return true if any suffix matches.

:::tabs
== Example

```lua
local ok = endswith("hello.lua", ".lua")
--result: true
```

== Signature

```lua
---@param s string
---@param suffix string|string[]
---@param start? integer
---@param stop? integer
---@return boolean
---@nodiscard
function endswith(s, suffix, start, stop) end
```

:::

<a id="fn-expandtabss-tabsize"></a>

#### `expandtabs(s, tabsize)`

Expand tabs to spaces using given tabsize.

:::tabs
== Example

```lua
local s = expandtabs("a\tb", 4)
--result: "a   b"
```

== Signature

```lua
---@param s string
---@param tabsize? integer
---@return string
---@nodiscard
function expandtabs(s, tabsize) end
```

:::

<a id="fn-finds-sub-start-stop"></a>

#### `find(s, sub, start, stop)`

Return lowest index of substring or nil if not found.

:::tabs
== Example

```lua
local i = find("hello", "ll")
--result: 3
```

== Signature

```lua
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer?
---@nodiscard
function find(s, sub, start, stop) end
```

:::

<a id="fn-maps-mapping"></a>

#### `map(s, mapping)`

Format string with mapping (key-based) replacement.

:::tabs
== Example

```lua
local s = format_map("hi {name}", { name = "bob" })
--result: "hi bob"
```

== Signature

```lua
---@param s string
---@param mapping table
---@return string
---@nodiscard
function map(s, mapping) end
```

:::

<a id="fn-isalnums"></a>

#### `isalnum(s)`

Return true if all characters are alphanumeric and string is non-empty.

:::tabs
== Example

```lua
local ok = isalnum("abc123")
--result: true
```

> [!NOTE]
> Lua letters are ASCII by default, so non-ASCII letters are not alphanumeric.
>
> ```lua
> isalnum("á1")` --> `false`
> ```

````

== Signature

```lua
---@param s string
---@return boolean
---@nodiscard
function isalnum(s) end
````

:::

<a id="fn-isalphas"></a>

#### `isalpha(s)`

Return true if all characters are alphabetic and string is non-empty.

:::tabs
== Example

```lua
local ok = isalpha("abc")
--result: true
```

> [!NOTE]
> Lua letters are ASCII by default, so non-ASCII letters are not alphabetic.
>
> ```lua
> isalpha("á")` --> `false`
> ```

````

== Signature

```lua
---@param s string
---@return boolean
---@nodiscard
function isalpha(s) end
````

:::

<a id="fn-isasciis"></a>

#### `isascii(s)`

Return true if all characters are ASCII and string is non-empty.

:::tabs
== Example

```lua
local ok = isascii("hello")
--result: true
```

> [!NOTE]
> The empty string returns `true`.

== Signature

```lua
---@param s string
---@return boolean
---@nodiscard
function isascii(s) end
```

:::

<a id="fn-isdecimals"></a>

#### `isdecimal(s)`

Return true if all characters are decimal characters and string is non-empty.

:::tabs
== Example

```lua
local ok = isdecimal("123")
--result: true
```

== Signature

```lua
---@param s string
---@return boolean
---@nodiscard
function isdecimal(s) end
```

:::

<a id="fn-isdigits"></a>

#### `isdigit(s)`

Return true if all characters are digits and string is non-empty.

:::tabs
== Example

```lua
local ok = isdigit("123")
--result: true
```

== Signature

```lua
---@param s string
---@return boolean
---@nodiscard
function isdigit(s) end
```

:::

<a id="fn-isidentifiers"></a>

#### `isidentifier(s)`

Return true if string is a valid identifier and not a reserved keyword.

:::tabs
== Example

```lua
local ok = isidentifier("foo_bar")
--result: true

ok = isidentifier("2var")
--result: false

ok = isidentifier("end")
--result: false (keyword)
```

== Signature

```lua
---@param s string
---@return boolean
---@nodiscard
function isidentifier(s) end
```

:::

<a id="fn-islowers"></a>

#### `islower(s)`

Return true if all cased characters are lowercase and there is at least one cased character.

:::tabs
== Example

```lua
local ok = islower("hello")
--result: true
```

== Signature

```lua
---@param s string
---@return boolean
---@nodiscard
function islower(s) end
```

:::

<a id="fn-isnumerics"></a>

#### `isnumeric(s)`

Return true if all characters are numeric and string is non-empty.

:::tabs
== Example

```lua
local ok = isnumeric("123")
--result: true
```

== Signature

```lua
---@param s string
---@return boolean
---@nodiscard
function isnumeric(s) end
```

:::

<a id="fn-isprintables"></a>

#### `isprintable(s)`

Return true if all characters are printable and string is non-empty.

:::tabs
== Example

```lua
local ok = isprintable("abc!")
--result: true
```

> [!NOTE]
> The empty string returns `true`.

== Signature

```lua
---@param s string
---@return boolean
---@nodiscard
function isprintable(s) end
```

:::

<a id="fn-isspaces"></a>

#### `isspace(s)`

Return true if all characters are whitespace and string is non-empty.

:::tabs
== Example

```lua
local ok = isspace(" \t")
--result: true
```

== Signature

```lua
---@param s string
---@return boolean
---@nodiscard
function isspace(s) end
```

:::

<a id="fn-istitles"></a>

#### `istitle(s)`

Return true if string is titlecased.

:::tabs
== Example

```lua
local ok = istitle("Hello World")
--result: true
```

== Signature

```lua
---@param s string
---@return boolean
---@nodiscard
function istitle(s) end
```

:::

<a id="fn-isuppers"></a>

#### `isupper(s)`

Return true if all cased characters are uppercase and there is at least one cased character.

:::tabs
== Example

```lua
local ok = isupper("HELLO")
--result: true
```

== Signature

```lua
---@param s string
---@return boolean
---@nodiscard
function isupper(s) end
```

:::

<a id="fn-joinsep-ls"></a>

#### `join(sep, ls)`

Join an iterable of strings using this string as separator.

:::tabs
== Example

```lua
local s = join(",", { "a", "b", "c" })
--result: "a,b,c"
```

== Signature

```lua
---@param sep string
---@param ls string[]
---@return string
---@nodiscard
function join(sep, ls) end
```

:::

<a id="fn-ljusts-width-fillchar"></a>

#### `ljust(s, width, fillchar)`

Left-justify string in a field of given width.

:::tabs
== Example

```lua
local s = ljust("hi", 5, ".")
--result: "hi..."
```

== Signature

```lua
---@param s string
---@param width integer
---@param fillchar? string
---@return string
---@nodiscard
function ljust(s, width, fillchar) end
```

:::

<a id="fn-lowers"></a>

#### `lower(s)`

Return lowercased copy.

:::tabs
== Example

```lua
local s = lower("HeLLo")
--result: "hello"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function lower(s) end
```

:::

<a id="fn-lstrips-chars"></a>

#### `lstrip(s, chars)`

Remove leading characters (default: whitespace).

:::tabs
== Example

```lua
local s = lstrip("  hello")
--result: "hello"
```

== Signature

```lua
---@param s string
---@param chars? string
---@return string
---@nodiscard
function lstrip(s, chars) end
```

:::

<a id="fn-rstrips-chars"></a>

#### `rstrip(s, chars)`

Remove trailing characters (default: whitespace).

:::tabs
== Example

```lua
local s = rstrip("hello  ")
--result: "hello"
```

== Signature

```lua
---@param s string
---@param chars? string
---@return string
---@nodiscard
function rstrip(s, chars) end
```

:::

<a id="fn-strips-chars"></a>

#### `strip(s, chars)`

Remove leading and trailing characters (default: whitespace).

:::tabs
== Example

```lua
local s = strip("  hello  ")
--result: "hello"
```

== Signature

```lua
---@param s string
---@param chars? string
---@return string
---@nodiscard
function strip(s, chars) end
```

:::

<a id="fn-partitions-sep"></a>

#### `partition(s, sep)`

Partition string into head, sep, tail from left.

:::tabs
== Example

```lua
local a, b, c = partition("a-b-c", "-")
--result: "a", "-", "b-c"
```

== Signature

```lua
---@param s string
---@param sep string
---@return string,string,string
---@nodiscard
function partition(s, sep) end
```

:::

<a id="fn-removeprefixs-prefix"></a>

#### `removeprefix(s, prefix)`

Remove prefix if present.

:::tabs
== Example

```lua
local s = removeprefix("foobar", "foo")
--result: "bar"
```

== Signature

```lua
---@param s string
---@param prefix string
---@return string
---@nodiscard
function removeprefix(s, prefix) end
```

:::

<a id="fn-removesuffixs-suffix"></a>

#### `removesuffix(s, suffix)`

Remove suffix if present.

:::tabs
== Example

```lua
local s = removesuffix("foobar", "bar")
--result: "foo"
```

== Signature

```lua
---@param s string
---@param suffix string
---@return string
---@nodiscard
function removesuffix(s, suffix) end
```

:::

<a id="fn-replaces-old-new-count"></a>

#### `replace(s, old, new, count)`

Return a copy of the string with all occurrences of a substring replaced.

:::tabs
== Example

```lua
local s = replace("a-b-c", "-", "_", 1)
--result: "a_b-c"
```

== Signature

```lua
---@param s string
---@param old string
---@param new string
---@param count? integer
---@return string
---@nodiscard
function replace(s, old, new, count) end
```

:::

<a id="fn-rfinds-sub-start-stop"></a>

#### `rfind(s, sub, start, stop)`

Return highest index of substring or nil if not found.

:::tabs
== Example

```lua
local i = rfind("ababa", "ba")
--result: 4
```

== Signature

```lua
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer?
---@nodiscard
function rfind(s, sub, start, stop) end
```

:::

<a id="fn-rindexs-sub-start-stop"></a>

#### `rindex(s, sub, start, stop)`

Like rfind but raises on failure (placeholder).

:::tabs
== Example

```lua
local i = rindex("ababa", "ba")
--result: 4
```

== Signature

```lua
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer
---@nodiscard
function rindex(s, sub, start, stop) end
```

:::

<a id="fn-rjusts-width-fillchar"></a>

#### `rjust(s, width, fillchar)`

Right-justify string in a field of given width.

:::tabs
== Example

```lua
local s = rjust("hi", 5, ".")
--result: "...hi"
```

== Signature

```lua
---@param s string
---@param width integer
---@param fillchar? string
---@return string
---@nodiscard
function rjust(s, width, fillchar) end
```

:::

<a id="fn-rpartitions-sep"></a>

#### `rpartition(s, sep)`

Partition string into head, sep, tail from right.

:::tabs
== Example

```lua
local a, b, c = rpartition("a-b-c", "-")
--result: "a-b", "-", "c"
```

== Signature

```lua
---@param s string
---@param sep string
---@return string,string,string
---@nodiscard
function rpartition(s, sep) end
```

:::

<a id="fn-rsplits-sep-maxsplit"></a>

#### `rsplit(s, sep, maxsplit)`

Split from the right by separator, up to maxsplit.

:::tabs
== Example

```lua
local parts = rsplit("a,b,c", ",", 1)
--result: { "a,b", "c" }
```

== Signature

```lua
---@param s string
---@param sep? string
---@param maxsplit? integer
---@return mods.List|string[]
---@nodiscard
function rsplit(s, sep, maxsplit) end
```

:::

<a id="fn-splits-sep-maxsplit"></a>

#### `split(s, sep, maxsplit)`

Split by separator (or whitespace) up to maxsplit.

:::tabs
== Example

```lua
local parts = split("a,b,c", ",")
--result: { "a", "b", "c" }
```

== Signature

```lua
---@param s string
---@param sep? string
---@param maxsplit? integer
---@return mods.List|string[]
---@nodiscard
function split(s, sep, maxsplit) end
```

:::

<a id="fn-splitliness-keepends"></a>

#### `splitlines(s, keepends)`

Split on line boundaries.

:::tabs
== Example

```lua
local lines = splitlines("a\nb\r\nc")
--result: { "a", "b", "c" }
```

== Signature

```lua
---@param s string
---@param keepends? boolean
---@return mods.List|string[]
---@nodiscard
function splitlines(s, keepends) end
```

:::

<a id="fn-swapcases"></a>

#### `swapcase(s)`

Return a copy with case of alphabetic characters swapped.

:::tabs
== Example

```lua
local s = swapcase("AbC")
--result: "aBc"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function swapcase(s) end
```

:::

<a id="fn-startswiths-prefix-start-stop"></a>

#### `startswith(s, prefix, start, stop)`

Return true if string starts with prefix.
If prefix is a list, return true if any prefix matches.

:::tabs
== Example

```lua
local ok = startswith("hello.lua", "he")
--result: true
```

== Signature

```lua
---@param s string
---@param prefix string|string[]
---@param start? integer
---@param stop? integer
---@return boolean
---@nodiscard
function startswith(s, prefix, start, stop) end
```

:::

<a id="fn-titles"></a>

#### `title(s)`

Return titlecased copy.

:::tabs
== Example

```lua
local s = title("hello world")
--result: "Hello World"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function title(s) end
```

:::

<a id="fn-translates-table_map"></a>

#### `translate(s, table_map)`

Translate characters using a mapping table.

:::tabs
== Example

```lua
local map = { [string.byte("a")] = "b", ["c"] = false }
local s = translate("abc", map)
--result: "bb"
```

== Signature

```lua
---@param s string
---@param table_map table
---@return string
---@nodiscard
function translate(s, table_map) end
```

:::

<a id="fn-uppers"></a>

#### `upper(s)`

Return uppercased copy.

:::tabs
== Example

```lua
local s = upper("Hello")
--result: "HELLO"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function upper(s) end
```

:::

<a id="fn-zfills-width"></a>

#### `zfill(s, width)`

Pad numeric string on the left with zeros.

:::tabs
== Example

```lua
local s = zfill("42", 5)
--result: "00042"
```

== Signature

```lua
---@param s string
---@param width integer
---@return string
---@nodiscard
function zfill(s, width) end
```

:::
