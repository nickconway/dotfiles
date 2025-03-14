return {
    "folke/noice.nvim",
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to the notification view.,
        --   If not available, we `mini` as the fallback,
        "rcarriga/nvim-notify",
    },
    config = function()
        local noice = require("noice")

        noice.setup({
            cmdline = {
                format = {
                    cmdline = { title = '' },
                    search_down = { title = '' },
                    search_up = { title = '' },
                    filter = { title = '' },
                    lua = { title = '' },
                    help = { title = '' },
                    input = { title = '' },
                },
            },
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false,        -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and  together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true,            -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,        -- add a border to hover docs and signature help
            },
        })

        require("notify").setup({
            background_colour = "#000000",
        })
    end,
}
