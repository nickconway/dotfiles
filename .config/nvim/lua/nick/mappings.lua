local opts = { noremap = true, silent = true }

vim.keymap.set('n', 'x', '"_x', opts)

vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

vim.keymap.set('n', 'J', 'mzJ`z', opts)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set('n', '<leader><CR>', ':so ~/.config/nvim/init.lua<CR>', opts)

vim.keymap.set('n', '<leader>bd', ':bp|bd #<CR>', opts)
vim.keymap.set('n', '<leader>bn', ':bn<CR>', opts)
vim.keymap.set('n', '<leader>bp', ':bp<CR>', opts)

vim.keymap.set('n', '<leader>pv', ':Ex<CR>', opts)

vim.keymap.set('n', '<leader>qq', ':q<CR>', opts)

vim.keymap.set('n', '<leader>so', ':so %<CR>', opts)
vim.keymap.set('n', '<leader>ss', ':w<CR>', opts)
vim.keymap.set('n', '<leader>st', ':wq<CR>', opts)

vim.keymap.set('n', '<leader>tt', '<c-w>T', opts)
vim.keymap.set('n', '<leader>ww', '<c-w>=', opts)

vim.keymap.set('n', '<leader>ws', ':split<CR>', opts)
vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', opts)
vim.keymap.set('n', '<leader>zm', ':ZenMode<CR>', opts)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", opts)
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", opts)
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", opts)
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", opts)

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)

vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format() end, opts)
