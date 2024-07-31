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
    { "BufWritePre" },
    {
        callback = function()
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
