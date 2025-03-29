return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "onsails/lspkind-nvim" },
        { 'saghen/blink.cmp' },
    },
    config = function(_, opts)
        local text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
        }

        vim.diagnostic.config({
            virtual_lines = {
                format = function(d)
                    return text[d.severity] .. " " .. d.message
                end
            },
            severity_sort = true,
            signs = { text = text },
        })

        local lspconfig = require("lspconfig")

        require("lspconfig.ui.windows").default_options.border = "rounded"

        lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
            "force",
            lspconfig.util.default_config.capabilities,
            require('blink.cmp').get_lsp_capabilities()
        )
    end,
}
