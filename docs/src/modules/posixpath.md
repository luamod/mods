---
description: "Lexical path operations for POSIX-style paths."
---

# `posixpath`

Lexical path operations for POSIX-style paths.

> [!NOTE]
>
> Python `posixpath`-style behavior, ported to Lua.

## Usage

```lua
posixpath = require "mods.posixpath"

print(posixpath.join("/usr", "bin")) --> "/usr/bin"
```

## Functions

**Normalization & Predicates**:

| Function                         | Description                            |
| -------------------------------- | -------------------------------------- |
| [`normcase(s)`](#fn-normcase)    | Normalize case for POSIX paths.        |
| [`join(a, ...)`](#fn-join)       | Join path components.                  |
| [`normpath(path)`](#fn-normpath) | Normalize separators and dot segments. |
| [`isabs(path)`](#fn-isabs)       | Return `true` when `path` is absolute. |

**Path Decomposition**:

| Function                             | Description                                        |
| ------------------------------------ | -------------------------------------------------- |
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
| [`abspath(path)`](#fn-abspath)         | Return normalized absolute path.                 |
| [`relpath(path, start?)`](#fn-relpath) | Return `path` relative to optional `start` path. |
| [`commonpath(paths)`](#fn-commonpath)  | Return longest common sub-path from a path list. |

### Normalization & Predicates

<a id="fn-normcase"></a>

#### `normcase(s)`

Normalize case for POSIX paths.

> [!NOTE]
>
> This is a no-op for POSIX semantics.

**Parameters**:

- `s` (`string`): Input path value.

**Return**:

- `value` (`string`): Path after POSIX case normalization.

**Example**:

```lua
posixpath.normcase("/A/B") --> "/A/B"
```

<a id="fn-join"></a>

#### `join(a, ...)`

Join path components.

> [!NOTE]
>
> Single input is returned as-is.

**Parameters**:

- `a` (`string`): First path component.
- `...` (`string`): Additional path components.

**Return**:

- `value` (`string`): Joined POSIX path.

**Example**:

```lua
posixpath.join("/usr", "bin") --> "/usr/bin"
```

<a id="fn-normpath"></a>

#### `normpath(path)`

Normalize separators and dot segments.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `value` (`string`): Normalized path.

**Example**:

```lua
posixpath.normpath("/a//./b/..") --> "/a"
```

<a id="fn-isabs"></a>

#### `isabs(path)`

Return `true` when `path` is absolute.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `value` (`boolean`): True when `path` is absolute.

**Example**:

```lua
posixpath.isabs("/a/b") --> true
```

### Path Decomposition

<a id="fn-split"></a>

#### `split(path)`

Split path into directory head and tail component.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `head` (`string`): Directory portion.
- `tail` (`string`): Final path component.

**Example**:

```lua
posixpath.split("/a/b.txt") --> "/a", "b.txt"
```

<a id="fn-splitext"></a>

#### `splitext(path)`

Split path into a root and extension.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `root` (`string`): Path without the final extension.
- `ext` (`string`): Final extension including leading dot.

**Example**:

```lua
posixpath.splitext("archive.tar.gz") --> "archive.tar", ".gz"
```

<a id="fn-splitdrive"></a>

#### `splitdrive(path)`

Split drive prefix from remainder.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `drive` (`string`): Drive prefix (always empty on POSIX).
- `rest` (`string`): Path remainder.

**Example**:

```lua
posixpath.splitdrive("/a/b") --> "", "/a/b"
```

> [!NOTE]
>
> Split drive prefix (always empty on POSIX) from remainder.

<a id="fn-splitroot"></a>

#### `splitroot(path)`

Split path into drive, root, and tail components.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `drive` (`string`): Drive prefix (always empty on POSIX).
- `root` (`string`): Root separator segment.
- `tail` (`string`): Remaining path without leading root separator.

**Example**:

```lua
posixpath.splitroot("/a/b") --> "", "/", "a/b"
```

<a id="fn-basename"></a>

#### `basename(path)`

Return final path component.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `value` (`string`): Final path component.

**Example**:

```lua
posixpath.basename("/a/b.txt") --> "b.txt"
```

<a id="fn-dirname"></a>

#### `dirname(path)`

Return directory portion of a path.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `value` (`string`): Parent directory path.

**Example**:

```lua
posixpath.dirname("/a/b.txt") --> "/a"
```

### Environment Expand

<a id="fn-expanduser"></a>

#### `expanduser(path)`

Expand `~` home segment when available.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `value` (`string`): Path with `~` expanded when possible.

**Example**:

```lua
posixpath.expanduser("~/tmp") --> "<HOME>/tmp" (when HOME is set)
```

### Derived Paths

<a id="fn-abspath"></a>

#### `abspath(path)`

Return normalized absolute path.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `value` (`string`): Absolute normalized path.

**Example**:

```lua
posixpath.abspath("/a/./b") --> "/a/b"
```

<a id="fn-relpath"></a>

#### `relpath(path, start?)`

Return `path` relative to optional `start` path.

**Parameters**:

- `path` (`string`): Input path.
- `start?` (`string`): Optional base path.

**Return**:

- `value` (`string`): Path relative to `start` (or current directory when
  omitted).

**Example**:

```lua
posixpath.relpath("/a/b/c", "/a") --> "b/c"
```

<a id="fn-commonpath"></a>

#### `commonpath(paths)`

Return longest common sub-path from a path list.

**Parameters**:

- `paths` (`string[]`): List of POSIX paths.

**Return**:

- `value` (`string`): Longest common sub-path, or empty string when `paths` is
  empty.

**Example**:

```lua
posixpath.commonpath({ "/a/b/c", "/a/b/d" }) --> "/a/b"
```
