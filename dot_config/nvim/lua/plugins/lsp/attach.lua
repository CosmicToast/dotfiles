-- [nfnl] Compiled from fnl/plugins/lsp/attach.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("toast.core")
local assoc = _local_1_["assoc"]
local map = _local_1_["map"]
local _local_2_ = require("toast.table")
local insert = _local_2_["insert"]
local function _3_(c, b)
  local lsp = vim.lsp
  local lbf = lsp.buf
  local ll
  local function _4_()
    return print(vim.inspect(lbf.list_workspace_folders()))
  end
  ll = {{"", group = "+lsp"}, {"w", group = "+workspace"}, {"D", lbf.declaration, desc = "goto declaration"}, {"d", lbf.definition, desc = "goto definition"}, {"k", lbf.hover, desc = "hover"}, {"K", lbf.signature_help, desc = "signature help"}, {"i", lbf.implementation, desc = "goto implementation"}, {"t", lbf.type_definition, desc = "goto type definition"}, {"r", lbf.rename, desc = "rename"}, {"c", lbf.code_action, desc = "code action"}, {"R", lbf.reference, desc = "list references"}, {"wa", lbf.add_workspace_folder, desc = "add folder"}, {"wr", lbf.remove_workspace_folder, desc = "remove folder"}, {"wl", _4_, desc = "list folders"}}
  local ll0
  local function _5_(_241)
    return assoc(_241, 1, ("<localleader><localleader>" .. (_241)[1]))
  end
  ll0 = map(_5_, ll)
  vim.api.nvim_buf_set_option(b, "omnifunc", "v:lua.vim.lsp.omnifunc")
  local function _6_()
    return vim.lsp.buf.format({async = true})
  end
  return (require("which-key")).add({insert(ll0, {"<leader>F", _6_, desc = "run format"}), buffer = b})
end
return _3_
