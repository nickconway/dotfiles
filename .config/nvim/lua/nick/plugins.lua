local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', 1, 'https://github.com/wbthomason/packer.nvim', install_path})
end

local function get_config(name)
    return string.format("require('plugins/%s')", name)
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {'lewis6991/impatient.nvim', config = get_config('impatient') }

    use 'onsails/lspkind-nvim'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use { 'hrsh7th/nvim-cmp', config = get_config('cmp') }

    use {'L3MON4D3/LuaSnip', config = get_config('luasnip')}
    use 'saadparwaiz1/cmp_luasnip'

    use {
        'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
        config = get_config('treesitter')
    }

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

    use { 'folke/zen-mode.nvim' }

    use { 'navarasu/onedark.nvim', config = get_config('onedark') }

    use { 'windwp/nvim-autopairs', config = get_config('autopairs') }
    use 'nathom/tmux.nvim'

    use 'sbdchd/neoformat'
    use('kmonad/kmonad-vim')
    use { 'akinsho/toggleterm.nvim', config = get_config('toggleterm') }

    use { 'kyazdani42/nvim-tree.lua', config = get_config('nvim-tree') }

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
