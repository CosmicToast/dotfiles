-- [nfnl] Compiled from fnl/plugins/lsp/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("toast.core")
local assoc = _local_1_["assoc"]
local _local_2_ = require("toast.nvim")
local executable_3f = _local_2_["executable?"]
local function gopts(plist)
  return {clangd = {}, clojure_lsp = {root_dir = plist("project.clj", "deps.edn", "bb.edn", "build.boot", "shadow-cljs.edn", ".git")}, denols = {root_dir = plist("deno.json", "deno.jsonc"), autostart = false}, gopls = {}, ltex = {}, lua_ls = {}, pyright = {}, ruff = {cmd = {"ruff", "server", "--preview"}}, texlab = {filetypes = {"tex", "plaintex", "bib", "latex"}}, tsserver = {root_dir = plist("tsconfig.json", "package.json"), autostart = false}, zls = {}}
end
local attach = require("plugins.lsp.attach")
local function _3_(_, opts)
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
local function _5_()
  local function _6_(...)
    return require("lspconfig.util").root_pattern(...)
  end
  return gopts(_6_)
end
return {{"neovim/nvim-lspconfig", config = _3_, opts = _5_}}
