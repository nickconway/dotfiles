return {
    { "nvchad/volt", lazy = true },
    {
        "nvchad/minty",
        lazy = true,
        keys = {
            {
                "<leader>co",
                function()
                    require("minty.huefy").open({ border = true })
                end,
                desc = "Color Picker (Hues)"
            },
            {
                "<leader>cO",
                function()
                    require("minty.shades").open({ border = true })
                end,
                desc = "Color Picker (Shades)"
            }
        }
    }
}
