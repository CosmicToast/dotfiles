return {
	{
		'olimorris/onedarkpro.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd [[:color onedark]]
		end,
	},
}
