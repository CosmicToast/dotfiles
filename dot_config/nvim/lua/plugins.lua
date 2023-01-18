local packer = require 'ipacker'
local compiled = vim.fn.stdpath 'data' .. '/packer_compiled.lua'

local function plugn(plug) -- plug name
	return plug:gsub([[^.*/([^./]*)%.?.*$]], '%1')
end

local function plugi(conf) -- plug initialization string
	-- you can pass it the plugin spec
	if conf:find '/' then conf = plugn(conf) end
	return 'plugins.' .. conf
end

local sust = {}
colors = {
	default = 'default', -- in case of no packer
	scheme = 'onedark', -- in case of yes packer
	lualine = 'onedark', -- per plugin stuff from here on
}
packer.startup({function(iuse)
	local tf  = require 'transformer'
	local use = tf(iuse)

	local sus = tf(function(spec)
		table.insert(sust, plugi(spec[1]))
		iuse(spec)
	end)
	local kbd = sus { requires = {'folke/which-key.nvim'} }

	use 'wbthomason/packer.nvim'
	use 'Olical/aniseed'

	-- colors
	use 'folke/tokyonight.nvim'
	use 'olimorris/onedarkpro.nvim'

	-- editor
	use { run = function()
			require 'nvim-treesitter.install'.update { with_sync = true }
		end }
		{ config = function() require 'nvim-treesitter.configs'.setup {
			ensure_installed = 'all',
			sync_install = true,
			highlight = {
				enable = true,
			},
		} end }
		'nvim-treesitter/nvim-treesitter'
	sus 'neovim/nvim-lspconfig'
	kbd 'echasnovski/mini.nvim'

	sus 'linty-org/readline.nvim'
	sus 'nvim-lualine/lualine.nvim'
	use 'folke/which-key.nvim'

	-- completion, signatures, and snippets
	sus 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'PaterJason/cmp-conjure'

	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-path'

	use 'dcampos/nvim-snippy'
	use 'dcampos/cmp-snippy'

	use 'ray-x/lsp_signature.nvim'

	-- interactive features
	use { run = 'make' } 'nvim-telescope/telescope-fzf-native.nvim'
	kbd { requires = 'nvim-lua/plenary.nvim' } 'nvim-telescope/telescope.nvim'
	kbd 'kyazdani42/nvim-tree.lua'

	kbd 'ggandor/leap.nvim'
	kbd 'Olical/conjure'

	-- language features
	use { ft = 'janet' } 'janet-lang/janet.vim'
	use { ft = {'scm', 'janet', 'clojure', 'fennel' } }
		'gpanders/nvim-parinfer'
end, config = {
	compile_path = compiled,
}})

local function configure()
	vim.cmd(':colo ' .. colors.scheme)
	for _, v in ipairs(sust) do require(v) end
	require 'which-key'.setup{}
	require 'bindings'
end

if ipacker == 0 then
	-- no packer
	vim.cmd(':colo ' .. colors.default)
elseif ipacker == 1 then
	-- run sync and wait for it before configuring
	packer.sync()
	vim.api.nvim_create_autocmd({'User PackerComplete'}, { callback = function()
		configure()
	end })
else
	-- run things normally
	if vim.fn.filereadable(compiled) > 0 then dofile(compiled) end
	configure()
end

