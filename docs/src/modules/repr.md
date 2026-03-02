---
desc: "Render any Lua value as a readable string."
---

# `repr`

Render any Lua value as a readable string.

## Usage

```lua
repr = require "mods.repr"

print(repr("Hello world!")) --> "Hello world!"

view = { user = { name = "Ada", tags = { "lua", "docs" } } }
print(repr(view))
--> {
--    user = {
--      name = "Ada",
--      tags = {
--        [1] = "lua",
--        [2] = "docs"
--      }
--    }
--  }
```

<a id="fn-repr"></a>

## `repr(v)`

Convert a Lua value to a readable string representation.

**Parameters**:

- `v` (`any`): Value to render.

**Return**:

- `out` (`string`): Readable string representation.

**Example**:

```lua
repr("Hello")      --> '"Hello"'
repr({ "a", "b" }) --> '{ "a", "b" }'
repr()             --> "nil"
```
