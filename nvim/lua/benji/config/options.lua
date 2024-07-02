local opt = vim.opt

-- General
opt.backup = false
opt.swapfile = false
opt.undodir = os.getenv('HOME') .. '/.cache/vim/undo'
opt.undofile = true

-- UI
opt.guicursor = ''
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.wrap = false
opt.colorcolumn = '80'

-- Tabs, Indent
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = false
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "nosplit"

opt.scrolloff = 8
opt.signcolumn = 'yes'
opt.isfname:append('@-@')

opt.updatetime = 50
