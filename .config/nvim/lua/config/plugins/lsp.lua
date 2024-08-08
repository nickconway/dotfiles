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

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client ~= nil and client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, bufnr)
                end

                local map = function(m, lhs, rhs, desc)
                    local key_opts = { buffer = bufnr, desc = desc, nowait = true }
                    vim.keymap.set(m, lhs, rhs, key_opts)
                end

                map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover documentation")
                map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition")
                map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration")
                map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation")
                map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to type definition")
                map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", "Go to reference")
                map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show function signature")
                map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol")
                map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format file")
                map("x", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format selection")
                map("n", "<leader>lc", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Execute code action")
            end,
        })
    end,
}
