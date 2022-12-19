local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', 1, 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {}
        end,
    },
    git = {
        clone_timeout = 300,
    },
}

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

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
        }
    }

    use 'mfussenegger/nvim-dap'
    use "rcarriga/nvim-dap-ui"
    use "ravenxrz/DAPInstall.nvim"

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-context'

    use 'RRethy/vim-illuminate'

    use { 'nvim-telescope/telescope.nvim',
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-github.nvim" },
            { "nvim-telescope/telescope-fzy-native.nvim" },
        },
    }
    use { "nvim-telescope/telescope-file-browser.nvim" }

    use 'folke/which-key.nvim'

    use {
        'rmagatti/session-lens',
        requires = {
            'rmagatti/auto-session',
            'nvim-telescope/telescope.nvim',
        },
    }

    use 'numToStr/Comment.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'lewis6991/gitsigns.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'folke/zen-mode.nvim'
    use 'navarasu/onedark.nvim'
    use 'windwp/nvim-autopairs'
    use 'nathom/tmux.nvim'
    use 'theprimeagen/harpoon'
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'
    use "lukas-reineke/indent-blankline.nvim"

    use {
        "folke/noice.nvim",
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    }

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
