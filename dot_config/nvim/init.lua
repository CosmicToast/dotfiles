vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- options
local options = {
	timeoutlen = 300,
	clipboard = 'unnamedplus',
	completeopt = 'menu,menuone,noselect',
	mouse = 'a',
	smartcase = true,
	smartindent = true,
	backup = false,
	swapfile = false,
	termguicolors = true,
	expandtab = false,
	shiftwidth = 4,
	tabstop = 4,
	number = true,
	numberwidth = 2,
	scrolloff = 4,
	sidescrolloff = 4,
	foldmethod = 'expr',
	foldexpr = 'nvim_treesitter#foldexpr()',
	foldlevelstart = 99,
}
for k, v in pairs(options) do vim.opt[k] = v end

-- plugins
if vim.fn.executable 'git' == 0 then
	require 'noplugins'
else
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
	  vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	  })
	end
	vim.opt.rtp:prepend(lazypath)
	require 'lazy'.setup("plugins", {})
	require 'bindings'
	vim.cmd [[colorscheme starlight]]
end
