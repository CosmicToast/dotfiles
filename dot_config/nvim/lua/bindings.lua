---@diagnostic disable:undefined-global

local util = require 'util'

local env = vim.env

-- TODO: write a wrapper for both
if not util.hp 'which-key.nvim' then
	-- minimal bindings for a no-plugin environment
	local km = vim.keymap.set
	km('n', '<leader>sv', function() dofile(env.MYVIMRC) end, { desc = 'source vimrc'})
	km('n', '<leader>s%', '<cmd>source %<cr>', { desc = 'source current file'})
else
	-- general bindings that aren't specific to a plugin
	require 'which-key'.register {
		-- diagnostics
		['<leader>'] = {
			e = { vim.diagnostic.open_float, 'diag float' },
			q = { vim.diagnostic.setloclist, 'diag locations' },
		},
		['[d'] = { vim.diagnostic.goto_prev, 'prev diag' },
		[']d'] = { vim.diagnostic.goto_next, 'next diag' },

		-- source
		['<leader>s'] = {
			name = '+source',
			v = { function() dofile(env.MYVIMRC) end, 'Vimrc' },
			['%'] = { '<cmd>source %<cr>', 'Current File' },
		},

		-- document missing builtins
		['g'] = {
			t = 'Next tab',
			T = 'Previous tab',
		},
	}
end
