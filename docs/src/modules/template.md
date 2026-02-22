---
desc:
  "Render lightweight templates with dot-path placeholders and function-aware
  values."
---

# `template`

Render lightweight templates with dot-path placeholders and function-aware
values.

## Usage

```lua
template = require "mods.template"

view = {
  user = { name = "World" },
}

out = template("Hello {{user.name}}!", view) --> "Hello World!"
```

## Rules

- Placeholders use <code v-pre>{{name}}</code>.

```lua
template("Hi {{name}}", { name = "Ada" }) --> "Hi Ada"
```

- Whitespace inside placeholders is ignored.

```lua
template("Hi {{ name }}", { name = "Ada" }) --> "Hi Ada"
```

- Dot paths are supported.

```lua
template("Role: {{user.meta.role}}", {
  user = { meta = { role = "Engineer" } },
}) --> "Role: Engineer"
```

- <code v-pre>{{.}}</code> resolves to the whole `view`.

```lua
template("Value: {{.}}", 123) --> "Value: 123"
```

- Function values are called and their return value is rendered.

```lua
template("Hi {{name_func}}", { name_func = function() return "Ada" end })
--> "Hi Ada"
```

- Table values render as first-depth key/value pairs. String values are quoted;
  nested tables/functions are summarized.

```lua
template("Data: {{data}}", { data = { a = 1, b = true } })
--> {
--     a = 1,
--     b = true
--  }
```

- Missing keys render as an empty string.

```lua
template("Missing: {{unknown}}", {}) --> "Missing: "
```

- If a tag is not closed (<code v-pre>{{name</code>), it is emitted as-is.

```lua
template("Hi {{name", { name = "Ada" }) --> "Hi {{name"
```

- `template(view)` is shorthand for <code v-pre>template("{{.}}", view)</code>.

```lua
template({ a = 1, b = true })
--> {
--    a = 1,
--    b = true
--  }
```
