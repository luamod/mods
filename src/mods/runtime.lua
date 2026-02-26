local version = _VERSION
local major_s, minor_s = _VERSION:match("^Lua (%d+)%.(%d+)$")
local major = tonumber(major_s) --[[@as integer]]
local minor = tonumber(minor_s) --[[@as integer]]
local version_num = major * 100 + minor
local is_luajit = rawget(_G, "jit") ~= nil

---@type mods.runtime
local M = {
  version = version,
  major = major,
  minor = minor,
  version_num = version_num,
  is_luajit = is_luajit,
  is_lua51 = major == 5 and minor == 1,
  is_lua52 = major == 5 and minor == 2,
  is_lua53 = major == 5 and minor == 3,
  is_lua54 = major == 5 and minor == 4,
}

return M
