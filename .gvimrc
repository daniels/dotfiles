" -----------------------------------------------------------
"  GRAPHICAL
" -----------------------------------------------------------
"
winpos 0 0
"colorscheme default

if has("gui_macvim")
  set gfn=Menlo:h11
  set shell=/bin/bash
elseif has("gui_win32")
  set gfn=Consolas:h10
elseif has("gui_gtk")
  set gfn=Monospace\ 10
  set shell=/bin/bash
endif

set antialias
set guioptions=gemc
set columns=90
set lines=57
if &diff
  " double the width up to a reasonable maximum
  let &columns = ((&columns*2 > 172)? 172: &columns*2)
endif
"set cmdheight=2
set cursorline

" puts external commands through a pipe instead of a pseudo-tty:
" set noguipty

" put the * register on the system clipboard
set clipboard+=unnamed

" -----------------------------------------------------------
"  TABS
" -----------------------------------------------------------
"
set guitablabel=%N\ %t\ %m

" C-TAB and C-SHIFT-TAB cycle tabs forward and backward
nmap <c-tab> :tabnext<cr>
imap <c-tab> <c-o>:tabnext<cr>
vmap <c-tab> <c-o>:tabnext<cr>
nmap <c-s-tab> :tabprevious<cr>
imap <c-s-tab> <c-o>:tabprevious<cr>
vmap <c-s-tab> <c-o>:tabprevious<cr>

" C-# switches to tab
nmap <d-1> 1gt
nmap <d-2> 2gt
nmap <d-3> 3gt
nmap <d-4> 4gt
nmap <d-5> 5gt
nmap <d-6> 6gt
nmap <d-7> 7gt
nmap <d-8> 8gt
nmap <d-9> 9gt

" -----------------------------------------------------------
"  Highlight Trailing Whitespace
" -----------------------------------------------------------
"
highlight SpecialKey    guifg=#222222 guibg=#ffff99
highlight StatusLineNC  guifg=#AAAAAA guibg=#222222 gui=none
highlight StatusLine    guifg=#FFFFFF guibg=#336699 gui=none
highlight LineNr        guifg=#999999 guibg=#eeeeee gui=none
