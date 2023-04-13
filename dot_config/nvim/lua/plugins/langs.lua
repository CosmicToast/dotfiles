-- language support
return {
	-- treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		version = false,
		lazy = false,
		build = ':TSUpdateSync',
		-- event = { 'BufReadPost', 'BufNewFile' },
		config = function(_, opts)
			require 'nvim-treesitter.configs'.setup(opts)
		end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		opts = {
			ensure_installed = 'all',
			ignore_install = { 'neorg' },
			sync_intall = true,
			highlight = {
				enable = true,
			},
		},
	},

	-- non-treesitter languages
	{
		'janet-lang/janet.vim',
		ft = 'janet',
	},

	-- helpers for lisps
	{
		'gpanders/nvim-parinfer',
		ft = {
			'clojure',
			'fennel',
			'janet',
			'scm',
		},
	},
}
