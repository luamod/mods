local runtime = require "mods.runtime"

if runtime.version >= 504 then
  return
end

local floor = math.floor
local char = string.char
local concat = table.concat
local huge, neg_huge = math.huge, -math.huge

if runtime.is_lua51 then
  rawset(table, "unpack", unpack)
  rawset(table, "pack", function(...)
    return { n = select("#", ...), ... }
  end)
end

if runtime.is_lua51 and not runtime.is_luajit then
  local function load_string(v, i, name, expected)
    local t = type(v)
    if t == "string" or t == "number" then
      return tostring(v)
    end
    error(("bad argument #%d to 'load' (%s expected, got %s)"):format(i, expected or name, t), 3)
  end

  rawset(_G, "load", function(chunk, chunkname, mode, env)
    local is_reader = type(chunk) == "function"
    local src
    if is_reader then
      local chunks = {}
      local i = 0
      while true do
        local ok, part = pcall(chunk)
        if not ok then
          return nil, part
        end
        if part == nil or part == "" then
          src = concat(chunks, "", 1, i)
          break
        end
        if type(part) ~= "string" then
          return nil, "reader function must return a string"
        end
        i = i + 1
        chunks[i] = part
      end
    else
      src = load_string(chunk, 1, "function or string", "function")
    end

    mode = mode == nil and "bt" or load_string(mode, 3, "string")

    local kind = src:byte(1) == 27 and "binary" or "text"
    if mode:find(kind == "binary" and "b" or "t", 1, true) == nil then
      return nil, "attempt to load a " .. kind .. " chunk (mode is '" .. mode .. "')"
    end

    local fn, err = loadstring(src, is_reader and (chunkname or "(load)") or chunkname)
    if fn ~= nil and env ~= nil then
      setfenv(fn, env)
    end
    return fn, err
  end)
end

if runtime.version < 503 then
  -- Lua 5.1/5.2 do not expose integer/float subtypes, so 2.0 is reported as integer.
  rawset(math, "type", function(v)
    if type(v) == "number" then
      return v > neg_huge and v < huge and v == floor(v) and "integer" or "float"
    end
  end)
end

if runtime.version < 504 then
  local pack = table.pack

  -- Some runtimes or libraries may already provide utf8;
  -- keep the table and normalize char.
  local utf8 = rawget(_G, "utf8")
  utf8 = type(utf8) == "table" and utf8 or {}

  local function cont(cp, shift)
    return 0x80 + (floor(cp / shift) % 0x40)
  end

  rawset(_G, "utf8", utf8)
  rawset(utf8, "char", function(...)
    local chars = pack(...)
    for i = 1, chars.n do
      local cp = tonumber(chars[i])
      if cp == nil then
        error(("bad argument #%d to 'char' (number expected, got %s)"):format(i, type(chars[i])), 2)
      elseif cp ~= cp or cp == huge or cp == neg_huge or cp ~= floor(cp) then
        error(("bad argument #%d to 'char' (number has no integer representation)"):format(i), 2)
      elseif cp < 0 or cp > 0x7FFFFFFF then
        error(("bad argument #%d to 'char' (value out of range)"):format(i), 2)
      end

      if cp <= 0x7F then
        chars[i] = char(cp)
      elseif cp <= 0x7FF then
        chars[i] = char(0xC0 + floor(cp / 0x40), cont(cp, 1))
      elseif cp <= 0xFFFF then
        chars[i] = char(0xE0 + floor(cp / 0x1000), cont(cp, 0x40), cont(cp, 1))
      elseif cp <= 0x1FFFFF then
        chars[i] = char(0xF0 + floor(cp / 0x40000), cont(cp, 0x1000), cont(cp, 0x40), cont(cp, 1))
      elseif cp <= 0x3FFFFFF then
        chars[i] = char(0xF8 + floor(cp / 0x1000000), cont(cp, 0x40000), cont(cp, 0x1000), cont(cp, 0x40), cont(cp, 1))
      else
        chars[i] = char(
          0xFC + floor(cp / 0x40000000),
          cont(cp, 0x1000000),
          cont(cp, 0x40000),
          cont(cp, 0x1000),
          cont(cp, 0x40),
          cont(cp, 1)
        )
      end
    end
    return concat(chars, "", 1, chars.n)
  end)
end
