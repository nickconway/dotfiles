return {
    "nvim-neorg/neorg",
    enabled = function()
        local f = io.open(os.getenv("HOME") .. "/.work", "r")
        if f ~= nil then
            f:close()
            return false
        end
        return true
    end,
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
