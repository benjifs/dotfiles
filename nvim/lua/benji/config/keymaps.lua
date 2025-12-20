vim.g.mapleader = ' '
local keymap = vim.keymap.set
-- open netrw
keymap('n', '<leader>pv', vim.cmd.Ex)
-- move selection up and down in Visual
keymap('v', 'J', ":m '>+1<CR>gv=gv")
keymap('v', 'K', ":m '<-2<CR>gv=gv")
-- J(oins) next line with current line
-- this keeps cursor in position while J
keymap('n', 'J', 'mzJ`z')
-- page up/down with cursor in middle
keymap('n', '<C-u>', '<C-u>zz')
keymap('n', '<C-d>', '<C-d>zz')
-- next/prev with cursor in middle
keymap('n', 'n', 'nzzzv')
keymap('n', 'N', 'Nzzzv')
-- y(ank) or d(elete) to system clipboard
keymap({ 'n', 'v' }, '<leader>y', [["+y]])
keymap('n', '<leader>Y', [["+Y]])
keymap({ 'n', 'v' }, '<leader>d', [["_d]])
-- quickfix navigation
keymap('n', '<C-k>', '<cmd>cnext<CR>zz')
keymap('n', '<C-j>', '<cmd>cprev<CR>zz')
keymap('n', '<leader>k', '<cmd>lnext<CR>zz')
keymap('n', '<leader>j', '<cmd>lprev<CR>zz')
-- find and replace word under cursor
keymap('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- formats with LSP
keymap('n', '<leader>f', vim.lsp.buf.format)
-- misc
keymap('n', 'Q', '<nop>')