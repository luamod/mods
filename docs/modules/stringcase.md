---
description:
  Convert strings across naming conventions like snake_case, camelCase, and
  kebab-case.
---

# `stringcase`

String case conversion helpers.

## Import

```lua
local sc = require("mods.stringcase")
```

## Usage

```lua
local s = "FooBar baz"

sc.snake(s) --> "foo_bar_baz"
sc.camel(s) --> "fooBarBaz"
sc.kebab(s) --> "foo-bar-baz"
sc.title(s) --> "Foo Bar Baz"
```

## Quick Reference

**Quick Reference: Basic**:

| Function                 | Description                      |
| ------------------------ | -------------------------------- |
| [`lower(s)`](#fn-lowers) | Convert string to all lowercase. |
| [`upper(s)`](#fn-uppers) | Convert string to all uppercase. |

**Quick Reference: Word Case**:

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

**Quick Reference: Letter Case**:

| Function                       | Description                                                               |
| ------------------------------ | ------------------------------------------------------------------------- |
| [`swap(s)`](#fn-swaps)         | Swap case of each letter.                                                 |
| [`capital(s)`](#fn-capitals)   | Capitalize the first letter and lowercase the rest.                       |
| [`sentence(s)`](#fn-sentences) | Convert string to sentence case (first letter uppercase, rest lowercase). |

## Functions

### Basic

#### `lower(s)` {#fn-lowers}

Convert string to all lowercase.

```lua
sc.lower("foo_bar-baz") --> "foo_bar-baz"
sc.lower("FooBar baz") --> "foobar baz"
```

#### `upper(s)` {#fn-uppers}

Convert string to all uppercase.

```lua
sc.upper("foo_bar-baz") --> "FOO_BAR-BAZ"
sc.upper("FooBar baz") --> "FOOBAR BAZ"
```

### Word Case

#### `snake(s)` {#fn-snakes}

Convert string to snake_case.

```lua
sc.snake("foo_bar-baz") --> "foo_bar_baz"
sc.snake("FooBar baz") --> "foo_bar_baz"
```

#### `camel(s)` {#fn-camels}

Convert string to camelCase.

```lua
sc.camel("foo_bar-baz") --> "fooBarBaz"
sc.camel("FooBar baz") --> "fooBarBaz"
```

#### `replace(s, sep)` {#fn-replaces-sep}

Normalize to snake_case, then replace underscores with a separator.

```lua
sc.replace("foo_bar-baz", "-") --> "foo-bar-baz"
sc.replace("FooBar baz", "-") --> "foo-bar-baz"
```

#### `acronym(s)` {#fn-acronyms}

Get acronym of words in string (first letters only).

```lua
sc.acronym("foo_bar-baz") --> "FBB"
```

#### `title(s)` {#fn-titles}

Convert string to Title Case (first letter of each word capitalized).

```lua
sc.title("foo_bar-baz") --> "Foo Bar Baz"
sc.title("FooBar baz") --> "Foo Bar Baz"
```

#### `constant(s)` {#fn-constants}

Convert string to CONSTANT_CASE (uppercase snake_case).

```lua
sc.constant("foo_bar-baz") --> "FOO_BAR_BAZ"
```

#### `pascal(s)` {#fn-pascals}

Convert string to PascalCase.

```lua
sc.pascal("foo_bar-baz") --> "FooBarBaz"
sc.pascal("FooBar baz") --> "FooBarBaz"
```

#### `kebab(s)` {#fn-kebabs}

Convert string to kebab-case.

```lua
sc.kebab("foo_bar-baz") --> "foo-bar-baz"
sc.kebab("FooBar baz") --> "foo-bar-baz"
```

#### `dot(s)` {#fn-dots}

Convert string to dot.case.

```lua
sc.dot("foo_bar-baz") --> "foo.bar.baz"
sc.dot("FooBar baz") --> "foo.bar.baz"
```

#### `space(s)` {#fn-spaces}

Convert string to space case (spaces between words).

```lua
sc.space("foo_bar-baz") --> "foo bar baz"
sc.space("FooBar baz") --> "foo bar baz"
```

#### `path(s)` {#fn-paths}

Convert string to path/case (slashes between words).

```lua
sc.path("foo_bar-baz") --> "foo/bar/baz"
sc.path("FooBar baz") --> "foo/bar/baz"
```

### Letter Case

#### `swap(s)` {#fn-swaps}

Swap case of each letter.

```lua
sc.swap("foo_bar-baz") --> "FOO_BAR-BAZ"
sc.swap("FooBar baz") --> "fOObAR BAZ"
```

#### `capital(s)` {#fn-capitals}

Capitalize the first letter and lowercase the rest.

```lua
sc.capital("foo_bar-baz") --> "Foo_bar-baz"
sc.capital("FooBar baz") --> "Foobar baz"
```

#### `sentence(s)` {#fn-sentences}

Convert string to sentence case (first letter uppercase, rest lowercase).

```lua
sc.sentence("foo_bar-baz") --> "Foo_bar-baz"
sc.sentence("FooBar baz") --> "FooBar baz"
```
