vim.cmd([[
    fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun
]])

Ag = vim.api.nvim_create_augroup("main", { clear = true })

vim.api.nvim_create_autocmd(
    { "BufNewFile", "BufRead" },
    { pattern = "*.keymap", command = "set filetype=dts", group = Ag }
)

vim.api.nvim_create_autocmd(
    "BufWritePost",
    { pattern = "plugins.lua", command = "source <afile> | PackerSync", group = Ag }
)

vim.api.nvim_create_autocmd(
    "TextYankPost",
    { callback = function() require("vim.highlight").on_yank({ timeout = 40 }) end, group = Ag }
)

vim.api.nvim_create_autocmd(
    "VimResized",
    { command = "wincmd =", group = Ag }
)

vim.api.nvim_create_autocmd(
    { "TextChanged", "FocusLost", "InsertLeave", "BufLeave" },
    {
        command = "wa",
        group = Ag
    }
)

vim.api.nvim_create_autocmd(
    { "BufWritePre", "BufWritePost" },
    {
        callback = function()
            vim.lsp.buf.format({ async = false })
        end,
        group = Ag
    }
)
