local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', 1, 'https://github.com/wbthomason/packer.nvim', install_path})
end

function get_config(name)
    return string.format("require('plugins/%s')", name)
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'onsails/lspkind-nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use { 'hrsh7th/nvim-cmp', config = get_config('cmp') }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

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

    use 'SirVer/ultisnips'
    use 'quangnguyen30192/cmp-nvim-ultisnips'

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

    use { 'navarasu/onedark.nvim', config = get_config('onedark') }

    use { 'windwp/nvim-autopairs', config = get_config('autopairs') }

    use 'nathom/tmux.nvim'

    use 'sbdchd/neoformat'

    use { 'akinsho/toggleterm.nvim', config = get_config('toggleterm') }

    use { 'kyazdani42/nvim-tree.lua', config = get_config('nvim-tree') }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
