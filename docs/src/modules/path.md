---
description: "Generic cross-platform path API."
---

# `path`

Generic cross-platform path API.

## Usage

```lua
path = require "mods.path"

print(path.join("src", "mods", "path.lua")) --> "src/mods/path.lua"
print(path.normpath("a//b/./c")) --> "a/b/c"
print(path.splitext("archive.tar.gz")) --> "archive.tar", ".gz"
```

## Functions

**Normalization & Predicates**:

| Function                             | Description                                                |
| ------------------------------------ | ---------------------------------------------------------- |
| [`normcase(s)`](#fn-normcase)        | Normalize case for POSIX paths.                            |
| [`join(path, ...)`](#fn-join)        | Join path components.                                      |
| [`normpath(path)`](#fn-normpath)     | Normalize separators and dot segments.                     |
| [`isabs(path)`](#fn-isabs)           | Return `true` when `path` is absolute.                     |
| [`ismount(path)`](#fn-ismount)       | Return `true` when `path` points to a mount root.          |
| [`isreserved(path)`](#fn-isreserved) | Return `true` when `path` contains a reserved NT filename. |

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
> This is a (no-op for POSIX semantics).

**Parameters**:

- `s` (`string`): Input path value.

**Return**:

- `value` (`string`): Path after POSIX case normalization.

**Example**:

```lua
path.normcase("/A/B") --> "/A/B"
```

<a id="fn-join"></a>

#### `join(path, ...)`

Join path components.

> [!NOTE]
>
> Single input is returned as-is.

**Parameters**:

- `path` (`string`): Base path component.
- `...` (`string`): Additional path components.

**Return**:

- `value` (`string`): Joined POSIX path.

**Example**:

```lua
path.join("/usr", "bin") --> "/usr/bin"
path.join([[C:\a]], [[b]]) --> [[C:\a\b]]
```

<a id="fn-normpath"></a>

#### `normpath(path)`

Normalize separators and dot segments.

**Parameters**:

- `path` (`string`): Path to normalize.

**Return**:

- `value` (`string`): Normalized path.

**Example**:

```lua
path.normpath("/a//./b/..") --> "/a"
path.normpath([[A/foo/../B]]) --> [[A\B]]
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
path.isabs("/a/b") --> true
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
path.ismount([[C:\]]) --> true
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
path.isreserved([[a\CON.txt]]) --> true
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
path.split("/a/b.txt") --> "/a", "b.txt"
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
path.splitext("archive.tar.gz") --> "archive.tar", ".gz"
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
path.splitdrive("/a/b") --> "", "/a/b"
```

> [!NOTE]
>
> Split drive prefix (always empty on POSIX) from remainder.

<a id="fn-splitroot"></a>

#### `splitroot(path)`

Split path into drive, root, and tail components.

**Parameters**:

- `path` (`string`): Path to split.

**Return**:

- `drive` (`string`): Drive prefix (always empty on POSIX).
- `root` (`string`): Root separator segment.
- `tail` (`string`): Remaining path without leading root separator.

**Example**:

```lua
path.splitroot("/a/b")     --> "", "/", "a/b"
path.splitroot([[C:\a\b]]) --> "C:", [[\]], "a\\b"
```

<a id="fn-basename"></a>

#### `basename(path)`

Return final path component.

**Parameters**:

- `path` (`string`): Path to inspect.

**Return**:

- `value` (`string`): Final path component.

**Example**:

```lua
path.basename("/a/b.txt")     --> "b.txt"
path.basename([[C:\a\b.txt]]) --> "b.txt"
```

<a id="fn-dirname"></a>

#### `dirname(path)`

Return directory portion of a path.

**Parameters**:

- `path` (`string`): Path to inspect.

**Return**:

- `value` (`string`): Parent directory path.

**Example**:

```lua
path.dirname("/a/b.txt")     --> "/a"
path.dirname([[C:\a\b.txt]]) --> [[C:\a]]
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
path.expanduser("~/tmp") --> "<HOME>/tmp" (when HOME is set)
path.expanduser([[x\y]]) --> [[x\y]]
```

### Derived Paths

<a id="fn-abspath"></a>

#### `abspath(path)`

Return normalized absolute path.

**Parameters**:

- `path` (`string`): Path to absolutize.

**Return**:

- `value` (`string`): Absolute normalized path.

**Example**:

```lua
path.abspath("/a/./b")      --> "/a/b"
path.abspath([[C:\a\..\b]]) --> [[C:\b]]
```

<a id="fn-relpath"></a>

#### `relpath(path, start?)`

Return `path` relative to optional `start` path.

**Parameters**:

- `path` (`string`): Input path.
- `start?` (`string`): Optional base path.

**Return**:

- `value` (`string`): Relative path from `start` to `path`.

**Example**:

```lua
path.relpath("/a/b/c", "/a")         --> "b/c"
path.relpath([[C:\a\b\c]], [[C:\a]]) --> [[b\c]]
```

<a id="fn-commonpath"></a>

#### `commonpath(paths)`

Return longest common sub-path from a path list.

**Parameters**:

- `paths` (`string[]`): List of POSIX paths.

**Return**:

- `value` (`string`): Longest common sub-path.

**Example**:

```lua
path.commonpath({ "/a/b/c", "/a/b/d" })         --> "/a/b"
path.commonpath({ [[C:\a\b\c]], [[c:/a/b/d]] }) --> [[C:\a\b]]
```
