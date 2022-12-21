return {
    'rmagatti/session-lens',
    dependencies = {
        'rmagatti/auto-session',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require('session-lens').setup({
            path_display = { 'shorten' },
            theme_conf = {},
            previewer = false
        })
        require('auto-session').setup {
            log_level = 'error',
            auto_session_use_git_branch = true,
        }
    end
}
