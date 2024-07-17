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
            if not (vim.fn.hostname() == "alma") then
                vim.lsp.buf.format({ async = false })
            end
        end,
        group = Ag
    }
)

vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
        pattern = { "*" },
        callback = function()
            local save_cursor = vim.fn.getpos(".")
            vim.cmd([[%s/\s\+$//e]])
            vim.fn.setpos(".", save_cursor)
        end,
        group = Ag
    }
)

-- Hyprlang LSP
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = { "*.hl", "hypr*.conf*" },
    callback = function()
        vim.lsp.start {
            name = "hyprlang",
            cmd = { "hyprls" },
            root_dir = vim.fn.getcwd(),
        }
    end,
    group = Ag
})
