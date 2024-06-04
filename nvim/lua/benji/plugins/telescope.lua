return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.4',
	dependencies = 'nvim-lua/plenary.nvim',
	config = function()
		vim.keymap.set('n', '<leader>pf', require('telescope.builtin').find_files, {})
		vim.keymap.set('n', '<C-p>', require('telescope.builtin').git_files, {})
		vim.keymap.set('n', '<leader>ps', function()
			require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end
}
