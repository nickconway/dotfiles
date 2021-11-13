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
set clipboard+=unnamedplus


let mapleader=" "



call plug#begin('~/.vim/plugged')

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
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kdheepak/tabline.nvim'

Plug 'nvim-lualine/lualine.nvim'

Plug 'navarasu/onedark.nvim'

Plug 'windwp/nvim-autopairs'

Plug 'nathom/tmux.nvim'

call plug#end()



" Yank cursor to eol
nnoremap Y y$

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
nnoremap <silent> <leader>bfd :bdelete!<CR>
nnoremap <silent> <leader>bd :bdelete<CR>
nnoremap <silent> <leader>bn :bn<CR>
nnoremap <silent> <leader>bp :bp<CR>
nnoremap <silent> <leader>ff :lua require('telescope.builtin').find_files{}<CR>
nnoremap <silent> <leader>fb :lua require('telescope.builtin').buffers()<CR>
nnoremap <silent> <leader>fg :lua require('telescope.builtin').git_files()<CR>
nnoremap <silent> <leader>fh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <silent> <leader>fi :lua require('telescope.builtin').file_browser()<CR>
nnoremap <silent> <leader>fl :lua require('telescope.builtin').live_grep()<CR>
nnoremap <silent> <leader>fs :lua require('telescope.builtin').current_buffer_fuzzy_find()<CR><CR>
nnoremap <silent> <leader>ga :Git add %:p<CR><CR>
nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gc :Git commit -v -q<CR>
nnoremap <silent> <leader>gt :Git commit -v -q %:p<CR>
nnoremap <silent> <leader>gd :Git diff<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR><CR>
nnoremap <silent> <leader>gy :silent! Glog<CR>:bot copen<CR>
nnoremap <silent> <leader>gg :Ggrep<Space>
nnoremap <silent> <leader>gm :Gmove<Space>
nnoremap <silent> <leader>gb :Git branch<Space>
nnoremap <silent> <leader>go :Git checkout<Space>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gl :Git pull<CR>
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

set completeopt=menuone,noinsert,noselect
set sessionoptions+=tabpages,globals
let g:completion_matching_strategy_list = ["exact", "substring", "fuzzy"]

lua << EOF
require('tabline').setup{
   options = {
       show_filename_only = true
   }
}
require("gitsigns").setup{
    current_line_blame = true,
    yadm = {
        enable = true
    }
}

require("which-key").setup{}
require("onedark").setup{}

require('nvim-autopairs').setup{}

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
require('lualine').setup{
--    tabline = {
--      lualine_c = { 'buffers' },
--      lualine_x = { 'tabs' }
--    }
}

local cmp = require('cmp')
cmp.setup{
    snippet = {
        expand = function(args)
            vim.fn['UltiSnips#Anon'](args.body)
        end,
    },
    sources = cmp.config.sources({
        {name = 'nvim-lsp'},
        {name = 'buffer'},
        {name = 'path'},
        {name = 'ultisnips'},
    })
}
cmp.setup.cmdline('/', {
    sources = {
        {name = 'path'},
    }
})
cmp.setup.cmdline(':', {
    sources = {
        {name = 'path'},
        {name = 'cmdline'}
    }
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require('lspconfig').vimls.setup{
    capabilities = capabilities
}
require('lspconfig').pyright.setup{
    capabilities = capabilities
}
EOF

nnoremap <silent> <M-Up> :lua require('tmux').move_up()<CR>
nnoremap <silent> <M-Down> :lua require('tmux').move_down()<CR>
nnoremap <silent> <M-Left> :lua require('tmux').move_left()<CR>
nnoremap <silent> <M-Right> :lua require('tmux').move_right()<CR>

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
augroup END
