return {
	'nvim-mini/mini.pick',
	version = '*',
	config = function()
		require('mini.pick').setup()
		vim.keymap.set('n', '<leader>pf', ':Pick files<CR>')
		vim.keymap.set('n', '<leader>ps', ':Pick grep live<CR>')
		vim.keymap.set('n', '<leader>pb', ':Pick buffers<CR>')
		-- vim.keymap.set('n', '<C-p>', pick_git_files)
	end,
}