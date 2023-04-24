local function gen(key, fn, desc)
	return {'<leader>f' .. key,
			function()
				require 'telescope.builtin'[fn]()
			end,
			desc = desc}
end

return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
			},
		},
		config = function(_, opts)
			local ts = require 'telescope'
			ts.setup(opts)
			ts.load_extension 'fzf'
		end,
		cmd  = 'Telescope',
		keys = {
			gen('f', 'find_files', 'Find File'),
			gen('g', 'live_grep',  'Live Grep'),
			gen('b', 'buffers',    'Find Buffer'),
			gen('h', 'help_tags',  'Find Help'),
			gen('c', 'commands',   'Find Command'),
			gen('t', 'treesitter', 'Find Treesitter'),
		},
	},
}
