---@diagnostic disable:undefined-global

local cmp = require 'cmp'
local snp = require 'snippy'

local mappings = require('snippy.mapping')
vim.keymap.set('i', '<Tab>', mappings.expand_or_advance('<Tab>'),
	{ desc = 'snippy next' })
vim.keymap.set('s', '<Tab>', mappings.next('<Tab>'),
	{ desc = 'snippy next' })
vim.keymap.set({ 'i', 's' }, '<S-Tab>', mappings.previous('<S-Tab>'),
	{ desc = 'snippy prev' })
vim.keymap.set('x', '<Tab>', mappings.cut_text,
	{ remap = true, desc = 'snippy cut' })
vim.keymap.set('n', 'g<Tab>', mappings.cut_text,
	{ remap = true, desc = 'snippy cut' })

cmp.setup {
	mapping = cmp.mapping.preset.insert {
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm { select = true },
	},
	snippet = {
		expand = function(args)
			snp.expand_snippet(args.body)
		end,
	},
	window = {
	},
	sources = cmp.config.sources {
		{ name = 'nvim_lsp' },
		-- { name = 'conjure' },
		{ name = 'snippy' },
	},
}

cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' },
	}, {
		{ name = 'cmdline' },
	})
})
