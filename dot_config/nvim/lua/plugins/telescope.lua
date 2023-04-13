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
	},
}
