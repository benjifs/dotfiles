vim.pack.add({
	-- completion
	{ src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('v1.*') },
	{ src = 'https://github.com/rafamadriz/friendly-snippets' }, -- dependencies
	-- colorscheme
	{ src = 'https://github.com/tjdevries/colorbuddy.nvim' },
	-- git
	{ src = 'https://github.com/lewis6991/gitsigns.nvim' },
	-- lsp
	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
	{ src = 'https://github.com/mason-org/mason.nvim' }, -- dependencies
	{ src = 'https://github.com/neovim/nvim-lspconfig' }, -- dependencies
	-- picker
	{ src = 'https://github.com/nvim-mini/mini.pick' },
})

require('benji.plugins.blink')
require('benji.plugins.colorscheme')
require('benji.plugins.gitsigns')
require('benji.plugins.lsp')
require('benji.plugins.mini')
