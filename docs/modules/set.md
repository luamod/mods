---
title: Set
description:
  Python-style Set API for unique-value operations, predicates, and set algebra.
---

# `Set`

A Python-style set class providing common operations to create, modify, and
query collections of unique values.

## Quick Reference

**Mutation**

| Function                                                                 | Description                                                 |
| ------------------------------------------------------------------------ | ----------------------------------------------------------- |
| [`add(v)`](#fn-addv)                                                     | Add an element to the set.                                  |
| [`clear()`](#fn-clear)                                                   | Remove all elements from the set.                           |
| [`difference_update(set)`](#fn-difference_updateset)                     | Remove elements found in another set (in place).            |
| [`discard(v)`](#fn-discardv)                                             | Remove an element if present, do nothing otherwise.         |
| [`intersection_update(set)`](#fn-intersection_updateset)                 | Keep only elements common to both sets (in place).          |
| [`pop()`](#fn-pop)                                                       | Remove and return an arbitrary element.                     |
| [`symmetric_difference_update(set)`](#fn-symmetric_difference_updateset) | Update the set with elements not shared by both (in place). |
| [`update(set)`](#fn-updateset)                                           | Add all elements from another set (in place).               |

**Copying**

| Function             | Description                       |
| -------------------- | --------------------------------- |
| [`copy()`](#fn-copy) | Return a shallow copy of the set. |

**Set Operations**

| Function                                                   | Description                                     |
| ---------------------------------------------------------- | ----------------------------------------------- |
| [`difference(set)`](#fn-differenceset)                     | Return elements in this set but not in another. |
| [`intersection(set)`](#fn-intersectionset)                 | Return elements common to both sets.            |
| [`symmetric_difference(set)`](#fn-symmetric_differenceset) | Return elements not shared by both sets.        |
| [`union(set)`](#fn-unionset)                               | Return a new set with all elements from both.   |

**Predicates**

| Function                               | Description                                                      |
| -------------------------------------- | ---------------------------------------------------------------- |
| [`isdisjoint(set)`](#fn-isdisjointset) | Return true if sets have no elements in common.                  |
| [`isempty()`](#fn-isempty)             | Return true if the set has no elements.                          |
| [`issubset(set)`](#fn-issubsetset)     | Return true if all elements of this set are also in another set. |
| [`issuperset(set)`](#fn-issupersetset) | Return true if this set contains all elements of another set.    |

**Query**

| Function           | Description                               |
| ------------------ | ----------------------------------------- |
| [`len()`](#fn-len) | Return the number of elements in the set. |

**Transform**

| Function                 | Description                             |
| ------------------------ | --------------------------------------- |
| [`map(fn)`](#fn-mapfn)   | Return a new set by mapping each value. |
| [`values()`](#fn-values) | Return a list of all values in the set. |

## Functions

### Mutation

#### `add(v)` {#fn-addv}

Add an element to the set.

:::tabs

== Example

```lua
local s = Set({ "a" })
s:add("b")
-- result: s contains "a", "b"
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@param v any
---@return T self
function add(v) end
```

:::

#### `clear()` {#fn-clear}

Remove all elements from the set.

:::tabs

== Example

```lua
local s = Set({ "a", "b" })
s:clear()
-- result: s is empty
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@return T self
function clear() end
```

:::

#### `difference_update(set)` {#fn-difference_updateset}

Remove elements found in another set (in place).

:::tabs

== Example

```lua
local s = Set({ "a", "b" })
s:difference_update(Set({ "b" }))
-- result: s contains "a"
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return T self
function difference_update(set) end
```

:::

#### `discard(v)` {#fn-discardv}

Remove an element if present, do nothing otherwise.

:::tabs

== Example

```lua
local s = Set({ "a", "b" })
s:discard("b")
-- result: s contains "a"
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@param v any
---@return T self
function discard(v) end
```

:::

#### `intersection_update(set)` {#fn-intersection_updateset}

Keep only elements common to both sets (in place).

:::tabs

== Example

```lua
local s = Set({ "a", "b" })
s:intersection_update(Set({ "b", "c" }))
-- result: s contains "b"
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return T self
function intersection_update(set) end
```

:::

#### `pop()` {#fn-pop}

Remove and return an arbitrary element.

:::tabs

== Example

```lua
local v = Set({ "a", "b" }):pop()
-- result: v is either "a" or "b"
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@return any
function pop() end
```

:::

#### `symmetric_difference_update(set)` {#fn-symmetric_difference_updateset}

Update the set with elements not shared by both (in place).

:::tabs

== Example

```lua
local s = Set({ "a", "b" })
s:symmetric_difference_update(Set({ "b", "c" }))
-- result: s contains "a", "c"
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return T self
function symmetric_difference_update(set) end
```

:::

#### `update(set)` {#fn-updateset}

Add all elements from another set (in place).

:::tabs

== Example

```lua
local s = Set({ "a" })
s:update(Set({ "b" }))
-- result: s contains "a", "b"
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return T self
function update(set) end
```

:::

### Copying

#### `copy()` {#fn-copy}

Return a shallow copy of the set.

:::tabs

== Example

```lua
local s = Set({ "a" })
local c = s:copy()
-- result: c is a new set with "a"
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@return T set
---@nodiscard
function copy() end
```

:::

### Set Operations

#### `difference(set)` {#fn-differenceset}

Return elements in this set but not in another.

:::tabs

== Example

```lua
local s = Set({ "a", "b" })
local d = s:difference(Set({ "b" }))
-- result: d contains "a"
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return T set
---@nodiscard
function difference(set) end
```

:::

#### `intersection(set)` {#fn-intersectionset}

Return elements common to both sets.

:::tabs

== Example

```lua
local s = Set({ "a", "b" })
local i = s:intersection(Set({ "b", "c" }))
-- result: i contains "b"
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return T set
---@nodiscard
function intersection(set) end
```

:::

#### `symmetric_difference(set)` {#fn-symmetric_differenceset}

Return elements not shared by both sets.

:::tabs

== Example

```lua
local s = Set({ "a", "b" })
local d = s:symmetric_difference(Set({ "b", "c" }))
-- result: d contains "a", "c"
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return T set
---@nodiscard
function symmetric_difference(set) end
```

:::

#### `union(set)` {#fn-unionset}

Return a new set with all elements from both.

:::tabs

== Example

```lua
local s = Set({ "a" }):union(Set({ "b" }))
-- result: s contains "a", "b"
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return T set
---@nodiscard
function union(set) end
```

:::

### Predicates

#### `isdisjoint(set)` {#fn-isdisjointset}

Return true if sets have no elements in common.

:::tabs

== Example

```lua
local ok = Set({ "a" }):isdisjoint(Set({ "b" }))
-- result: true
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return boolean
---@nodiscard
function isdisjoint(set) end
```

:::

#### `isempty()` {#fn-isempty}

Return true if the set has no elements.

:::tabs

== Example

```lua
local empty = Set({}):isempty()
-- result: true
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@return boolean
---@nodiscard
function isempty() end
```

:::

#### `issubset(set)` {#fn-issubsetset}

Return true if all elements of this set are also in another set.

:::tabs

== Example

```lua
local ok = Set({ "a" }):issubset(Set({ "a", "b" }))
-- result: true
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return boolean
---@nodiscard
function issubset(set) end
```

:::

#### `issuperset(set)` {#fn-issupersetset}

Return true if this set contains all elements of another set.

:::tabs

== Example

```lua
local ok = Set({ "a", "b" }):issuperset(Set({ "a" }))
-- result: true
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@param set T
---@return boolean
---@nodiscard
function issuperset(set) end
```

:::

### Query

#### `len()` {#fn-len}

Return the number of elements in the set.

:::tabs

== Example

```lua
local n = Set({ "a", "b" }):len()
-- result: 2
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@return integer
---@nodiscard
function len() end
```

:::

### Transform

#### `map(fn)` {#fn-mapfn}

Return a new set by mapping each value.

:::tabs

== Example

```lua
local s = Set({ 1, 2 }):map(function(v) return v * 10 end)
-- result: s contains 10, 20
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@param fn fun(v:any):any
---@return T set
---@nodiscard
function map(fn) end
```

:::

#### `values()` {#fn-values}

Return a list of all values in the set.

:::tabs

== Example

```lua
local values = Set({ "a", "b" }):values()
-- result: { "a", "b" }
```

== Signature

```lua
---@generic T:mods.Set|table<any,true>
---@param self T
---@return mods.List|any[] values
---@nodiscard
function values() end
```

:::
