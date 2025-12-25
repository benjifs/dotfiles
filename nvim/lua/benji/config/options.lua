-- General
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv('HOME') .. '/.cache/vim/undo'
vim.opt.undofile = true
-- UI
vim.opt.guicursor = ''
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.colorcolumn = '80'
vim.opt.winborder = 'rounded'
-- Tabs, Indent
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.smartindent = true
-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'nosplit'
-- Extra
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')
vim.opt.updatetime = 50
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·', eol = '¬', nbsp = '_', space = '·' }

vim.diagnostic.config({
	underline = true,
	virtual_text = true,
})

-- I think this is supposed to work but there's something wrong with my config.
-- Will check back later but for now, blink is good.
-- vim.api.nvim_create_autocmd('LspAttach', {
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		if client and client:supports_method('textDocument/completion') then
-- 			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
-- 		end
-- 	end,
-- })
-- vim.opt.completeopt = 'menuone,noinsert,popup,fuzzy'
