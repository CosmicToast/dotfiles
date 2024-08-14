-- [nfnl] Compiled from fnl/plugins/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("toast.core")
local assoc = _local_1_["assoc"]
local map = _local_1_["map"]
local _local_2_ = require("toast.table")
local insert = _local_2_["insert"]
local _local_3_ = require("toast.nvim")
local executable_3f = _local_3_["executable?"]
local function gopts(plist)
  return {basedpyright = {}, clangd = {}, clojure_lsp = {root_dir = plist("project.clj", "deps.edn", "bb.edn", "build.boot", "shadow-cljs.edn", ".git")}, denols = {root_dir = plist("deno.json", "deno.jsonc"), autostart = false}, gopls = {}, ltex = {}, lua_ls = {}, ruff = {cmd = {"ruff", "server", "--preview"}}, texlab = {filetypes = {"tex", "plaintex", "bib", "latex"}}, tsserver = {root_dir = plist("tsconfig.json", "package.json"), autostart = false}, zls = {}}
end
local function attach(c, b)
  local lsp = vim.lsp
  local lbf = lsp.buf
  local ll = {{"", group = "+lsp"}, {"w", group = "+workspace"}, {"D", lbf.declaration, desc = "goto declaration"}, {"d", lbf.definition, desc = "goto definition"}, {"k", lbf.hover, desc = "hover"}, {"K", lbf.signature_help, desc = "signature help"}, {"i", lbf.implementation, desc = "goto implementation"}, {"t", lbf.type_definition, desc = "goto type definition"}, {"r", lbf.rename, desc = "rename"}, {"c", lbf.code_action, desc = "code action"}, {"R", lbf.reference, desc = "list references"}}
  local ll0
  local function _4_(_241)
    return assoc(_241, 1, ("<localleader><localleader>" .. _241[1]))
  end
  ll0 = map(_4_, ll)
  vim.api.nvim_buf_set_option(b, "omnifunc", "v:lua.vim.lsp.omnifunc")
  local function _5_()
    return vim.lsp.buf.format({async = true})
  end
  return require("which-key").add({insert(ll0, {"<leader>F", _5_, desc = "run format"}), buffer = b})
end
local function _6_(_, opts)
  for k, v in pairs(opts) do
    local s = require("lspconfig")[k]
    local c = (v.cmd or s.document_config.default_config.cmd)
    local att = (v.on_attach or attach)
    if executable_3f(c[1]) then
      s.setup(assoc(v, "on_attach", att))
    else
    end
  end
  return nil
end
local function _8_()
  local function _9_(...)
    return require("lspconfig.util").root_pattern(...)
  end
  return gopts(_9_)
end
return {{"neovim/nvim-lspconfig", config = _6_, opts = _8_}}
