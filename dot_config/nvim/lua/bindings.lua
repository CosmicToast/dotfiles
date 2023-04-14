-- general bindings that aren't specific to a plugin
require 'which-key'.register {
	-- diagnostics
	['<leader>'] = {
		e = { vim.diagnostic.open_float, 'diag float' },
		q = { vim.diagnostic.setloclist, 'diag locations' },
	},
	['[d'] = { vim.diagnostic.goto_prev, 'prev diag' },
	[']d'] = { vim.diagnostic.goto_next, 'next diag' },

	-- document missing builtins
	['g'] = {
		t = 'Next tab',
		T = 'Previous tab',
	},
}

-- readline
local readline = require 'readline'
vim.keymap.set('!', '<M-Right>', readline.forward_word)
vim.keymap.set('!', '<M-Left>', readline.backward_word)
vim.keymap.set('!', '<C-a>', readline.beginning_of_line)
vim.keymap.set('!', '<C-e>', readline.end_of_line)
vim.keymap.set('!', '<M-d>', readline.kill_word)
vim.keymap.set('!', '<M-BS>', readline.backward_kill_word)
vim.keymap.set('!', '<C-w>', readline.unix_word_rubout)
vim.keymap.set('!', '<C-k>', readline.kill_line)
vim.keymap.set('!', '<C-u>', readline.backward_kill_line)
