---
desc:
  "A Python-style set class providing common operations to create, modify, and
  query collections of unique values."
---

# `Set`

A Python-style set class providing common operations to create, modify, and
query collections of unique values.

## Usage

```lua
Set = require "mods.Set"

s = Set({ "a" })
print(s:contains("a")) --> true
```

## Dependencies

Dependencies below are lazy-loaded 💤 on first access.

- [`mods.tbl`](https://luamod.github.io/mods/modules/tbl)

## Functions

**Mutation**:

| Function                                                      | Description                                                 |
| ------------------------------------------------------------- | ----------------------------------------------------------- |
| [`add`](#add)                                                 | Add an element to the set.                                  |
| [`clear`](#clear)                                             | Remove all elements from the set.                           |
| [`difference_update`](#difference-update)                     | Remove elements found in another set (in place).            |
| [`intersection_update`](#intersection-update)                 | Keep only elements common to both sets (in place).          |
| [`pop`](#pop)                                                 | Remove and return an arbitrary element.                     |
| [`symmetric_difference_update`](#symmetric-difference-update) | Update the set with elements not shared by both (in place). |
| [`update`](#update)                                           | Add all elements from another set (in place).               |

**Copying**:

| Function                                        | Description                                         |
| ----------------------------------------------- | --------------------------------------------------- |
| [`copy`](#copy)                                 | Return a shallow copy of the set.                   |
| [`difference`](#difference)                     | Return elements in this set but not in another.     |
| [`intersection`](#intersection)                 | Return elements common to both sets.                |
| [`remove`](#remove)                             | Remove an element if present, do nothing otherwise. |
| [`symmetric_difference`](#symmetric-difference) | Return elements not shared by both sets.            |
| [`union`](#union)                               | Return a new set with all elements from both.       |

**Predicates**:

| Function                    | Description                                                      |
| --------------------------- | ---------------------------------------------------------------- |
| [`isdisjoint`](#isdisjoint) | Return true if sets have no elements in common.                  |
| [`isempty`](#isempty)       | Return true if the set has no elements.                          |
| [`issubset`](#issubset)     | Return true if all elements of this set are also in another set. |
| [`issuperset`](#issuperset) | Return true if this set contains all elements of another set.    |

**Query**:

| Function                | Description                               |
| ----------------------- | ----------------------------------------- |
| [`contains`](#contains) | Return true if the set contains `v`.      |
| [`len`](#len)           | Return the number of elements in the set. |

**Transform**:

| Function            | Description                             |
| ------------------- | --------------------------------------- |
| [`map`](#map)       | Return a new set by mapping each value. |
| [`values`](#values) | Return a list of all values in the set. |

### Mutation

In-place operations that mutate the current set.

#### `add`

Add an element to the set.

```lua
s = Set({ "a" }):add("b") --> s contains "a", "b"
```

#### `clear`

Remove all elements from the set.

```lua
s = Set({ "a", "b" }):clear() --> s is empty
```

#### `difference_update`

Remove elements found in another set (in place).

```lua
s = Set({ "a", "b" }):difference_update(Set({ "b" })) --> s contains "a"
```

#### `intersection_update`

Keep only elements common to both sets (in place).

```lua
s = Set({ "a", "b" }):intersection_update(Set({ "b", "c" }))
--> s contains "b"
```

#### `pop`

Remove and return an arbitrary element.

```lua
v = Set({ "a", "b" }):pop() --> v is either "a" or "b"
```

#### `symmetric_difference_update`

Update the set with elements not shared by both (in place).

```lua
s = Set({ "a", "b" }):symmetric_difference_update(Set({ "b", "c" }))
--> s contains "a", "c"
```

#### `update`

Add all elements from another set (in place).

```lua
s = Set({ "a" }):update(Set({ "b" })) --> s contains "a", "b"
```

### Copying

Non-mutating set operations that return new set instances.

#### `copy`

Return a shallow copy of the set.

```lua
c = Set({ "a" }):copy() --> c is a new set with "a"
```

#### `difference`

Return elements in this set but not in another.

```lua
d = Set({ "a", "b" }):difference(Set({ "b" })) --> d contains "a"
```

#### `intersection`

Return elements common to both sets.

```lua
i = Set({ "a", "b" }):intersection(Set({ "b", "c" })) --> i contains "b"
```

#### `remove`

Remove an element if present, do nothing otherwise.

```lua
s = Set({ "a", "b" }):remove("b") --> s contains "a"
```

#### `symmetric_difference`

Return elements not shared by both sets.

```lua
d = Set({ "a", "b" }):symmetric_difference(Set({ "b", "c" }))
--> d contains "a", "c"
```

#### `union`

Return a new set with all elements from both.

```lua
s = Set({ "a" }):union(Set({ "b" })) --> s contains "a", "b"
```

### Predicates

Boolean checks about set relationships and emptiness.

#### `isdisjoint`

Return true if sets have no elements in common.

```lua
ok = Set({ "a" }):isdisjoint(Set({ "b" })) --> true
```

#### `isempty`

Return true if the set has no elements.

```lua
empty = Set({}):isempty() --> true
```

#### `issubset`

Return true if all elements of this set are also in another set.

```lua
ok = Set({ "a" }):issubset(Set({ "a", "b" })) --> true
```

#### `issuperset`

Return true if this set contains all elements of another set.

```lua
ok = Set({ "a", "b" }):issuperset(Set({ "a" })) --> true
```

### Query

Read-only queries for membership and size.

#### `contains`

Return true if the set contains `v`.

```lua
ok = Set({ "a", "b" }):contains("a") --> true
ok = Set({ "a", "b" }):contains("z") --> false
```

#### `len`

Return the number of elements in the set.

```lua
n = Set({ "a", "b" }):len() --> 2
```

### Transform

Value-to-value transformations and projection helpers.

#### `map`

Return a new set by mapping each value.

```lua
s = Set({ 1, 2 }):map(function(v) return v * 10 end) --> s contains 10, 20
```

#### `values`

Return a list of all values in the set.

```lua
values = Set({ "a", "b" }):values() --> { "a", "b" }
```
