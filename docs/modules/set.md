# Set

`mods.Set` provides common operations for set values.

## Usage

```lua
local Set = require("mods.Set")

local s = Set({ "a", "b", "a" })
local n = s:len()
-- n == 2
```

## Quick Reference

| Function | Description |
| --- | --- |
| [`isdisjoint(set)`](#fn-isdisjointset) | Return true if sets have no elements in common. |
| [`isempty()`](#fn-isempty) | Return true if the set has no elements. |
| [`issubset(set)`](#fn-issubsetset) | Return true if all elements of this set are also in another set. |
| [`issuperset(set)`](#fn-issupersetset) | Return true if this set contains all elements of another set. |
| [`len()`](#fn-len) | Return the number of elements in the set. |
| [`copy()`](#fn-copy) | Return a shallow copy of the set. |
| [`difference(set)`](#fn-differenceset) | Return elements in this set but not in another. |
| [`intersection(set)`](#fn-intersectionset) | Return elements common to both sets. |
| [`map(fn)`](#fn-mapfn) | Return a new set by mapping each value. |
| [`symmetric_difference(set)`](#fn-symmetric_differenceset) | Return elements not shared by both sets. |
| [`union(set)`](#fn-unionset) | Return a new set with all elements from both. |
| [`values()`](#fn-values) | Return a list of all values in the set. |
| [`add(v)`](#fn-addv) | Add an element to the set. |
| [`clear()`](#fn-clear) | Remove all elements from the set. |
| [`difference_update(set)`](#fn-difference_updateset) | Remove elements found in another set (in place). |
| [`discard(v)`](#fn-discardv) | Remove an element if present, do nothing otherwise. |
| [`intersection_update(set)`](#fn-intersection_updateset) | Keep only elements common to both sets (in place). |
| [`pop()`](#fn-pop) | Remove and return an arbitrary element. |
| [`symmetric_difference_update(set)`](#fn-symmetric_difference_updateset) | Update the set with elements not shared by both (in place). |
| [`update(set)`](#fn-updateset) | Add all elements from another set (in place). |

## Methods

### Query

<a id="fn-isdisjointset"></a>
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

<a id="fn-isempty"></a>
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

<a id="fn-issubsetset"></a>
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

<a id="fn-issupersetset"></a>
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

<a id="fn-len"></a>
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

<a id="fn-copy"></a>
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

<a id="fn-differenceset"></a>
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

<a id="fn-intersectionset"></a>
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

<a id="fn-mapfn"></a>
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

<a id="fn-symmetric_differenceset"></a>
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

<a id="fn-unionset"></a>
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

<a id="fn-values"></a>
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

<a id="fn-addv"></a>
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

<a id="fn-clear"></a>
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

<a id="fn-difference_updateset"></a>
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

<a id="fn-discardv"></a>
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

<a id="fn-intersection_updateset"></a>
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

<a id="fn-pop"></a>
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

<a id="fn-symmetric_difference_updateset"></a>
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

<a id="fn-updateset"></a>
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
