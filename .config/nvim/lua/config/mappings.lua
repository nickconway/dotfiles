local function map(mode, lhs, rhs, desc, opts)
    local options = { silent = true, noremap = true }
    if desc then
        options = { silent = true, noremap = true, desc = desc }
    end

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.keymap.set(mode, lhs, rhs, options)
end

local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
end

local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
end

local builtin = require("telescope.builtin")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local function get_files()
    if vim.fn.getcwd() == vim.fn.getenv("HOME") then
        local topts = {}

        local yadm_command = { "get-yadm-files" }

        topts.entry_maker = function(entry)
            local str = entry
            str = string.gsub(str, ".config/yadm/alt/", "")
            str = string.gsub(str, "##template.*", "")
            return {
                value = string.format("%s/%s", vim.fn.getenv("HOME"), entry),
                display = str,
                ordinal = entry
            }
        end

        pickers.new(topts, {
            prompt_title = "Yadm Files",
            finder = finders.new_oneshot_job(
                vim.tbl_flatten { yadm_command, },
                topts
            ),
            previewer = conf.file_previewer(topts),
            sorter = conf.file_sorter(topts),
        }):find()
    elseif is_git_repo() then
        require("telescope.builtin").git_files({ cwd = get_git_root() })
    else
        require("telescope.builtin").find_files()
    end
end

map("n", "x", '"_x')

map("i", "<C-c>", "<Esc>")

-- centering
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- delete words
map("i", "<C-h>", "<Esc>cvb")

-- change word
map("n", "<CR>", "ciw")
map("n", "<S-CR>", function()
    vim.opt.iskeyword:append(".")
    vim.cmd("normal! ciw")
    vim.opt.iskeyword:remove(".")
end)

-- cursor stays on yank
map("v", "y", "ygv<Esc>")

-- cycle buffers
map("n", "<Tab>", "<C-w>w")
map("n", "<S-Tab>", "<C-w>W")

-- Alternate buffer
map("n", "<BS>", ":b#<CR>")

map("n", "J", "mzJ`z")

map("v", "J", ":m '>+1<CR>gv==kgvo<Esc>=kgvo")
map("v", "K", ":m '<-2<CR>gv==jgvo<Esc>=jgvo")

map("x", "<leader>p", '"_dP')

map("n", "<leader><CR>", ":so ~/.config/nvim/init.lua<CR>", "Reload config")

map("n", "<leader>bd", ":bp|bd #<CR>", "Delete buffer")
map("n", "<leader>bn", ":bn<CR>", "Next buffer")
map("n", "<leader>bp", ":bp<CR>", "Previous buffer")

map("n", "<leader>D", ":DBUIToggle<CR>", "Toggle DBUI")

map("n", "<leader>F", function()
    local null_ls_sources = require('null-ls.sources')
    local ft = vim.bo.filetype

    local has_null_ls = #null_ls_sources.get_available(ft, 'NULL_LS_FORMATTING') > 0

    vim.lsp.buf.format({
        filter = function(client)
            if has_null_ls then
                return client.name == 'null-ls'
            else
                return true
            end
        end,
    })
end, "Format buffer")

map("n", "<leader>q", ":xa<CR>", "Quit")
map("n", "<leader>Q", ":qa!<CR>", "Force quit")

map("n", "<leader>s", ":update<CR>", "Save file")

map("n", "<leader>t", ":Trouble diagnostics toggle<CR>", "Trouble")

map("n", "<leader>=", "<c-w>T", "Move to new tab")
map("n", "<leader>ww", "<c-w>=", "Resize windows equally")

map("n", "<leader>wc", ":wq<CR>", "Close window")
map("n", "<leader>ws", function()
    vim.cmd('split')
    get_files()
end, "Split horizontally")
map("n", "<leader>wv", function()
    vim.cmd('vsplit')
    get_files()
end, "Split vertically")

map("n", "<C-k>", "<cmd>cnext<CR>zz")
map("n", "<C-j>", "<cmd>cprev<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz", "Location list next")
map("n", "<leader>j", "<cmd>lprev<CR>zz", "Location list previous")

map("n", "<C-f>", "<cmd>silent !tmux-sessionizer<CR>")

map("n", "<leader>/", [[/\<<C-r><C-w>\><CR>]], "Search word under cursor", { silent = false })
map("n", "<leader><leader>/", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], "Replace word under cursor", { silent = false })

