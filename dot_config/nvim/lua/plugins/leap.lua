local leap = require 'leap'
leap.set_default_keymaps()

local api  = vim.api
local hl   = api.nvim_set_hl
local auto = api.nvim_create_autocmd

local wk = require 'which-key'
wk.register {
	['g'] = {
		s = 'Leap across windows',
	},
}
