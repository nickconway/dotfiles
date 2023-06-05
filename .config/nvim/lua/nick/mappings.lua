local opts = { noremap = true, silent = true }

vim.keymap.set("n", "x", '"_x', opts)

-- centering
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- delete words
vim.keymap.set("i", "<C-BS>", "<Esc>cvb", opts)

-- change word
vim.keymap.set("n", "<CR>", "ciw", opts)

-- cursor stays on yank
vim.keymap.set("v", "y", "ygv<Esc>", opts)

-- cycle buffers
vim.keymap.set("n", "<Tab>", "<C-w>w", opts)
vim.keymap.set("n", "<S-Tab>", "<C-w>W", opts)

-- Telescope thing
vim.keymap.set(
	"n",
	";",
	"<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>",
	opts
)

-- Alternate buffer
vim.keymap.set("n", "<BS>", ":b#<CR>", opts)

-- Format
vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = false })<CR>", opts)

vim.keymap.set("n", "J", "mzJ`z", opts)

vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<Esc>=kgvo", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<Esc>=jgvo", opts)

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader><CR>", ":so ~/.config/nvim/init.lua<CR>", opts)

vim.keymap.set("n", "<leader>bd", ":bp|bd #<CR>", opts)
vim.keymap.set("n", "<leader>bn", ":bn<CR>", opts)
vim.keymap.set("n", "<leader>bp", ":bp<CR>", opts)

vim.keymap.set("n", "<leader>qq", ":q<CR>", opts)

vim.keymap.set("n", "<leader>so", ":so %<CR>", opts)
vim.keymap.set("n", "<leader>ss", ":w<CR>", opts)
vim.keymap.set("n", "<leader>st", ":wq<CR>", opts)

vim.keymap.set("n", "<leader>tt", "<c-w>T", opts)
vim.keymap.set("n", "<leader>ww", "<c-w>=", opts)

vim.keymap.set("n", "<leader>ws", ":split<CR>", opts)
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>", opts)
vim.keymap.set("n", "<leader>zm", ":ZenMode<CR>", opts)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", opts)
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", opts)
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", opts)
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", opts)

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-n>", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "<C-e>", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "<C-i>", function()
	ui.nav_file(3)
end)
vim.keymap.set("n", "<C-o>", function()
	ui.nav_file(4)
end)

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>")
vim.keymap.set("n", "<leader>di", "<cmd>DapStepInto<CR>")
vim.keymap.set("n", "<leader>do", "<cmd>DapStepOut<CR>")
vim.keymap.set("n", "<leader>dt", "<cmd>DapTerminate<CR>")
vim.keymap.set("n", "<leader>dv", "<cmd>DapStepOver<CR>")
vim.keymap.set("n", "<leader>dr", function()
	require("dap").repl.open()
end)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pb", builtin.buffers, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>pf", builtin.find_files, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>pg", builtin.git_files, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ph", builtin.help_tags, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>pl", builtin.live_grep, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>pp", ":SearchSession<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>pv", ":Telescope file_browser<CR>", opts)

vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { silent = true })
