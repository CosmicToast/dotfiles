local attach = require 'plugins.lsp.attach'
local caps   = require 'plugins.lsp.capabilities'

return {
	{
		'neovim/nvim-lspconfig',
		config = function(_, opts)
			for k, v in pairs(opts) do
				v.on_attach = v.on_attach or attach
				if type(caps) == 'table' then
					v.capabilities = v.capabilities or caps
				end
				local s = require 'lspconfig'[k]
				local c = v.cmd or s.document_config.default_config.cmd
				if vim.fn.executable(c[1]) ~= 0 then
					s.setup(v)
				end
			end
		end,
		opts = function()
			local plist = function(...)
				local p = require 'lspconfig.util'.root_pattern(...)
				return function(f) return p(f) end
			end
			return {
				clangd = {},
				clojure_lsp = {
					root_dir = plist('project.clj', 'deps.edn', 'bb.edn', 'build.boot', 'shadow-cljs.edn', '.git'),
				},
				denols = {
					root_dir = plist('deno.json', 'deno.jsonc'),
				},
				gopls = {},
				ltex  = {},
				lua_ls = {},
				tsserver = {
					root_dir = plist('tsconfig.json', 'package.json'),
				},
			}
		end
	},
}
