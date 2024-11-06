return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        quickfile = { enabled = true },
        words = { enabled = false },
        notifier = {
            enabled = true,
            timeout = 3000,
            style = "compact"
        },
    },
}
