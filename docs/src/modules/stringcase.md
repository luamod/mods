---
desc: "String case conversion helpers."
---

# `stringcase`

String case conversion helpers.

## Usage

```lua
sc = require "mods.stringcase"

print(stringcase.snake("FooBar")) --> "foo_bar"
```

## Functions

**Basic**:

| Function          | Description                      |
| ----------------- | -------------------------------- |
| [`lower`](#lower) | Convert string to all lowercase. |
| [`upper`](#upper) | Convert string to all uppercase. |

**Word Case**:

| Function                | Description                                                           |
| ----------------------- | --------------------------------------------------------------------- |
| [`snake`](#snake)       | Convert string to snake_case.                                         |
| [`camel`](#camel)       | Convert string to camelCase.                                          |
| [`replace`](#replace)   | Normalize to snake_case, then replace underscores with a separator.   |
| [`acronym`](#acronym)   | Get acronym of words in string (first letters only).                  |
| [`title`](#title)       | Convert string to Title Case (first letter of each word capitalized). |
| [`constant`](#constant) | Convert string to CONSTANT_CASE (uppercase snake_case).               |
| [`pascal`](#pascal)     | Convert string to PascalCase.                                         |
| [`kebab`](#kebab)       | Convert string to kebab-case.                                         |
| [`dot`](#dot)           | Convert string to dot.case.                                           |
| [`space`](#space)       | Convert string to space case (spaces between words).                  |
| [`path`](#path)         | Convert string to path/case (slashes between words).                  |

**Letter Case**:

| Function                | Description                                                               |
| ----------------------- | ------------------------------------------------------------------------- |
| [`swap`](#swap)         | Swap case of each letter.                                                 |
| [`capital`](#capital)   | Capitalize the first letter and lowercase the rest.                       |
| [`sentence`](#sentence) | Convert string to sentence case (first letter uppercase, rest lowercase). |

### Basic

#### `lower`

Convert string to all lowercase.

```lua
lower("foo_bar-baz") --> "foo_bar-baz"
lower("FooBar baz")  --> "foobar baz"
```

#### `upper`

Convert string to all uppercase.

```lua
upper("foo_bar-baz") --> "FOO_BAR-BAZ"
upper("FooBar baz")  --> "FOOBAR BAZ"
```

### Word Case

#### `snake`

Convert string to snake_case.

```lua
snake("foo_bar-baz") --> "foo_bar_baz"
snake("FooBar baz")  --> "foo_bar_baz"
```

#### `camel`

Convert string to camelCase.

```lua
camel("foo_bar-baz") --> "fooBarBaz"
camel("FooBar baz")  --> "fooBarBaz"
```

#### `replace`

Normalize to snake_case, then replace underscores with a separator.

```lua
replace("foo_bar-baz", "-") --> "foo-bar-baz"
replace("FooBar baz", "-")  --> "foo-bar-baz"
```

#### `acronym`

Get acronym of words in string (first letters only).

```lua
acronym("foo_bar-baz") --> "FBB"
acronym("FooBar baz")  --> "FBB"
```

#### `title`

Convert string to Title Case (first letter of each word capitalized).

```lua
title("foo_bar-baz") --> "Foo Bar Baz"
title("FooBar baz")  --> "Foo Bar Baz"
```

#### `constant`

Convert string to CONSTANT_CASE (uppercase snake_case).

```lua
constant("foo_bar-baz") --> "FOO_BAR_BAZ"
constant("FooBar baz")  --> "FOO_BAR_BAZ"
```

#### `pascal`

Convert string to PascalCase.

```lua
pascal("foo_bar-baz") --> "FooBarBaz"
pascal("FooBar baz")  --> "FooBarBaz"
```

#### `kebab`

Convert string to kebab-case.

```lua
kebab("foo_bar-baz") --> "foo-bar-baz"
kebab("FooBar baz")  --> "foo-bar-baz"
```

#### `dot`

Convert string to dot.case.

```lua
dot("foo_bar-baz") --> "foo.bar.baz"
dot("FooBar baz")  --> "foo.bar.baz"
```

#### `space`

Convert string to space case (spaces between words).

```lua
space("foo_bar-baz") --> "foo bar baz"
space("FooBar baz")  --> "foo bar baz"
```

#### `path`

Convert string to path/case (slashes between words).

```lua
path("foo_bar-baz") --> "foo/bar/baz"
path("FooBar baz")  --> "foo/bar/baz"
```

### Letter Case

#### `swap`

Swap case of each letter.

```lua
swap("foo_bar-baz") --> "FOO_BAR-BAZ"
swap("FooBar baz")  --> "fOObAR BAZ"
```

#### `capital`

Capitalize the first letter and lowercase the rest.

```lua
capital("foo_bar-baz") --> "Foo_bar-baz"
capital("FooBar baz")  --> "Foobar baz"
```

#### `sentence`

Convert string to sentence case (first letter uppercase, rest lowercase).

```lua
sentence("foo_bar-baz") --> "Foo_bar-baz"
sentence("FooBar baz")  --> "FooBar baz"
```
