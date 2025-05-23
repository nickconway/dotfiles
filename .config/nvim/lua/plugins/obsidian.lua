return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
        -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
        "BufReadPre " .. vim.fn.expand "~" .. "/Documents/Notes/**.md",
        "BufNewFile " .. vim.fn.expand "~" .. "/Documents/Notes/**.md",

        "BufReadPre /mnt/nas/home/Documents/Notes/**.md",
        "BufNewFile /mnt/nas/home/Documents/Notes/**.md",

        "BufReadPre " .. vim.fn.expand "~" .. "/Git/blog/**.md",
        "BufNewFile " .. vim.fn.expand "~" .. "/Git/blog/**.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter"
    },
    opts = {
        workspaces = {
            {
                name = "Local Notes",
                path = "~/Documents/Notes",
            },
            {
                name = "Notes",
                path = "/mnt/nas/home/Documents/Notes",
            },
            {
                name = "Blog",
                path = "~/Git/blog",
            },
        },
        daily_notes = {
            -- Optional, if you keep daily notes in a separate directory.
            folder = nil,
            date_format = "%Y/%B/%m-%d-%Y - %A",
            -- Optional, if you want to change the date format of the default alias of daily notes.
            alias_format = "%B %-d, %Y",
            -- Optional, default tags to add to each new daily note created.
            default_tags = { "daily-notes" },
            -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
            template = nil
        },
        mappings = {
            ["gf"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true, desc = "Obsidian Edit File" },
            },
            ["<leader>ch"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true, desc = "Toggle Checkbox" },
            },
            ["<leader>oo"] = {
                action = function()
                    return require("obsidian").util.smart_action()
                end,
                opts = { buffer = true, expr = true, desc = "Obsidian Smart Action" },
            },
            ["<leader>od"] = {
                action = function()
                    vim.cmd("ObsidianToday")
                end,
                opts = { buffer = true, expr = true, desc = "Obsidian Daily Note" },
            }
        }
    },
}
