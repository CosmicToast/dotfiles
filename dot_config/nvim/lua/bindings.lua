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
