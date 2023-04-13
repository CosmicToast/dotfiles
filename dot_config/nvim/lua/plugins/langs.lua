-- language support
return {
	-- treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		version = false,
		build = ':TSUpdate',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		main = 'nvim-treesitter.configs',
		opts = {
			ensure_installed = 'all',
			ignore_install = { 'norg' },
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
