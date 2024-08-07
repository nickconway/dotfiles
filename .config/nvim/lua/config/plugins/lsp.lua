return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- LSP Support
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "simrat39/rust-tools.nvim" },
        { "folke/neodev.nvim" },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "petertriho/cmp-git" },

        -- Snippets
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },

        { "onsails/lspkind-nvim" },
    },
    config = function()
        local ds = vim.diagnostic.severity
        local levels = {
            [ds.ERROR] = 'error',
            [ds.WARN] = 'warn',
            [ds.INFO] = 'info',
            [ds.HINT] = 'hint'
        }

        local text = {}
        local sign_opts = {
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = '»'
        }

        for i, l in pairs(levels) do
            if type(sign_opts[l]) == 'string' then
                text[i] = sign_opts[l]
            end
        end

        vim.diagnostic.config({ signs = { text = text } })

        local lspconfig = require('lspconfig')
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = "luasnip" },
                { name = 'buffer' },
                { name = 'cmp' },
                { name = 'path' },
            },
            formatting = {
                fields = { 'abbr', 'kind', 'menu' },
                format = require('lspkind').cmp_format({
                    before = require("tailwindcss-colorizer-cmp").formatter,
                    mode = 'symbol_text',  -- show only symbol annotations
                    maxwidth = 50,         -- prevent the popup from showing more than provided characters
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                })
            }
        })

        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources(
                {
                    { name = 'git' },
                },
                {
                    { name = 'buffer' },
                })
        })
        require("cmp_git").setup()

        cmp.setup.filetype({ 'sql' }, {
            sources = {
                { name = "vim-dadbod-completion" },
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'cmp' },
                { name = 'path' },
            }
        })

        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
                {
                    { name = 'buffer' },
                    { name = 'path' }
                },
                {
                    {
                        name = 'cmdline',
                    }
                }),
            matching = { disallow_symbol_nonprefix_matching = false }
        })

        lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig.util.default_config.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, bufnr)
                end

                local map = function(m, lhs, rhs, desc)
                    local key_opts = { buffer = bufnr, desc = desc, nowait = true }
                    vim.keymap.set(m, lhs, rhs, key_opts)
                end

                map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', 'Hover documentation')
                map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', 'Go to definition')
                map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Go to declaration')
                map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Go to implementation')
                map('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Go to type definition')
                map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', 'Go to reference')
                map('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Show function signature')
                map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename symbol')
                map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', 'Format file')
                map('x', '<leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', 'Format selection')
                map('n', '<leader>lc', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Execute code action')
            end
        })

        require('mason').setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        require('mason-lspconfig').setup({
            ensure_installed = {
                "tsserver",
                "eslint",
                "lua_ls",
                "rust_analyzer",
                "tailwindcss",
                "svelte",
                "hyprls",
                "gopls",
            },
            automatic_installation = false,
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,

                lua_ls = function()
                    require('lspconfig').lua_ls.setup({
                        on_init = function(client)
                            local path = client.workspace_folders[1].name
                            if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                                return
                            end

                            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                                runtime = {
                                    -- Tell the language server which version of Lua you're using
                                    -- (most likely LuaJIT in the case of Neovim)
                                    version = 'LuaJIT'
                                },
                                -- Make the server aware of Neovim runtime files
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        vim.env.VIMRUNTIME
                                        -- Depending on the usage, you might want to add additional paths here.
                                        -- "${3rd}/luv/library"
                                        -- "${3rd}/busted/library",
                                    }
                                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                                    -- library = vim.api.nvim_get_runtime_file("", true)
                                }
                            })
                        end,
                        settings = {
                            Lua = {}
                        }
                    })
                end,

                clangd = function()
                    require('lspconfig').clangd.setup({
                        capabilities = {
                            offsetEncoding = 'utf8',
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
            }
        })
    end,
}
