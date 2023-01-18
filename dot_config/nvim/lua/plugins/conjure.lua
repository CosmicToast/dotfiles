---@diagnostic disable:undefined-global
local prefix = '<localleader>e'
vim.g['conjure#mapping#prefix'] = prefix
vim.g['conjure#extract#tree_sitter#enabled'] = true
-- disabling: lua, python, rust
vim.g['conjure#filetypes'] = {
	'clojure',
	'fennel',
	'hy',
	'janet',
	'julia',
	'lisp',
	'racket',
	'scheme',
}
vim.g['conjure#filetype#fennel'] = 'conjure.client.fennel.stdio'

-- TODO: only do this in affected buffers
-- how?
local wk = require 'which-key'
wk.register({
	name = '+conjure',
	e = {
		name = '+eval',
		c = { name = '+comment' },
	},
	g = { name = '+get' },
	l = { name = '+log' },
	r = { name = '+reset' },
}, {prefix = prefix})
