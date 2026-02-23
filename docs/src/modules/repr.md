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
print(repr(view)) --> {
--                      user = {
--                        name = "Ada",
--                        tags = {
--                          [1] = "lua",
--                          [2] = "docs"
--                        }
--                      }
--                    }

```
