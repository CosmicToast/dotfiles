vim.g.mapleader = ' '
vim.g.maplocalleader = ','

require 'plugins'

-- options
local options = {
	timeoutlen = 300,
	clipboard = 'unnamedplus',
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
}
for k, v in pairs(options) do vim.opt[k] = v end
