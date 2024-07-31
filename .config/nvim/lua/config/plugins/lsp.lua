return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        {
            "williamboman/mason.nvim",
            build = function()
                pcall(vim.cmd, "MasonUpdate")
            end,
        },
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

        -- Snippets
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },

        { "onsails/lspkind-nvim" },
    },
    config = function()
        local lsp_zero = require("lsp-zero")

        lsp_zero.on_attach(function(client, bufnr)
            if client.server_capabilities.documentSymbolProvider then
                require("nvim-navic").attach(client, bufnr)
            end
            lsp_zero.default_keymaps({ buffer = bufnr })

            -- vim.api.nvim_create_autocmd("CursorHold", {
            --     buffer = bufnr,
            --     callback = function()
            --         local float_opts = {
            --             focusable = false,
            --             close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            --             border = "rounded",
            --             source = "always", -- show source in diagnostic popup window
            --             prefix = " ",
            --         }
            --
            --         if not vim.b.diagnostics_pos then
            --             vim.b.diagnostics_pos = { nil, nil }
            --         end
            --
            --         local cursor_pos = vim.api.nvim_win_get_cursor(0)
            --         if (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2]) and #vim.diagnostic.get() > 0
            --         then
            --             vim.diagnostic.open_float(nil, float_opts)
            --         else
            --             local position_params = vim.lsp.util.make_position_params()
            --             vim.lsp.buf_request_all(bufnr, "textDocument/hover", position_params, function(results)
            --                 local b = false
            --                 for _, result in pairs(results) do
            --                     if result.result and result.result.contents then
            --                         b = true
            --                     end
            --                 end
            --                 if b then
            --                     vim.lsp.buf.hover()
            --                 end
            --             end)
            --         end
            --
            --         vim.b.diagnostics_pos = cursor_pos
            --     end,
            -- })
        end)

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                "tsserver",
                "eslint",
                "lua_ls",
                "rust_analyzer",
            },
            handlers = {
                lsp_zero.default_setup,

                lua_ls = function()
                    require('lspconfig').lua_ls.setup(lsp_zero.nvim_lua_ls())
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

        lsp_zero.set_sign_icons({
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = '»'
        })

        lsp_zero.set_server_config({
            on_init = function(client)
                client.server_capabilities.semanticTokensProvider = nil
            end,
        })

        lsp_zero.setup()

        local cmp = require('cmp')
        local cmp_action = require('lsp-zero').cmp_action()

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<Tab>'] = cmp_action.luasnip_supertab(),
                ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
            }),
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = {
                { name = 'nvim_lsp' },
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

        cmp.setup.filetype({ 'sql' },
            {
                sources = {
                    { name = "vim-dadbod-completion" },
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'cmp' },
                    { name = 'path' },
                }
            })

        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'buffer' },
                { name = 'path' }
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                }
            })
        })
    end,
}
