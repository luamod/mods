---
editLinkTarget: types/stringcase.lua
---

# stringcase

`mods.stringcase` Convert string to all lowercase.

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

<a id="fn-lowers"></a>

#### `lower(s)`

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
function lower(s) end
```

:::

<a id="fn-uppers"></a>

#### `upper(s)`

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
function upper(s) end
```

:::

<a id="fn-snakes"></a>

#### `snake(s)`

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
function snake(s) end
```

:::

<a id="fn-camels"></a>

#### `camel(s)`

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
function camel(s) end
```

:::

<a id="fn-replaces-sep"></a>

#### `replace(s, sep)`

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
function replace(s, sep) end
```

:::

<a id="fn-acronyms"></a>

#### `acronym(s)`

Get acronym of words in string (first letters only).

:::tabs
== Example

```lua
M.acronym("Hyper Text Markup Language") --> "HTML"
```

== Signature

```lua
---@param s string
---@return string
function acronym(s) end
```

:::

<a id="fn-titles"></a>

#### `title(s)`

Convert string to Title Case (first letter of each word capitalized).

:::tabs
== Example

```lua
M.title("hello world") --> "Hello World"
```

== Signature

```lua
---@param s string
---@return string
function title(s) end
```

:::

<a id="fn-constants"></a>

#### `constant(s)`

Convert string to CONSTANT_CASE (uppercase snake_case).

:::tabs
== Example

```lua
M.constant("hello world") --> "HELLO_WORLD"
```

== Signature

```lua
---@param s string
---@return string
function constant(s) end
```

:::

<a id="fn-pascals"></a>

#### `pascal(s)`

Convert string to PascalCase.

:::tabs
== Example

```lua
M.pascal("hello world") --> "HelloWorld"
```

== Signature

```lua
---@param s string
---@return string
function pascal(s) end
```

:::

<a id="fn-kebabs"></a>

#### `kebab(s)`

Convert string to kebab-case.

:::tabs
== Example

```lua
M.kebab("hello world") --> "hello-world"
```

== Signature

```lua
---@param s string
---@return string
function kebab(s) end
```

:::

<a id="fn-dots"></a>

#### `dot(s)`

Convert string to dot.case.

:::tabs
== Example

```lua
M.dot("hello world") --> "hello.world"
```

== Signature

```lua
---@param s string
---@return string
function dot(s) end
```

:::

<a id="fn-spaces"></a>

#### `space(s)`

Convert string to space case (spaces between words).

:::tabs
== Example

```lua
M.space("hello_world") --> "hello world"
```

== Signature

```lua
---@param s string
---@return string
function space(s) end
```

:::

<a id="fn-paths"></a>

#### `path(s)`

Convert string to path/case (slashes between words).

:::tabs
== Example

```lua
M.path("hello world") --> "hello/world"
```

== Signature

```lua
---@param s string
---@return string
function path(s) end
```

:::

<a id="fn-swaps"></a>

#### `swap(s)`

Swap case of each letter.

:::tabs
== Example

```lua
M.swap("Hello World") --> "hELLO wORLD"
```

== Signature

```lua
---@param s string
---@return string
function swap(s) end
```

:::

<a id="fn-capitals"></a>

#### `capital(s)`

Capitalize the first letter and lowercase the rest.

:::tabs
== Example

```lua
M.capital("hELLO") --> "Hello"
```

== Signature

```lua
---@param s string
---@return string
function capital(s) end
```

:::

<a id="fn-sentences"></a>

#### `sentence(s)`

Convert string to sentence case (first letter uppercase, rest lowercase).

:::tabs
== Example

```lua
M.sentence("hELLO WORLD") --> "Hello world"
```

== Signature

```lua
---@param s string
---@return string
function sentence(s) end
```

:::
