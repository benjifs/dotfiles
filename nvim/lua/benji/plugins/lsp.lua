-- This video covers how to setup lsp with and without plugins
-- https://www.youtube.com/watch?v=yI9R13h9IEE
-- Ultimately, I like this approach the most
return {
	{
		'mason-org/mason-lspconfig.nvim',
		opts = {
			ensure_installed = {
				'html',
				'cssls',
				'lua_ls',
				'eslint',
				'ts_ls',
			}
		},
		dependencies = {
				{ 'mason-org/mason.nvim', opts = {} },
				'neovim/nvim-lspconfig',
		},
	}
}