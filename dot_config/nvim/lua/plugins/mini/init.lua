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
			return {
				ai = {},
				align = {},
				basics = {},
				bracketed = {
					indent = { options = { change_type = 'diff' } },
				},
				comment = {},
				completion = {},
				cursorword = {},
				indentscope = {},
				move = {},
				splitjoin = {},
				-- starter = require 'plugins.mini.starter',
				statusline = {},
				tabline = {},
				trailspace = {},
		}
	end },
}
