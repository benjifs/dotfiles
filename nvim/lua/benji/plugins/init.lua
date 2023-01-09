return {
    'tpope/vim-commentary',
    {
        'tpope/vim-fugitive',
        keys = {
            { '<leader>gs', vim.cmd.Git }
        },
    },
    {
        'mbbill/undotree',
        keys = {
            { '<leader>u', vim.cmd.UndotreeToggle }
        },
    },
}