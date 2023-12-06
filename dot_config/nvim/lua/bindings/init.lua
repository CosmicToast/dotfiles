for _, v in ipairs {
	'builtins',
	'plugins',
} do
	require ('bindings.' .. v)
end

-- general bindings that aren't specific to a plugin
require 'which-key'.register {
	-- diagnostics
	['<leader>'] = {
		e = { vim.diagnostic.open_float, 'diag float' },
		q = { vim.diagnostic.setloclist, 'diag locations' },
	},
	['[d'] = { vim.diagnostic.goto_prev, 'prev diag' },
	[']d'] = { vim.diagnostic.goto_next, 'next diag' },
}
