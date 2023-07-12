return {
	{
		'echasnovski/mini.nvim',
		version = false, -- beta
		config = function(_, opts)
			for k, v in pairs(opts) do
				require ("mini." .. k).setup(v)
			end
		end,
		opts = function()
			local starter = require 'mini.starter'
			return {
				ai = {},
				align = {},
				basics = {},
				bracketed = {},
				comment = {},
				completion = {},
				cursorword = {},
				indentscope = {},
				move = {},
				splitjoin = {},
				starter = require 'plugins.mini.starter',
				statusline = {},
				tabline = {},
				trailspace = {},
		}
	end },
}
