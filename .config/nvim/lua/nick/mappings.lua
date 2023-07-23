local opts = { noremap = true, silent = true }

vim.keymap.set("n", "x", '"_x', opts)

vim.keymap.set("i", "<C-c>", "<Esc>", opts)
-- centering
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- delete words
vim.keymap.set("i", "<C-h>", "<Esc>cvb", opts)

-- change word
vim.keymap.set("n", "<CR>", "ciw", opts)

-- cursor stays on yank
vim.keymap.set("v", "y", "ygv<Esc>", opts)

-- cycle buffers
vim.keymap.set("n", "<Tab>", "<C-w>w", opts)
vim.keymap.set("n", "<S-Tab>", "<C-w>W", ops)

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

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file)
vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>ht", function()
    ui.nav_file(1)
end)
vim.keymap.set("n", "<leader>hs", function()
    ui.nav_file(2)
end)
vim.keymap.set("n", "<leader>hr", function()
    ui.nav_file(3)
end)
vim.keymap.set("n", "<leader>ha", function()
    ui.nav_file(4)
end)

vim.keymap.set("n", "-", ":lua MiniFiles.open()<CR>", opts)

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
vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
vim.keymap.set("n", "<leader>fg", builtin.git_files, opts)
vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)
vim.keymap.set("n", "<leader>fl", builtin.live_grep, opts)
vim.keymap.set("n", "<leader>fm", "<cmd>lua require('telescope.builtin').resume()<cr>", opts)
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope oldfiles<cr>", opts)
vim.keymap.set("n", "<leader>fs", ":SearchSession<CR>", opts)
vim.keymap.set("n", "<leader>fo", ":Telescope file_browser<CR>", opts)

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    dir = "git_dir",
    direction = "float",
    float_opts = {
        border = "double",
    },
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function(_)
        vim.cmd("startinsert!")
    end,
})

local yadm = Terminal:new({
    cmd = "yadm enter lazygit",
    hidden = true,
    dir = "/home/nick/",
    direction = "float",
    float_opts = {
        border = "double",
    },
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function(_)
        vim.cmd("startinsert!")
    end,
})

local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
end

vim.keymap.set("n", "<leader>g", function()
    if is_git_repo() then
        lazygit:toggle()
    else
        yadm:toggle()
    end
end, opts)
