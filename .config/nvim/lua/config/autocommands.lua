Ag = vim.api.nvim_create_augroup("main", { clear = true })

vim.api.nvim_create_autocmd(
    { "BufNewFile", "BufRead" },
    { pattern = "*.keymap", command = "set filetype=dts", group = Ag }
)

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        require("vim.highlight").on_yank({ timeout = 40 })
    end,
    group = Ag,
})

vim.api.nvim_create_autocmd("VimResized", {
    group = Ag,
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

vim.api.nvim_create_autocmd("FocusLost", {
    command = "silent! update",
    group = Ag,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)

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
            async = false,
        })
    end,
    group = Ag,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    group = Ag,
    nested = true,
    callback = function()
        if os.getenv("AUTOSESSION_ENABLED") == "no" then
            return
        end
        if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
            require("persistence").load()
        end
    end,
})

-- Hyprlang LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.hl", "hypr*.conf*" },
    callback = function()
        vim.lsp.start({
            name = "hyprlang",
            cmd = { "hyprls" },
            root_dir = vim.fn.getcwd(),
        })
    end,
    group = Ag,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = "*git-rebase-todo",
    group = Ag,
    callback = function()
        vim.keymap.set({ "n", "x" }, "p", ":normal ^ciwpick<CR>", { silent = true, buffer = true })

        vim.keymap.set({ "n", "x" }, "r", ":normal ^ciwreword<CR>", { buffer = true, silent = true })
        vim.keymap.set({ "n", "x" }, "e", ":normal ^ciwedit<CR>", { buffer = true, silent = true })
        vim.keymap.set({ "n", "x" }, "s", ":normal ^ciwsquash<CR>", { buffer = true, silent = true })
        vim.keymap.set({ "n", "x" }, "f", ":normal ^ciwfixup<CR>", { buffer = true, silent = true })
        vim.keymap.set({ "n", "x" }, "fc", ":normal ^ciwfixup -c<CR>", { buffer = true, silent = true })
        vim.keymap.set({ "n", "x" }, "fC", ":normal ^ciwfixup -C<CR>", { buffer = true, silent = true })
        vim.keymap.set("n", "x", "oexec ", { buffer = true, silent = true })
        vim.keymap.set("n", "b", "obreak<ESC>", { buffer = true, silent = true })
        vim.keymap.set({ "n", "x" }, "d", ":normal ^ciwdrop<CR>", { buffer = true, silent = true })
        vim.keymap.set("n", "l", "olabel ", { buffer = true, silent = true })
        vim.keymap.set("n", "t", "oreset ", { buffer = true, silent = true })

        -- TODO: merge command
        -- vim.keymap.set("n", "t", "oreset ", { buffer = true, silent = true})

        vim.keymap.set("n", "U", "oupdate-ref ", { buffer = true, silent = true })
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = Ag,
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = Ag,
    pattern = {
        "PlenaryTestPopup",
        "grug-far",
        "help",
        "lspinfo",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
        "dbout",
        "gitsigns.blame",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", {
            buffer = event.buf,
            silent = true,
            desc = "Quit buffer",
        })
    end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = Ag,
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})
