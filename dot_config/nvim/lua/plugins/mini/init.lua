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
				animate = {},
				basics = {},
				bracketed = {},
				comment = {},
				completion = {},
				cursorword = {},
				indentscope = {},
				jump2d = {},
				move = {},
				splitjoin = {},
				starter = {
					items = {
						starter.sections.telescope(),
						starter.sections.builtin_actions(),
					},
				},
				statusline = {},
				surround = {},
				tabline = {},
				trailspace = {},
		}
	end },
}
