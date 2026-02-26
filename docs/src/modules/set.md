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
| [`equals`](#equals)         | Return true when both sets contain exactly the same members.     |
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

**Metamethods**:

| Function          | Description                                                                |
| ----------------- | -------------------------------------------------------------------------- |
| [`__add`](#add)   | Return the union of two sets using `+`.                                    |
| [`__bor`](#bor)   | Return the union of two sets using `\|`.                                   |
| [`__band`](#band) | Return the intersection of two sets using `&`.                             |
| [`__bxor`](#bxor) | Return elements present in exactly one set using `^`.                      |
| [`__eq`](#eq)     | Return true if both sets contain exactly the same members using `==`.      |
| [`__le`](#le)     | Return true if the left set is a subset of the right set using `<=`.       |
| [`__lt`](#lt)     | Return true if the left set is a proper subset of the right set using `<`. |
| [`__sub`](#sub)   | Return the difference of two sets using `-`.                               |

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

> [!NOTE]
>
> `difference` is also available as the `__sub` (`-`) operator.
> `a:difference(b)` is equivalent to `a - b`.

#### `intersection`

Return elements common to both sets.

```lua
i = Set({ "a", "b" }):intersection(Set({ "b", "c" })) --> i contains "b"
```

> [!NOTE]
>
> `intersection` is also available as `__band` (`&`) on Lua 5.3+.

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

> [!NOTE]
>
> `symmetric_difference` is also available as `__bxor` (`^`) on Lua 5.3+.

#### `union`

Return a new set with all elements from both.

```lua
s = Set({ "a" }):union(Set({ "b" })) --> s contains "a", "b"
```

> [!NOTE]
>
> `union` is available as `__add` (`+`) and `__bor` (`|`) on Lua 5.3+.
> `a:union(b)` is equivalent to `a + b` and `a | b`.

### Predicates

Boolean checks about set relationships and emptiness.

#### `isdisjoint`

Return true if sets have no elements in common.

```lua
ok = Set({ "a" }):isdisjoint(Set({ "b" })) --> true
```

#### `equals`

Return true when both sets contain exactly the same members.

```lua
a = Set({ "a", "b" })
b = Set({ "b", "a" })
ok = a:equals(b) --> true
```

> [!NOTE]
>
> `equals` is also available as the `__eq` (`==`) operator. `a:equals(b)` is
> equivalent to `a == b`.

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

> [!NOTE]
>
> `issubset` is also available as the `__le` (`<=`) operator. `a:issubset(b)` is
> equivalent to `a <= b`.

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

### Metamethods

#### `__add`

Return the union of two sets using `+`.

```lua
a = Set({ "a", "b" })
b = Set({ "b", "c" })
u = a + b --> { a = true, b = true, c = true }
```

> [!NOTE]
>
> `__add` is the operator form of `:union(set)`.

#### `__bor`

Return the union of two sets using `|`.

```lua
a = Set({ "a", "b" })
b = Set({ "b", "c" })
u = a | b --> { a = true, b = true, c = true }
```

> [!NOTE]
>
> `__bor` is the operator form of `:union(set)` on Lua 5.3+.

#### `__band`

Return the intersection of two sets using `&`.

```lua
a = Set({ "a", "b" })
b = Set({ "b", "c" })
i = a & b --> { b = true }
```

> [!NOTE]
>
> `__band` is the operator form of `:intersection(set)` on Lua 5.3+.

#### `__bxor`

Return elements present in exactly one set using `^`.

```lua
a = Set({ "a", "b" })
b = Set({ "b", "c" })
d = a ^ b --> { a = true, c = true }
```

> [!NOTE]
>
> `__bxor` is the operator form of `:symmetric_difference(set)` on Lua 5.3+.

#### `__eq`

Return true if both sets contain exactly the same members using `==`.

```lua
ok = Set({ "a", "b" }) == Set({ "b", "a" }) --> true
```

> [!NOTE]
>
> `__eq` is the operator form of `:equals(set)`.

#### `__le`

Return true if the left set is a subset of the right set using `<=`.

```lua
a = Set({ "a" })
b = Set({ "a", "b" })
ok = a <= b --> true
```

> [!NOTE]
>
> `__le` is the operator form of `:issubset(set)`.

#### `__lt`

Return true if the left set is a proper subset of the right set using `<`.

```lua
a = Set({ "a" })
b = Set({ "a", "b" })
ok = a < b --> true
```

#### `__sub`

Return the difference of two sets using `-`.

```lua
a = Set({ "a", "b" })
b = Set({ "b", "c" })
d = a - b --> { a = true }
```

> [!NOTE]
>
> `__sub` is the operator form of `:difference(set)`.
