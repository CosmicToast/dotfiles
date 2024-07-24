-- [nfnl] Compiled from pre.fnl by https://github.com/Olical/nfnl, do not edit.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local options = {timeoutlen = 300, clipboard = "unnamedplus", completeopt = "menu,menuone,noselect", mouse = "a", smartcase = true, smartindent = true, termguicolors = true, shiftwidth = 4, tabstop = 4, number = true, numberwidth = 2, scrolloff = 4, sidescrolloff = 4, foldmethod = "expr", foldexpr = "nvim_treesitter#foldexpr()", foldlevelstart = 99, wrap = true, expandtab = false, backup = false, swapfile = false}
for k, v in pairs(options) do
  vim.opt[k] = v
end
return nil
