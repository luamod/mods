---
description:
  "Shared generic path helpers used by platform-specific path modules."
---

# `path`

Shared generic path helpers used by platform-specific path modules.
<a id="fn-splitext"></a>

## `_splitext(path, sep, altsep?, extsep)`

Split extension from a path. Follows Python `genericpath._splitext` semantics.

**Parameters**:

- `path` (`string`)
- `sep` (`string`)
- `altsep?` (`string`)
- `extsep` (`string`)

**Return**:

- `root` (`string`)
- `ext` (`string`)

**Example**:

```lua
local root, ext = path._splitext("archive.tar.gz", "/", nil, ".")
print(root, ext) --> "archive.tar", ".gz"
```
