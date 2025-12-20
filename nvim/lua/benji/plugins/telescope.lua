return { -- Fuzzy Finder (files, lsp, etc)
	'nvim-telescope/telescope.nvim',
	dependencies = 'nvim-lua/plenary.nvim',
	config = function()
		vim.keymap.set('n', '<leader>pf', require('telescope.builtin').find_files, {})
		vim.keymap.set('n', '<C-p>', require('telescope.builtin').git_files, {})
		vim.keymap.set('n', '<leader>ps', function()
			require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end
}