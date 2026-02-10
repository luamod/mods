---@meta mods.template

---Render a simple template with the given view.
---
---**example:**
---```lua
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
---out = template('Missing key: "{{missing}}"', view)
-----result: 'Missing key: ""'
---```
---@param template string
---@param view? table
---@return string
---@nodiscard
local function render(template, view) end

return render
