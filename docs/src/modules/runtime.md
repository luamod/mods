---
desc: "Exposes Lua runtime metadata and version compatibility flags."
---

# `runtime`

Exposes Lua runtime metadata and version compatibility flags.

## Usage

```lua
runtime = require "mods.runtime"

print(runtime.version)     --> "Lua 5.x"
print(runtime.version_num) --> 501 | 502 | 503 | 504
print(runtime.is_lua54)    --> true | false
```

## Fields

| Field                         | Description                                       |
| ----------------------------- | ------------------------------------------------- |
| [`version`](#version)         | Version string reported by the runtime.           |
| [`major`](#major)             | Major version number parsed from `version`.       |
| [`minor`](#minor)             | Minor version number parsed from `version`.       |
| [`version_num`](#version-num) | Numeric version encoded as `major * 100 + minor`. |
| [`is_luajit`](#is-luajit)     | True when running under LuaJIT.                   |
| [`is_lua51`](#is-lua51)       | True only on Lua 5.1 runtimes.                    |
| [`is_lua52`](#is-lua52)       | True only on Lua 5.2 runtimes.                    |
| [`is_lua53`](#is-lua53)       | True only on Lua 5.3 runtimes.                    |
| [`is_lua54`](#is-lua54)       | True only on Lua 5.4 runtimes.                    |

### `version`

Version string reported by the runtime.

```lua
print(runtime.version) --> "Lua 5.x"
```

### `major`

Major version number parsed from `version`.

```lua
print(runtime.major) --> 5
```

### `minor`

Minor version number parsed from `version`.

```lua
print(runtime.minor) --> 1 | 2 | 3 | 4
```

### `version_num`

Numeric version encoded as `major * 100 + minor`.

```lua
print(runtime.version_num) --> 501 | 502 | 503 | 504
```

### `is_luajit`

True when running under LuaJIT.

```lua
print(runtime.is_luajit) --> true | false
```

### `is_lua51`

True only on Lua 5.1 runtimes.

```lua
print(runtime.is_lua51) --> true | false
```

### `is_lua52`

True only on Lua 5.2 runtimes.

```lua
print(runtime.is_lua52) --> true | false
```

### `is_lua53`

True only on Lua 5.3 runtimes.

```lua
print(runtime.is_lua53) --> true | false
```

### `is_lua54`

True only on Lua 5.4 runtimes.

```lua
print(runtime.is_lua54) --> true | false
```
