return {
    'SmiteshP/nvim-navic',
    dependencies = {
        'neovim/nvim-lspconfig',
    },
    config = function()
        local navic = require("nvim-navic")

        navic.setup({
            separator = " ",
            highlight = true,
            depth_limit = 5,
            lazy_update_context = true,
        })
    end
}
