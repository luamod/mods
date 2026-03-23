---
description: "Filesystem I/O, metadata, and filesystem path operations."
---

# `fs`

Filesystem I/O, metadata, and filesystem path operations.

## Usage

```lua
fs = require "mods.fs"

fs.mkdir("tmp/cache/app", true)
fs.write_text("tmp/cache/app/data.txt", "hello")
print(fs.read_text("tmp/cache/app/data.txt")) --> "hello"
```

## Functions

**Reading**:

| Function                              | Description                            |
| ------------------------------------- | -------------------------------------- |
| [`read_bytes(path)`](#fn-read-bytes)  | Read full file in binary mode.         |
| [`read_text(path)`](#fn-read-text)    | Read full file in text mode.           |
| [`dir(path, opts?)`](#fn-dir)         | Iterator over items in `path`.         |
| [`listdir(path, opts?)`](#fn-listdir) | Return direct children of a directory. |

**Writing**:

| Function                                     | Description                                                                   |
| -------------------------------------------- | ----------------------------------------------------------------------------- |
| [`write_bytes(path, data)`](#fn-write-bytes) | Write full file in binary mode.                                               |
| [`write_text(path, data)`](#fn-write-text)   | Write full file in text mode.                                                 |
| [`touch(path)`](#fn-touch)                   | Create file if missing without truncating, or update timestamps if it exists. |
| [`rename(oldname, newname)`](#fn-rename)     | Rename or move a filesystem entry.                                            |
| [`rm(path, recursive?)`](#fn-rm)             | Remove a filesystem entry, or a directory tree when `recursive` is `true`.    |
| [`mkdir(path, parents?)`](#fn-mkdir)         | Create a directory.                                                           |
| [`cp(src, dst)`](#fn-cp)                     | Copy a file or directory tree.                                                |

**Metadata**:

| Function                                   | Description                                                                        |
| ------------------------------------------ | ---------------------------------------------------------------------------------- |
| [`getsize(path)`](#fn-getsize)             | Return file size in bytes.                                                         |
| [`getatime(path)`](#fn-getatime)           | Return last access time.                                                           |
| [`getmtime(path)`](#fn-getmtime)           | Return last modification time.                                                     |
| [`getctime(path)`](#fn-getctime)           | Return metadata change time.                                                       |
| [`lstat(path)`](#fn-lstat)                 | Return symlink-aware file attributes.                                              |
| [`stat(path)`](#fn-stat)                   | Return file attributes.                                                            |
| [`samefile(path_a, path_b)`](#fn-samefile) | Return whether two paths refer to the same file, or `nil` and an error on failure. |

**Existence Checks**:

| Function                       | Description                                                  |
| ------------------------------ | ------------------------------------------------------------ |
| [`exists(path)`](#fn-exists)   | Return `true` when a path exists.                            |
| [`lexists(path)`](#fn-lexists) | Return `true` when a path exists without following symlinks. |

### Reading

<a id="fn-read-bytes"></a>

#### `read_bytes(path)`

Read full file in binary mode.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `body` (`string?`): File contents read in binary mode, or `nil` on failure.
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.read_bytes("README.md")
```

<a id="fn-read-text"></a>

#### `read_text(path)`

Read full file in text mode.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `body` (`string?`): File contents read in text mode, or `nil` on failure.
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.read_text("README.md")
```

<a id="fn-dir"></a>

#### `dir(path, opts?)`

Iterator over items in `path`.

**Parameters**:

- `path` (`string`): Input path.
- `opts?`
  (`{hidden?:boolean, recursive?:boolean, follow_links?:boolean, type?:string}`):
  Optional traversal options.

**Return**:

- `iterator`
  (`(fun(state:table, prev?:string):basename:string?, type:"file"|"directory"|"link"|"fifo"|"socket"|"char"|"block"|"unknown"?)?`):
  Iterator, or `nil` on failure.
- `state` (`table|string`): Iterator state on success, or error message on
  failure.

**Example**:

```lua
for name, type in fs.dir(path.cwd(), { recursive = true }) do
  print(name, type)
end
```

<a id="fn-listdir"></a>

#### `listdir(path, opts?)`

Return direct children of a directory.

**Parameters**:

- `path` (`string`): Input path.
- `opts?`
  (`{hidden?:boolean, recursive?:boolean, follow_links?:boolean, type?:string}`):
  Optional traversal options.

**Return**:

- `paths` (`mods.List<string>?`): Direct child paths.
- `err` (`string?`): Error message when traversal setup fails.

**Example**:

```lua
fs.listdir("src")
```

### Writing

<a id="fn-write-bytes"></a>

#### `write_bytes(path, data)`

Write full file in binary mode.

**Parameters**:

- `path` (`string`): Input path.
- `data` (`string`): Input data.

**Return**:

- `written` (`true?`): `true` when writing succeeds, or `nil` on failure.
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.write_bytes("tmp.bin", "abc") --> true, nil
```

<a id="fn-write-text"></a>

#### `write_text(path, data)`

Write full file in text mode.

**Parameters**:

- `path` (`string`): Input path.
- `data` (`string`): Input data.

**Return**:

- `written` (`true?`): `true` when writing succeeds, or `nil` on failure.
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.write_text("tmp.txt", "abc") --> true, nil
```

<a id="fn-touch"></a>

#### `touch(path)`

Create file if missing without truncating, or update timestamps if it exists.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `touched` (`true?`): `true` when the file exists after touch, or `nil` on
  failure.
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.touch("tmp.txt") --> true, nil
```

<a id="fn-rename"></a>

#### `rename(oldname, newname)`

Rename or move a filesystem entry.

**Parameters**:

- `oldname` (`string`): Existing path.
- `newname` (`string`): Replacement path.

**Return**:

- `renamed` (`true?`): `true` when the rename succeeds, or `nil` on failure.
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.rename("old.txt", "new.txt")
```

> [!NOTE]
>
> This is an alias for `os.rename`.

<a id="fn-rm"></a>

#### `rm(path, recursive?)`

Remove a filesystem entry, or a directory tree when `recursive` is `true`.

**Parameters**:

- `path` (`string`): Input path.
- `recursive?` (`boolean`): Remove a directory tree recursively when `true`.

**Return**:

- `removed` (`true?`): `true` when removal succeeds, or `nil` on failure.
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.rm("tmp.txt") --> true, nil
fs.rm("tmp/cache", true) --> true, nil
```

<a id="fn-mkdir"></a>

#### `mkdir(path, parents?)`

Create a directory.

**Parameters**:

- `path` (`string`): Input path.
- `parents?` (`boolean`): Create missing parent directories when `true`.

**Return**:

- `created` (`true?`): `true` when directory creation succeeds, or `nil` on
  failure.
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.mkdir("tmp/a/b", true)
```

<a id="fn-cp"></a>

#### `cp(src, dst)`

Copy a file or directory tree.

**Parameters**:

- `src` (`string`): Source path.
- `dst` (`string`): Destination path.

**Return**:

- `copied` (`true?`): `true` when copying succeeds, or `nil` on failure.
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.cp("a.txt", "b.txt")
fs.cp("src", "backup/src")
```

### Metadata

<a id="fn-getsize"></a>

#### `getsize(path)`

Return file size in bytes.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `size` (`integer?`): File size in bytes.
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.getsize("README.md") --> 1234
```

<a id="fn-getatime"></a>

#### `getatime(path)`

Return last access time.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `timestamp` (`number?`): Access time (seconds since epoch).
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.getatime("README.md") --> 1712345678
```

<a id="fn-getmtime"></a>

#### `getmtime(path)`

Return last modification time.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `timestamp` (`number?`): Modification time (seconds since epoch).
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.getmtime("README.md") --> 1712345678
```

<a id="fn-getctime"></a>

#### `getctime(path)`

Return metadata change time.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `timestamp` (`number?`): Change time (seconds since epoch).
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.getctime("README.md") --> 1712345678
```

<a id="fn-lstat"></a>

#### `lstat(path)`

Return symlink-aware file attributes.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `attrs` (`LuaFileSystem.Attributes?`): Symlink-aware attributes, or `nil` on
  failure.
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.lstat("README.md")
```

<a id="fn-stat"></a>

#### `stat(path)`

Return file attributes.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `attrs`
  (`string|integer|LuaFileSystem.AttributeMode|LuaFileSystem.Attributes?`): File
  attributes, or `nil` on failure.
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.stat("README.md")
```

<a id="fn-samefile"></a>

#### `samefile(path_a, path_b)`

Return whether two paths refer to the same file, or `nil` and an error on
failure.

**Parameters**:

- `path_a` (`string`): Input path.
- `path_b` (`string`): Input path.

**Return**:

- `isSameFile` (`boolean?`): True when both paths refer to the same file.
- `errmsg` (`string?`): Error message when the check fails.
- `errcode` (`integer?`): OS error code when available.

**Example**:

```lua
fs.samefile("README.md", "README.md") --> true
```

### Existence Checks

<a id="fn-exists"></a>

#### `exists(path)`

Return `true` when a path exists.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `exists` (`boolean`): True when the path exists.

**Example**:

```lua
fs.exists("README.md") --> true
```

> [!NOTE]
>
> Broken symlinks return `false`.

<a id="fn-lexists"></a>

#### `lexists(path)`

Return `true` when a path exists without following symlinks.

**Parameters**:

- `path` (`string`): Input path.

**Return**:

- `exists` (`boolean`): True when the path or symlink entry exists.

**Example**:

```lua
fs.lexists("README.md") --> true
```

> [!NOTE]
>
> Broken symlinks return `true`.
