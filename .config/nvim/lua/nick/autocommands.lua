vim.cmd([[
    fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun
]])

vim.cmd([[
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
]])
