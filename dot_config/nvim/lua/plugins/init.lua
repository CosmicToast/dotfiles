-- simple stuff that doesn't need any handling
-- and doesn't fit in elsewhere
return {
	{ 'folke/lazy.nvim', version = false },
	'Olical/aniseed',
	{
		'Olical/conjure',
		config = function(_, opts)
			for k, v in pairs(opts) do
				vim.g['conjure#' .. k] = v
			end
		end,
		opts = {
			['mapping#prefix'] = '<localleader>e',
			['extract#tree_sitter#enabled'] = true,
			-- disabling lua, python, rust
			filetypes = {
				'clojure',
				'fennel',
				'hy',
				'janet',
				'julia',
				'lisp',
				'racket',
				'scheme',
			},
			['filetype#fennel'] = 'conjure.client.fennel.stdio',
		},
	},
}
