local function map(modes, lhs, rhs, desc, opts)
    local options = { silent = true, noremap = true }
    if desc then
        options = { silent = true, noremap = true, desc = desc }
    end

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    if type(lhs) == "string" then
        vim.keymap.set(modes, lhs, rhs, options)
    elseif type(lhs) == "table" then
        for _, key in pairs(lhs) do
            vim.keymap.set(modes, key, rhs, options)
        end
    end
end

local run_commands = {
    cs = {
        cmd = "dotnet run",
        window = true
    },
    sh = function()
        return "bash " .. vim.fn.expand("%")
    end,
}

map("n", "<leader>cr", function()
    local cmd
    local window

    if not run_commands[vim.bo.filetype] then
        return
    end

    if type(run_commands[vim.bo.filetype]) == "string" then
        cmd = run_commands[vim.bo.filetype]
    elseif type(run_commands[vim.bo.filetype]) == "function" then
        cmd = run_commands[vim.bo.filetype]()
    elseif type(run_commands[vim.bo.filetype]) == "table" then
        cmd = run_commands[vim.bo.filetype]["cmd"]
        window = run_commands[vim.bo.filetype]["window"]
    end

    if window == true then
        vim.cmd("silent !tmux-run -w '" .. cmd .. "'")
    else
        vim.cmd("silent !tmux-run '" .. cmd .. "'")
    end
end, "Run Code")

map("n", "<Home>", "^")

map("n", "x", '"_x')
map("n", "c", '"_c')

map("i", "<C-c>", "<Esc>")

-- centering
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- delete words
map("i", "<C-h>", "<Esc>cvb")

-- change word
map("n", "<CR>", '"_ciw')
map("n", "<S-CR>", '"_ciW')

-- cursor stays on yank
map("x", "y", "ygv<Esc>")

-- cycle buffers
map("n", "<Tab>", "<C-w>w")
map("n", "<S-Tab>", "<C-w>W")

-- Alternate buffer
map("n", "<BS>", ":b#<CR>")

map("n", "J", "mzJ`z")

-- Move lines
map("n", "<C-Down>", "<cmd>m .+1<cr>==", "Move Down")
map("n", "<C-Up>", "<cmd>m .-2<cr>==", "Move Up")
map("i", "<C-Down>", "<esc><cmd>m .+1<cr>==gi", "Move Down")
map("i", "<C-Up>", "<esc><cmd>m .-2<cr>==gi", "Move Up")
map("v", "<C-Down>", ":m '>+1<cr>gv=gv", "Move Down")
map("v", "<C-Up>", ":m '<-2<cr>gv=gv", "Move Up")

map("i", "<esc>", "<cmd>noh<cr><esc>")
map("n", "<esc>", function()
    vim.cmd("noh")
    local mc = require("multicursor-nvim")
    if not mc.cursorsEnabled() then
        mc.enableCursors()
    elseif mc.hasCursors() then
        mc.clearCursors()
    else
        -- Default <esc> handler.
    end
end)

map("n", "<leader>ch", function()
    vim.cmd("set cursorline!")
    vim.cmd("set cursorcolumn!")
end, "Toggle Crosshair")
-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Below")
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Above")

map("n", "p", 'p=`]')
map("n", "P", 'P=`]')
map("x", "p", '"_dP=`]')

map("n", "<leader><CR>", ":so ~/.config/nvim/init.lua<CR>", "Reload config")

map("n", "<leader>bd", ":bp|bd #<CR>", "Delete buffer")
map("n", "<leader>bn", ":bn<CR>", "Next buffer")
map("n", "<leader>bp", ":bp<CR>", "Previous buffer")

map("n", "<leader>F", function()
    local null_ls_sources = require("null-ls.sources")
    local ft = vim.bo.filetype

    local has_null_ls = #null_ls_sources.get_available(ft, "NULL_LS_FORMATTING") > 0

    vim.lsp.buf.format({
        filter = function(client)
            if has_null_ls then
                return client.name == "null-ls"
            else
                return true
            end
        end,
    })
end, "Format buffer")

map("n", "<leader>q", ":xa<CR>", "Quit")
map("n", "<leader>Q", ":qa!<CR>", "Force Quit")

map("n", "<C-s>", ":update<CR>", "Save File")

map("n", "<leader>=", "<c-w>T", "Move to new tab")
map("n", "<leader>ww", "<c-w>=", "Resize windows equally")

map("n", { "<leader>wq", "<leader>wc" }, function()
    if vim.bo[vim.api.nvim_win_get_buf(0)].readonly then
        vim.cmd("q!")
    else
        vim.cmd("wq")
    end
end, "Close window")

map("n", "<leader>ws", function()
    vim.cmd("split")
end, "Split horizontally")

map("n", "<leader>wv", function()
    vim.cmd("vsplit")
end, "Split vertically")

map("n", "<C-k>", "<cmd>cnext<CR>zz")
map("n", "<C-j>", "<cmd>cprev<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz", "Location list next")
map("n", "<leader>j", "<cmd>lprev<CR>zz", "Location list previous")

map("n", "<C-f>", "<cmd>silent !tmux-sessionizer<CR>")

map("n", "<leader>/", "*", "Search word under cursor")
map("n", "<leader><A-/>", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], "Replace word under cursor", { silent = false })

map("n", "<leader>X", "<cmd>!chmod +x %<CR>", "Make file executable")

map("n", "<leader>z", ":ZenMode<CR>", "Zen mode")

map("n", "<leader>lu", ":Lazy update<CR>", "Lazy update")
map("n", "<leader>ll", ":Lazy<CR>", "Lazy")

map("x", "<lt>", "<lt>gv")
map("x", ">", ">gv")
map("x", "<S-Tab>", "<lt>gv")
map("x", "<Tab>", ">gv")
