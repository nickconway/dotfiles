return {
    'nanozuki/tabby.nvim',
    config = function()
        require('tabby.tabline').use_preset('active_wins_at_tail')
    end
}
