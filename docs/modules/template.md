---
editLinkTarget: types/template.lua
---

# `template`

Render a simple template using the provided context.

**example:**

```lua
local view = {
 user = { name = "Ada" },
 count = 3,
}

local out = template("Hello {{user.name}}!", view)
--result: "Hello Ada!"

out = template("You have {{count}} new messages.", view)
--result: "You have 3 new messages."

out = template('Missing key: "{{missing}}"', view)
--result: 'Missing key: ""'
```
