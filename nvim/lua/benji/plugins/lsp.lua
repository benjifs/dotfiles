-- This video covers how to setup lsp with and without plugins
-- https://www.youtube.com/watch?v=yI9R13h9IEE
-- I like this approach the most
require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {
		-- 'html',
		-- 'cssls',
		'lua_ls',
		'eslint',
		'ts_ls',
	},
})
