# Set

`mods.Set` provides common operations for set values.

## Usage

```lua
local Set = require("mods.Set")
```

## Methods

### Query

#### `isdisjoint(set)`

Return true if sets have no elements in common.

:::tabs
== Example

```lua
local ok = Set({ "a" }):isdisjoint(Set({ "b" }))
-- result: true
```

== Type

```lua
---@param set mods.Set
---@return boolean
---@nodiscard
function isdisjoint(set) end
```
:::

#### `isempty()`

Return true if the set has no elements.

:::tabs
== Example

```lua
local empty = Set({}):isempty()
-- result: true
```

== Type

```lua
---@return boolean
---@nodiscard
function isempty() end
```
:::

#### `issubset(set)`

Return true if all elements of this set are also in another set.

:::tabs
== Example

```lua
local ok = Set({ "a" }):issubset(Set({ "a", "b" }))
-- result: true
```

== Type

```lua
---@param set mods.Set
---@return boolean
---@nodiscard
function issubset(set) end
```
:::

#### `issuperset(set)`

Return true if this set contains all elements of another set.

:::tabs
== Example

```lua
local ok = Set({ "a", "b" }):issuperset(Set({ "a" }))
-- result: true
```

== Type

```lua
---@param set mods.Set
---@return boolean
---@nodiscard
function issuperset(set) end
```
:::

#### `len()`

Return the number of elements in the set.

:::tabs
== Example

```lua
local n = Set({ "a", "b" }):len()
-- result: 2
```

== Type

```lua
---@return integer
---@nodiscard
function len() end
```
:::

### Transform

#### `copy()`

Return a shallow copy of the set.

:::tabs
== Example

```lua
local s = Set({ "a" })
local c = s:copy()
-- result: c is a new set with "a"
```

== Type

```lua
---@return mods.Set
---@nodiscard
function copy() end
```
:::

#### `difference(set)`

Return elements in this set but not in another.

:::tabs
== Example

```lua
local s = Set({ "a", "b" })
local d = s:difference(Set({ "b" }))
-- result: d contains "a"
```

== Type

```lua
---@param set mods.Set
---@return mods.Set
---@nodiscard
function difference(set) end
```
:::

#### `intersection(set)`

Return elements common to both sets.

:::tabs
== Example

```lua
local s = Set({ "a", "b" })
local i = s:intersection(Set({ "b", "c" }))
-- result: i contains "b"
```

== Type

```lua
---@param set mods.Set
---@return mods.Set
---@nodiscard
function intersection(set) end
```
:::

#### `map(fn)`

Return a new set by mapping each value.

:::tabs
== Example

```lua
local s = Set({ 1, 2 }):map(function(v) return v * 10 end)
-- result: s contains 10, 20
```

== Type

```lua
---@param fn fun(v:T):any
---@return mods.Set
---@nodiscard
function map(fn) end
```
:::

#### `symmetric_difference(set)`

Return elements not shared by both sets.

:::tabs
== Example

```lua
local s = Set({ "a", "b" })
local d = s:symmetric_difference(Set({ "b", "c" }))
-- result: d contains "a", "c"
```

== Type

```lua
---@param set mods.Set
---@return mods.Set
---@nodiscard
function symmetric_difference(set) end
```
:::

#### `union(set)`

Return a new set with all elements from both.

:::tabs
== Example

```lua
local s = Set({ "a" }):union(Set({ "b" }))
-- result: s contains "a", "b"
```

== Type

```lua
---@param set mods.Set
---@return mods.Set
---@nodiscard
function union(set) end
```
:::

#### `values()`

Return a list of all values in the set.

:::tabs
== Example

```lua
local values = Set({ "a", "b" }):values()
-- result: { "a", "b" }
```

== Type

```lua
---@return mods.List values
---@nodiscard
function values() end
```
:::

### In-place

#### `add(v)`

Add an element to the set.

:::tabs
== Example

```lua
local s = Set({ "a" })
s:add("b")
-- result: s contains "a", "b"
```

== Type

```lua
---@param v any
---@return self self
function add(v) end
```
:::

#### `clear()`

Remove all elements from the set.

:::tabs
== Example

```lua
local s = Set({ "a", "b" })
s:clear()
-- result: s is empty
```

== Type

```lua
---@return self self
function clear() end
```
:::

#### `difference_update(set)`

Remove elements found in another set (in place).

:::tabs
== Example

```lua
local s = Set({ "a", "b" })
s:difference_update(Set({ "b" }))
-- result: s contains "a"
```

== Type

```lua
---@param set self
---@return self self
function difference_update(set) end
```
:::

#### `discard(v)`

Remove an element if present, do nothing otherwise.

:::tabs
== Example

```lua
local s = Set({ "a", "b" })
s:discard("b")
-- result: s contains "a"
```

== Type

```lua
---@param v any
---@return self self
function discard(v) end
```
:::

#### `intersection_update(set)`

Keep only elements common to both sets (in place).

:::tabs
== Example

```lua
local s = Set({ "a", "b" })
s:intersection_update(Set({ "b", "c" }))
-- result: s contains "b"
```

== Type

```lua
---@param set mods.Set
---@return self self
function intersection_update(set) end
```
:::

#### `pop()`

Remove and return an arbitrary element.

:::tabs
== Example

```lua
local v = Set({ "a", "b" }):pop()
-- result: v is either "a" or "b"
```

== Type

```lua
---@return any
function pop() end
```
:::

#### `symmetric_difference_update(set)`

Update the set with elements not shared by both (in place).

:::tabs
== Example

```lua
local s = Set({ "a", "b" })
s:symmetric_difference_update(Set({ "b", "c" }))
-- result: s contains "a", "c"
```

== Type

```lua
---@param set self
---@return self self
function symmetric_difference_update(set) end
```
:::

#### `update(set)`

Add all elements from another set (in place).

:::tabs
== Example

```lua
local s = Set({ "a" })
s:update(Set({ "b" }))
-- result: s contains "a", "b"
```

== Type

```lua
---@param set mods.Set
---@return self self
function update(set) end
```
:::
