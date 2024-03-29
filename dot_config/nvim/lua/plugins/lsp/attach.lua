return function(c, b)
	local lsp = vim.lsp
	local lbf = lsp.buf
	local wk  = require 'which-key'
	vim.api.nvim_buf_set_option(b, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	wk.register({
		name = '+lsp',
		D = {lbf.declaration, 'goto declaration'},
		d = {lbf.definition, 'goto definition'},
		k = {lbf.hover, 'hover'},
		K = {lbf.signature_help, 'signature help'},
		i = {lbf.implementation, 'goto implementation'},
		t = {lbf.type_definition, 'goto type definition'},
		r = {lbf.rename, 'rename'},
		c = {lbf.code_action, 'code action'},
		R = {lbf.references, 'list references'},
		w = {
			name = '+workspace',
			a = {lbf.add_workspace_folder, 'add folder'},
			r = {lbf.remove_workspace_folder, 'remove folder'},
			l = {
				function() print(vim.inspect(lbf.list_workspace_folders())) end,
				'list folders'
			},
		},
	}, {
	prefix = '<localleader><localleader>',
		buffer = b,
	})
	wk.register({
		['<leader>F'] = {
			function() vim.lsp.buf.format {async = true} end,
			'run format',
		},
	}, { buffer = b })
end
