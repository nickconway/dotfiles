return {
    "dmtrKovalenko/fff.nvim",
    build = function()
        -- downloads a prebuilt binary or falls back to cargo build
        require("fff.download").download_or_build_binary()
    end,
    -- for nixos:
    -- build = "nix run .#release",
    opts = {
        debug = {
            enabled = true,
            show_scores = true,
        },
    },
    lazy = false, -- the plugin lazy-initialises itself
    keys = {
        {
            "<leader>ff",
            function()
                require("fff").find_files()
            end,
            desc = "Find files",
        },
        {
            "<leader>fl",
            function()
                require("fff").live_grep()
            end,
            desc = "Live grep",
        },
        {
            "<leader>fz",
            function()
                require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
            end,
            desc = "Live fuzzy grep",
        },
        {
            "<leader>fw",
            function()
                require("fff").live_grep({ query = vim.fn.expand("<cword>") })
            end,
            desc = "Search current word",
        },
    },
}
