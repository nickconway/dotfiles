vim.api.nvim_create_autocmd(
    { "BufNewFile", "BufRead" },
    {
        group = vim.api.nvim_create_augroup("keymap-dts", { clear = true }),
        pattern = "*.keymap",
        command = "set filetype=dts",
    }
)

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        require("vim.highlight").on_yank({ timeout = 50 })
    end,
    group = vim.api.nvim_create_augroup("highlight-on-yank", { clear = true }),
})

vim.api.nvim_create_autocmd("VimResized", {
    group = vim.api.nvim_create_augroup("equal-windows", { clear = true }),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

vim.api.nvim_create_autocmd("FocusLost", {
    command = "silent! update",
    group = vim.api.nvim_create_augroup("save-on-focus-lost", { clear = true }),
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("save-on-focus-lost", { clear = true }),
    pattern = { "json", "jsonc", "json5" },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("spell-wrap", { clear = true }),
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
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
    group = vim.api.nvim_create_augroup("autosave", { clear = true }),
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    group = vim.api.nvim_create_augroup("autosession", { clear = true }),
    nested = true,
    callback = function()
        if os.getenv("AUTOSESSION_ENABLED") == "no" then
            return
        end
        if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
            require("persistence").load()
        else
            require("persistence").stop()
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
    group = vim.api.nvim_create_augroup("hyprls", { clear = true }),
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = "*git-rebase-todo",
    group = vim.api.nvim_create_augroup("rebase-keymaps", { clear = true }),
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
    group = vim.api.nvim_create_augroup("create-directories", { clear = true }),
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
    group = vim.api.nvim_create_augroup("q-close", { clear = true }),
    pattern = {
        "PlenaryTestPopup",
        "grug-far",
        "grug-far-history",
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
    group = vim.api.nvim_create_augroup("update-focus", { clear = true }),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})
