---@diagnostic disable: undefined-global

local lspc = require 'lspconfig'
local lspu = require 'lspconfig.util'

local function plist(...)
	local p = lspu.root_pattern(...)
	return function(f) return p(f) end
end

-- completion
local cap = require 'cmp_nvim_lsp'.default_capabilities()

-- mappings
local wk = require 'which-key'

-- signature help
local sg = require 'lsp_signature'
local sgconf = {
	zindex = 50,
	hint_enable = false,
	extra_trigger_chars = {' '},
	toggle_key = '<M-x>',
}

---@diagnostic disable-next-line: unused-local
local on_attach = function(c, b)
	local lsp = vim.lsp
	local lbf = lsp.buf
	vim.api.nvim_buf_set_option(b, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	sg.on_attach(sgconf, b)
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

-- configs
local common = { on_attach = on_attach, capabilities = cap }
local clojure = vim.deepcopy(common)
local deno    = vim.deepcopy(common)
local tss     = vim.deepcopy(common)
clojure.root_dir = plist('project.clj', 'deps.edn', 'bb.edn', 'build.boot', 'shadow-cljs.edn', '.git')
deno.root_dir    = plist('deno.json', 'deno.jsonc')
tss.root_dir     = plist('tsconfig.json', 'package.json')

-- servers
local function enable(name, opts)
	opts = opts or common
	local s = lspc[name]
	local c = opts.cmd or s.document_config.default_config.cmd
	if vim.fn.executable(c[1]) ~= 0 then
		s.setup(opts)
	end
end

enable('clojure_lsp', clojure)
enable('denols', deno)
enable 'gopls'
enable 'ltex'
enable 'sumneko_lua'
enable('tsserver', tss)