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

```lua
local s = capitalize("hello WORLD") --> "Hello world"
```

#### `center(s, width, fillchar)` {#fn-centers-width-fillchar}

Center string within width, padded with fill characters.

```lua
local s = center("hi", 6, "-") --> "--hi--"
```

#### `count(s, sub, start, stop)` {#fn-counts-sub-start-stop}

Count non-overlapping occurrences of a substring.

```lua
local n = count("aaaa", "aa") --> 2
n = count("aaaa", "a", 2, -1) --> 2
n = count("abcd", "") --> 5
```

#### `endswith(s, suffix, start, stop)` {#fn-endswiths-suffix-start-stop}

Return true if string ends with suffix. If suffix is a list, return true if any
suffix matches.

```lua
local ok = endswith("hello.lua", ".lua") --> true
```

#### `expandtabs(s, tabsize)` {#fn-expandtabss-tabsize}

Expand tabs to spaces using given tabsize.

```lua
local s = expandtabs("a\tb", 4) --> "a   b"
```

#### `find(s, sub, start, stop)` {#fn-finds-sub-start-stop}

Return lowest index of substring or nil if not found.

```lua
local i = find("hello", "ll") --> 3
```

#### `format_map(s, mapping)` {#fn-format_maps-mapping}

Format string with mapping (key-based) replacement.

```lua
local s = format_map("hi {name}", { name = "bob" }) --> "hi bob"
```

### Predicates

#### `isalnum(s)` {#fn-isalnums}

Return true if all characters are alphanumeric and string is non-empty.

```lua
local ok = isalnum("abc123") --> true
```

> [!NOTE]
>
> Lua letters are ASCII by default, so non-ASCII letters are not alphanumeric.
>
> ```lua
> isalnum("á1")` --> `false`
> ```

#### `isalpha(s)` {#fn-isalphas}

Return true if all characters are alphabetic and string is non-empty.

```lua
local ok = isalpha("abc") --> true
```

> [!NOTE]
>
> Lua letters are ASCII by default, so non-ASCII letters are not alphabetic.
>
> ```lua
> isalpha("á")` --> `false`
> ```

#### `isascii(s)` {#fn-isasciis}

Return true if all characters are ASCII and string is non-empty.

```lua
local ok = isascii("hello") --> true
```

> [!NOTE]
>
> The empty string returns `true`.

#### `isdecimal(s)` {#fn-isdecimals}

Return true if all characters are decimal characters and string is non-empty.

```lua
local ok = isdecimal("123") --> true
```

#### `isdigit(s)` {#fn-isdigits}

Return true if all characters are digits and string is non-empty.

```lua
local ok = isdigit("123") --> true
```

#### `isidentifier(s)` {#fn-isidentifiers}

Return true if string is a valid identifier and not a reserved keyword.

```lua
local ok = isidentifier("foo_bar") --> true
ok = isidentifier("2var") --> false
ok = isidentifier("end") --> false (keyword)
```

#### `islower(s)` {#fn-islowers}

Return true if all cased characters are lowercase and there is at least one
cased character.

```lua
local ok = islower("hello") --> true
```

#### `isnumeric(s)` {#fn-isnumerics}

Return true if all characters are numeric and string is non-empty.

```lua
local ok = isnumeric("123") --> true
```

#### `isprintable(s)` {#fn-isprintables}

Return true if all characters are printable and string is non-empty.

```lua
local ok = isprintable("abc!") --> true
```

> [!NOTE]
>
> The empty string returns `true`.

#### `isspace(s)` {#fn-isspaces}

Return true if all characters are whitespace and string is non-empty.

```lua
local ok = isspace(" \t") --> true
```

#### `istitle(s)` {#fn-istitles}

Return true if string is titlecased.

```lua
local ok = istitle("Hello World") --> true
```

#### `isupper(s)` {#fn-isuppers}

Return true if all cased characters are uppercase and there is at least one
cased character.

```lua
local ok = isupper("HELLO") --> true
```

### Layout

#### `join(sep, ls)` {#fn-joinsep-ls}

Join an iterable of strings using this string as separator.

```lua
local s = join(",", { "a", "b", "c" }) --> "a,b,c"
```

#### `ljust(s, width, fillchar)` {#fn-ljusts-width-fillchar}

