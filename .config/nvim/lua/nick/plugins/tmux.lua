return {
    'nathom/tmux.nvim',
    config = function()
        vim.api.nvim_set_keymap('n', '<M-Up>', ':lua require(\'tmux\').move_up()<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<M-Down>', ':lua require(\'tmux\').move_down()<CR>',
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<M-Left>', ':lua require(\'tmux\').move_left()<CR>',
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<M-Right>', ':lua require(\'tmux\').move_right()<CR>',
            { noremap = true, silent = true })
    end
}
