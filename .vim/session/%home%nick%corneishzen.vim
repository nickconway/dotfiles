let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
let UltiSnipsExpandTrigger = "<tab>"
let UltiSnipsListSnippets = "<c-tab>"
let UltiSnipsEditSplit = "normal"
let UltiSnipsEnableSnipMate =  1 
let UltiSnipsJumpBackwardTrigger = "<c-k>"
let UltiSnipsJumpForwardTrigger = "<c-j>"
let UltiSnipsRemoveSelectModeMappings =  1 
silent only
silent tabonly
cd ~/
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
set stal=2
tabnew
tabrewind
edit corneishzen/config/corne-ish_zen.keymap
argglobal
balt corneishzen/config/corne-ish_zen.keymap
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 23 - ((22 * winheight(0) + 40) / 80)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 23
normal! 02|
tabnext
edit corneishzen/config/corne-ish_zen_left.conf
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 40 + 41) / 83)
exe 'vert 1resize ' . ((&columns * 97 + 97) / 194)
exe '2resize ' . ((&lines * 40 + 41) / 83)
exe 'vert 2resize ' . ((&columns * 96 + 97) / 194)
exe '3resize ' . ((&lines * 39 + 41) / 83)
argglobal
balt corneishzen/config/corne-ish_zen_right.conf
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 6 - ((5 * winheight(0) + 20) / 40)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 6
normal! 038|
wincmd w
argglobal
if bufexists("corneishzen/config/corne-ish_zen_right.conf") | buffer corneishzen/config/corne-ish_zen_right.conf | else | edit corneishzen/config/corne-ish_zen_right.conf | endif
if &buftype ==# 'terminal'
  silent file corneishzen/config/corne-ish_zen_right.conf
endif
balt corneishzen/config/west.yml
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 6 - ((5 * winheight(0) + 20) / 40)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 6
normal! 0
wincmd w
argglobal
if bufexists("corneishzen/config/west.yml") | buffer corneishzen/config/west.yml | else | edit corneishzen/config/west.yml | endif
if &buftype ==# 'terminal'
  silent file corneishzen/config/west.yml
endif
balt corneishzen/config/corne-ish_zen.keymap
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 11 - ((10 * winheight(0) + 19) / 39)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 11
normal! 016|
wincmd w
exe '1resize ' . ((&lines * 40 + 41) / 83)
exe 'vert 1resize ' . ((&columns * 97 + 97) / 194)
exe '2resize ' . ((&lines * 40 + 41) / 83)
exe 'vert 2resize ' . ((&columns * 96 + 97) / 194)
exe '3resize ' . ((&lines * 39 + 41) / 83)
tabnext 1
set stal=1
badd +1 corneishzen/config/corne-ish_zen.keymap
badd +1 corneishzen/config/west.yml
badd +6 corneishzen/config/corne-ish_zen_right.conf
badd +6 corneishzen/config/corne-ish_zen_left.conf
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOF
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
nohlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
