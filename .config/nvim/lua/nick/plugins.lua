local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', 1, 'https://github.com/wbthomason/packer.nvim', install_path})
end

local function get_config(name)
    return string.format("require('plugins/%s')", name)
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
    use { 'lewis6991/impatient.nvim', config = get_config('impatient') }

    use 'onsails/lspkind-nvim'
    use 'neovim/nvim-lspconfig'
    use "williamboman/mason-lspconfig.nvim"
    use { "williamboman/mason.nvim", config = function() require('mason').setup() end }

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use { 'hrsh7th/nvim-cmp', config = get_config('cmp') }

    use { 'L3MON4D3/LuaSnip', config = get_config('luasnip') }
    use 'saadparwaiz1/cmp_luasnip'

    use {
        'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
        config = get_config('treesitter')
    }
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-context'

    use 'nvim-lua/popup.nvim'
    use { 'nvim-telescope/telescope.nvim',
            requires = {
                { "nvim-lua/plenary.nvim" },
                { "nvim-telescope/telescope-github.nvim" },
            },
        config = get_config('telescope')
    }
    use 'nvim-telescope/telescope-fzy-native.nvim'

    use { 'folke/which-key.nvim', config = get_config('which-key') }
    use 'sunjon/shade.nvim'

    use {
        'rmagatti/auto-session',
        config = function()
            require('auto-session').setup {
                log_level = 'info',
            }
        end
    }

    use {
        'rmagatti/session-lens',
        requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
        config = get_config('session-lens')
    }

    use { 'numToStr/Comment.nvim', config = get_config('Comment') }

    use 'kyazdani42/nvim-web-devicons'
    use { 'lewis6991/gitsigns.nvim', config = get_config('gitsigns') }

    use 'kdheepak/tabline.nvim'
    use { 'nvim-lualine/lualine.nvim', config = get_config('lualine') }

    use { 'folke/zen-mode.nvim', config = get_config('zen-mode') }

    use { 'navarasu/onedark.nvim', config = get_config('onedark') }

    use { 'windwp/nvim-autopairs', config = get_config('autopairs') }
    use 'nathom/tmux.nvim'

    use 'sbdchd/neoformat'
    use { 'akinsho/toggleterm.nvim', config = get_config('toggleterm') }

    use { 'kyazdani42/nvim-tree.lua', config = get_config('nvim-tree') }
    use "lukas-reineke/indent-blankline.nvim"

    use {
        'rcarriga/nvim-notify',
        config = function()
            require("notify").setup({
                background_colour = "#000000",
            })
        end,
    }
    use({
      "folke/noice.nvim",
      config = function()
        require("noice").setup({
            presets = {
              -- you can enable a preset by setting it to true, or a table that will override the preset config
              -- you can also add custom presets that you can enable/disable with enabled=true
              bottom_search = true, -- use a classic bottom cmdline for search
              command_palette = true, -- position the cmdline and popupmenu together
              long_message_to_split = false, -- long messages will be sent to a split
              inc_rename = false, -- enables an input dialog for inc-rename.nvim
            }
        })
      end,
      requires = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
        }
    })

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
