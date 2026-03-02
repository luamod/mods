---
desc:
  "A set class providing common operations to create, modify, and query
  collections of unique values."
---

# `Set`

A set class providing common operations to create, modify, and query collections
of unique values.

## Usage

```lua
Set = require "mods.Set"

s = Set({ "a" })
print(s:contains("a")) --> true
```

## Functions

**Mutation**:

| Function                                                              | Description                                                 |
| --------------------------------------------------------------------- | ----------------------------------------------------------- |
| [`add(v)`](#fn-add)                                                   | Add an element to the set.                                  |
| [`clear()`](#fn-clear)                                                | Remove all elements from the set.                           |
| [`difference_update(set)`](#fn-difference-update)                     | Remove elements found in another set (in place).            |
| [`intersection_update(set)`](#fn-intersection-update)                 | Keep only elements common to both sets (in place).          |
| [`pop()`](#fn-pop)                                                    | Remove and return an arbitrary element.                     |
| [`symmetric_difference_update(set)`](#fn-symmetric-difference-update) | Update the set with elements not shared by both (in place). |
| [`update(set)`](#fn-update)                                           | Add all elements from another set (in place).               |

**Copying**:

| Function                                                | Description                                         |
| ------------------------------------------------------- | --------------------------------------------------- |
| [`copy()`](#fn-copy)                                    | Return a shallow copy of the set.                   |
| [`difference(set)`](#fn-difference)                     | Return elements in this set but not in another.     |
| [`intersection(set)`](#fn-intersection)                 | Return elements common to both sets.                |
| [`remove(v)`](#fn-remove)                               | Remove an element if present, do nothing otherwise. |
| [`symmetric_difference(set)`](#fn-symmetric-difference) | Return elements not shared by both sets.            |
| [`union(set)`](#fn-union)                               | Return a new set with all elements from both.       |

**Predicates**:

| Function                            | Description                                                      |
| ----------------------------------- | ---------------------------------------------------------------- |
| [`isdisjoint(set)`](#fn-isdisjoint) | Return true if sets have no elements in common.                  |
| [`equals(set)`](#fn-equals)         | Return true when both sets contain exactly the same members.     |
| [`isempty()`](#fn-isempty)          | Return true if the set has no elements.                          |
| [`issubset(set)`](#fn-issubset)     | Return true if all elements of this set are also in another set. |
| [`issuperset(set)`](#fn-issuperset) | Return true if this set contains all elements of another set.    |

**Query**:

| Function                      | Description                               |
| ----------------------------- | ----------------------------------------- |
| [`contains(v)`](#fn-contains) | Return true if the set contains `v`.      |
| [`len()`](#fn-len)            | Return the number of elements in the set. |

**Transform**:

| Function                 | Description                             |
| ------------------------ | --------------------------------------- |
| [`map(fn)`](#fn-map)     | Return a new set by mapping each value. |
| [`values()`](#fn-values) | Return a list of all values in the set. |

**Metamethods**:

| Function                  | Description                                                                |
| ------------------------- | -------------------------------------------------------------------------- |
| [`__add(set)`](#fn-add)   | Return the union of two sets using `+`.                                    |
| [`__bor(set)`](#fn-bor)   | Return the union of two sets using `\|`.                                   |
| [`__band(set)`](#fn-band) | Return the intersection of two sets using `&`.                             |
| [`__bxor(set)`](#fn-bxor) | Return elements present in exactly one set using `^`.                      |
| [`__eq(set)`](#fn-eq)     | Return true if both sets contain exactly the same members using `==`.      |
| [`__le(set)`](#fn-le)     | Return true if the left set is a subset of the right set using `<=`.       |
| [`__lt(set)`](#fn-lt)     | Return true if the left set is a proper subset of the right set using `<`. |
| [`__sub(set)`](#fn-sub)   | Return the difference of two sets using `-`.                               |

### Mutation

In-place operations that mutate the current set. <a id="fn-add"></a>

#### `add(v)`

Add an element to the set.

**Parameters**:

- `v` (`any`): Value to add.

**Return**:

- `self` (`T`): Current set instance.

**Example**:

```lua
s = Set({ "a" }):add("b") --> s contains "a", "b"
```

<a id="fn-clear"></a>

#### `clear()`

Remove all elements from the set.

**Return**:

- `self` (`T`): Current set instance.

**Example**:

```lua
s = Set({ "a", "b" }):clear() --> s is empty
```

<a id="fn-difference-update"></a>

#### `difference_update(set)`

Remove elements found in another set (in place).

**Parameters**:

- `set` (`T`): Other set value.

**Return**:

- `self` (`T`): Current set instance.

**Example**:

```lua
s = Set({ "a", "b" }):difference_update(Set({ "b" })) --> s contains "a"
```

<a id="fn-intersection-update"></a>

#### `intersection_update(set)`

Keep only elements common to both sets (in place).

**Parameters**:

- `set` (`T`): Other set value.

**Return**:

- `self` (`T`): Current set instance.

**Example**:

```lua
s = Set({ "a", "b" }):intersection_update(Set({ "b", "c" }))
--> s contains "b"
```

<a id="fn-pop"></a>

#### `pop()`

Remove and return an arbitrary element.

**Return**:

- `value` (`any`): Removed value, or `nil` when the set is empty.

**Example**:

```lua
v = Set({ "a", "b" }):pop() --> v is either "a" or "b"
```

<a id="fn-symmetric-difference-update"></a>

#### `symmetric_difference_update(set)`

Update the set with elements not shared by both (in place).

**Parameters**:

- `set` (`T`): Other set value.

**Return**:

- `self` (`T`): Current set instance.

**Example**:

```lua
s = Set({ "a", "b" }):symmetric_difference_update(Set({ "b", "c" }))
--> s contains "a", "c"
```

<a id="fn-update"></a>

#### `update(set)`

Add all elements from another set (in place).

**Parameters**:

- `set` (`T`): Other set value.

**Return**:

- `self` (`T`): Current set instance.

**Example**:

```lua
s = Set({ "a" }):update(Set({ "b" })) --> s contains "a", "b"
```

### Copying

Non-mutating set operations that return new set instances. <a id="fn-copy"></a>

#### `copy()`

Return a shallow copy of the set.

**Return**:

- `set` (`mods.Set`): New set.

**Example**:

```lua
c = Set({ "a" }):copy() --> c is a new set with "a"
```

<a id="fn-difference"></a>

#### `difference(set)`

Return elements in this set but not in another.

**Parameters**:

- `set` (`mods.Set|table<any,true>`): Other set value.

**Return**:

- `set` (`mods.Set`): New set.

**Example**:

```lua
d = Set({ "a", "b" }):difference(Set({ "b" })) --> d contains "a"
```

> [!NOTE]
>
> `difference` is also available as the `__sub` (`-`) operator.
> `a:difference(b)` is equivalent to `a - b`.

<a id="fn-intersection"></a>

#### `intersection(set)`

Return elements common to both sets.

**Parameters**:

- `set` (`mods.Set|table<any,true>`): Other set value.

**Return**:

- `set` (`mods.Set`): New set.

**Example**:

```lua
i = Set({ "a", "b" }):intersection(Set({ "b", "c" })) --> i contains "b"
```

> [!NOTE]
>
> `intersection` is also available as `__band` (`&`) on Lua 5.3+.

<a id="fn-remove"></a>

#### `remove(v)`

Remove an element if present, do nothing otherwise.

**Parameters**:

- `v` (`any`): Value to remove.

**Return**:

- `self` (`T`): Current set instance.

**Example**:

```lua
s = Set({ "a", "b" }):remove("b") --> s contains "a"
```

<a id="fn-symmetric-difference"></a>

#### `symmetric_difference(set)`

Return elements not shared by both sets.

**Parameters**:

- `set` (`mods.Set|table<any,true>`): Other set value.

**Return**:

- `set` (`mods.Set`): New set.

**Example**:

```lua
d = Set({ "a", "b" }):symmetric_difference(Set({ "b", "c" }))
--> d contains "a", "c"
```

> [!NOTE]
>
> `symmetric_difference` is also available as `__bxor` (`^`) on Lua 5.3+.

<a id="fn-union"></a>

#### `union(set)`

Return a new set with all elements from both.

**Parameters**:

- `set` (`mods.Set|table<any,true>`): Other set value.

**Return**:

- `set` (`mods.Set`): New set.

**Example**:

```lua
s = Set({ "a" }):union(Set({ "b" })) --> s contains "a", "b"
```

> [!NOTE]
>
> `union` is available as `__add` (`+`) and `__bor` (`|`) on Lua 5.3+.
> `a:union(b)` is equivalent to `a + b` and `a | b`.

### Predicates

Boolean checks about set relationships and emptiness. <a id="fn-isdisjoint"></a>

#### `isdisjoint(set)`

Return true if sets have no elements in common.

**Parameters**:

- `set` (`T`): Other set value.

**Return**:

- `ok` (`boolean`): True when sets have no elements in common.

**Example**:

```lua
ok = Set({ "a" }):isdisjoint(Set({ "b" })) --> true
```

<a id="fn-equals"></a>

#### `equals(set)`

Return true when both sets contain exactly the same members.

**Parameters**:

- `set` (`mods.Set|table<any,true>`): Other set value.

**Return**:

- `ok` (`boolean`): True when both sets contain the same members.

**Example**:

```lua
a = Set({ "a", "b" })
b = Set({ "b", "a" })
ok = a:equals(b) --> true
```

> [!NOTE]
>
> `equals` is also available as the `__eq` (`==`) operator. `a:equals(b)` is
> equivalent to `a == b`.

<a id="fn-isempty"></a>

#### `isempty()`

Return true if the set has no elements.

**Return**:

- `ok` (`boolean`): True when the set has no elements.

**Example**:

```lua
empty = Set({}):isempty() --> true
```

<a id="fn-issubset"></a>

#### `issubset(set)`

Return true if all elements of this set are also in another set.

**Parameters**:

- `set` (`mods.Set|table<any,true>`): Other set value.

**Return**:

- `ok` (`boolean`): True when every element of `self` exists in `set`.

**Example**:

```lua
ok = Set({ "a" }):issubset(Set({ "a", "b" })) --> true
```

> [!NOTE]
>
> `issubset` is also available as the `__le` (`<=`) operator. `a:issubset(b)` is
> equivalent to `a <= b`.

<a id="fn-issuperset"></a>

#### `issuperset(set)`

Return true if this set contains all elements of another set.

**Parameters**:

- `set` (`mods.Set|table<any,true>`): Other set value.

**Return**:

- `ok` (`boolean`): True when `self` contains every element of `set`.

**Example**:

```lua
ok = Set({ "a", "b" }):issuperset(Set({ "a" })) --> true
```

### Query

Read-only queries for membership and size. <a id="fn-contains"></a>

#### `contains(v)`

Return true if the set contains `v`.

**Parameters**:

- `v` (`any`): Value to check.

**Return**:

- `ok` (`boolean`): True when `v` is present in the set.

**Example**:

```lua
ok = Set({ "a", "b" }):contains("a") --> true
ok = Set({ "a", "b" }):contains("z") --> false
```

<a id="fn-len"></a>

#### `len()`

Return the number of elements in the set.

**Return**:

- `count` (`integer`): Element count.

**Example**:

```lua
n = Set({ "a", "b" }):len() --> 2
```

### Transform

Value-to-value transformations and projection helpers. <a id="fn-map"></a>

#### `map(fn)`

Return a new set by mapping each value.

**Parameters**:

- `fn` (`fun(v:any):any`): Mapping function.

**Return**:

- `set` (`mods.Set`): New set.

**Example**:

```lua
s = Set({ 1, 2 }):map(function(v) return v * 10 end) --> s contains 10, 20
```

<a id="fn-values"></a>

#### `values()`

Return a list of all values in the set.

**Return**:

- `values` (`mods.List`): List of set values.

**Example**:

```lua
values = Set({ "a", "b" }):values() --> { "a", "b" }
```

### Metamethods

<a id="fn-add"></a>

#### `__add(set)`

Return the union of two sets using `+`.

**Parameters**:

- `set` (`mods.Set|table<any,true>`): Other set value.

**Return**:

- `set` (`mods.Set`): New set.

**Example**:

```lua
a = Set({ "a", "b" })
b = Set({ "b", "c" })
u = a + b --> { a = true, b = true, c = true }
```

> [!NOTE]
>
> `__add` is the operator form of `:union(set)`.

<a id="fn-bor"></a>

#### `__bor(set)`

Return the union of two sets using `|`.

**Parameters**:

- `set` (`mods.Set|table<any,true>`): Other set value.

**Return**:

- `set` (`mods.Set`): New set.

**Example**:

```lua
a = Set({ "a", "b" })
b = Set({ "b", "c" })
u = a | b --> { a = true, b = true, c = true }
```

> [!NOTE]
>
> `__bor` is the operator form of `:union(set)` on Lua 5.3+.

<a id="fn-band"></a>

#### `__band(set)`

Return the intersection of two sets using `&`.

**Parameters**:

- `set` (`mods.Set|table<any,true>`): Other set value.

**Return**:

- `set` (`mods.Set`): New set.

**Example**:

```lua
a = Set({ "a", "b" })
b = Set({ "b", "c" })
i = a & b --> { b = true }
```

> [!NOTE]
>
> `__band` is the operator form of `:intersection(set)` on Lua 5.3+.

<a id="fn-bxor"></a>

#### `__bxor(set)`

Return elements present in exactly one set using `^`.

**Parameters**:

- `set` (`mods.Set|table<any,true>`): Other set value.

**Return**:

- `set` (`mods.Set`): New set.

**Example**:

```lua
a = Set({ "a", "b" })
b = Set({ "b", "c" })
d = a ^ b --> { a = true, c = true }
```

> [!NOTE]
>
> `__bxor` is the operator form of `:symmetric_difference(set)` on Lua 5.3+.

<a id="fn-eq"></a>

#### `__eq(set)`

Return true if both sets contain exactly the same members using `==`.

**Parameters**:

- `set` (`mods.Set|table<any,true>`): Other set value.

**Return**:

- `ok` (`boolean`): True when both sets contain the same members.

**Example**:

```lua
ok = Set({ "a", "b" }) == Set({ "b", "a" }) --> true
```

> [!NOTE]
>
> `__eq` is the operator form of `:equals(set)`.

<a id="fn-le"></a>

#### `__le(set)`

Return true if the left set is a subset of the right set using `<=`.

**Parameters**:

- `set` (`mods.Set|table<any,true>`): Other set value.

**Return**:

- `ok` (`boolean`): True when `self` is a subset of `set`.

**Example**:

```lua
a = Set({ "a" })
b = Set({ "a", "b" })
ok = a <= b --> true
```

> [!NOTE]
>
> `__le` is the operator form of `:issubset(set)`.

<a id="fn-lt"></a>

#### `__lt(set)`

Return true if the left set is a proper subset of the right set using `<`.

**Parameters**:

- `set` (`mods.Set|table<any,true>`): Other set value.

**Return**:

- `ok` (`boolean`): True when `self` is a proper subset of `set`.

**Example**:

```lua
a = Set({ "a" })
b = Set({ "a", "b" })
ok = a < b --> true
```

<a id="fn-sub"></a>

#### `__sub(set)`

Return the difference of two sets using `-`.

**Parameters**:

- `set` (`mods.Set|table<any,true>`): Other set value.

**Return**:

- `set` (`mods.Set`): New set.

**Example**:

```lua
a = Set({ "a", "b" })
b = Set({ "b", "c" })
d = a - b --> { a = true }
```

> [!NOTE]
>
> `__sub` is the operator form of `:difference(set)`.
