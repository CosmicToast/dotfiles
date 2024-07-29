-- [nfnl] Compiled from fnl/plugins/lsp/init.fnl by https://github.com/Olical/nfnl, do not edit.
local function gopts(plist)
  return {clangd = {}, clojure_lsp = {root_dir = plist("project.clj", "deps.edn", "bb.edn", "build.boot", "shadow-cljs.edn", ".git")}, denols = {root_dir = plist("deno.json", "deno.jsonc"), autostart = false}, gopls = {}, ltex = {}, lua_ls = {}, pyright = {}, ruff = {cmd = {"ruff", "server", "--preview"}}, texlab = {filetypes = {"tex", "plaintex", "bib", "latex"}}, tsserver = {root_dir = plist("tsconfig.json", "package.json"), autostart = false}, zls = {}}
end
local attach = require("plugins.lsp.attach")
local caps = require("plugins.lsp.capabilities")
local function _1_(_, opts)
  for k, v in pairs(opts) do
    v.on_attach = (attach or v.on_attach)
    if ("table" == type(caps)) then
      v.capabilities = (v.capabilities or caps)
    else
    end
    local s = require("lspconfig")[k]
    local c = (v.cmd or s.document_config.default_config.cmd)
    if (0 ~= vim.fn.executable(c[1])) then
      s.setup(v)
    else
    end
  end
  return nil
end
local function _4_()
  local plist
  local function _5_(...)
    local p = require("lspconfig.util").root_pattern(...)
    local function _6_(_241)
      return p(_241)
    end
    return _6_
  end
  plist = _5_
  return gopts(plist)
end
return {{"neovim/nvim-lspconfig", config = _1_, opts = _4_}}
