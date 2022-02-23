local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', 1, 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.nvim_exec([[
    augroup packer
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'onsails/lspkind-nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'

    use 'folke/which-key.nvim'

    use 'SirVer/ultisnips'
    use 'quangnguyen30192/cmp-nvim-ultisnips'

    use 'tpope/vim-obsession'
    use 'dhruvasagar/vim-prosession'
    use 'numToStr/Comment.nvim'

    use 'kyazdani42/nvim-web-devicons'
    use 'lewis6991/gitsigns.nvim'
    use 'kdheepak/tabline.nvim'

    use 'nvim-lualine/lualine.nvim'

    use 'navarasu/onedark.nvim'

    use 'windwp/nvim-autopairs'

    use 'nathom/tmux.nvim'

    use 'sbdchd/neoformat'

    use 'akinsho/toggleterm.nvim'

    if packer_bootstrap then
        require('packer').sync()
    end
end)

require("gitsigns").setup{
    current_line_blame = true,
    yadm = {
        enable = true
    }
}

require("which-key").setup{}
require("onedark").setup{}

require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = require('telescope.actions').close
            }
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    },
    pickers = {
        find_files = {
            hidden = true
        }
    }
}

require('telescope').load_extension('fzy_native')
require('nvim-treesitter').setup{}
require("Comment").setup{}

require('lualine').setup{
    options = {
        theme = 'transparent_onedark',
        section_separators = {left = '', right = ''},
        component_separators = {left = '', right = ''},
        padding = 1
    },
    sections = {
        lualine_x = {'tabs', 'encoding', 'fileformat', 'filetype'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
}

local cmp = require('cmp')
cmp.setup({
    formatting = {
        format = require('lspkind').cmp_format({with_text = false, maxwidth = 50})
    },
    experimental = {
        native_menu = false,
        ghost_text = true
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
        end,
    },
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<esc>'] = cmp.mapping.abort()
    },
    sources = {
        { name = 'nvim_lsp' },
        --{ name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
        { name = 'buffer' },
        { name = 'path' },
        { name = 'cmdline' }
    }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'path' },
        { name = 'buffer' },
        { name = 'cmdline' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = {
        { name = 'path' },
        { name = 'cmdline' }
    }
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig').vimls.setup{
    capabilities = capabilities
}
require('lspconfig').pyright.setup{
    capabilities = capabilities
}

require('nvim-autopairs').setup{}
require('toggleterm').setup{
    size = 20,
    open_mapping = [[<c-\>]],
    shade_terminals = false,
    direction = "horizontal",
    persist_size = true,
}
