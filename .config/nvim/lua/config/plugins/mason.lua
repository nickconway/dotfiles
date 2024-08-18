return {
    "williamboman/mason.nvim",
    dependencies = {
        { "williamboman/mason-lspconfig.nvim" },
        { "simrat39/rust-tools.nvim" },
    },
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
        ensure_installed = {},
        ui = {
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    },
    config = function(_, opts)
        require("mason").setup(opts)

        local mr = require("mason-registry")
        mr:on("package:install:success", function()
            vim.defer_fn(function()
                -- trigger FileType event to possibly load this newly installed LSP server
                require("lazy.core.handler.event").trigger({
                    event = "FileType",
                    buf = vim.api.nvim_get_current_buf(),
                })
            end, 100)
        end)

        mr.refresh(function()
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end)

        on_attach = function(client, bufnr)
            if client.server_capabilities.documentSymbolProvider then
                require("nvim-navic").attach(client, bufnr)
            end

            local map = function(m, lhs, rhs, desc)
                local key_opts = { buffer = bufnr, desc = desc, nowait = true }
                vim.keymap.set(m, lhs, rhs, key_opts)
            end

            map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Documentation")
            map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to Definition")
            map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to Declaration")
            map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to Implementation")
            map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to Type Definition")
            map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", "Go to Reference")
            map("n", "gS", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show Function Signature")
            map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename Symbol")
            map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format File")
            map("x", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
                "Format Selection")
            map("n", "<leader>lc", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Execute Code Action")
        end

        require("mason-lspconfig").setup({
            ensure_installed = {
                "tsserver",
                "eslint",
                "lua_ls",
                "bashls",
                "rust_analyzer",
                "tailwindcss",
                "svelte",
                "hyprls",
                "gopls",
            },
            automatic_installation = true,
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        on_attach = on_attach,
                    })
                end,

                lua_ls = function()
                    require("lspconfig").lua_ls.setup({
                        on_attach = on_attach,
                        on_init = function(client)
                            local path = client.workspace_folders[1].name
                            if
                                vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc")
                            then
                                return
                            end

                            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                                runtime = {
                                    -- Tell the language server which version of Lua you're using
                                    -- (most likely LuaJIT in the case of Neovim)
                                    version = "LuaJIT",
                                },
                                -- Make the server aware of Neovim runtime files
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        vim.env.VIMRUNTIME,
                                        -- Depending on the usage, you might want to add additional paths here.
                                        -- "${3rd}/luv/library"
                                        -- "${3rd}/busted/library",
                                    },
                                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                                    -- library = vim.api.nvim_get_runtime_file("", true)
                                },
                            })
                        end,
                        settings = {
                            Lua = {},
                        },
                    })
                end,

                clangd = function()
                    require("lspconfig").clangd.setup({
                        on_attach = on_attach,
                        capabilities = {
                            offsetEncoding = "utf-16",
                        },
                        cmd = {
                            "clangd",
                            "--background-index",
                        },
                        on_init = function(client, _)
                            client.server_capabilities.semanticTokensProvider = nil
                        end,
                    })
                end,
            },
        })
    end,
}
