---
description:
  Python-like string utilities for formatting, predicates, splitting, and
  casing.
---

# `str`

String utility helpers modeled after Python's `str`.

## Quick Reference

**Quick Reference: Formatting**:

| Function                                                              | Description                                                           |
| --------------------------------------------------------------------- | --------------------------------------------------------------------- |
| [`capitalize(s)`](#fn-capitalizes)                                    | Return copy with first character capitalized and the rest lowercased. |
| [`center(s, width, fillchar)`](#fn-centers-width-fillchar)            | Center string within width, padded with fill characters.              |
| [`count(s, sub, start, stop)`](#fn-counts-sub-start-stop)             | Count non-overlapping occurrences of a substring.                     |
| [`endswith(s, suffix, start, stop)`](#fn-endswiths-suffix-start-stop) | Return true if string ends with suffix.                               |
| [`expandtabs(s, tabsize)`](#fn-expandtabss-tabsize)                   | Expand tabs to spaces using given tabsize.                            |
| [`find(s, sub, start, stop)`](#fn-finds-sub-start-stop)               | Return lowest index of substring or nil if not found.                 |
| [`format_map(s, mapping)`](#fn-format_maps-mapping)                   | Format string with mapping (key-based) replacement.                   |

**Quick Reference: Predicates**:

| Function                               | Description                                                                                  |
| -------------------------------------- | -------------------------------------------------------------------------------------------- |
| [`isalnum(s)`](#fn-isalnums)           | Return true if all characters are alphanumeric and string is non-empty.                      |
| [`isalpha(s)`](#fn-isalphas)           | Return true if all characters are alphabetic and string is non-empty.                        |
| [`isascii(s)`](#fn-isasciis)           | Return true if all characters are ASCII and string is non-empty.                             |
| [`isdecimal(s)`](#fn-isdecimals)       | Return true if all characters are decimal characters and string is non-empty.                |
| [`isdigit(s)`](#fn-isdigits)           | Return true if all characters are digits and string is non-empty.                            |
| [`isidentifier(s)`](#fn-isidentifiers) | Return true if string is a valid identifier and not a reserved keyword.                      |
| [`islower(s)`](#fn-islowers)           | Return true if all cased characters are lowercase and there is at least one cased character. |
| [`isnumeric(s)`](#fn-isnumerics)       | Return true if all characters are numeric and string is non-empty.                           |
| [`isprintable(s)`](#fn-isprintables)   | Return true if all characters are printable and string is non-empty.                         |
| [`isspace(s)`](#fn-isspaces)           | Return true if all characters are whitespace and string is non-empty.                        |
| [`istitle(s)`](#fn-istitles)           | Return true if string is titlecased.                                                         |
| [`isupper(s)`](#fn-isuppers)           | Return true if all cased characters are uppercase and there is at least one cased character. |

**Quick Reference: Layout**:

| Function                                                 | Description                                                   |
| -------------------------------------------------------- | ------------------------------------------------------------- |
| [`join(sep, ls)`](#fn-joinsep-ls)                        | Join an iterable of strings using this string as separator.   |
| [`ljust(s, width, fillchar)`](#fn-ljusts-width-fillchar) | Left-justify string in a field of given width.                |
| [`lower(s)`](#fn-lowers)                                 | Return lowercased copy.                                       |
| [`lstrip(s, chars)`](#fn-lstrips-chars)                  | Remove leading characters (default: whitespace).              |
| [`rstrip(s, chars)`](#fn-rstrips-chars)                  | Remove trailing characters (default: whitespace).             |
| [`strip(s, chars)`](#fn-strips-chars)                    | Remove leading and trailing characters (default: whitespace). |

**Quick Reference: Split & Replace**:

| Function                                                    | Description                                                               |
| ----------------------------------------------------------- | ------------------------------------------------------------------------- |
| [`partition(s, sep)`](#fn-partitions-sep)                   | Partition string into head, sep, tail from left.                          |
| [`removeprefix(s, prefix)`](#fn-removeprefixs-prefix)       | Remove prefix if present.                                                 |
| [`removesuffix(s, suffix)`](#fn-removesuffixs-suffix)       | Remove suffix if present.                                                 |
| [`replace(s, old, new, count)`](#fn-replaces-old-new-count) | Return a copy of the string with all occurrences of a substring replaced. |
| [`rfind(s, sub, start, stop)`](#fn-rfinds-sub-start-stop)   | Return highest index of substring or nil if not found.                    |
| [`rindex(s, sub, start, stop)`](#fn-rindexs-sub-start-stop) | Like rfind but raises on failure (placeholder).                           |
| [`rjust(s, width, fillchar)`](#fn-rjusts-width-fillchar)    | Right-justify string in a field of given width.                           |
| [`rpartition(s, sep)`](#fn-rpartitions-sep)                 | Partition string into head, sep, tail from right.                         |
| [`rsplit(s, sep, maxsplit)`](#fn-rsplits-sep-maxsplit)      | Split from the right by separator, up to maxsplit.                        |
| [`split(s, sep, maxsplit)`](#fn-splits-sep-maxsplit)        | Split by separator (or whitespace) up to maxsplit.                        |
| [`splitlines(s, keepends)`](#fn-splitliness-keepends)       | Split on line boundaries.                                                 |

**Quick Reference: Casing & Transform**:

| Function                                                                  | Description                                               |
| ------------------------------------------------------------------------- | --------------------------------------------------------- |
| [`swapcase(s)`](#fn-swapcases)                                            | Return a copy with case of alphabetic characters swapped. |
| [`startswith(s, prefix, start, stop)`](#fn-startswiths-prefix-start-stop) | Return true if string starts with prefix.                 |
| [`title(s)`](#fn-titles)                                                  | Return titlecased copy.                                   |
| [`translate(s, table_map)`](#fn-translates-table_map)                     | Translate characters using a mapping table.               |
| [`upper(s)`](#fn-uppers)                                                  | Return uppercased copy.                                   |
| [`zfill(s, width)`](#fn-zfills-width)                                     | Pad numeric string on the left with zeros.                |

## Functions

### Formatting

#### `capitalize(s)` {#fn-capitalizes}

Return copy with first character capitalized and the rest lowercased.

::: code-group

```lua [example.lua]
local s = capitalize("hello WORLD")
--result: "Hello world"
```

```lua [signature.lua]
---@param s string
---@return string
---@nodiscard
function capitalize(s) end
```

:::

#### `center(s, width, fillchar)` {#fn-centers-width-fillchar}

Center string within width, padded with fill characters.

::: code-group

```lua [example.lua]
local s = center("hi", 6, "-")
--result: "--hi--"
```

```lua [signature.lua]
---@param s string
---@param width integer
---@param fillchar? string
---@return string
---@nodiscard
function center(s, width, fillchar) end
```

:::

#### `count(s, sub, start, stop)` {#fn-counts-sub-start-stop}

Count non-overlapping occurrences of a substring.

::: code-group

```lua [example.lua]
local n = count("aaaa", "aa")
--result: 2

n = count("aaaa", "a", 2, -1)
--result: 2

n = count("abcd", "")
--result: 5
```

```lua [signature.lua]
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer
---@nodiscard
function count(s, sub, start, stop) end
```

:::

#### `endswith(s, suffix, start, stop)` {#fn-endswiths-suffix-start-stop}

Return true if string ends with suffix. If suffix is a list, return true if any
suffix matches.

::: code-group

```lua [example.lua]
local ok = endswith("hello.lua", ".lua")
--result: true
```

```lua [signature.lua]
---@param s string
---@param suffix string|string[]
---@param start? integer
---@param stop? integer
---@return boolean
---@nodiscard
function endswith(s, suffix, start, stop) end
```

:::

#### `expandtabs(s, tabsize)` {#fn-expandtabss-tabsize}

Expand tabs to spaces using given tabsize.

::: code-group

```lua [example.lua]
local s = expandtabs("a\tb", 4)
--result: "a   b"
```

```lua [signature.lua]
---@param s string
---@param tabsize? integer
---@return string
---@nodiscard
function expandtabs(s, tabsize) end
```

:::

#### `find(s, sub, start, stop)` {#fn-finds-sub-start-stop}

Return lowest index of substring or nil if not found.

::: code-group

```lua [example.lua]
local i = find("hello", "ll")
--result: 3
```

```lua [signature.lua]
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer?
---@nodiscard
function find(s, sub, start, stop) end
```

:::

#### `format_map(s, mapping)` {#fn-format_maps-mapping}

Format string with mapping (key-based) replacement.

::: code-group

```lua [example.lua]
local s = format_map("hi {name}", { name = "bob" })
--result: "hi bob"
```

```lua [signature.lua]
---@param s string
---@param mapping table
---@return string
---@nodiscard
function format_map(s, mapping) end
```

:::

### Predicates

#### `isalnum(s)` {#fn-isalnums}

Return true if all characters are alphanumeric and string is non-empty.

::: code-group

```lua [example.lua]
local ok = isalnum("abc123")
--result: true
```

> [!NOTE]
>
> Lua letters are ASCII by default, so non-ASCII letters are not alphanumeric.
>
> ```lua
> isalnum("á1")` --> `false`
> ```

```lua [signature.lua]
---@param s string
---@return boolean
---@nodiscard
function isalnum(s) end
```

:::

#### `isalpha(s)` {#fn-isalphas}

Return true if all characters are alphabetic and string is non-empty.

::: code-group

```lua [example.lua]
local ok = isalpha("abc")
--result: true
```

> [!NOTE]
>
> Lua letters are ASCII by default, so non-ASCII letters are not alphabetic.
>
> ```lua
> isalpha("á")` --> `false`
> ```

```lua [signature.lua]
---@param s string
---@return boolean
---@nodiscard
function isalpha(s) end
```

:::

#### `isascii(s)` {#fn-isasciis}

Return true if all characters are ASCII and string is non-empty.

::: code-group

```lua [example.lua]
local ok = isascii("hello")
--result: true
```

> [!NOTE]
>
> The empty string returns `true`.

```lua [signature.lua]
---@param s string
---@return boolean
---@nodiscard
function isascii(s) end
```

:::

#### `isdecimal(s)` {#fn-isdecimals}

Return true if all characters are decimal characters and string is non-empty.

::: code-group

```lua [example.lua]
local ok = isdecimal("123")
--result: true
```

```lua [signature.lua]
---@param s string
---@return boolean
---@nodiscard
function isdecimal(s) end
```

:::

#### `isdigit(s)` {#fn-isdigits}

Return true if all characters are digits and string is non-empty.

::: code-group

```lua [example.lua]
local ok = isdigit("123")
--result: true
```

```lua [signature.lua]
---@param s string
---@return boolean
---@nodiscard
function isdigit(s) end
```

:::

#### `isidentifier(s)` {#fn-isidentifiers}

Return true if string is a valid identifier and not a reserved keyword.

::: code-group

```lua [example.lua]
local ok = isidentifier("foo_bar")
--result: true

ok = isidentifier("2var")
--result: false

ok = isidentifier("end")
--result: false (keyword)
```

```lua [signature.lua]
---@param s string
---@return boolean
---@nodiscard
function isidentifier(s) end
```

:::

#### `islower(s)` {#fn-islowers}

Return true if all cased characters are lowercase and there is at least one
cased character.

::: code-group

```lua [example.lua]
local ok = islower("hello")
--result: true
```

```lua [signature.lua]
---@param s string
---@return boolean
---@nodiscard
function islower(s) end
```

:::

#### `isnumeric(s)` {#fn-isnumerics}

Return true if all characters are numeric and string is non-empty.

::: code-group

```lua [example.lua]
local ok = isnumeric("123")
--result: true
```

```lua [signature.lua]
---@param s string
---@return boolean
---@nodiscard
function isnumeric(s) end
```

:::

#### `isprintable(s)` {#fn-isprintables}

Return true if all characters are printable and string is non-empty.

::: code-group

```lua [example.lua]
local ok = isprintable("abc!")
--result: true
```

> [!NOTE]
>
> The empty string returns `true`.

```lua [signature.lua]
---@param s string
---@return boolean
---@nodiscard
function isprintable(s) end
```

:::

#### `isspace(s)` {#fn-isspaces}

Return true if all characters are whitespace and string is non-empty.

::: code-group

```lua [example.lua]
local ok = isspace(" \t")
--result: true
```

```lua [signature.lua]
---@param s string
---@return boolean
---@nodiscard
function isspace(s) end
```

:::

#### `istitle(s)` {#fn-istitles}

Return true if string is titlecased.

::: code-group

```lua [example.lua]
local ok = istitle("Hello World")
--result: true
```

```lua [signature.lua]
---@param s string
---@return boolean
---@nodiscard
function istitle(s) end
```

:::

#### `isupper(s)` {#fn-isuppers}

Return true if all cased characters are uppercase and there is at least one
cased character.

::: code-group

```lua [example.lua]
local ok = isupper("HELLO")
--result: true
```

```lua [signature.lua]
---@param s string
---@return boolean
---@nodiscard
function isupper(s) end
```

:::

### Layout

#### `join(sep, ls)` {#fn-joinsep-ls}

Join an iterable of strings using this string as separator.

::: code-group

```lua [example.lua]
local s = join(",", { "a", "b", "c" })
--result: "a,b,c"
```

```lua [signature.lua]
---@param sep string
---@param ls string[]
---@return string
---@nodiscard
function join(sep, ls) end
```

:::

#### `ljust(s, width, fillchar)` {#fn-ljusts-width-fillchar}

Left-justify string in a field of given width.

::: code-group

```lua [example.lua]
local s = ljust("hi", 5, ".")
--result: "hi..."
```

```lua [signature.lua]
---@param s string
---@param width integer
---@param fillchar? string
---@return string
---@nodiscard
function ljust(s, width, fillchar) end
```

:::

#### `lower(s)` {#fn-lowers}

Return lowercased copy.

::: code-group

```lua [example.lua]
local s = lower("HeLLo")
--result: "hello"
```

```lua [signature.lua]
---@param s string
---@return string
---@nodiscard
function lower(s) end
```

:::

#### `lstrip(s, chars)` {#fn-lstrips-chars}

Remove leading characters (default: whitespace).

::: code-group

```lua [example.lua]
local s = lstrip("  hello")
--result: "hello"
```

```lua [signature.lua]
---@param s string
---@param chars? string
---@return string
---@nodiscard
function lstrip(s, chars) end
```

:::

#### `rstrip(s, chars)` {#fn-rstrips-chars}

Remove trailing characters (default: whitespace).

::: code-group

```lua [example.lua]
local s = rstrip("hello  ")
--result: "hello"
```

```lua [signature.lua]
---@param s string
---@param chars? string
---@return string
---@nodiscard
function rstrip(s, chars) end
```

:::

#### `strip(s, chars)` {#fn-strips-chars}

Remove leading and trailing characters (default: whitespace).

::: code-group

```lua [example.lua]
local s = strip("  hello  ")
--result: "hello"
```

```lua [signature.lua]
---@param s string
---@param chars? string
---@return string
---@nodiscard
function strip(s, chars) end
```

:::

### Split & Replace

#### `partition(s, sep)` {#fn-partitions-sep}

Partition string into head, sep, tail from left.

::: code-group

```lua [example.lua]
local a, b, c = partition("a-b-c", "-")
--result: "a", "-", "b-c"
```

```lua [signature.lua]
---@param s string
---@param sep string
---@return string,string,string
---@nodiscard
function partition(s, sep) end
```

:::

#### `removeprefix(s, prefix)` {#fn-removeprefixs-prefix}

Remove prefix if present.

::: code-group

```lua [example.lua]
local s = removeprefix("foobar", "foo")
--result: "bar"
```

```lua [signature.lua]
---@param s string
---@param prefix string
---@return string
---@nodiscard
function removeprefix(s, prefix) end
```

:::

#### `removesuffix(s, suffix)` {#fn-removesuffixs-suffix}

Remove suffix if present.

::: code-group

```lua [example.lua]
local s = removesuffix("foobar", "bar")
--result: "foo"
```

```lua [signature.lua]
---@param s string
---@param suffix string
---@return string
---@nodiscard
function removesuffix(s, suffix) end
```

:::

#### `replace(s, old, new, count)` {#fn-replaces-old-new-count}

Return a copy of the string with all occurrences of a substring replaced.

::: code-group

```lua [example.lua]
local s = replace("a-b-c", "-", "_", 1)
--result: "a_b-c"
```

```lua [signature.lua]
---@param s string
---@param old string
---@param new string
---@param count? integer
---@return string
---@nodiscard
function replace(s, old, new, count) end
```

:::

#### `rfind(s, sub, start, stop)` {#fn-rfinds-sub-start-stop}

Return highest index of substring or nil if not found.

::: code-group

```lua [example.lua]
local i = rfind("ababa", "ba")
--result: 4
```

```lua [signature.lua]
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer?
---@nodiscard
function rfind(s, sub, start, stop) end
```

:::

#### `rindex(s, sub, start, stop)` {#fn-rindexs-sub-start-stop}

Like rfind but raises on failure (placeholder).

::: code-group

```lua [example.lua]
local i = rindex("ababa", "ba")
--result: 4
```

```lua [signature.lua]
---@param s string
---@param sub string
---@param start? integer
---@param stop? integer
---@return integer
---@nodiscard
function rindex(s, sub, start, stop) end
```

:::

#### `rjust(s, width, fillchar)` {#fn-rjusts-width-fillchar}

Right-justify string in a field of given width.

::: code-group

```lua [example.lua]
local s = rjust("hi", 5, ".")
--result: "...hi"
```

```lua [signature.lua]
---@param s string
---@param width integer
---@param fillchar? string
---@return string
---@nodiscard
function rjust(s, width, fillchar) end
```

:::

#### `rpartition(s, sep)` {#fn-rpartitions-sep}

Partition string into head, sep, tail from right.

::: code-group

```lua [example.lua]
local a, b, c = rpartition("a-b-c", "-")
--result: "a-b", "-", "c"
```

```lua [signature.lua]
---@param s string
---@param sep string
---@return string,string,string
---@nodiscard
function rpartition(s, sep) end
```

:::

#### `rsplit(s, sep, maxsplit)` {#fn-rsplits-sep-maxsplit}

Split from the right by separator, up to maxsplit.

::: code-group

```lua [example.lua]
local parts = rsplit("a,b,c", ",", 1)
--result: { "a,b", "c" }
```

```lua [signature.lua]
---@param s string
---@param sep? string
---@param maxsplit? integer
---@return mods.List
---@nodiscard
function rsplit(s, sep, maxsplit) end
```

:::

#### `split(s, sep, maxsplit)` {#fn-splits-sep-maxsplit}

Split by separator (or whitespace) up to maxsplit.

::: code-group

```lua [example.lua]
local parts = split("a,b,c", ",")
--result: { "a", "b", "c" }
```

```lua [signature.lua]
---@param s string
---@param sep? string
---@param maxsplit? integer
---@return mods.List
---@nodiscard
function split(s, sep, maxsplit) end
```

:::

#### `splitlines(s, keepends)` {#fn-splitliness-keepends}

Split on line boundaries.

::: code-group

```lua [example.lua]
local lines = splitlines("a\nb\r\nc")
--result: { "a", "b", "c" }
```

```lua [signature.lua]
---@param s string
---@param keepends? boolean
---@return mods.List
---@nodiscard
function splitlines(s, keepends) end
```

:::

### Casing & Transform

#### `swapcase(s)` {#fn-swapcases}

Return a copy with case of alphabetic characters swapped.

::: code-group

```lua [example.lua]
local s = swapcase("AbC")
--result: "aBc"
```

```lua [signature.lua]
---@param s string
---@return string
---@nodiscard
function swapcase(s) end
```

:::

#### `startswith(s, prefix, start, stop)` {#fn-startswiths-prefix-start-stop}

Return true if string starts with prefix. If prefix is a list, return true if
any prefix matches.

::: code-group

```lua [example.lua]
local ok = startswith("hello.lua", "he")
--result: true
```

```lua [signature.lua]
---@param s string
---@param prefix string|string[]
---@param start? integer
---@param stop? integer
---@return boolean
---@nodiscard
function startswith(s, prefix, start, stop) end
```

:::

#### `title(s)` {#fn-titles}

Return titlecased copy.

::: code-group

```lua [example.lua]
local s = title("hello world")
--result: "Hello World"
```

```lua [signature.lua]
---@param s string
---@return string
---@nodiscard
function title(s) end
```

:::

#### `translate(s, table_map)` {#fn-translates-table_map}

Translate characters using a mapping table.

::: code-group

```lua [example.lua]
local map = { [string.byte("a")] = "b", ["c"] = false }
local s = translate("abc", map)
--result: "bb"
```

```lua [signature.lua]
---@param s string
---@param table_map table
---@return string
---@nodiscard
function translate(s, table_map) end
```

:::

#### `upper(s)` {#fn-uppers}

Return uppercased copy.

::: code-group

```lua [example.lua]
local s = upper("Hello")
--result: "HELLO"
```

```lua [signature.lua]
---@param s string
---@return string
---@nodiscard
function upper(s) end
```

:::

#### `zfill(s, width)` {#fn-zfills-width}

Pad numeric string on the left with zeros.

::: code-group

```lua [example.lua]
local s = zfill("42", 5)
--result: "00042"
```

```lua [signature.lua]
---@param s string
---@param width integer
---@return string
---@nodiscard
function zfill(s, width) end
```

:::
