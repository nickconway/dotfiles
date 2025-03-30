return {
    "stevearc/oil.nvim",
    keys = {
        {
            "-",
            function()
                local oil = require("oil")
                local util = require("oil.util")

                oil.toggle_float(".")

                util.run_after_load(0, function()
                    oil.open_preview()
                end)
            end,
            desc = "Open directory"
        },
    },
    opts = {
        columns = {
            "icon",
            -- "permissions",
            -- "size",
            -- "mtime",
        },
        skip_confirm_for_simple_edits = true,
        watch_for_changes = true,
        use_default_keymaps = false,

        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<leader>wv"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
            ["<leader>ws"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
            ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["q"] = "actions.close",
            ["<esc>"] = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["r"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
            ["g\\"] = "actions.toggle_trash",
        },
    },
}
