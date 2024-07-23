for _, v in ipairs {
	'builtins',
	'plugins',
} do
	require ('bindings.' .. v)
end

-- general bindings that aren't specific to a plugin
require 'which-key'.add {
	-- diagnostics
	{ '<leader>e', vim.diagnostic.open_float, desc = 'diag float' },
	{ '<leader>q', vim.diagnostic.setloclist, desc = 'diag locations' },
	{ '[d', vim.diagnostic.goto_prev, desc = 'prev diag' },
	{ ']d', vim.diagnostic.goto_next, desc = 'next diag' },
}
