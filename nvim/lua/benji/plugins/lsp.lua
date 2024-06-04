return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v3.x',
	dependencies = {
		{ 'williamboman/mason.nvim' },
		{ 'williamboman/mason-lspconfig.nvim' },
		{ 'neovim/nvim-lspconfig' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/nvim-cmp' },
		{ 'L3MON4D3/LuaSnip' },
	},
	config = function()
		local lsp_zero = require('lsp-zero')

		-- To get rid of: Undefined global `vim`
		lsp_zero.configure('lua_ls', {
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' }
					}
				}
			}
		})

		lsp_zero.on_attach(function(client, bufnr)
			-- see :help lsp-zero-keybindings
			-- to learn the available actions
			lsp_zero.default_keymaps({ buffer = bufnr })
		end)

		-- Autocompletion
		local cmp = require('cmp')
		cmp.setup({
			formatting = lsp_zero.cmp_format(),
			preselect = 'item',
			completion = {
				completeopt = 'menu,menuone,noinsert'
			},
			mapping = cmp.mapping.preset.insert({
				['<CR>'] = cmp.mapping.confirm({ select = true }),
				-- Conflicts with tmux. Will fix later
				['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
				['<C-s>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'path' },
				{ name = 'buffer' },
			})
		})

		-- LSP
		-- see :help lsp-zero-guide:integrate-with-mason-nvim
		-- to learn how to use mason.nvim with lsp-zero
		require('mason').setup({})
		require('mason-lspconfig').setup({
			ensure_installed = {
				'lua_ls',
				'eslint',
				'tsserver',
			},
			handlers = {
				lsp_zero.default_setup,
			}
		})
	end,
}
