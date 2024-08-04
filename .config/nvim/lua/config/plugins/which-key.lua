return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
    config = function()
        require("which-key").add({
            { "<leader>b", group = "Buffers" },
            { "<leader>d", group = "DAP" },
            { "<leader>f", group = "Find" },
            { "<leader>g", group = "Git" },
            { "<leader>h", group = "Harpoon" },
            { "<leader>l", group = "Lazy" },
            { "<leader>s", group = "Save" },
            { "<leader>w", group = "Window" },
        })
    end
}
