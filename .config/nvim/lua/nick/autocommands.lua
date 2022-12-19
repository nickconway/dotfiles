vim.cmd([[
    fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun

    fun! ILeave()
        call TrimWhitespace()
        lua vim.lsp.buf.format()
        w
    endfun
]])

ag = vim.api.nvim_create_augroup("Main", { clear = true })

vim.api.nvim_create_autocmd(
    { "BufNewFile", "BufRead" },
    { pattern = "*.keymap", command = "set filetype=dts", group = ag }
)
vim.api.nvim_create_autocmd(
    "BufWritePost",
    { pattern = "plugins.lua", command = "source <afile> | PackerSync", group = ag }
)
vim.api.nvim_create_autocmd(
    "TextYankPost",
    { callback = function() require("vim.highlight").on_yank({ timeout = 40 }) end, group = ag }
)
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    { command = ":call TrimWhitespace()", group = ag }
)
vim.api.nvim_create_autocmd(
    { "VimResized" },
    { command = "wincmd =", group = ag }
)
vim.api.nvim_create_autocmd(
    { "InsertLeave" },
    { command = ":call ILeave()", group = ag }
)
