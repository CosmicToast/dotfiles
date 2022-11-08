local ts = require 'telescope'

ts.setup {
	-- pickers = {},
	-- extensions = {},
}

ts.load_extension 'fzf'

local tb = require 'telescope.builtin'
local wk = require 'which-key'
wk.register {
	['<leader>f'] = {
		name = '+find',
		f = { tb.find_files, 'Find File' },
		g = { tb.live_grep, 'Live Grep' },
		b = { tb.buffers, 'Find Buffer' },
		h = { tb.help_tags, 'Find Help' },
		c = { tb.commands, 'Find Command' },
		t = { tb.treesitter, 'Find Treesitter' },
	}
}
