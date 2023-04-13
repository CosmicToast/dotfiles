return {
	{
		'nvim-neo-tree/neo-tree.nvim',
		cmd = 'Neotree',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'MunifTanjim/nui.nvim',
		},
		keys = {
			{
				'<leader>n',
				function()
					require 'neo-tree.command'.execute { toggle = true }
				end,
				desc = 'Neotree',
			},
		},
		opts = {
		},
	},
}
