# AGENTS Guidelines for This Repository

This document provides guidelines for agentic coding agents operating in this
repository.

## Project Overview

**Mods** is a pure Lua utility library with lazy-loaded inter-module
dependencies, supporting Lua 5.1, 5.2, 5.3, 5.4, and LuaJIT.

## Directory Structure

```txt
.
├── src/
│   └── mods/              Source code modules
├── spec/                  Busted test files
├── types/                 Lua type annotations
└── docs/                  VitePress documentation
```

## Build, Lint, and Test Commands

### Running Tests

```sh
# All tests
busted

# Single spec file (most common for iteration)
busted spec/<module>_spec.lua
```

### Linting

```sh
# Lua static analysis
luacheck .

# Markdown linting (docs)
npx --yes markdownlint-cli2 'docs/**/*.md' '!docs/.vitepress/**'
```

### Formatting

```sh
# Format Lua files
stylua .

# Format Markdown, JSON, YAML, TS files
npx --yes prettier --write .
```

### Documentation

```sh
# Docs dev server
npx --yes vitepress dev docs

# Build docs
npx --yes vitepress build docs

# Preview built docs
npx --yes vitepress preview docs
```

### CI Pipeline

The project uses GitHub Actions. CI runs on `.github/workflows/ci.yml` - lints
and tests on multiple Lua versions.

## Code Style Guidelines

### General Conventions

- **Language**: Pure Lua (no C bindings) for maximum compatibility
- **Lua versions**: 5.1, 5.2, 5.3, 5.4, LuaJIT
- **Column limit**: 120 characters for Lua, 80 for Markdown
- **Indentation**: 2 spaces (no tabs)

### Formatting (StyLua)

Configuration in `.stylua.toml`:

```toml
indent_type = "Spaces"
indent_width = 2
column_width = 120
sort_requires.enabled = true
```

### Naming Conventions

- **Modules**: lowercase or PascalCase (e.g., `str`, `tbl`, `List`, `Set`)
- **Functions/variables**: snake_case (e.g., `is_empty`, `validate_args`)
- **Constants**: UPPER_SNAKE_CASE
- **Private functions**: prefix with underscore where appropriate

### LuaLS Type Annotations

Use Lua Language Server annotations for type hints:

```lua
---@type mods.str
local M = {}

---@param s string
---@param width integer
---@return string
function M.center(s, width)
  -- ...
end
```

The project uses `---@type` module annotations (see `types/mods.lua` for
reference).

### Imports and Require

- Use local references for performance (e.g., `local concat = table.concat`)
- Sort requires alphabetically (enforced by StyLua)
- Lazy-load inter-module dependencies via `src/mods/init.lua`

### Error Handling

- Return `nil, error_message` for error cases (Lua convention)
- Use assertions sparingly; prefer explicit error returns
- Validate inputs at module boundaries

### Test Style

Tests use busted framework. Use table-driven test format where possible:

```lua
describe("mods.str", function()
  local tests = {
    { "capitalize", "hello", {}, "Hello" },
    { "count", "aaaa", { "a" }, 4 },
  }
  for _, tt in ipairs(tests) do
    local fn = M[tt[1]]
    local result = fn(tt[2], unpack(tt[3]))
    assert.equals(tt[4], result)
  end)
end)
```

Test helpers defined in `.busted`:

- `_TEST` global is set
- `inspect` available for debugging
- `args_repr` for table comparison

### Adding New Modules

When adding a module to `src/mods/`, also update:

1. `src/mods/init.lua` - add module name
2. `types/mods.lua` - add type definition
3. `README.md` - add to modules table
4. `docs/modules/index.md` - add documentation entry

## Code Review Checklist

- [ ] All tests pass: `busted`
- [ ] No luacheck warnings: `luacheck .`
- [ ] Code formatted: `stylua .` and `prettier --write .`
- [ ] New module added to `init.lua`, types, README, docs
- [ ] Tests added/updated in `spec/`

## Commit Message Format

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```txt
<type>(<scope>): <description>

[optional body]
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

## Additional Notes

- Never edit module documentation files under `docs/src/modules/`; these files
  are auto-generated.
- `_G._TEST = true` is set for test-specific behavior (see `.busted`)
- LuaCheck globals: `_TEST`, `inspect` (defined in `.luarc.json`)

## Additional Resources

- [Documentation](https://luamod.github.io/mods/)
- [LuaRocks](https://luarocks.org/modules/luamod/mods)
- [GitHub Discussions](https://github.com/luamod/mods/discussions)
