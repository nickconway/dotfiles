return {
    'rmagatti/auto-session',
    dependencies = {
        'rmagatti/session-lens',
        'nvim-telescope/telescope.nvim',
    },
    lazy = true,
    init = function()
        require('session-lens').setup({
            path_display = { 'shorten' },
            theme_conf = {},
            previewer = false
        })
        require('auto-session').setup {
            auto_session_enabled = os.getenv("AUTOSESSION_ENABLED") ~= "no",
            log_level = 'error',
            auto_session_use_git_branch = true,
            auto_restore_lazy_delay_enabled = true,
        }
    end
}
