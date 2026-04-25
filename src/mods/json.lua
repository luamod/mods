local concat = table.concat
local byte = string.byte
local find = string.find
local fmt = string.format
local rep = string.rep
local sort = table.sort
local sub = string.sub
local gsub = string.gsub
local utf8_char = utf8.char
local huge = math.huge

local NULL = setmetatable({}, {
  __tostring = function()
    return "json.null"
  end,
})

---@type mods.json
local M = {
  null = NULL,
}

local ESCAPE_PATTERN = '[%z\1-\31\\"]'
local MAX_PARSE_DEPTH = 1000
local DECODE_SIMPLE_ESCAPES = { [0x2F] = "/" }
local ENCODE_ESCAPE_MAP = { ['"'] = '\\"', ["\\"] = "\\\\" }
local ESCAPE_BYTES = {
  [0x08] = "\\b",
  [0x09] = "\\t",
  [0x0A] = "\\n",
  [0x0C] = "\\f",
  [0x0D] = "\\r",
  [0x22] = '\\"',
  [0x5C] = "\\\\",
}

local parser_parse_array
local parser_parse_object

for i = 0, 31 do
  ENCODE_ESCAPE_MAP[string.char(i)] = ESCAPE_BYTES[i] or fmt("\\u%04x", i)
end

for ch, escaped in pairs(ESCAPE_BYTES) do
  DECODE_SIMPLE_ESCAPES[byte(escaped, 2)] = string.char(ch)
end

local function quote_string(s)
  return '"' .. (find(s, ESCAPE_PATTERN) and gsub(s, ESCAPE_PATTERN, ENCODE_ESCAPE_MAP) or s) .. '"'
end

local function is_digit_byte(ch)
  return ch ~= nil and ch >= 0x30 and ch <= 0x39
end

local function decode_hex4_at(input, pos)
  local hex = sub(input, pos, pos + 3)
  if not find(hex, "^%x%x%x%x$") then
    return nil, "expected 4 hex digits"
  end

  local codepoint = tonumber(hex, 16)
  if codepoint == nil then
    return nil, "expected 4 hex digits"
  end

  return codepoint
end

local function parse_unicode_escape(input, pos)
  local cp, hex_err = decode_hex4_at(input, pos + 2)
  if not cp then
    return nil, pos, hex_err
  end

  pos = pos + 6

  if cp >= 0xD800 and cp <= 0xDBFF then
    if sub(input, pos, pos + 1) ~= "\\u" then
      return nil, pos, "expected low surrogate after high surrogate"
    end

    local low, low_err = decode_hex4_at(input, pos + 2)
    if not low then
      return nil, pos, low_err
    elseif low < 0xDC00 or low > 0xDFFF then
      return nil, pos, "invalid low surrogate"
    end

    cp = 0x10000 + ((cp - 0xD800) * 0x400) + (low - 0xDC00)
    pos = pos + 6
  elseif cp >= 0xDC00 and cp <= 0xDFFF then
    return nil, pos - 6, "unexpected low surrogate"
  end

  return utf8_char(cp --[[@as integer]]), pos
end

local function classify_table(t)
  local count = 0
  local numeric_count = 0
  local string_count = 0
  local max_index = 0

  for k in pairs(t) do
    count = count + 1
    local key_type = type(k)
    if key_type == "string" then
      string_count = string_count + 1
    elseif key_type == "number" then
      if k >= 1 and k % 1 == 0 then
        numeric_count = numeric_count + 1
        if k > max_index then
          max_index = k
        end
      else
        return nil, "cannot encode table with non-integer numeric key"
      end
    else
      return nil, "cannot encode table with unsupported key type: " .. key_type
    end
  end

  if count == 0 then
    return "empty", 0
  end
  if numeric_count > 0 and string_count > 0 then
    return nil, "cannot encode mixed table"
  end
  if numeric_count > 0 then
    if max_index ~= numeric_count then
      return nil, "cannot encode sparse array"
    end
    return "array", max_index
  end
  return "object", count
end

