-- [nfnl] Compiled from fnl/toast/nvim.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("toast.core")
local every_3f = _local_1_["every?"]
local function executable_3f(...)
  local paths = {...}
  local function _2_(_241)
    return (0 ~= vim.fn.executable(_241))
  end
  return every_3f(_2_, paths)
end
return {["executable?"] = executable_3f}
