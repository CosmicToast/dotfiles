local function helper(opts, ...)
	for _, spec in ipairs({...}) do
		for _, v in ipairs(spec) do
			if opts.prefix then
				v[0] = opts.prefix .. v[0]
			end
			if opts.buffer then
				v.buffer = opts.buffer
			end
		end
	end
end

return function(c, b)
	local lsp = vim.lsp
	local lbf = lsp.buf
	local wk  = require 'which-key'
	vim.api.nvim_buf_set_option(b, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	wk.add(helper({buffer = b}, {
		{ '<leader>F', function() vim.lsp.buf.format {async = true} end,
		  desc = 'run format' },
	}, helper({prefix = '<localleader><localleader>'}, {
		{ '', group = '+lsp' },
		{ 'w', group = '+workspace' },

		{ 'D', lbf.declaration, desc = 'goto declaration' },
		{ 'd', lbf.definition, desc = 'goto definition' },
		{ 'k', lbf.hover, desc = 'hover' },
		{ 'K', lbf.signature_help, desc = 'signature help' },
		{ 'i', lbf.implementation, desc = 'goto implementation' },
		{ 't', lbf.type_definition, desc = 'goto type definition' },
		{ 'r', lbf.rename, desc = 'rename' },
		{ 'c', lbf.code_action, desc = 'code action' },
		{ 'R', lbf.references, desc = 'list references' },

		{ 'wa', lbf.add_workspace_folder, 'add folder' },
		{ 'wr', lbf.remove_workspace_folder, 'remove folder' },
		{ 'wl', function() print(vim.inspect(lbf.list_workspace_folders())) end,
		  desc = 'list folders' },
	})))
end
