local lfs = require "lfs"
local mods = require "mods"

local M = {}

---@module "spec.helpers.Tree"
M.Tree = mods.utils.lazy_module("spec.helpers.Tree")

function M.tmpname()
  local p = os.tmpname()
  os.remove(p)
  return p
end

function M.make_tmp_dir()
  local root = M.tmpname()
  assert(lfs.mkdir(root))
  return root
end

function M.with_env(env, fn)
  local getenv = os.getenv
  rawset(os, "getenv", function(name)
    return env[name]
  end)
  fn()
  rawset(os, "getenv", getenv)
end

return M
