vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.mouse = 'a'
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.autoindent = true
vim.opt.errorbells = false
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = "~/.vim/undodir"
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 4
vim.opt.signcolumn = 'yes'
vim.opt.cmdheight = 1
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
vim.opt.showtabline = 0
vim.opt.siso = 4
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = false
vim.opt.fillchars = 'eob: '
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.sessionoptions:append { 'tabpages', 'globals' }

vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

vim.cmd("colorscheme onedark")
vim.cmd('highlight Normal guibg=none')
vim.cmd('highlight SignColumn guibg=none')
vim.cmd('highlight EndOfBuffer guibg=none')
