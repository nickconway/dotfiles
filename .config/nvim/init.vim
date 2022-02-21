set number
set relativenumber
set tabstop=4
set smarttab
set smartindent
set shiftwidth=4
set mouse=a
set softtabstop=4
set expandtab
set nohlsearch
set hidden
set autoindent
set noerrorbells
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=4
set signcolumn=yes
set cmdheight=1
set clipboard+=unnamed,unnamedplus
set showtabline=0
set siso=4
set noshowcmd
set noshowmode
set foldmethod=indent
set nofoldenable



let mapleader=" "



call plug#begin('~/.vim/plugged')

Plug 'onsails/lspkind-nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'folke/which-key.nvim'

Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'numToStr/Comment.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kdheepak/tabline.nvim'

Plug 'nvim-lualine/lualine.nvim'

Plug 'navarasu/onedark.nvim'

Plug 'windwp/nvim-autopairs'

Plug 'nathom/tmux.nvim'

Plug 'sbdchd/neoformat'

Plug 'akinsho/toggleterm.nvim'
call plug#end()



nnoremap x "_x

" Keep centered
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv
nnoremap <silent> J mzJ`z

" Typing breakpoints
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Move text
vnoremap N :m '>+1<CR>gv=gv
vnoremap E :m '<-2<CR>gv=gv
inoremap <silent> <c-n> <esc>:m .+1<CR>==i
inoremap <silent> <c-e> <esc>:m .-2<CR>==i
nnoremap <silent> <leader>e :m .-2<CR>==
nnoremap <silent><leader>n :m .+1<CR>==

nnoremap <silent> ZZ :qa<CR>
nnoremap <silent> <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <silent> <leader>bb :BufferLinePick<CR>
nnoremap <silent> <leader>bfd :bp\|bd! #<CR>
nnoremap <silent> <leader>bd :bp\|bd #<CR>
nnoremap <silent> <leader>bn :bn<CR>
nnoremap <silent> <leader>bp :bp<CR>
nnoremap <silent> <leader>ff :lua require('telescope.builtin').find_files{}<CR>
nnoremap <silent> <leader>fb :lua require('telescope.builtin').buffers()<CR>
nnoremap <silent> <leader>fg :lua require('telescope.builtin').git_files()<CR>
nnoremap <silent> <leader>fh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <silent> <leader>fi :lua require('telescope.builtin').file_browser()<CR>
nnoremap <silent> <leader>fl :lua require('telescope.builtin').live_grep()<CR>
nnoremap <silent> <leader>fs :lua require('telescope.builtin').current_buffer_fuzzy_find()<CR><CR>
nnoremap <silent> <leader>gg :lua require('toggleterm.terminal').Terminal:new({ cmd = 'lazygit' }):toggle()<CR>
nnoremap <silent> <leader>oo :Obsess<CR>
nnoremap <silent> <leader>pi :PlugInstall<CR>
tnoremap <silent> <leader>qq <C-\><C-n>
nnoremap <silent> <leader>qq :q<CR>
nnoremap <silent> <leader>so :so ~/.config/nvim/init.vim<CR>
nnoremap <silent> <leader>ss :w<CR>
nnoremap <silent> <leader>st :wq<CR>
nnoremap <silent> <leader>tt <c-w>T
nnoremap <silent> <leader>tn :tabnext<CR>
nnoremap <silent> <leader>to :TablineToggleShowAllBuffers<CR>
nnoremap <silent> <leader>tp :tabprevious<CR>
nnoremap <leader>t, :TablineTabRename<Space>
nnoremap <silent> <leader>ww <c-w>=
nnoremap <silent> <leader>wc :wq<CR><CR>
nnoremap <silent> <leader>ws :split<CR>
nnoremap <silent> <leader>wv :vsplit<CR>

nnoremap <silent> <M-Up> :lua require('tmux').move_up()<CR>
nnoremap <silent> <M-Down> :lua require('tmux').move_down()<CR>
nnoremap <silent> <M-Left> :lua require('tmux').move_left()<CR>
nnoremap <silent> <M-Right> :lua require('tmux').move_right()<CR>
tnoremap <silent> <esc> <C-\><C-n>
tnoremap <silent> <M-Up> <C-\><C-n><C-W>k
tnoremap <silent> <M-Down> <C-\><C-n><C-W>j
tnoremap <silent> <M-Left> <C-\><C-n><C-W>h
tnoremap <silent> <M-Right> <C-\><C-n><C-W>l

set completeopt=menuone,noinsert,noselect
set sessionoptions+=tabpages,globals
let g:completion_matching_strategy_list = ["exact", "substring", "fuzzy"]

lua << EOF
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
EOF

colorscheme onedark
highlight Normal guibg=none
highlight SignColumn guibg=none
highlight EndOfBuffer guibg=none guifg=guibg
set fillchars=eob:\ ,

" Insert only caps-lock
for c in range(char2nr('A'), char2nr('Z'))
    execute 'lnoremap ' . nr2char(c+32) . ' ' . nr2char(c)
    execute 'lnoremap ' . nr2char(c) . ' ' . nr2char(c+32)
endfor

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup MAIN
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd InsertLeave * set iminsert=0
    autocmd FileType which_key set laststatus=0 noshowmode noruler
    autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    autocmd VimResized * wincmd =
    autocmd TextChanged,InsertLeave * if &readonly == 0 && filereadable(bufname('%')) | silent write | endif " autosave
augroup END
