require 'nvim-tree'.setup {
	filters = {
		dotfiles = true,
	},
	git = {
		enable = true,
		ignore = true,
	},
	renderer = {
		icons = {
			glyphs = {
				default = '-',
				symlink = '→',
				folder = {
					arrow_closed = '▶',
					arrow_open = '▼',

					default = '📁',
					open = '📂',

					symlink = '📁',
					symlink_open = '📂',

					empty = '📁',
					empty_open = '📂',
				},
				git = {
					deleted  = '-', -- unused
					unstaged = '±',
					untracked = '+',
					unmerged = 'U',
				},
			},
		},
	},
}

local api = require 'nvim-tree.api'
local wk  = require 'which-key'
local km  = vim.keymap.set
wk.register {
	['<leader>'] = {
		n = { api.tree.toggle, 'nvim-tree' },
	}
}
