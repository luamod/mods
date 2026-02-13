---
title: template
description: Render lightweight templates with dot-path placeholders and function-aware values.
---

# `template`

Render a simple template using the provided context.

## Import

```lua
local mods = require("mods")
local template = mods.template
```

## Usage

```lua
local view = {
  user = {
    name = "Ada",
    meta = { role = "Engineer" },
    name_func = function()
      return "Ada"
    end,
  },
  count = 3,
  name_func = function()
    return "Ada"
  end,
}

local out = template("Hello {{user.name}}!", view)
-- result: "Hello Ada!"

out = template(view)
-- result:
-- {
--   count=3,
--   name_func=<function>,
--   user={...}
-- }

out = template("You have {{count}} new messages.", view)
-- result: "You have 3 new messages."

out = template('Missing key: "{{missing}}"', view)
-- result: 'Missing key: ""'

out = template("Role: {{ user.meta.role }}", view)
-- result: "Role: Engineer"

out = template("Hi {{name_func}}", view)
-- result: "Hi Ada"

out = template("Stats: {{stats}}", { stats = { count = 3, ok = true } })
-- result:
-- Stats: {
--   count=3,
--   ok=true
-- }
```

## Rules

- Placeholders use <code v-pre>{{name}}</code>.

  ```lua
  template("Hi {{name}}", { name = "Ada" })
  -- result: "Hi Ada"
  ```

- Whitespace inside placeholders is ignored.

  ```lua
  template("Hi {{ name }}", { name = "Ada" })
  -- result: "Hi Ada"
  ```

- Dot paths are supported.

  ```lua
  template("Role: {{user.meta.role}}", {
    user = { meta = { role = "Engineer" } },
  }) -- result: "Role: Engineer"
  ```

- <code v-pre>{{.}}</code> resolves to the whole `view`.

  ```lua
  template("Value: {{.}}", 123)
  -- result: "Value: 123"
  ```

- Function values are called and their return value is rendered.

  ```lua
  template("Hi {{name_func}}", {
    name_func = function()
      return "Ada"
    end,
  }) -- result: "Hi Ada"
  ```

- Table values render as first-depth key/value pairs.
  String values are quoted; nested tables/functions are summarized.

  ```lua
  template("Data: {{data}}", { data = { a = 1, b = true } })
  -- result:
  -- Data: {
  --   a=1,
  --   b=true
  -- }
  ```

- Missing keys render as an empty string.

  ```lua
  template("Missing: {{unknown}}", {})
  -- result: "Missing: "
  ```

- If a tag is not closed (<code v-pre>{{name</code>), it is emitted as-is.

  ```lua
  template("Hi {{name", { name = "Ada" })
  -- result: "Hi {{name"
  ```

- `template(view)` is shorthand for <code v-pre>template("{{.}}", view)</code>.

  ```lua
  template({ a = 1, b = true })
  -- result:
  -- {
  --   a=1,
  --   b=true
  -- }
  ```
