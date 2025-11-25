return {
    { "nvchad/volt", lazy = true },
    {
        "nvchad/menu",
        lazy = true,
        keys = {
            {
                "<leader>md",
                function()
                    require("menu").open("default")
                end,
                desc = "Default Menu",
            },
            {
                "<leader>mg",
                function()
                    require("menu").open("gitsigns")
                end,
                desc = "Gitsigns Menu",
            },
            {
                "<leader>ml",
                function()
                    require("menu").open("lsp")
                end,
                desc = "LSP Menu",
            },
            {
                "<leader>mn",
                function()
                    require("menu").open("nvimtree")
                end,
                desc = "Nvimtree Menu",
            },
        },
    },
}
