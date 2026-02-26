---
desc: "String utility helpers modeled after Python's `str`."
---

# `str`

String utility helpers modeled after Python's `str`.

## Usage

```lua
str = require "mods.str"

print(str.capitalize("hello world")) --> "Hello world"
```

## Functions

**Formatting**:

| Function                    | Description                                                           |
| --------------------------- | --------------------------------------------------------------------- |
| [`capitalize`](#capitalize) | Return copy with first character capitalized and the rest lowercased. |
| [`center`](#center)         | Center string within width, padded with fill characters.              |
| [`count`](#count)           | Count non-overlapping occurrences of a substring.                     |
| [`endswith`](#endswith)     | Return true if string ends with suffix.                               |
| [`expandtabs`](#expandtabs) | Expand tabs to spaces using given tabsize.                            |
| [`find`](#find)             | Return lowest index of substring or nil if not found.                 |
| [`format_map`](#format-map) | Format string with mapping (key-based) replacement.                   |

**Predicates**:

| Function                        | Description                                                                                  |
| ------------------------------- | -------------------------------------------------------------------------------------------- |
| [`isalnum`](#isalnum)           | Return true if all characters are alphanumeric and string is non-empty.                      |
| [`isalpha`](#isalpha)           | Return true if all characters are alphabetic and string is non-empty.                        |
| [`isascii`](#isascii)           | Return true if all characters are ASCII and string is non-empty.                             |
| [`isdecimal`](#isdecimal)       | Return true if all characters are decimal characters and string is non-empty.                |
| [`isdigit`](#isdigit)           | Return true if all characters are digits and string is non-empty.                            |
| [`isidentifier`](#isidentifier) | Return true if string is a valid identifier and not a reserved keyword.                      |
| [`islower`](#islower)           | Return true if all cased characters are lowercase and there is at least one cased character. |
| [`isnumeric`](#isnumeric)       | Return true if all characters are numeric and string is non-empty.                           |
| [`isprintable`](#isprintable)   | Return true if all characters are printable and string is non-empty.                         |
| [`isspace`](#isspace)           | Return true if all characters are whitespace and string is non-empty.                        |
| [`istitle`](#istitle)           | Return true if string is titlecased.                                                         |
| [`isupper`](#isupper)           | Return true if all cased characters are uppercase and there is at least one cased character. |

**Layout**:

| Function            | Description                                                   |
| ------------------- | ------------------------------------------------------------- |
| [`join`](#join)     | Join an iterable of strings using this string as separator.   |
| [`ljust`](#ljust)   | Left-justify string in a field of given width.                |
| [`lower`](#lower)   | Return lowercased copy.                                       |
| [`lstrip`](#lstrip) | Remove leading characters (default: whitespace).              |
| [`rstrip`](#rstrip) | Remove trailing characters (default: whitespace).             |
| [`strip`](#strip)   | Remove leading and trailing characters (default: whitespace). |

**Split & Replace**:

| Function                        | Description                                                               |
| ------------------------------- | ------------------------------------------------------------------------- |
| [`partition`](#partition)       | Partition string into head, sep, tail from left.                          |
| [`removeprefix`](#removeprefix) | Remove prefix if present.                                                 |
| [`removesuffix`](#removesuffix) | Remove suffix if present.                                                 |
| [`replace`](#replace)           | Return a copy of the string with all occurrences of a substring replaced. |
| [`rfind`](#rfind)               | Return highest index of substring or nil if not found.                    |
| [`rindex`](#rindex)             | Like rfind but raises on failure (placeholder).                           |
| [`rjust`](#rjust)               | Right-justify string in a field of given width.                           |
| [`rpartition`](#rpartition)     | Partition string into head, sep, tail from right.                         |
| [`rsplit`](#rsplit)             | Split from the right by separator, up to maxsplit.                        |
| [`split`](#split)               | Split by separator (or whitespace) up to maxsplit.                        |
| [`splitlines`](#splitlines)     | Split on line boundaries.                                                 |

**Casing & Transform**:

| Function                    | Description                                               |
| --------------------------- | --------------------------------------------------------- |
| [`swapcase`](#swapcase)     | Return a copy with case of alphabetic characters swapped. |
| [`startswith`](#startswith) | Return true if string starts with prefix.                 |
| [`title`](#title)           | Return titlecased copy.                                   |
| [`translate`](#translate)   | Translate characters using a mapping table.               |
| [`upper`](#upper)           | Return uppercased copy.                                   |
| [`zfill`](#zfill)           | Pad numeric string on the left with zeros.                |

### Formatting

#### `capitalize`

Return copy with first character capitalized and the rest lowercased.

```lua
s = capitalize("hello WORLD")
--result: "Hello world"
```

#### `center`

Center string within width, padded with fill characters.

```lua
s = center("hi", 6, "-")
--result: "--hi--"
```

#### `count`

Count non-overlapping occurrences of a substring.

```lua
n = count("aaaa", "aa")
--result: 2

n = count("aaaa", "a", 2, -1)
--result: 2

n = count("abcd", "")
--result: 5
```

#### `endswith`

Return true if string ends with suffix.

> [!NOTE]
>
> If suffix is a list, returns `true` when any suffix matches.

```lua
ok = endswith("hello.lua", ".lua")
--result: true
```

#### `expandtabs`

Expand tabs to spaces using given tabsize.

```lua
s = expandtabs("a\tb", 4)
--result: "a   b"
```

#### `find`

Return lowest index of substring or nil if not found.

```lua
i = find("hello", "ll")
--result: 3
```

#### `format_map`

Format string with mapping (key-based) replacement.

```lua
s = format_map("hi {name}", { name = "bob" })
--result: "hi bob"
```

### Predicates

#### `isalnum`

Return true if all characters are alphanumeric and string is non-empty.

```lua
ok = isalnum("abc123")
--result: true
```

> [!NOTE]
>
> Lua letters are ASCII by default, so non-ASCII letters are not alphanumeric.
>
> ```lua
> isalnum("á1")` --> `false`
> ```

#### `isalpha`

Return true if all characters are alphabetic and string is non-empty.

```lua
ok = isalpha("abc")
--result: true
```

> [!NOTE]
>
> Lua letters are ASCII by default, so non-ASCII letters are not alphabetic.
>
> ```lua
> isalpha("á")` --> `false`
> ```

#### `isascii`

Return true if all characters are ASCII and string is non-empty.

```lua
ok = isascii("hello")
--result: true
```

> [!NOTE]
>
> The empty string returns `true`.

#### `isdecimal`

Return true if all characters are decimal characters and string is non-empty.

```lua
ok = isdecimal("123")
--result: true
```

#### `isdigit`

Return true if all characters are digits and string is non-empty.

```lua
ok = isdigit("123")
--result: true
```

#### `isidentifier`

Return true if string is a valid identifier and not a reserved keyword.

```lua
ok = isidentifier("foo_bar")
--result: true

ok = isidentifier("2var")
--result: false

ok = isidentifier("end")
--result: false (keyword)
```

#### `islower`

Return true if all cased characters are lowercase and there is at least one
cased character.

```lua
ok = islower("hello")
--result: true
```

#### `isnumeric`

Return true if all characters are numeric and string is non-empty.

```lua
ok = isnumeric("123")
--result: true
```

#### `isprintable`

Return true if all characters are printable and string is non-empty.

```lua
ok = isprintable("abc!")
--result: true
```

> [!NOTE]
>
> The empty string returns `true`.

#### `isspace`

Return true if all characters are whitespace and string is non-empty.

```lua
ok = isspace(" \t")
--result: true
```

#### `istitle`

Return true if string is titlecased.

```lua
ok = istitle("Hello World")
--result: true
```

#### `isupper`

Return true if all cased characters are uppercase and there is at least one
cased character.

```lua
ok = isupper("HELLO")
--result: true
```

### Layout

#### `join`

Join an iterable of strings using this string as separator.

```lua
s = join(",", { "a", "b", "c" })
--result: "a,b,c"
```

#### `ljust`

Left-justify string in a field of given width.

```lua
s = ljust("hi", 5, ".")
--result: "hi..."
```

#### `lower`

Return lowercased copy.

```lua
s = lower("HeLLo")
--result: "hello"
```

#### `lstrip`

Remove leading characters (default: whitespace).

```lua
s = lstrip("  hello")
--result: "hello"
```

#### `rstrip`

Remove trailing characters (default: whitespace).

```lua
s = rstrip("hello  ")
--result: "hello"
```

#### `strip`

Remove leading and trailing characters (default: whitespace).

```lua
s = strip("  hello  ")
--result: "hello"
```

### Split & Replace

#### `partition`

Partition string into head, sep, tail from left.

```lua
a, b, c = partition("a-b-c", "-")
--result: "a", "-", "b-c"
```

#### `removeprefix`

Remove prefix if present.

```lua
s = removeprefix("foobar", "foo")
--result: "bar"
```

#### `removesuffix`

Remove suffix if present.

```lua
s = removesuffix("foobar", "bar")
--result: "foo"
```

#### `replace`

Return a copy of the string with all occurrences of a substring replaced.

```lua
s = replace("a-b-c", "-", "_", 1)
--result: "a_b-c"
```

#### `rfind`

Return highest index of substring or nil if not found.

```lua
i = rfind("ababa", "ba")
--result: 4
```

#### `rindex`

Like rfind but raises on failure (placeholder).

```lua
i = rindex("ababa", "ba")
--result: 4
```

#### `rjust`

Right-justify string in a field of given width.

```lua
s = rjust("hi", 5, ".")
--result: "...hi"
```

#### `rpartition`

Partition string into head, sep, tail from right.

```lua
a, b, c = rpartition("a-b-c", "-")
--result: "a-b", "-", "c"
```

#### `rsplit`

Split from the right by separator, up to maxsplit.

```lua
parts = rsplit("a,b,c", ",", 1)
--result: { "a,b", "c" }
```

#### `split`

Split by separator (or whitespace) up to maxsplit.

```lua
parts = split("a,b,c", ",")
--result: { "a", "b", "c" }
```

#### `splitlines`

Split on line boundaries.

```lua
lines = splitlines("a\nb\r\nc")
--result: { "a", "b", "c" }
```

### Casing & Transform

#### `swapcase`

Return a copy with case of alphabetic characters swapped.

```lua
s = swapcase("AbC")
--result: "aBc"
```

#### `startswith`

Return true if string starts with prefix.

> [!NOTE]
>
> If prefix is a list, returns `true` when any prefix matches.

```lua
ok = startswith("hello.lua", "he")
--result: true
```

#### `title`

Return titlecased copy.

```lua
s = title("hello world")
--result: "Hello World"
```

#### `translate`

Translate characters using a mapping table.

```lua
map = { [string.byte("a")] = "b", ["c"] = false }
s = translate("abc", map)
--result: "bb"
```

#### `upper`

Return uppercased copy.

```lua
s = upper("Hello")
--result: "HELLO"
```

#### `zfill`

Pad numeric string on the left with zeros.

```lua
s = zfill("42", 5)
--result: "00042"
```
