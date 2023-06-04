return {
    'VonHeikemen/lsp-zero.nvim',
    branch = "v2.x",
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        {
            'williamboman/mason.nvim',
            build = function()
                pcall(vim.cmd, "MasonUpdate")
            end,
        },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'simrat39/rust-tools.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },

        { 'onsails/lspkind-nvim' },
    },
    config = function()
        local lsp = require('lsp-zero').preset("recommended")

        lsp.ensure_installed({
            'tsserver',
            'eslint',
            'lua_ls',
            'rust_analyzer',
        })

        lsp.on_attach(function(client, bufnr)
            if client.server_capabilities.documentSymbolProvider then
                require('nvim-navic').attach(client, bufnr)
            end
            lsp.default_keymaps({ buffer = bufnr })
        end)

        lsp.nvim_workspace()
        lsp.setup()
    end
}
