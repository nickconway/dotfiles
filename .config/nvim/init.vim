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
set scrolloff=8
set signcolumn=yes



let mapleader=" "

nnoremap <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>sq :wq<CR>

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
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <c-j> <esc>:m .+1<CR>==i
inoremap <c-k> <esc>:m .-2<CR>==i
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==



call plug#begin('~/.vim/plugged')

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'joshdick/onedark.vim'

call plug#end()



colorscheme onedark
highlight Normal guibg=none


nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")})<CR>
nnoremap <c-p> :lua require('telescope.builtin').find_files{}<CR>


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
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd InsertLeave * set iminsert=0
augroup END
