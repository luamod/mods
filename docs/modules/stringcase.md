---
editLinkTarget: types/stringcase.lua
---

# stringcase

String case conversion helpers.

## Quick Reference

| Function                              | Description                                                               |
| ------------------------------------- | ------------------------------------------------------------------------- |
| [`lower(s)`](#fn-lowers)              | Convert string to all lowercase.                                          |
| [`upper(s)`](#fn-uppers)              | Convert string to all uppercase.                                          |
| [`snake(s)`](#fn-snakes)              | Convert string to snake_case.                                             |
| [`camel(s)`](#fn-camels)              | Convert string to camelCase.                                              |
| [`replace(s, sep)`](#fn-replaces-sep) | Replace underscores in snake_case with a given separator (default empty). |
| [`acronym(s)`](#fn-acronyms)          | Get acronym of words in string (first letters only).                      |
| [`title(s)`](#fn-titles)              | Convert string to Title Case (first letter of each word capitalized).     |
| [`constant(s)`](#fn-constants)        | Convert string to CONSTANT_CASE (uppercase snake_case).                   |
| [`pascal(s)`](#fn-pascals)            | Convert string to PascalCase.                                             |
| [`kebab(s)`](#fn-kebabs)              | Convert string to kebab-case.                                             |
| [`dot(s)`](#fn-dots)                  | Convert string to dot.case.                                               |
| [`space(s)`](#fn-spaces)              | Convert string to space case (spaces between words).                      |
| [`path(s)`](#fn-paths)                | Convert string to path/case (slashes between words).                      |
| [`swap(s)`](#fn-swaps)                | Swap case of each letter.                                                 |
| [`capital(s)`](#fn-capitals)          | Capitalize the first letter and lowercase the rest.                       |
| [`sentence(s)`](#fn-sentences)        | Convert string to sentence case (first letter uppercase, rest lowercase). |

## Functions

#### `lower(s)` {#fn-lowers}

Convert string to all lowercase.

:::tabs
== Example

```lua
lower("Hello World") --> "hello world"
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
upper("Hello World") --> "HELLO WORLD"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function upper(s) end
```

:::

#### `snake(s)` {#fn-snakes}

Convert string to snake_case.

:::tabs
== Example

```lua
snake("Hello World") --> "hello_world"
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
camel("Hello World") --> "helloWorld"
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

Replace underscores in snake_case with a given separator (default empty).

:::tabs
== Example

```lua
replace("hello_world", "-") --> "hello-world"
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
acronym("Hyper Text Markup Language") --> "HTML"
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
title("hello world") --> "Hello World"
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
constant("hello world") --> "HELLO_WORLD"
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
pascal("hello world") --> "HelloWorld"
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
kebab("hello world") --> "hello-world"
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
dot("hello world") --> "hello.world"
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
space("hello_world") --> "hello world"
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
path("hello world") --> "hello/world"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function path(s) end
```

:::

#### `swap(s)` {#fn-swaps}

Swap case of each letter.

:::tabs
== Example

```lua
swap("Hello World") --> "hELLO wORLD"
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
capital("hELLO") --> "Hello"
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
sentence("hELLO WORLD") --> "Hello world"
```

== Signature

```lua
---@param s string
---@return string
---@nodiscard
function sentence(s) end
```

:::
