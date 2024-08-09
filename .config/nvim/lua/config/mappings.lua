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

        topts.entry_maker = function(entry)
            local str = entry
            str = string.gsub(str, ".config/yadm/alt/", "")
            str = string.gsub(str, "##template.*", "")
            return {
                value = string.format("%s/%s", vim.fn.getenv("HOME"), entry),
                display = str,
                ordinal = entry,
            }
        end

        pickers
            .new(topts, {
                prompt_title = "Yadm Files",
                finder = finders.new_oneshot_job({ "get-yadm-files" }, topts),
                previewer = conf.file_previewer(topts),
                sorter = conf.file_sorter(topts),
            })
            :find()
    elseif is_git_repo() then
        require("telescope.builtin").git_files({ cwd = get_git_root() })
    else
        require("telescope.builtin").find_files()
    end
end

map("n", "<Home>", "^")

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

map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", "Escape and Clear hlsearch")

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Below")
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Above")

map("x", "p", '"_dP')

map("n", "<leader><CR>", ":so ~/.config/nvim/init.lua<CR>", "Reload config")

map("n", "<leader>bd", ":bp|bd #<CR>", "Delete buffer")
map("n", "<leader>bn", ":bn<CR>", "Next buffer")
map("n", "<leader>bp", ":bp<CR>", "Previous buffer")

map("n", "<leader>a", ":Neotree<CR>", "NeoTree")

map("n", "<leader>D", ":DBUIToggle<CR>", "Toggle DBUI")

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

map("n", "<leader>t", ":Trouble diagnostics toggle<CR>", "Trouble")

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
    get_files()
end, "Split horizontally")
map("n", "<leader>wv", function()
    vim.cmd("vsplit")
    get_files()
end, "Split vertically")

map("n", "<C-k>", "<cmd>cnext<CR>zz")
map("n", "<C-j>", "<cmd>cprev<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz", "Location list next")
map("n", "<leader>j", "<cmd>lprev<CR>zz", "Location list previous")

map("n", "<C-f>", "<cmd>silent !tmux-sessionizer<CR>")

map("n", "<leader>/", "*", "Search word under cursor")
map("n", "<leader><A-/>", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], "Replace word under cursor", { silent = false })

map("n", "<leader>X", "<cmd>!chmod +x %<CR>", "Make file executable")

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

map("n", "<leader>z", ":ZenMode<CR>", "Zen mode")

map("n", "<leader>gg", function()
    if is_git_repo() then
        vim.env.GIT_DIR = get_git_root() .. "/.git"
        vim.env.GIT_WORK_TREE = get_git_root()
    else
        vim.env.GIT_DIR = vim.fn.expand("~/.local/share/yadm/repo.git")
        vim.env.GIT_WORK_TREE = vim.fn.expand("~")
    end
    local neogit = require("neogit")
    neogit.open({ kind = "replace" })
end, "NeoGit")

map("n", "<leader>gl", function()
    local opts = {
        cmd = "lazygit",
        hidden = true,
        dir = "git_dir",
        direction = "float",
        float_opts = {
            border = "none",
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
map("n", "<leader>gh", "<cmd>Gitsigns preview_hunk_inline<CR>", "Preview hunk")
map("n", "<leader>gn", "<cmd>Gitsigns next_hunk<CR>", "Next hunk")
map("n", "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>", "Previous hunk")
map("n", "<leader>g", "<cmd>Git<CR>", "Git status")

map("n", "<leader>pu", ":Lazy update<CR>", "Lazy update")
map("n", "<leader>pp", ":Lazy<CR>", "Lazy")

map("x", "<lt>", "<lt>gv")
map("x", ">", ">gv")
map("x", "<S-Tab>", "<lt>gv")
map("x", "<Tab>", ">gv")
