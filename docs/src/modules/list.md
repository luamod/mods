---
desc:
  "A list class providing common operations to create, modify, and query
  sequences of values."
---

# `List`

A list class providing common operations to create, modify, and query sequences
of values.

## Usage

```lua
List = require "mods.List"

ls = List({ "a" }):append("b")
print(ls:contains("b")) --> true
print(ls:index("b"))    --> 2
```

> [!NOTE]
>
> `List(t)` wraps `t` with the `List` metatable in place. It does not copy or
> filter table values. `List(t):copy()` or `List.copy(t)` both copy only `1..#t`
> and wrap `t` as a List.

## Functions

**Predicates**:

| Function                   | Description                                       |
| -------------------------- | ------------------------------------------------- |
| [`all(pred)`](#fn-all)     | Return true if all values match the predicate.    |
| [`any(pred)`](#fn-any)     | Return true if any value matches the predicate.   |
| [`equals(ls)`](#fn-equals) | Compare two lists using shallow element equality. |
| [`lt(ls)`](#fn-lt)         | Compare two lists lexicographically.              |
| [`le(ls)`](#fn-le)         | Compare two lists lexicographically.              |

**Mutation**:

| Function                       | Description                                                          |
| ------------------------------ | -------------------------------------------------------------------- |
| [`append()`](#fn-append)       | Append a value to the end of the list.                               |
| [`clear()`](#fn-clear)         | Remove all elements from the list.                                   |
| [`extend(ls)`](#fn-extend)     | Extend the list with another list.                                   |
| [`extract(pred)`](#fn-extract) | Extract values matching the predicate and remove them from the list. |
| [`insert(pos, v)`](#fn-insert) | Insert a value at the given position.                                |
| [`insert(v)`](#fn-insert)      | Append a value to the end of the list.                               |
| [`pop()`](#fn-pop)             | Remove and return the last element.                                  |
| [`pop(pos)`](#fn-pop)          | Remove and return the element at the given position.                 |
| [`prepend(v)`](#fn-prepend)    | Insert a value at the start of the list.                             |
| [`remove(v)`](#fn-remove)      | Remove the first matching value.                                     |
| [`sort(comp?)`](#fn-sort)      | Sort the list in place.                                              |

**Copying**:

| Function             | Description                        |
| -------------------- | ---------------------------------- |
| [`copy()`](#fn-copy) | Return a shallow copy of the list. |

**Query**:

| Function                         | Description                                                 |
| -------------------------------- | ----------------------------------------------------------- |
| [`contains(v)`](#fn-contains)    | Return true if the list contains the value.                 |
| [`count(v)`](#fn-count)          | Count how many times a value appears.                       |
| [`index(v)`](#fn-index)          | Return the index of the first matching value.               |
| [`index_if(pred)`](#fn-index-if) | Return the index of the first value matching the predicate. |
| [`len()`](#fn-len)               | Return the number of elements in the list.                  |

**Access**:

| Function               | Description                                 |
| ---------------------- | ------------------------------------------- |
| [`first()`](#fn-first) | Return the first element or `nil` if empty. |
| [`last()`](#fn-last)   | Return the last element or `nil` if empty.  |

**Transform**:

| Function                               | Description                                                          |
| -------------------------------------- | -------------------------------------------------------------------- |
| [`difference(ls)`](#fn-difference)     | Return a new list with values not in the given list.                 |
| [`drop(n)`](#fn-drop)                  | Return a new list without the first n elements.                      |
| [`filter(pred)`](#fn-filter)           | Return a new list with values matching the predicate.                |
| [`flatten()`](#fn-flatten)             | Flatten one level of nested lists.                                   |
| [`foreach(fn)`](#fn-foreach)           | Apply a function to each element (for side effects).                 |
| [`group_by(fn)`](#fn-group-by)         | Group list values by a computed key.                                 |
| [`intersection(ls)`](#fn-intersection) | Return values that are also present in the given list.               |
| [`invert()`](#fn-invert)               | Invert values to indices in a new table.                             |
| [`concat(sep?, i?, j?)`](#fn-concat)   | Concatenate list values using Lua's native `table.concat` behavior.  |
| [`join(sep?, quoted?)`](#fn-join)      | Join list values into a string.                                      |
| [`tostring()`](#fn-tostring)           | Render the list to a string via the regular method form.             |
| [`keypath()`](#fn-keypath)             | Render list items as a table-access key path.                        |
| [`map(fn)`](#fn-map)                   | Return a new list by mapping each value.                             |
| [`mul(n)`](#fn-mul)                    | Return a new list repeated `n` times (list multiplication behavior). |
| [`reduce(fn, init?)`](#fn-reduce)      | Reduce the list to a single value using an accumulator.              |
| [`reverse()`](#fn-reverse)             | Return a new list with items reversed.                               |
| [`toset()`](#fn-toset)                 | Convert the list to a set.                                           |
| [`slice(i?, j?)`](#fn-slice)           | Return a new list containing items from i to j (inclusive).          |
| [`take(n)`](#fn-take)                  | Return the first n elements as a new list.                           |
| [`uniq()`](#fn-uniq)                   | Return a new list with duplicates removed (first occurrence kept).   |
| [`zip(ls)`](#fn-zip)                   | Zip two lists into a list of 2-element tables.                       |

**Metamethods**:

| Function                       | Description                                                                                                     |
| ------------------------------ | --------------------------------------------------------------------------------------------------------------- |
| [`__eq(ls)`](#fn-eq)           | Compare two lists using shallow element equality (`==`).                                                        |
| [`__lt(ls)`](#fn-lt)           | Compare two lists lexicographically (`<`).                                                                      |
| [`__le(ls)`](#fn-le)           | Compare two lists lexicographically (`<=`).                                                                     |
| [`__mul(n)`](#fn-mul)          | Repeat a list `n` times (`*`).                                                                                  |
| [`__add(ls)`](#fn-add)         | Extend the left-hand list in place with right-hand values, then return the same left-hand list reference (`+`). |
| [`__sub(ls)`](#fn-sub)         | Return values from the left list that are not present in the right list (`-`).                                  |
| [`__tostring()`](#fn-tostring) | Render the list to a string like `{ "a", "b", 1 }`.                                                             |

### Predicates

Boolean checks for list-wide conditions. <a id="fn-all"></a>

#### `all(pred)`

Return true if all values match the predicate.

**Parameters**:

- `pred` (`fun(v:any):boolean`): Predicate function.

**Return**:

- `ok` (`boolean`): Whether the condition is met.

**Example**:

```lua
is_even = function(v) return v % 2 == 0 end
ok = List({ 2, 4 }):all(is_even) --> true
```

> [!NOTE]
>
> Empty lists return `true`.

<a id="fn-any"></a>

#### `any(pred)`

Return true if any value matches the predicate.

**Parameters**:

- `pred` (`fun(v:any):boolean`): Predicate function.

**Return**:

- `ok` (`boolean`): Whether the condition is met.

**Example**:

```lua
has_len_2 = function(v) return #v == 2 end
ok = List({ "a", "bb" }):any(has_len_2) --> true
```

<a id="fn-equals"></a>

#### `equals(ls)`

Compare two lists using shallow element equality.

**Parameters**:

- `ls` (`mods.List|any[]`): Other list value.

**Return**:

- `ok` (`boolean`): Whether the condition is met.

**Example**:

```lua
a = List({ "x", "y" })
b = List({ "x", "y" })
ok = a:equals(b) --> true
```

> [!NOTE]
>
> - `equals` is also available through the `==` operator when both operands are
>   `List`.
>
>   ```lua
>   a = List({ "a", 1 })
>   b = List({ "a", 1 })
>   ok = (a == b) --> true
>   ```
>
> - Unlike `==`, this method also works when `ls` is a plain array table.
>
>   ```lua
>   a = List({ "a", 1 })
>   b = { "a", 1 }
>   ok = a:equals(b) --> true
>   ```
>
> - `equals` checks only array positions (`1..#list`), so extra non-array keys
>   are ignored:
>
>   ```lua
>   t = {}
>   a = List({ "a", t })
>   b = { "a", t, a = 1 }
>   ok = a:equals(b) --> true
>   ```

<a id="fn-lt"></a>

#### `lt(ls)`

Compare two lists lexicographically.

**Parameters**:

- `ls` (`mods.List|any[]`): Other list value.

**Return**:

- `ok` (`boolean`): Whether the condition is met.

**Example**:

```lua
ok = List({ 1, 2 }):lt({ 1, 3 })    --> true
ok = List({ 1, 2 }):lt({ 1, 2, 0 }) --> true
```

> [!NOTE]
>
> `lt` is also available through the `<` operator.

<a id="fn-le"></a>

#### `le(ls)`

Compare two lists lexicographically.

**Parameters**:

- `ls` (`mods.List|any[]`): Other list value.

**Return**:

- `ok` (`boolean`): Whether the condition is met.

**Example**:

```lua
ok = List({ 1, 2 }):le({ 1, 2 })  --> true
ok = List({ 1, 2 }):le({ 1, 1 })  --> false
```

> [!NOTE]
>
> `le` is also available through the `<=` operator.

### Mutation

In-place operations that modify the current list. <a id="fn-append"></a>

#### `append()`

Append a value to the end of the list.

**Return**:

- `self` (`T`): Current list instance.

**Example**:

```lua
ls = List({ "a" }):append("b") --> { "a", "b" }
```

<a id="fn-clear"></a>

#### `clear()`

Remove all elements from the list.

**Return**:

- `self` (`T`): Current list instance.

**Example**:

```lua
ls = List({ "a", "b" }):clear() --> { }
```

<a id="fn-extend"></a>

#### `extend(ls)`

Extend the list with another list.

**Parameters**:

- `ls` (`any[]`): List values.

**Return**:

- `self` (`T`): Current list instance.

**Example**:

```lua
ls = List({ "a" }):extend({ "b", "c" }) --> { "a", "b", "c" }
```

> [!NOTE]
>
> `extend` is also available through the `+` operator.

<a id="fn-extract"></a>

#### `extract(pred)`

Extract values matching the predicate and remove them from the list.

**Parameters**:

- `pred` (`fun(v:any):boolean`): Predicate function.

**Return**:

- `ls` (`mods.List`): Extracted values.

**Example**:

```lua
ls = List({ "a", "bb", "c" })
is_len_1 = function(v) return #v == 1 end
ex = ls:extract(is_len_1) --> ex = { "a", "c" }, ls = { "bb" }
```

<a id="fn-insert"></a>

#### `insert(pos, v)`

Insert a value at the given position.

**Parameters**:

- `pos` (`integer`): Insert position.
- `v` (`any`): Value to insert.

**Return**:

- `self` (`T`): Current list instance.

**Example**:

```lua
ls = List({ "a", "c" }):insert(2, "b") --> { "a", "b", "c" }
```

<a id="fn-insert"></a>

#### `insert(v)`

Append a value to the end of the list.

**Parameters**:

- `v` (`any`): Value to append.

**Return**:

- `self` (`T`): Current list instance.

**Example**:

```lua
ls = List({ "a", "b" }):insert("c") --> { "a", "b", "c" }
```

<a id="fn-pop"></a>

#### `pop()`

Remove and return the last element.

**Return**:

- `value` (`any`): Removed value.

**Example**:

```lua
ls = List({ "a", "b" })
v = ls:pop() --> v == "b"; ls is { "a" }
```

<a id="fn-pop"></a>

#### `pop(pos)`

Remove and return the element at the given position.

**Parameters**:

- `pos` (`integer`): Numeric value.

**Return**:

- `value` (`any`): Removed value.

**Example**:

```lua
ls = List({ "a", "b", "c" })
v = ls:pop(2) --> v == "b"; ls is { "a", "c" }
```

<a id="fn-prepend"></a>

#### `prepend(v)`

Insert a value at the start of the list.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `self` (`T`): Current list instance.

**Example**:

```lua
ls = List({ "b", "c" })
ls:prepend("a") --> { "a", "b", "c" }
```

<a id="fn-remove"></a>

#### `remove(v)`

Remove the first matching value.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `self` (`T`): Current list instance.

**Example**:

```lua
ls = List({ "a", "b", "b" })
ls:remove("b") --> { "a", "b" }
```

<a id="fn-sort"></a>

#### `sort(comp?)`

Sort the list in place.

**Parameters**:

- `comp?` (`fun(a,b):boolean`): Optional comparison function (defaults to
  `nil`).

**Return**:

- `self` (`T`): Current list instance.

**Example**:

```lua
ls = List({ 3, 1, 2 })
ls:sort() --> { 1, 2, 3 }
```

### Copying

Operations that return copied list data. <a id="fn-copy"></a>

#### `copy()`

Return a shallow copy of the list.

**Return**:

- `ls` (`mods.List`): New list.

**Example**:

```lua
c = List({ "a", "b" }):copy() --> { "a", "b" }
```

### Query

Read-only queries for membership, counts, and indices. <a id="fn-contains"></a>

#### `contains(v)`

Return true if the list contains the value.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the condition is met.

**Example**:

```lua
ok = List({ "a", "b" }):contains("b") --> true
```

<a id="fn-count"></a>

#### `count(v)`

Count how many times a value appears.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `res` (`integer`): Result count.

**Example**:

```lua
n = List({ "a", "b", "b" }):count("b") --> 2
```

<a id="fn-index"></a>

#### `index(v)`

Return the index of the first matching value.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `index` (`integer?`): Result index, or nil when not found.

**Example**:

```lua
i = List({ "a", "b", "c", "b" }):index("b") --> 2
```

<a id="fn-index-if"></a>

#### `index_if(pred)`

Return the index of the first value matching the predicate.

**Parameters**:

- `pred` (`fun(v:any):boolean`): Predicate function.

**Return**:

- `index` (`integer?`): Result index, or nil when no value matches.

**Example**:

```lua
gt_1 = function(x) return x > 1 end
i = List({ 1, 2, 3 }):index_if(gt_1) --> 2
```

<a id="fn-len"></a>

#### `len()`

Return the number of elements in the list.

**Return**:

- `count` (`integer`): Element count.

**Example**:

```lua
n = List({ "a", "b", "c" }):len() --> 3
```

> [!NOTE]
>
> Uses Lua's `#` operator.

### Access

Direct element access helpers. <a id="fn-first"></a>

#### `first()`

Return the first element or `nil` if empty.

**Return**:

- `value` (`any`): First value, or `nil` if empty.

**Example**:

```lua
v = List({ "a", "b" }):first() --> "a"
```

<a id="fn-last"></a>

#### `last()`

Return the last element or `nil` if empty.

**Return**:

- `value` (`any`): Last value, or `nil` if empty.

**Example**:

```lua
v = List({ "a", "b" }):last() --> "b"
```

### Transform

Non-mutating transformations and derived-list operations.
<a id="fn-difference"></a>

#### `difference(ls)`

Return a new list with values not in the given list.

**Parameters**:

- `ls` (`mods.List|any[]`): Other list value.

**Return**:

- `ls` (`T`): New list.

**Example**:

```lua
d = List({ "a", "b", "c" }):difference({ "b" }) --> { "a", "c" }
```

> [!NOTE]
>
> `difference` is also available through the `-` operator.

<a id="fn-drop"></a>

#### `drop(n)`

Return a new list without the first n elements.

**Parameters**:

- `n` (`integer`): Numeric value.

**Return**:

- `ls` (`mods.List`): New list.

**Example**:

```lua
t = List({ "a", "b", "c" }):drop(1) --> { "b", "c" }
```

<a id="fn-filter"></a>

#### `filter(pred)`

Return a new list with values matching the predicate.

**Parameters**:

- `pred` (`fun(v:any):boolean`): Predicate function.

**Return**:

- `ls` (`mods.List`): New list.

**Example**:

```lua
is_len_1 = function(v) return #v == 1 end
f = List({ "a", "bb", "c" }):filter(is_len_1) --> { "a", "c" }
```

<a id="fn-flatten"></a>

#### `flatten()`

Flatten one level of nested lists.

**Return**:

- `ls` (`mods.List`): New list.

**Example**:

```lua
f = List({ { "a", "b" }, { "c" } }):flatten() --> { "a", "b", "c" }
```

<a id="fn-foreach"></a>

#### `foreach(fn)`

Apply a function to each element (for side effects).

**Parameters**:

- `fn` (`fun(v:any)`): Callback function.

**Return**:

- `none` (`nil`)

**Example**:

```lua
List({ "a", "b" }):foreach(print)
--> prints -> a
--> prints -> b
```

<a id="fn-group-by"></a>

#### `group_by(fn)`

Group list values by a computed key.

**Parameters**:

- `fn` (`fun(v:any):any`): Callback function.

**Return**:

- `groups` (`table`): Groups keyed by the callback result.

**Example**:

```lua
words = { "aa", "b", "ccc", "dd" }
g = List(words):group_by(string.len) --> { {"b"}, { "aa", "dd" }, { "ccc" } }
```

<a id="fn-intersection"></a>

#### `intersection(ls)`

Return values that are also present in the given list.

**Parameters**:

- `ls` (`mods.List|any[]`): Other list value.

**Return**:

- `ls` (`mods.List`): New list.

**Example**:

```lua
i = List({ "a", "b", "a", "c" }):intersection({ "a", "c" })
--> { "a", "a", "c" }
```

> [!NOTE]
>
> Order is preserved from the original list.

<a id="fn-invert"></a>

#### `invert()`

Invert values to indices in a new table.

**Return**:

- `idxByValue` (`table`): Table mapping each value to its last index.

**Example**:

```lua
t = List({ "a", "b", "c" }):invert() --> { a = 1, b = 2, c = 3 }
```

<a id="fn-concat"></a>

#### `concat(sep?, i?, j?)`

Concatenate list values using Lua's native `table.concat` behavior.

**Parameters**:

- `sep?` (`string`): Optional separator value (defaults to `""`).
- `i?` (`integer`): Optional start index (defaults to `1`).
- `j?` (`integer`): Optional end index (defaults to `#self`).

**Return**:

- `s` (`string`): Concatenated string.

**Example**:

```lua
s = List({ "a", "b", "c" }):concat(",") --> "a,b,c"
```

> [!NOTE]
>
> This method forwards to `table.concat` directly and keeps its strict element
> rules.

<a id="fn-join"></a>

#### `join(sep?, quoted?)`

Join list values into a string.

**Parameters**:

- `sep?` (`string`): Optional separator value (defaults to `""`).
- `quoted?` (`boolean`): Optional boolean flag (defaults to `false`).

**Return**:

- `s` (`string`): Joined string.

**Example**:

```lua
s = List({ "a", "b", "c" }):join(",")        --> "a,b,c"
s = List({ "a", "b", "c" }):join(", ", true) --> '"a", "b", "c"'
```

> [!NOTE]
>
> Values are converted with `tostring` before joining. Set `quoted = true` to
> quote string values.

<a id="fn-tostring"></a>

#### `tostring()`

Render the list to a string via the regular method form.

**Return**:

- `s` (`string`): Rendered list string.

**Example**:

```lua
s = List({ "a", "b", 1 }):tostring() --> '{ "a", "b", 1 }'
```

> [!NOTE]
>
> `tostring(list)` calls `list:tostring()`.

<a id="fn-keypath"></a>

#### `keypath()`

Render list items as a table-access key path.

**Return**:

- `s` (`string`): Key-path string.

**Example**:

```lua
p = List({ "ctx", "users", 1, "name" }):keypath() --> "ctx.users[1].name"
```

<a id="fn-map"></a>

#### `map(fn)`

Return a new list by mapping each value.

**Parameters**:

- `fn` (`fun(v):any`): Callback function.

**Return**:

- `ls` (`mods.List`): New list.

**Example**:

```lua
to_upper = function(v) return v:upper() end
m = List({ "a", "b" }):map(to_upper) --> { "A", "B" }
```

<a id="fn-mul"></a>

#### `mul(n)`

Return a new list repeated `n` times (list multiplication behavior).

**Parameters**:

- `n` (`integer`): Numeric value.

**Return**:

- `ls` (`mods.List`): New list.

**Example**:

```lua
ls = List({ "a", "b" }):mul(3) --> { "a", "b", "a", "b", "a", "b" }
```

> [!NOTE]
>
> `mul` is also available through the `*` operator.

<a id="fn-reduce"></a>

#### `reduce(fn, init?)`

Reduce the list to a single value using an accumulator.

**Parameters**:

- `fn` (`fun(acc:any,`): v:any):any Reducer function.
- `init?` (`any`): Optional initial accumulator; for non-empty lists, `nil` or
  omitted uses the first item.

**Return**:

- `res` (`any`): Reduced value.

**Example**:

```lua
add = function(acc, v) return acc + v end
sum = List({ 1, 2, 3 }):reduce(add, 0) --> 6
sum = List({ 1, 2, 3 }):reduce(add, 10) --> 16
```

> [!NOTE]
>
> For empty lists, returns `init` unchanged (or `nil` when omitted).

<a id="fn-reverse"></a>

#### `reverse()`

Return a new list with items reversed.

**Return**:

- `ls` (`mods.List`): New list.

**Example**:

```lua
r = List({ "a", "b", "c" }):reverse() --> { "c", "b", "a" }
```

<a id="fn-toset"></a>

#### `toset()`

Convert the list to a set.

**Return**:

- `set` (`mods.Set`): New set.

**Example**:

```lua
s = List({ "a", "b", "a" }):toset() --> { a = true, b = true }
```

> [!NOTE]
>
> Order is preserved from the original list.

<a id="fn-slice"></a>

#### `slice(i?, j?)`

Return a new list containing items from i to j (inclusive).

**Parameters**:

- `i?` (`integer`): Optional start index (defaults to `1`).
- `j?` (`integer`): Optional end index (defaults to `#self`).

**Return**:

- `ls` (`mods.List`): New list.

**Example**:

```lua
t = List({ "a", "b", "c", "d" }):slice(2, 3) --> { "b", "c" }
```

> [!NOTE]
>
> Supports negative indices (-1 is last element).

<a id="fn-take"></a>

#### `take(n)`

Return the first n elements as a new list.

**Parameters**:

- `n` (`integer`): Numeric value.

**Return**:

- `ls` (`mods.List`): New list.

**Example**:

```lua
t = List({ "a", "b", "c" }):take(2) --> { "a", "b" }
```

<a id="fn-uniq"></a>

#### `uniq()`

Return a new list with duplicates removed (first occurrence kept).

**Return**:

- `ls` (`mods.List`): New list.

**Example**:

```lua
u = List({ "a", "b", "a", "c" }):uniq() --> { "a", "b", "c" }
```

<a id="fn-zip"></a>

#### `zip(ls)`

Zip two lists into a list of 2-element tables.

**Parameters**:

- `ls` (`mods.List|any[]`): Other list value.

**Return**:

- `ls` (`mods.List`): New list.

**Example**:

```lua
z = List({ "a", "b" }):zip({ 1, 2 }) --> { {"a",1}, {"b",2} }
```

> [!NOTE]
>
> Length is the minimum of both lists.

### Metamethods

<a id="fn-eq"></a>

#### `__eq(ls)`

Compare two lists using shallow element equality (`==`).

**Parameters**:

- `ls` (`mods.List|any[]`): Other list value.

**Return**:

- `ok` (`boolean`): Whether the condition is met.

**Example**:

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
> - `==` returns `false` for `List` vs plain-table comparisons. Use
>   `:equals(ls)` for `List` vs plain-table comparisons.
>
>   ```lua
>   t = { "a", 1 }
>   a = List(t)
>   b = { "a", 1 }
>   ok = (a == b)     --> false
>   ok = a:equals(b) --> true
>   ```
>
> - Like `:equals(ls)`, `==` compares only array positions (`1..#list`), so
>   extra non-array keys are ignored when both operands are `List`.
>
>   ```lua
>   a = List({ "a", t })
>   b = List({ "a", t, extra = 1 })
>   ok = (a == b) --> true
>   ```

<a id="fn-lt"></a>

#### `__lt(ls)`

Compare two lists lexicographically (`<`).

**Parameters**:

- `ls` (`mods.List|any[]`): Other list value.

**Return**:

- `ok` (`boolean`): Whether the condition is met.

**Example**:

```lua
ok = List({ 1, 2 }) < List({ 1, 3 }) --> true
```

> [!NOTE]
>
> `<` is equivalent to `:lt(ls)`.

<a id="fn-le"></a>

#### `__le(ls)`

Compare two lists lexicographically (`<=`).

**Parameters**:

- `ls` (`mods.List|any[]`): Other list value.

**Return**:

- `ok` (`boolean`): Whether the condition is met.

**Example**:

```lua
ok = List({ 1, 2 }) <= List({ 1, 2 }) --> true
```

> [!NOTE]
>
> `<=` is equivalent to `:le(ls)`.

<a id="fn-mul"></a>

#### `__mul(n)`

Repeat a list `n` times (`*`).

**Parameters**:

- `n` (`integer|mods.List`): Right operand.

**Return**:

- `ls` (`mods.List`): New list.

**Example**:

```lua
l1 = List({ "a", "b" }) * 3 --> { "a", "b", "a", "b", "a", "b" }
l2 = 3 * List({ "a", "b" }) --> { "a", "b", "a", "b", "a", "b" }
```

> [!NOTE]
>
> `*` is equivalent to `:mul(n)`.

<a id="fn-add"></a>

#### `__add(ls)`

Extend the left-hand list in place with right-hand values, then return the same
left-hand list reference (`+`).

**Parameters**:

- `ls` (`mods.List|any[]`): Other list value.

**Return**:

- `self` (`mods.List|any[]`): Current list instance.

**Example**:

```lua
a = List({ "a", "b" })
b = { "c", "d" }
c = a + b --> c and a are the same reference: { "a", "b", "c", "d" }
```

> [!NOTE]
>
> `+` operator is equivalent to `:extend(ls)`.

<a id="fn-sub"></a>

#### `__sub(ls)`

Return values from the left list that are not present in the right list (`-`).

**Parameters**:

- `ls` (`mods.List|any[]`): Other list value.

**Return**:

- `ls` (`mods.List`): New list.

**Example**:

```lua
a = List({ "a", "b", "c" })
b = { "b" }
d = a - b --> { "a", "c" }
```

> [!NOTE]
>
> `-` operator is equivalent to `:difference(ls)`.

<a id="fn-tostring"></a>

#### `__tostring()`

Render the list to a string like `{ "a", "b", 1 }`.

**Return**:

- `s` (`string`): Rendered list string.

**Example**:

```lua
s = tostring(List({ "a", "b", 1 })) --> '{ "a", "b", 1 }'
```

> [!NOTE]
>
> `tostring(ls)` is equivalent to `:tostring()`.
