return {
    "NvChad/nvim-colorizer.lua",
    dependencies = {
        "roobert/tailwindcss-colorizer-cmp.nvim",
    },
    config = function()
        require("colorizer").setup({
            user_default_options = {
                tailwind = true,
            },
        })
        require("tailwindcss-colorizer-cmp").setup({
            color_square_width = 2,
        })
    end,
}