map("n", "<leader>x", "<cmd>!chmod +x %<CR>", "Make file executable")

map("n", "<leader>u", vim.cmd.UndotreeToggle, "Toggle undotree")

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

map("n", "<leader>ha", mark.add_file, "Add file")
map("n", "<leader>hh", ui.toggle_quick_menu, "Menu")

map("n", "<leader>ht", function()
    ui.nav_file(1)
end, "File 1")
map("n", "<leader>hs", function()
    ui.nav_file(2)
end, "File 2")
map("n", "<leader>hr", function()
    ui.nav_file(3)
end, "File 3")
map("n", "<leader>ha", function()
    ui.nav_file(4)
end, "File 4")

map("n", "-", ":lua MiniFiles.open()<CR>")

map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", "Toggle breakpoint")
map("n", "<leader>dc", "<cmd>DapContinue<CR>", "Continue")
map("n", "<leader>di", "<cmd>DapStepInto<CR>", "Step into")
map("n", "<leader>do", "<cmd>DapStepOut<CR>", "Stop out")
map("n", "<leader>dt", "<cmd>DapTerminate<CR>", "Terminate")
map("n", "<leader>dv", "<cmd>DapStepOver<CR>", "Step over")
map("n", "<leader>dr", function()
    require("dap").repl.open()
end, "Open repl")

map("n", "<leader>fb", builtin.buffers, "Buffers")
map("n", "<leader>ff", get_files, "Files")
map("n", "<leader>fh", builtin.help_tags, "Help tags")
map("n", "<leader>fl", builtin.live_grep, "Live grep")
map("n", "<leader>fm", "<cmd>lua require('telescope.builtin').resume()<cr>", "Last")
map("n", "<leader>fm", "<cmd>Telescope oldfiles<cr>", "Recent files")
map("n", "<leader>fs", ":SearchSession<CR>", "Sessions")
map("n", "<leader>fo", ":Telescope file_browser<CR>", "File browser")

map("n", "<leader>ll", ":Lazy<CR>", "Lazy")
map("n", "<leader>lu", ":Lazy update<CR>", "Lazy update")

map("n", "<leader>z", ":ZenMode<CR>", "Zen mode")

map("n", "<leader>gg", function()
    if is_git_repo() then
        vim.env.GIT_DIR = get_git_root() .. "/.git"
        vim.env.GIT_WORK_TREE = get_git_root()
    else
        vim.env.GIT_DIR = vim.fn.expand("~/.local/share/yadm/repo.git")
        vim.env.GIT_WORK_TREE = vim.fn.expand("~")
    end
    local neogit = require('neogit')
    neogit.open({ kind = "replace" })
end, "NeoGit")

map("n", "<leader>gl", function()
    local opts = {
        cmd = "lazygit",
        hidden = true,
        dir = "git_dir",
        direction = "float",
        float_opts = {
            border = "rounded",
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
    }

    if not is_git_repo() then
        opts.cmd = "yadm enter lazygit"
        opts.dir = os.getenv("HOME")
    end

    local Terminal = require("toggleterm.terminal").Terminal
    local term = Terminal:new(opts)
    term:toggle()
end, "LazyGit")

map("n", "<leader>ga", "<cmd>Git add %<CR>", "Git add current file")
map("n", "<leader>gA", "<cmd>Git add --all<CR>", "Git add all files")
map("n", "<leader>gb", "<cmd>Git branch<CR>", "Git branch")
map("n", "<leader>gc", "<cmd>Git commit -v<CR>", "Git commit")
map("n", "<leader>gca", "<cmd>Git commit -a -v<CR>", "Git commit --all")
map("n", "<leader>gcm", [[:Git commit -a m ""<Left>]], "Git commit -m", { silent = false })
map("n", "<leader>gcM", [[:Git commit -a m ""<Left>]], "Git commit -a -m", { silent = false })
map("n", "<leader>gn", "<cmd>Gitsigns next_hunk<CR>", "Next hunk")
map("n", "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>", "Previous hunk")
map("n", "<leader>g", "<cmd>Git<CR>", "Git status")

map("x", "<lt>", "<lt>gv")
map("x", ">", ">gv")
map("x", "<S-Tab>", "<lt>gv")
map("x", "<Tab>", ">gv")
