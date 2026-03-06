---
description: "Lexical path operations for Windows/NT-style paths."
---

# `ntpath`

Lexical path operations for Windows/NT-style paths.

> [!NOTE]
>
> Python `ntpath`-style behavior, ported to Lua.

## Usage

```lua
ntpath = require "mods.ntpath"

print(ntpath.join([[C:\]], "Users", "me")) --> "C:\Users\me"
```

## Functions

**Normalization & Predicates**:

| Function                             | Description                                                |
| ------------------------------------ | ---------------------------------------------------------- |
| [`normcase(s)`](#fn-normcase)        | Normalize case and separators for NT paths.                |
| [`isabs(path)`](#fn-isabs)           | Return `true` when `path` is absolute under NT rules.      |
| [`ismount(path)`](#fn-ismount)       | Return `true` when `path` points to a mount root.          |
| [`isreserved(path)`](#fn-isreserved) | Return `true` when `path` contains a reserved NT filename. |

**Path Decomposition**:

| Function                             | Description                                        |
| ------------------------------------ | -------------------------------------------------- |
| [`join(path, ...)`](#fn-join)        | Join one or more path components.                  |
| [`split(path)`](#fn-split)           | Split path into directory head and tail component. |
| [`splitext(path)`](#fn-splitext)     | Split path into a root and extension.              |
| [`splitdrive(path)`](#fn-splitdrive) | Split drive prefix from remainder.                 |
| [`splitroot(path)`](#fn-splitroot)   | Split path into drive, root, and tail components.  |
| [`basename(path)`](#fn-basename)     | Return final path component.                       |
| [`dirname(path)`](#fn-dirname)       | Return directory portion of a path.                |

**Environment Expand**:

| Function                             | Description                             |
| ------------------------------------ | --------------------------------------- |
| [`expanduser(path)`](#fn-expanduser) | Expand `~` home segment when available. |

**Derived Paths**:

| Function                               | Description                                      |
| -------------------------------------- | ------------------------------------------------ |
| [`normpath(path)`](#fn-normpath)       | Normalize separators and dot segments.           |
| [`abspath(path)`](#fn-abspath)         | Return normalized absolute path.                 |
| [`relpath(path, start?)`](#fn-relpath) | Return `path` relative to optional `start` path. |
| [`commonpath(paths)`](#fn-commonpath)  | Return longest common sub-path from a path list. |

### Normalization & Predicates

<a id="fn-normcase"></a>

#### `normcase(s)`

Normalize case and separators for NT paths.

**Parameters**:

- `s` (`string`): Path string to normalize.

**Return**:

- `value` (`string`): Normalized lowercase path with `\` separators.

**Example**:

```lua
ntpath.normcase([[A/B\C]]) --> [[a\b\c]]
```

<a id="fn-isabs"></a>

#### `isabs(path)`

Return `true` when `path` is absolute under NT rules.

**Parameters**:

- `path` (`string`): Path to inspect.

**Return**:

- `value` (`boolean`): `true` if the path is absolute.

**Example**:

```lua
ntpath.isabs([[C:\a]]) --> true
```

<a id="fn-ismount"></a>

#### `ismount(path)`

Return `true` when `path` points to a mount root.

**Parameters**:

- `path` (`string`): Path to inspect.

**Return**:

- `value` (`boolean`): `true` if the path resolves to a mount root.

**Example**:

```lua
ntpath.ismount([[C:\]]) --> true
```

<a id="fn-isreserved"></a>

#### `isreserved(path)`

Return `true` when `path` contains a reserved NT filename.

**Parameters**:

- `path` (`string`): Path to inspect.

**Return**:

- `value` (`boolean`): `true` if any component is NT-reserved.

**Example**:

```lua
ntpath.isreserved([[a\CON.txt]]) --> true
```

### Path Decomposition

<a id="fn-join"></a>

#### `join(path, ...)`

Join one or more path components.

**Parameters**:

- `path` (`string`): Base path component.
- `...` (`string`): Additional path components to append.

**Return**:

- `value` (`string`): Joined NT path.

**Example**:

```lua
ntpath.join([[C:\a]], [[b]]) --> [[C:\a\b]]
```

<a id="fn-split"></a>

#### `split(path)`

Split path into directory head and tail component.

**Parameters**:

- `path` (`string`): Path to split.

**Return**:

- `head` (`string`): Directory portion of the path.
- `tail` (`string`): Final path component.

**Example**:

```lua
ntpath.split([[C:\a\b.txt]]) --> [[C:\a]], "b.txt"
```

<a id="fn-splitext"></a>

#### `splitext(path)`

Split path into a root and extension.

**Parameters**:

- `path` (`string`): Path to split.

**Return**:

- `root` (`string`): Path without the final extension.
- `ext` (`string`): Final extension, including the leading dot when present.

**Example**:

```lua
ntpath.splitext("archive.tar.gz") --> "archive.tar", ".gz"
```

<a id="fn-splitdrive"></a>

#### `splitdrive(path)`

Split drive prefix from remainder.

**Parameters**:

- `path` (`string`): Path to split.

**Return**:

- `drive` (`string`): Drive or UNC share prefix.
- `rest` (`string`): Remaining path after the drive prefix.

**Example**:

```lua
ntpath.splitdrive([[C:\a\b]]) --> "C:", [[\a\b]]
```

<a id="fn-splitroot"></a>

#### `splitroot(path)`

Split path into drive, root, and tail components.

**Parameters**:

- `path` (`string`): Path to split.

**Return**:

- `drive` (`string`): Drive or UNC share prefix.
- `root` (`string`): Root separator portion.
- `tail` (`string`): Remaining path after drive and root.

**Example**:

```lua
ntpath.splitroot([[C:\a\b]]) --> "C:", [[\]], "a\\b"
```

<a id="fn-basename"></a>

#### `basename(path)`

Return final path component.

**Parameters**:

- `path` (`string`): Path to inspect.

**Return**:

- `value` (`string`): Final component of the path.

**Example**:

```lua
ntpath.basename([[C:\a\b.txt]]) --> "b.txt"
```

<a id="fn-dirname"></a>

#### `dirname(path)`

Return directory portion of a path.

**Parameters**:

- `path` (`string`): Path to inspect.

**Return**:

- `value` (`string`): Directory portion of the path.

**Example**:

```lua
ntpath.dirname([[C:\a\b.txt]]) --> [[C:\a]]
```

### Environment Expand

<a id="fn-expanduser"></a>

#### `expanduser(path)`

Expand `~` home segment when available.

**Parameters**:

- `path` (`string`): Path that may begin with `~`.

**Return**:

- `value` (`string`): Path with the home segment expanded when available.

**Example**:

```lua
ntpath.expanduser([[x\y]]) --> [[x\y]]
```

### Derived Paths

<a id="fn-normpath"></a>

#### `normpath(path)`

Normalize separators and dot segments.

**Parameters**:

- `path` (`string`): Path to normalize.

**Return**:

- `value` (`string`): Normalized NT path with dot segments resolved lexically.

**Example**:

```lua
ntpath.normpath([[A/foo/../B]]) --> [[A\B]]
```

<a id="fn-abspath"></a>

#### `abspath(path)`

Return normalized absolute path.

**Parameters**:

- `path` (`string`): Path to absolutize.

**Return**:

- `value` (`string`): Normalized absolute NT path.

**Example**:

```lua
ntpath.abspath([[C:\a\..\b]]) --> [[C:\b]]
```

<a id="fn-relpath"></a>

#### `relpath(path, start?)`

Return `path` relative to optional `start` path.

**Parameters**:

- `path` (`string`): Target path.
- `start?` (`string`): Optional start path used as the base.

**Return**:

- `value` (`string`): Relative path from `start` to `path`.

**Example**:

```lua
ntpath.relpath([[C:\a\b\c]], [[C:\a]]) --> [[b\c]]
```

<a id="fn-commonpath"></a>

#### `commonpath(paths)`

Return longest common sub-path from a path list.

**Parameters**:

- `paths` (`string[]`): Input NT paths.

**Return**:

- `value` (`string`): Longest common sub-path.

**Example**:

```lua
ntpath.commonpath({ [[C:\a\b\c]], [[c:/a/b/d]] }) --> [[C:\a\b]]
```
