---@meta mods.template

---Render a simple template using the provided context.
---Supports nested paths (`{{user.name}}`), trims placeholder whitespace,
---invokes function values, and renders missing keys as an empty string.
---For more info, see [template docs](https://luamod.github.io/mods/modules/template).
---
---```lua
---local template = require("mods.template")
---
---local view = {
---  user = { name = "Ada" },
---  count = 3,
---}
---
---local out = template("Hello {{user.name}}!", view)
-----result: "Hello Ada!"
---
---out = template("You have {{count}} new messages.", view)
-----result: "You have 3 new messages."
---
---out = template("Role: {{ user.role }}", { user = { role = "Engineer" } })
-----result: "Role: Engineer"
---
---out = template('Missing key: "{{missing}}"', view)
-----result: 'Missing key: ""'
---```
---@alias mods.template fun(template:string,view:table):string

---@type mods.template
local render

return render
