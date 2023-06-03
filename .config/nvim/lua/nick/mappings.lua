vim.keymap.set('n', 'x', '"_x')

-- centering
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- delete words
vim.keymap.set('i', '<C-BS>', '<Esc>cvb')

-- change word
vim.keymap.set('n', '<CR>', 'ciw')

-- cursor stays on yank
vim.keymap.set('v', 'y', 'ygv<Esc>')

vim.keymap.set('n', 'J', 'mzJ`z')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv==kgvo<Esc>=kgvo", { desc = "Move highlighted text down" })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv==jgvo<Esc>=jgvo", { desc = "Move highlighted text up" })

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set('n', '<leader><CR>', ':so ~/.config/nvim/init.lua<CR>')

vim.keymap.set('n', '<leader>bd', ':bp|bd #<CR>')
vim.keymap.set('n', '<leader>bn', ':bn<CR>')
vim.keymap.set('n', '<leader>bp', ':bp<CR>')

vim.keymap.set('n', '<leader>qq', ':q<CR>')

vim.keymap.set('n', '<leader>so', ':so %<CR>')
vim.keymap.set('n', '<leader>ss', ':w<CR>')
vim.keymap.set('n', '<leader>st', ':wq<CR>')

vim.keymap.set('n', '<leader>tt', '<c-w>T')
vim.keymap.set('n', '<leader>ww', '<c-w>=')

vim.keymap.set('n', '<leader>ws', ':split<CR>')
vim.keymap.set('n', '<leader>wv', ':vsplit<CR>')
vim.keymap.set('n', '<leader>zm', ':ZenMode<CR>')

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>")
