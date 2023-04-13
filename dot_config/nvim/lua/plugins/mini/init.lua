return {
	{
		'echasnovski/mini.nvim',
		version = false, -- beta
		config = function(_, opts)
			for k, v in pairs(opts) do
				require ("mini." .. k).setup(v)
			end
		end,
		opts = {
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
			starter = {},
			statusline = {},
			surround = {},
			tabline = {},
			trailspace = {},
		}
	},
}
