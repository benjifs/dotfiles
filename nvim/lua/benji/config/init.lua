require('benji.config.keymaps')
require('benji.config.options')
require('benji.config.lazy')

-- skeleton (snippets)
local function insert_skeleton(ext)
  local template = vim.fn.stdpath('config') .. '/templates/skeleton.' .. ext
	if vim.fn.filereadable(template) == 1 then
    vim.cmd("-1read " .. template)
  end
end
local function insert_skeleton_cmd(opts)
  insert_skeleton(opts.args)
end

vim.api.nvim_create_user_command('Skeleton', insert_skeleton_cmd, { nargs = 1 })
vim.api.nvim_create_user_command('Sk', insert_skeleton_cmd, { nargs = 1 })

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*.*',
  desc = 'Insert skeleton when creating a new file',
  callback = function()
    insert_skeleton(vim.fn.expand('%:e'))
  end,
})