Left-justify string in a field of given width.

```lua
local s = ljust("hi", 5, ".") --> "hi..."
```

#### `lower(s)` {#fn-lowers}

Return lowercased copy.

```lua
local s = lower("HeLLo") --> "hello"
```

#### `lstrip(s, chars)` {#fn-lstrips-chars}

Remove leading characters (default: whitespace).

```lua
local s = lstrip("  hello") --> "hello"
```

#### `rstrip(s, chars)` {#fn-rstrips-chars}

Remove trailing characters (default: whitespace).

```lua
local s = rstrip("hello  ") --> "hello"
```

#### `strip(s, chars)` {#fn-strips-chars}

Remove leading and trailing characters (default: whitespace).

```lua
local s = strip("  hello  ") --> "hello"
```

### Split & Replace

#### `partition(s, sep)` {#fn-partitions-sep}

Partition string into head, sep, tail from left.

```lua
local a, b, c = partition("a-b-c", "-") --> "a", "-", "b-c"
```

#### `removeprefix(s, prefix)` {#fn-removeprefixs-prefix}

Remove prefix if present.

```lua
local s = removeprefix("foobar", "foo") --> "bar"
```

#### `removesuffix(s, suffix)` {#fn-removesuffixs-suffix}

Remove suffix if present.

```lua
local s = removesuffix("foobar", "bar") --> "foo"
```

#### `replace(s, old, new, count)` {#fn-replaces-old-new-count}

Return a copy of the string with all occurrences of a substring replaced.

```lua
local s = replace("a-b-c", "-", "_", 1) --> "a_b-c"
```

#### `rfind(s, sub, start, stop)` {#fn-rfinds-sub-start-stop}

Return highest index of substring or nil if not found.

```lua
local i = rfind("ababa", "ba") --> 4
```

#### `rindex(s, sub, start, stop)` {#fn-rindexs-sub-start-stop}

Like rfind but raises on failure (placeholder).

```lua
local i = rindex("ababa", "ba") --> 4
```

#### `rjust(s, width, fillchar)` {#fn-rjusts-width-fillchar}

Right-justify string in a field of given width.

```lua
local s = rjust("hi", 5, ".") --> "...hi"
```

#### `rpartition(s, sep)` {#fn-rpartitions-sep}

Partition string into head, sep, tail from right.

```lua
local a, b, c = rpartition("a-b-c", "-") --> "a-b", "-", "c"
```

#### `rsplit(s, sep, maxsplit)` {#fn-rsplits-sep-maxsplit}

Split from the right by separator, up to maxsplit.

```lua
local parts = rsplit("a,b,c", ",", 1) --> { "a,b", "c" }
```

#### `split(s, sep, maxsplit)` {#fn-splits-sep-maxsplit}

Split by separator (or whitespace) up to maxsplit.

```lua
local parts = split("a,b,c", ",") --> { "a", "b", "c" }
```

#### `splitlines(s, keepends)` {#fn-splitliness-keepends}

Split on line boundaries.

```lua
local lines = splitlines("a\nb\r\nc") --> { "a", "b", "c" }
```

### Casing & Transform

#### `swapcase(s)` {#fn-swapcases}

Return a copy with case of alphabetic characters swapped.

```lua
local s = swapcase("AbC") --> "aBc"
```

#### `startswith(s, prefix, start, stop)` {#fn-startswiths-prefix-start-stop}

Return true if string starts with prefix. If prefix is a list, return true if
any prefix matches.

```lua
local ok = startswith("hello.lua", "he") --> true
```

#### `title(s)` {#fn-titles}

Return titlecased copy.

```lua
local s = title("hello world") --> "Hello World"
```

#### `translate(s, table_map)` {#fn-translates-table_map}

Translate characters using a mapping table.

```lua
local map = { [string.byte("a")] = "b", ["c"] = false }
local s = translate("abc", map) --> "bb"
```

#### `upper(s)` {#fn-uppers}

Return uppercased copy.

```lua
local s = upper("Hello") --> "HELLO"
```

#### `zfill(s, width)` {#fn-zfills-width}

Pad numeric string on the left with zeros.

```lua
local s = zfill("42", 5) --> "00042"
```