local function encode_value(v, seen, depth, indent, sort_keys)
  if v == NULL then
    return "null"
  end

  local vt = type(v)
  if vt == "nil" then
    return "null"
  elseif vt == "boolean" then
    return v and "true" or "false"
  elseif vt == "number" then
    if v ~= v or v == huge or v == -huge then
      return nil, (v == v and "cannot encode infinity" or "cannot encode NaN")
    end
    return fmt("%.16g", v)
  elseif vt == "string" then
    return quote_string(v)
  elseif vt ~= "table" then
    return nil, "unsupported type: " .. vt
  end

  if seen[v] then
    return nil, "cannot encode cyclic table"
  end

  local kind, info = classify_table(v)
  if not kind then
    return nil, info
  elseif kind == "empty" then
    kind = "array"
  end

  seen[v] = true
  local child_depth = depth + 1

  if kind == "array" then
    local items = {}
    for i = 1, info do
      local encoded, err = encode_value(v[i], seen, child_depth, indent, sort_keys)
      if encoded == nil then
        seen[v] = nil
        return nil, err
      end
      items[i] = encoded
    end
    seen[v] = nil

    if not indent then
      return "[" .. concat(items, ",") .. "]"
    end
    if info == 0 then
      return "[]"
    end

    local prefix = rep(indent, child_depth)
    local closing = rep(indent, depth)
    return "[\n" .. prefix .. concat(items, ",\n" .. prefix) .. "\n" .. closing .. "]"
  end

  local keys = {}
  for k in pairs(v) do
    keys[#keys + 1] = k
  end
  if sort_keys then
    sort(keys)
  end

  local items = {}
  for i = 1, #keys do
    local k = keys[i]
    local encoded_value, err = encode_value(v[k], seen, child_depth, indent, sort_keys)
    if not encoded_value then
      seen[v] = nil
      return nil, err
    end
    items[i] = quote_string(k) .. (indent and ": " or ":") .. encoded_value
  end
  seen[v] = nil

  if not indent then
    return "{" .. concat(items, ",") .. "}"
  end

  local prefix = rep(indent, child_depth)
  local closing = rep(indent, depth)
  return "{\n" .. prefix .. concat(items, ",\n" .. prefix) .. "\n" .. closing .. "}"
end

local function parser_skip_ws(input, pos, len)
  local next_pos = find(input, "[^ \t\r\n]", pos)
  return next_pos and next_pos or len + 1
end

local function format_decode_error(input, pos, msg)
  local line = 1
  local line_start = 1
  for i = 1, pos - 1 do
    if byte(input, i) == 0x0A then
      line = line + 1
      line_start = i + 1
    end
  end
  return fmt("%s at line %d, column %d", msg, line, pos - line_start + 1)
end

local function parser_parse_string(input, pos, len)
  local start_pos = pos
  pos = pos + 1

  local first_special = find(input, ESCAPE_PATTERN, pos)
  if not first_special then
    return nil, start_pos, "unterminated string"
  end

  local first_byte = byte(input, first_special)
  if first_byte == 0x22 then
    return sub(input, pos, first_special - 1), first_special + 1
  end

  local out, n = {}, 1
  if first_special > pos then
    out[n] = sub(input, pos, first_special - 1)
    n = n + 1
  end

  pos = first_special
  local chunk_start = pos

  while pos <= len do
    local ch = byte(input, pos)
    if ch == 0x22 then
      if chunk_start < pos then
        out[n] = sub(input, chunk_start, pos - 1)
      end
      return concat(out), pos + 1
    elseif ch < 0x20 then
      return nil, pos, "control character in string"
    elseif ch ~= 0x5C then
      pos = pos + 1
    else
      if chunk_start < pos then
        out[n] = sub(input, chunk_start, pos - 1)
        n = n + 1
      end

      local esc_pos = pos
      local esc = byte(input, pos + 1)
      if not esc then
        return nil, esc_pos, "unterminated escape sequence"
      end

      local simple_escape = DECODE_SIMPLE_ESCAPES[esc]
      if simple_escape then
        out[n] = simple_escape
        n = n + 1
        pos = pos + 2
      elseif esc == 0x75 then
        local decoded, new_pos, unicode_err = parse_unicode_escape(input, pos)
        if not decoded then
          return nil, new_pos, unicode_err
        end
        out[n] = decoded
        n = n + 1
        pos = new_pos
      else
        return nil, esc_pos, "invalid escape sequence"
      end

      chunk_start = pos
    end
  end

  return nil, start_pos, "unterminated string"
end

local function skip_digits(input, pos)
  repeat
    pos = pos + 1
  until not is_digit_byte(byte(input, pos))
  return pos
end

local function parser_parse_number(input, pos)
  local start_pos = pos

  if byte(input, pos) == 0x2D then
    pos = pos + 1
  end

  local first = byte(input, pos)
  if first == 0x30 then
    pos = pos + 1
    if is_digit_byte(byte(input, pos)) then
      return nil, start_pos, "leading zero is not allowed"
    end
  elseif first ~= nil and first >= 0x31 and first <= 0x39 then
    pos = skip_digits(input, pos)
  else
    return nil, start_pos, "invalid number"
  end

  if byte(input, pos) == 0x2E then
    pos = pos + 1
    if not is_digit_byte(byte(input, pos)) then
      return nil, start_pos, "invalid fraction"
    end
    pos = skip_digits(input, pos)
  end

  local exp = byte(input, pos)
  if exp == 0x65 or exp == 0x45 then
    pos = pos + 1
    local sign = byte(input, pos)
    if sign == 0x2B or sign == 0x2D then
      pos = pos + 1
    end
    if not is_digit_byte(byte(input, pos)) then
      return nil, start_pos, "invalid exponent"
    end
    pos = skip_digits(input, pos)
  end

  return tonumber(sub(input, start_pos, pos - 1)), pos
end

local function parse_literal(input, pos, literal, value)
  if sub(input, pos, pos + #literal - 1) ~= literal then
    return nil, pos, "unexpected token"
  end
  return value, pos + #literal
end

local function parse_value_at(input, pos, len, depth)
  local ch = byte(input, pos)
  if ch == 0x22 then
    return parser_parse_string(input, pos, len)
  elseif ch == 0x5B then
    return parser_parse_array(input, pos, len, depth + 1)
  elseif ch == 0x7B then
    return parser_parse_object(input, pos, len, depth + 1)
  elseif ch == 0x74 then
    return parse_literal(input, pos, "true", true)
  elseif ch == 0x66 then
    return parse_literal(input, pos, "false", false)
  elseif ch == 0x6E then
    return parse_literal(input, pos, "null", NULL)
  elseif ch == 0x2D or is_digit_byte(ch) then
    return parser_parse_number(input, pos)
  end
  return nil, pos, "unexpected token"
end

function parser_parse_array(input, pos, len, depth)
  if depth > MAX_PARSE_DEPTH then
    return nil, pos, "exceeded maximum nesting depth"
  end

  local res = {}
  local i = 1
  pos = parser_skip_ws(input, pos + 1, len)

  if byte(input, pos) == 0x5D then
    return res, pos + 1
  end

  while true do
    local v, err
    v, pos, err = parse_value_at(input, pos, len, depth)
    if v == nil then
      return nil, pos, err
    end
    res[i] = v
    i = i + 1

    pos = parser_skip_ws(input, pos, len)
    local ch = byte(input, pos)
    if ch == 0x5D then
      return res, pos + 1
    elseif ch ~= 0x2C then
      return nil, pos, "expected ',' or ']'"
    end
    pos = parser_skip_ws(input, pos + 1, len)
  end
end

function parser_parse_object(input, pos, len, depth)
  if depth > MAX_PARSE_DEPTH then
    return nil, pos, "exceeded maximum nesting depth"
  end

  local res = {}
  pos = parser_skip_ws(input, pos + 1, len)

  if byte(input, pos) == 0x7D then
    return res, pos + 1
  end

  while true do
    if byte(input, pos) ~= 0x22 then
      return nil, pos, "expected string key"
    end

    local k, v, err
    k, pos, err = parser_parse_string(input, pos, len)
    if not k then
      return nil, pos, err
    end

    pos = parser_skip_ws(input, pos, len)
    if byte(input, pos) ~= 0x3A then
      return nil, pos, "expected ':'"
    end
    pos = parser_skip_ws(input, pos + 1, len)

    v, pos, err = parse_value_at(input, pos, len, depth)
    if v == nil then
      return nil, pos, err
    end
    res[k] = v

    pos = parser_skip_ws(input, pos, len)
    local ch = byte(input, pos)
    if ch == 0x7D then
      return res, pos + 1
    elseif ch ~= 0x2C then
      return nil, pos, "expected ',' or '}'"
    end
    pos = parser_skip_ws(input, pos + 1, len)
  end
end

function M.encode(v, opts)
  if not opts then
    return encode_value(v, {}, 0)
  end
  return encode_value(v, {}, 0, opts.indent, opts.sort_keys)
end

function M.decode(s)
  if type(s) ~= "string" then
    return nil, "expected string"
  end

  local len = #s
  local pos = parser_skip_ws(s, 1, len)
  if pos > len then
    return nil, format_decode_error(s, pos, "unexpected end of input")
  end

  local v, new_pos, err = parse_value_at(s, pos, len, 0)
  if v == nil then
    return nil, format_decode_error(s, new_pos, err)
  end

  pos = parser_skip_ws(s, new_pos, len)
  if pos <= len then
    return nil, format_decode_error(s, pos, "unexpected trailing content")
  end

  return v
end

return M
