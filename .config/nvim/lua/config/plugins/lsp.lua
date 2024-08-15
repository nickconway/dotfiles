return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "onsails/lspkind-nvim" },
    },
    config = function()
        local ds = vim.diagnostic.severity
        local levels = {
            [ds.ERROR] = "error",
            [ds.WARN] = "warn",
            [ds.INFO] = "info",
            [ds.HINT] = "hint",
        }

        local text = {}
        local sign_opts = {
            error = "✘",
            warn = "▲",
            hint = "⚑",
            info = "»",
        }

        for i, l in pairs(levels) do
            if type(sign_opts[l]) == "string" then
                text[i] = sign_opts[l]
            end
        end

        vim.diagnostic.config({
            virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
            signs = { text = text },
        })

        local lspconfig = require("lspconfig")

        require("lspconfig.ui.windows").default_options.border = "rounded"
        lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
            "force",
            lspconfig.util.default_config.capabilities,
            require("cmp_nvim_lsp").default_capabilities()
        )
    end,
}
