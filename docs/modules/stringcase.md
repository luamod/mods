---
editLinkTarget: types/stringcase.lua
---

# `stringcase`

String case conversion helpers.

## Quick Reference

**Basic**

| Function                 | Description                      |
| ------------------------ | -------------------------------- |
| [`lower(s)`](#fn-lowers) | Convert string to all lowercase. |
| [`upper(s)`](#fn-uppers) | Convert string to all uppercase. |

**Word Case**

| Function                              | Description                                                           |
| ------------------------------------- | --------------------------------------------------------------------- |
| [`snake(s)`](#fn-snakes)              | Convert string to snake_case.                                         |
| [`camel(s)`](#fn-camels)              | Convert string to camelCase.                                          |
| [`replace(s, sep)`](#fn-replaces-sep) | Normalize to snake_case, then replace underscores with a separator.   |
| [`acronym(s)`](#fn-acronyms)          | Get acronym of words in string (first letters only).                  |
| [`title(s)`](#fn-titles)              | Convert string to Title Case (first letter of each word capitalized). |
| [`constant(s)`](#fn-constants)        | Convert string to CONSTANT_CASE (uppercase snake_case).               |
| [`pascal(s)`](#fn-pascals)            | Convert string to PascalCase.                                         |
| [`kebab(s)`](#fn-kebabs)              | Convert string to kebab-case.                                         |
| [`dot(s)`](#fn-dots)                  | Convert string to dot.case.                                           |
| [`space(s)`](#fn-spaces)              | Convert string to space case (spaces between words).                  |
| [`path(s)`](#fn-paths)                | Convert string to path/case (slashes between words).                  |

**Letter Case**

| Function                       | Description                                                               |
| ------------------------------ | ------------------------------------------------------------------------- |
| [`swap(s)`](#fn-swaps)         | Swap case of each letter.                                                 |
| [`capital(s)`](#fn-capitals)   | Capitalize the first letter and lowercase the rest.                       |
| [`sentence(s)`](#fn-sentences) | Convert string to sentence case (first letter uppercase, rest lowercase). |

## Functions

### Basic

#### `lower(s)` {#fn-lowers}

Convert string to all lowercase.

:::tabs
== Example

```lua
lower("foo_bar-baz") --> "foo_bar-baz"
lower("FooBar baz") --> "foobar baz"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function lower(s) end
```

:::

#### `upper(s)` {#fn-uppers}

Convert string to all uppercase.

:::tabs
== Example

```lua
upper("foo_bar-baz") --> "FOO_BAR-BAZ"
upper("FooBar baz") --> "FOOBAR BAZ"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function upper(s) end
```

:::

### Word Case

#### `snake(s)` {#fn-snakes}

Convert string to snake_case.

:::tabs
== Example

```lua
snake("foo_bar-baz") --> "foo_bar_baz"
snake("FooBar baz") --> "foo_bar_baz"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function snake(s) end
```

:::

#### `camel(s)` {#fn-camels}

Convert string to camelCase.

:::tabs
== Example

```lua
camel("foo_bar-baz") --> "fooBarBaz"
camel("FooBar baz") --> "fooBarBaz"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function camel(s) end
```

:::

#### `replace(s, sep)` {#fn-replaces-sep}

Normalize to snake_case, then replace underscores with a separator.

:::tabs
== Example

```lua
replace("foo_bar-baz", "-") --> "foo-bar-baz"
replace("FooBar baz", "-") --> "foo-bar-baz"
```

== Signature

```lua
---@param s string
---@param sep? string
---@return string
---@nodiscard
function replace(s, sep) end
```

:::

#### `acronym(s)` {#fn-acronyms}

Get acronym of words in string (first letters only).

:::tabs
== Example

```lua
acronym("foo_bar-baz") --> "FBB"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function acronym(s) end
```

:::

#### `title(s)` {#fn-titles}

Convert string to Title Case (first letter of each word capitalized).

:::tabs
== Example

```lua
title("foo_bar-baz") --> "Foo Bar Baz"
title("FooBar baz") --> "Foo Bar Baz"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function title(s) end
```

:::

#### `constant(s)` {#fn-constants}

Convert string to CONSTANT_CASE (uppercase snake_case).

:::tabs
== Example

```lua
constant("foo_bar-baz") --> "FOO_BAR_BAZ"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function constant(s) end
```

:::

#### `pascal(s)` {#fn-pascals}

Convert string to PascalCase.

:::tabs
== Example

```lua
pascal("foo_bar-baz") --> "FooBarBaz"
pascal("FooBar baz") --> "FooBarBaz"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function pascal(s) end
```

:::

#### `kebab(s)` {#fn-kebabs}

Convert string to kebab-case.

:::tabs
== Example

```lua
kebab("foo_bar-baz") --> "foo-bar-baz"
kebab("FooBar baz") --> "foo-bar-baz"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function kebab(s) end
```

:::

#### `dot(s)` {#fn-dots}

Convert string to dot.case.

:::tabs
== Example

```lua
dot("foo_bar-baz") --> "foo.bar.baz"
dot("FooBar baz") --> "foo.bar.baz"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function dot(s) end
```

:::

#### `space(s)` {#fn-spaces}

Convert string to space case (spaces between words).

:::tabs
== Example

```lua
space("foo_bar-baz") --> "foo bar baz"
space("FooBar baz") --> "foo bar baz"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function space(s) end
```

:::

#### `path(s)` {#fn-paths}

Convert string to path/case (slashes between words).

:::tabs
== Example

```lua
path("foo_bar-baz") --> "foo/bar/baz"
path("FooBar baz") --> "foo/bar/baz"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function path(s) end
```

:::

### Letter Case

#### `swap(s)` {#fn-swaps}

Swap case of each letter.

:::tabs
== Example

```lua
swap("foo_bar-baz") --> "FOO_BAR-BAZ"
swap("FooBar baz") --> "fOObAR BAZ"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function swap(s) end
```

:::

#### `capital(s)` {#fn-capitals}

Capitalize the first letter and lowercase the rest.

:::tabs
== Example

```lua
capital("foo_bar-baz") --> "Foo_bar-baz"
capital("FooBar baz") --> "Foobar baz"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function capital(s) end
```

:::

#### `sentence(s)` {#fn-sentences}

Convert string to sentence case (first letter uppercase, rest lowercase).

:::tabs
== Example

```lua
sentence("foo_bar-baz") --> "Foo_bar-baz"
sentence("FooBar baz") --> "FooBar baz"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function sentence(s) end
```

:::
