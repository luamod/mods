---
desc:
  "A Python-style list class providing common operations to create, modify, and
  query sequences of values."
---

# `List`

A Python-style list class providing common operations to create, modify, and
query sequences of values.

## Usage

```lua
List = require "mods.List"

ls = List({ "a" }):append("b")
print(ls:contains("b")) --> true
print(ls:index("b")) --> 2
```

## Functions

**Predicates**:

| Function            | Description                                              |
| ------------------- | -------------------------------------------------------- |
| [`all`](#all)       | Return true if all values match the predicate.           |
| [`any`](#any)       | Return true if any value matches the predicate.          |
| [`equals`](#equals) | Compare two lists using shallow element equality (`==`). |
| [`lt`](#lt)         | Compare two lists lexicographically (Python-style `<`).  |
| [`le`](#le)         | Compare two lists lexicographically (Python-style `<=`). |

**Mutation**:

| Function              | Description                                                          |
| --------------------- | -------------------------------------------------------------------- |
| [`append`](#append)   | Append a value to the end of the list.                               |
| [`clear`](#clear)     | Remove all elements from the list.                                   |
| [`extend`](#extend)   | Extend the list with another list.                                   |
| [`extract`](#extract) | Extract values matching the predicate and remove them from the list. |
| [`insert`](#insert)   | Insert a value at the given position.                                |
| [`insert`](#insert)   | Append a value to the end of the list.                               |
| [`pop`](#pop)         | Remove and return the last element.                                  |
| [`pop`](#pop)         | Remove and return the element at the given position.                 |
| [`prepend`](#prepend) | Insert a value at the start of the list.                             |
| [`remove`](#remove)   | Remove the first matching value.                                     |
| [`sort`](#sort)       | Sort the list in place.                                              |

**Copying**:

| Function        | Description                        |
| --------------- | ---------------------------------- |
| [`copy`](#copy) | Return a shallow copy of the list. |

**Query**:

| Function                | Description                                                 |
| ----------------------- | ----------------------------------------------------------- |
| [`contains`](#contains) | Return true if the list contains the value.                 |
| [`count`](#count)       | Count how many times a value appears.                       |
| [`index`](#index)       | Return the index of the first matching value.               |
| [`index_if`](#index-if) | Return the index of the first value matching the predicate. |
| [`len`](#len)           | Return the number of elements in the list.                  |

**Access**:

| Function          | Description                                 |
| ----------------- | ------------------------------------------- |
| [`first`](#first) | Return the first element or `nil` if empty. |
| [`last`](#last)   | Return the last element or `nil` if empty.  |

**Transform**:

| Function                        | Description                                                              |
| ------------------------------- | ------------------------------------------------------------------------ |
| [`difference`](#difference)     | Return a new list with values not in the given list.                     |
| [`drop`](#drop)                 | Return a new list without the first n elements.                          |
| [`filter`](#filter)             | Return a new list with values matching the predicate.                    |
| [`flatten`](#flatten)           | Flatten one level of nested lists.                                       |
| [`foreach`](#foreach)           | Apply a function to each element (for side effects).                     |
| [`group_by`](#group-by)         | Group list values by a computed key.                                     |
| [`intersection`](#intersection) | Return values that are also present in the given list.                   |
| [`invert`](#invert)             | Invert values to indices in a new table.                                 |
| [`concat`](#concat)             | Concatenate list values using Lua's native `table.concat` behavior.      |
| [`join`](#join)                 | Join list values into a string.                                          |
| [`tostring`](#tostring)         | Render the list to a string via the regular method form.                 |
| [`keypath`](#keypath)           | Render list items as a table-access key path.                            |
| [`map`](#map)                   | Return a new list by mapping each value.                                 |
| [`mul`](#mul)                   | Return a new list repeated `n` times (Python-style list multiplication). |
| [`reduce`](#reduce)             | Reduce the list to a single value using an accumulator.                  |
| [`reverse`](#reverse)           | Return a new list with items reversed.                                   |
| [`toset`](#toset)               | Convert the list to a set.                                               |
| [`slice`](#slice)               | Return a new list containing items from i to j (inclusive).              |
| [`take`](#take)                 | Return the first n elements as a new list.                               |
| [`uniq`](#uniq)                 | Return a new list with duplicates removed (first occurrence kept).       |
| [`zip`](#zip)                   | Zip two lists into a list of 2-element tables.                           |

**Metamethods**:

| Function                  | Description                                                                                               |
| ------------------------- | --------------------------------------------------------------------------------------------------------- |
| [`__eq`](#eq)             | Compare two lists using shallow element equality (`==`).                                                  |
| [`__lt`](#lt)             | Compare two lists lexicographically using `<`.                                                            |
| [`__le`](#le)             | Compare two lists lexicographically using `<=`.                                                           |
| [`__mul`](#mul)           | Repeat a list `n` times using `*`.                                                                        |
| [`__add`](#add)           | Extend the left-hand list in place with right-hand values, then return the same left-hand list reference. |
| [`__sub`](#sub)           | Return values from the left list that are not present in the right list.                                  |
| [`__tostring`](#tostring) | Render the list to a string like `{ "a", "b", 1 }`.                                                       |

### Predicates

Boolean checks for list-wide conditions.

#### `all`

Return true if all values match the predicate.

```lua
is_even = function(v) return v % 2 == 0 end
ok = List({ 2, 4 }):all(is_even) --> true
```

> [!NOTE]
>
> Empty lists return `true`.

#### `any`

Return true if any value matches the predicate.

```lua
has_len_2 = function(v) return #v == 2 end
ok = List({ "a", "bb" }):any(has_len_2) --> true
```

#### `equals`

Compare two lists using shallow element equality (`==`).

```lua
a = List({ "x", "y" })
b = List({ "x", "y" })
ok = a:equals(b) --> true
```

> [!NOTE]
>
> `equals` is also available as the `__eq` (`==`) operator when both operands
> are `List`.
>
> ```lua
> a = List({ "a", 1 })
> b = List({ "a", 1 })
> ok = (a == b) --> true
> ```
>
> Unlike `==`, this method also works when `ls` is a plain array table.
>
> ```lua
> a = List({ "a", 1 })
> b = { "a", 1 }
> ok = a:equals(b) --> true
> ```
>
> `equals` checks only array positions (`1..#list`), so extra non-array keys are
> ignored:
>
> ```lua
> t = {}
> a = List({ "a", t })
> b = { "a", t, a = 1 }
> ok = a:equals(b) --> true
> ```

#### `lt`

Compare two lists lexicographically (Python-style `<`).

```lua
ok = List({ 1, 2 }):lt({ 1, 3 })    --> true
ok = List({ 1, 2 }):lt({ 1, 2, 0 }) --> true
```

> [!NOTE]
>
> `lt` is also available as the `__lt` (`<`) operator. `a:lt(b)` is equivalent
> to `a < b`.

#### `le`

Compare two lists lexicographically (Python-style `<=`).

```lua
ok = List({ 1, 2 }):le({ 1, 2 })  --> true
ok = List({ 1, 2 }):le({ 1, 1 })  --> false
```

> [!NOTE]
>
> `le` is also available as the `__le` (`<=`) operator. `a:le(b)` is equivalent
> to `a <= b`.

### Mutation

In-place operations that modify the current list.

#### `append`

Append a value to the end of the list.

```lua
ls = List({ "a" }):append("b") --> { "a", "b" }
```

#### `clear`

Remove all elements from the list.

```lua
ls = List({ "a", "b" }):clear() --> { }
```

#### `extend`

Extend the list with another list.

```lua
ls = List({ "a" }):extend({ "b", "c" }) --> { "a", "b", "c" }
```

> [!NOTE]
>
> `extend` is also available as the `__add` (`+`) operator. `a:extend(b)` is
> equivalent to `a + b`.

#### `extract`

Extract values matching the predicate and remove them from the list.

```lua
ls = List({ "a", "bb", "c" })
is_len_1 = function(v) return #v == 1 end
ex = ls:extract(is_len_1) --> ex = { "a", "c" }, ls = { "bb" }
```

#### `insert`

Insert a value at the given position.

```lua
ls = List({ "a", "c" }):insert(2, "b") --> { "a", "b", "c" }
```

#### `insert`

Append a value to the end of the list.

```lua
ls = List({ "a", "b" }):insert("b") --> { "a", "b", "c" }
```

#### `pop`

Remove and return the last element.

```lua
ls = List({ "a", "b" })
v = ls:pop() --> v == "b"; ls is { "a" }
```

#### `pop`

Remove and return the element at the given position.

```lua
ls = List({ "a", "b", "c" })
v = ls:pop(2) --> v == "b"; ls is { "a", "c" }
```

#### `prepend`

Insert a value at the start of the list.

```lua
ls = List({ "b", "c" })
ls:prepend("a") --> { "a", "b", "c" }
```

#### `remove`

Remove the first matching value.

```lua
ls = List({ "a", "b", "b" })
ls:remove("b") --> { "a", "b" }
```

#### `sort`

Sort the list in place.

```lua
ls = List({ 3, 1, 2 })
ls:sort() --> { 1, 2, 3 }
```

### Copying

Operations that return copied list data.

#### `copy`

Return a shallow copy of the list.

```lua
c = List({ "a", "b" }):copy() --> { "a", "b" }
```

### Query

Read-only queries for membership, counts, and indices.

#### `contains`

Return true if the list contains the value.

```lua
ok = List({ "a", "b" }):contains("b") --> true
```

#### `count`

Count how many times a value appears.

```lua
n = List({ "a", "b", "b" }):count("b") --> 2
```

#### `index`

Return the index of the first matching value.

```lua
i = List({ "a", "b", "c", "b" }):index("b") --> 2
```

#### `index_if`

Return the index of the first value matching the predicate.

```lua
gt_1 = function(x) return x > 1 end
i = List({ 1, 2, 3 }):index_if(gt_1) --> 2
```

#### `len`

Return the number of elements in the list.

```lua
n = List({ "a", "b", "c" }):len() --> 3
```

> [!NOTE]
>
> Uses Lua's `#` operator, so length is reliable for contiguous array-like
> lists.

### Access

Direct element access helpers.

#### `first`

Return the first element or `nil` if empty.

```lua
v = List({ "a", "b" }):first() --> "a"
```

#### `last`

Return the last element or `nil` if empty.

```lua
v = List({ "a", "b" }):last() --> "b"
```

### Transform

Non-mutating transformations and derived-list operations.

#### `difference`

Return a new list with values not in the given list.

```lua
d = List({ "a", "b", "c" }):difference({ "b" }) --> { "a", "c" }
```

> [!NOTE]
>
> `difference` is also available as the `__sub` (`-`) operator.
> `a:difference(b)` is equivalent to `a - b`.

#### `drop`

Return a new list without the first n elements.

```lua
t = List({ "a", "b", "c" }):drop(1) --> { "b", "c" }
```

#### `filter`

Return a new list with values matching the predicate.

```lua
is_len_1 = function(v) return #v == 1 end
f = List({ "a", "bb", "c" }):filter(is_len_1) --> { "a", "c" }
```

#### `flatten`

Flatten one level of nested lists.

```lua
f = List({ { "a", "b" }, { "c" } }):flatten() --> { "a", "b", "c" }
```

#### `foreach`

Apply a function to each element (for side effects).

```lua
List({ "a", "b" }):foreach(print)
--> prints -> a
--> prints -> b
```

#### `group_by`

Group list values by a computed key.

```lua
words = { "aa", "b", "ccc", "dd" }
g = List(words):group_by(string.len) --> { {"b"}, { "aa", "dd" }, { "ccc" } }
```

#### `intersection`

Return values that are also present in the given list.

```lua
i = List({ "a", "b", "a", "c" }):intersection({ "a", "c" })
--> { "a", "a", "c" }
```

> [!NOTE]
>
> Order is preserved from the original list.

#### `invert`

Invert values to indices in a new table.

```lua
t = List({ "a", "b", "c" }):invert() --> { a = 1, b = 2, c = 3 }
```

#### `concat`

Concatenate list values using Lua's native `table.concat` behavior.

```lua
s = List({ "a", "b", "c" }):concat(",") --> "a,b,c"
```

> [!NOTE]
>
> This method forwards to `table.concat` directly and keeps its strict element
> rules.

#### `join`

Join list values into a string.

```lua
s = List({ "a", "b", "c" }):join(",") --> "a,b,c"
s = List({ "a", "b", "c" }):join(", ", true) --> '"a", "b", "c"'
```

> [!NOTE]
>
> Values are converted with `tostring` before joining. Set `quoted = true` to
> quote string values.

#### `tostring`

Render the list to a string via the regular method form.

```lua
s = List({ "a", "b", 1 }):tostring() --> '{ "a", "b", 1 }'
```

> [!NOTE]
>
> `tostring` is also available as the `__tostring` metamethod. `tostring(list)`
> is equivalent to `list:tostring()`.

#### `keypath`

Render list items as a table-access key path.

```lua
p = List({ "ctx", "users", 1, "name" }):keypath() --> "ctx.users[1].name"
```

#### `map`

Return a new list by mapping each value.

```lua
to_upper = function(v) return v:upper() end
m = List({ "a", "b" }):map(to_upper) --> { "A", "B" }
```

#### `mul`

Return a new list repeated `n` times (Python-style list multiplication).

```lua
ls = List({ "a", "b" }):mul(3) --> { "a", "b", "a", "b", "a", "b" }
```

> [!NOTE]
>
> `mul` is also available as the `__mul` (`*`) operator. `a:mul(n)` is
> equivalent to `a * n`.

#### `reduce`

Reduce the list to a single value using an accumulator.

```lua
add = function(acc, v) return acc + v end
sum = List({ 1, 2, 3 }):reduce(add, 0) --> 6
sum = List({ 1, 2, 3 }):reduce(add, 10) --> 16
```

> [!NOTE]
>
> If init is `nil`, the first element is used as the initial value. Empty lists
> return init (or `nil` if init is `nil`).

#### `reverse`

Return a new list with items reversed.

```lua
r = List({ "a", "b", "c" }):reverse() --> { "c", "b", "a" }
```

#### `toset`

Convert the list to a set.

```lua
s = List({ "a", "b", "a" }):toset() --> { a = true, b = true }
```

> [!NOTE]
>
> Order is preserved from the original list.

#### `slice`

Return a new list containing items from i to j (inclusive).

```lua
t = List({ "a", "b", "c", "d" }):slice(2, 3) --> { "b", "c" }
```

> [!NOTE]
>
> Supports negative indices (-1 is last element).

#### `take`

Return the first n elements as a new list.

```lua
t = List({ "a", "b", "c" }):take(2) --> { "a", "b" }
```

#### `uniq`

Return a new list with duplicates removed (first occurrence kept).

```lua
u = List({ "a", "b", "a", "c" }):uniq() --> { "a", "b", "c" }
```

#### `zip`

Zip two lists into a list of 2-element tables.

```lua
z = List({ "a", "b" }):zip({ 1, 2 }) --> { {"a",1}, {"b",2} }
```

> [!NOTE]
>
> Length is the minimum of both lists.

### Metamethods

#### `__eq`

Compare two lists using shallow element equality (`==`).

```lua
a = List({ "a", { 1 } })
b = List({ "a", { 1 } })
ok = a == b --> false (different nested table references)

t = { 1 }
a = List({ "a", t })
b = List({ "a", t })
ok = a == b --> true (same nested table reference)
```

> [!NOTE]
>
> `==` will not use this metamethod when the other operand is a plain table. Use
> `:equals(other)` for `List` vs plain-table comparisons.
>
> ```lua
> t = { "a", 1 }
> a = List(t)
> b = { "a", 1 }
> ok = (a == b)     --> false
> ok2 = a:equals(b) --> true
> ```
>
> Like `:equals`, `__eq` compares only array positions (`1..#list`), so extra
> non-array keys are ignored when both operands are `List`.
>
> ```lua
> a = List({ "a", t })
> b = List({ "a", t, extra = 1 })
> ok = (a == b) --> true
> ```

#### `__lt`

Compare two lists lexicographically using `<`.

```lua
ok = List({ 1, 2 }) < List({ 1, 3 }) --> true
```

> [!NOTE]
>
> `__lt` is the operator form of `:lt(ls)`.

#### `__le`

Compare two lists lexicographically using `<=`.

```lua
ok = List({ 1, 2 }) <= List({ 1, 2 }) --> true
```

> [!NOTE]
>
> `__le` is the operator form of `:le(ls)`.

#### `__mul`

Repeat a list `n` times using `*`.

```lua
l1 = List({ "a", "b" }) * 3 --> { "a", "b", "a", "b", "a", "b" }
l2 = 3 * List({ "a", "b" }) --> { "a", "b", "a", "b", "a", "b" }
```

> [!NOTE]
>
> `__mul` is the operator form of `:mul(n)`.

#### `__add`

Extend the left-hand list in place with right-hand values, then return the same
left-hand list reference.

```lua
a = List({ "a", "b" })
b = { "c", "d" }
c = a + b --> c and a are the same reference: { "a", "b", "c", "d" }
```

> [!NOTE]
>
> - `__add` mutates and returns the left-hand value (same reference).
> - `__add` is the operator form of `:extend(ls)`.

#### `__sub`

Return values from the left list that are not present in the right list.

```lua
a = List({ "a", "b", "c" })
b = { "b" }
d = a - b --> { "a", "c" }
```

> [!NOTE]
>
> `__sub` is the operator form of `:difference(ls)`.

#### `__tostring`

Render the list to a string like `{ "a", "b", 1 }`.

```lua
s = tostring(List({ "a", "b", 1 })) --> '{ "a", "b", 1 }'
```

> [!NOTE]
>
> `__tostring` is the operator form of `:tostring()`.
