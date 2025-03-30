return {
    {
        'navarasu/onedark.nvim',
        config = function()
            require("onedark").setup {
                transparent = true,
            }
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            styles = {
                bold = true,
                italic = true,
                transparency = false,
            },
        }
    }
}
