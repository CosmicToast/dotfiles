-- [nfnl] Compiled from pre.fnl by https://github.com/Olical/nfnl, do not edit.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local options = {timeoutlen = 300, clipboard = "unnamedplus", completeopt = "menu,menuone,noselect", mouse = "a", smartcase = true, smartindent = true, termguicolors = true, shiftwidth = 4, tabstop = 4, number = true, numberwidth = 2, scrolloff = 4, sidescrolloff = 4, foldmethod = "expr", foldexpr = "nvim_treesitter#foldexpr()", foldlevelstart = 99, wrap = true, winborder = "rounded", backup = false, expandtab = false, swapfile = false}
for k, v in pairs(options) do
  vim.opt[k] = v
end
vim.diagnostic.config({virtual_lines = true})
do
  local _let_1_ = vim.version()
  local major = _let_1_["major"]
  local minor = _let_1_["minor"]
  if ((major > 0) or (minor >= 10)) then
    vim.g.clipboard = {name = "OSC52", copy = {["+"] = require("vim.ui.clipboard.osc52").copy("+"), ["*"] = require("vim.ui.clipboard.osc52").copy("*")}, paste = {["+"] = require("vim.ui.clipboard.osc52").paste("+"), ["*"] = require("vim.ui.clipboard.osc52").paste("*")}}
  else
  end
end
do
  local ec = require("editorconfig")
  local function _3_(bufnr, val, opts)
    local bo = vim.bo[bufnr]
    if (bo.filetype ~= val) then
      bo.filetype = val
      return ec.config(bufnr)
    else
      return nil
    end
  end
  ec.properties.filetype = _3_
end
local function _5_(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if client:supports_method("textDocument/completion") then
    return vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
  else
    return nil
  end
end
vim.api.nvim_create_autocmd("LspAttach", {callback = _5_})
return vim.lsp.enable({"clangd", "clojure_lsp", "gopls", "lua_ls", "ruff", "pyright", "texlab", "ts_ls", "zls"})
