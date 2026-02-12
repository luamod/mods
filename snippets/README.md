# Snippets

Small reusable Lua logic blocks used as reference for module development.

These files are **not** runtime modules for `src/mods`.  
Use them as copy/paste sources when keeping modules standalone.

## Guidelines

1. Snippets are reference-only. Do not `require` them from `src/mods`.
2. Keep each file focused on one task only.
   Example: `quote.lua` only for quoting, `render_msg.lua` only for
   message rendering.
3. Use short, verb-style file names in `snake_case.lua`.
4. Add a short top reference block (not copied) in this format:
   ```lua
   --
   -- Copying notes:
   -- * Copy only the function-level doc block and function below.
   -- * Do not copy this reference section.
   --
   -- Used in:
   -- * src/mods/<module>.lua
   -- * src/mods/<module>.lua
   --
   -- Tests:
   -- * spec/_snippets_spec.lua
   --
   ```
5. Add a function-level doc block (copied with the function) in this format:
   ```lua
   ---
   --- <what this snippet does>
   ---
   --- Copied from snippets/<name>.lua
   --- IMPORTANT: Keep this function in sync with
   --- snippets/<name>.lua.
   ---
   ```
6. Update the `Used in` list when copied logic changes.
7. Keep this README index in sync when adding/removing snippet files.
