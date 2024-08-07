return {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    config = function()
        require('neorg').setup {
            load = {
                ["core.defaults"] = {},  -- Loads default behaviour
                ["core.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.dirman"] = {      -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/Documents/Notes",
                        },
                    },
                    default_workspace = "notes",
                },
            },
        }
    end
}
