Ag = vim.api.nvim_create_augroup("main", { clear = true })

vim.api.nvim_create_autocmd(
    { "BufNewFile", "BufRead" },
    { pattern = "*.keymap", command = "set filetype=dts", group = Ag }
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
    "FocusLost",
    {
        command = "silent! update",
        group = Ag,
    }
)

vim.api.nvim_create_autocmd(
    { "BufWritePre", "BufWritePost" },
    {
        callback = function()
            local project = vim.loop.cwd():match("^.*/(.+)$")
            if not (project == "koui3" or project == "ko_rest") then
                vim.lsp.buf.format({ async = false })
            end
        end,
        group = Ag
    }
)
