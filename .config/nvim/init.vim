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
set signcolumn=number
set cmdheight=1



let mapleader=" "



" Yank cursor to eol
nnoremap Y y$

" Keep centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Move text
vnoremap N :m '>+1<CR>gv=gv
vnoremap E :m '<-2<CR>gv=gv
inoremap <c-n> <esc>:m .+1<CR>==i
inoremap <c-e> <esc>:m .-2<CR>==i
nnoremap <leader>n :m .+1<CR>==
nnoremap <leader>e :m .-2<CR>==



call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-lua/completion-nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'folke/which-key.nvim'

Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'lewis6991/gitsigns.nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'navarasu/onedark.nvim'

call plug#end()



nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>bb :BufferLinePick<CR>
nnoremap <leader>bfd :bdelete!<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit -v -q<CR>
nnoremap <leader>gt :Git commit -v -q %:p<CR>
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gy :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gg :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>oo :Obsess<CR>
nnoremap <leader>pi :PlugInstall<CR>
tnoremap <leader>qq <C-\><C-n>
nnoremap <leader>qq :q<CR>
nnoremap <leader>so :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>ss :w<CR>
nnoremap <leader>st :wq<CR>
nnoremap <leader>ff :lua require('telescope.builtin').find_files{}<CR>
nnoremap <leader>fg :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fh :lua require('telescope.builtin').help_tags()<CR>



set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ["exact", "substring", "fuzzy"]

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
augroup END

lua << EOF
require("bufferline").setup{}
require("nvim-autopairs").setup{}
require("gitsigns").setup{}
require("which-key").setup{}
require("onedark").setup{}
require('telescope').setup{
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
            }
        }
}
require('telescope').load_extension('fzy_native')
EOF

let g:airline_powerline_fonts = 1
let g:airline_theme = "minimalist"
let g:onedark_transparent_style = 'v:true'
let g:onedark_disable_terminal_colors = "v:true"
colorscheme onedark
highlight Normal guibg=none
highlight NonText guifg=none guibg=none
highlight EndOfBuffer ctermfg=black ctermbg=black
