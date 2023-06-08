return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
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
        require("neodev").setup({
            library = { plugins = { "nvim-dap-ui" }, types = true },
        })

        local lsp = require("lsp-zero").preset("recommended")

        lsp.ensure_installed({
            "tsserver",
            "eslint",
            "lua_ls",
            "rust_analyzer",
        })

        lsp.on_attach(function(client, bufnr)
            if client.server_capabilities.documentSymbolProvider then
                require("nvim-navic").attach(client, bufnr)
            end
            lsp.default_keymaps({ buffer = bufnr })
        end)

        lsp.set_sign_icons({
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = '»'
        })

        lsp.set_server_config({
            on_init = function(client)
                client.server_capabilities.semanticTokensProvider = nil
            end,
        })

        lsp.nvim_workspace()
        lsp.setup()

        local cmp = require('cmp')
        local cmp_action = require('lsp-zero').cmp_action()

        cmp.setup({
            mapping = {
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<Tab>'] = cmp_action.luasnip_supertab(),
                ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
            },
            formatting = {
                -- changing the order of fields so the icon is the first
                fields = { 'menu', 'abbr', 'kind' },

                -- here is where the change happens
                format = function(entry, item)
                    local menu_icon = {
                        nvim_lsp = 'λ',
                        luasnip = '⋗',
                        buffer = 'Ω',
                        path = '🖫',
                        nvim_lua = 'Π',
                    }

                    item.menu = menu_icon[entry.source.name]
                    return item
                end,
            },
        })
    end,
}
