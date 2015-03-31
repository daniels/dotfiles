" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------

call plug#begin('~/.vim/bundle')
let g:plug_timeout = 300

" Solarized for Vim
Plug 'altercation/vim-colors-solarized'

" --- Syntax and more ---
Plug 'vim-scripts/applescript.vim'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-ruby/vim-ruby'

" Powerful syntax checking
Plug 'scrooloose/syntastic'

" -- Editing aids ---

" Autocompletion by tab
Plug 'ervandew/supertab'

" Align code on characters or regexps
Plug 'godlygeek/tabular'

" Easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Comment and uncomment lines
Plug 'tpope/vim-commentary'

" Use <C-_> to close tags
Plug 'vim-scripts/closetag.vim'

" Autoclose parens and more ...
Plug 'cohama/lexima.vim'
"Plug 'tpope/vim-endwise'
"Plug 'jiangmiao/auto-pairs'

" --- Search ---

" Search for files
Plug 'kien/ctrlp.vim'

" Search in files
Plug 'mileszs/ack.vim'
Plug 'rking/ag.vim'

" Plug 'pangloss/vim-simplefold'
" Plug 'scrooloose/snipmate-snippets'

" --- Utilities ---

" Run commands in the background
Plug 'tpope/vim-dispatch'

" Utility that help other plugins support repeat
Plug 'tpope/vim-repeat'

" --- Integrations, wrappers and more ---

" Integrate with ruby bundler
Plug 'tpope/vim-bundler'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Ruby project utilities
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rake'

" Helpers for UNIX
Plug 'tpope/vim-eunuch'

" Evaluate ruby and display results inline
"
" gem install seeing_is_believing
"
if executable('seeing_is_believing')
  Plug 't9md/vim-ruby-xmpfilter'
  let g:xmpfilter_cmd = "seeing_is_believing"

  autocmd FileType ruby nmap <buffer> <D-i> <Plug>(seeing_is_believing-mark)
  autocmd FileType ruby xmap <buffer> <D-i> <Plug>(seeing_is_believing-mark)
  autocmd FileType ruby imap <buffer> <D-i> <Plug>(seeing_is_believing-mark)

  autocmd FileType ruby nmap <buffer> <D-c> <Plug>(seeing_is_believing-clean)
  autocmd FileType ruby xmap <buffer> <D-c> <Plug>(seeing_is_believing-clean)
  autocmd FileType ruby imap <buffer> <D-c> <Plug>(seeing_is_believing-clean)

  " xmpfilter compatible
  autocmd FileType ruby nmap <buffer> <D-r> <Plug>(seeing_is_believing-run_-x)
  autocmd FileType ruby xmap <buffer> <D-r> <Plug>(seeing_is_believing-run_-x)
  autocmd FileType ruby imap <buffer> <D-r> <Plug>(seeing_is_believing-run_-x)

  " auto insert mark at appropriate spot.
  autocmd FileType ruby nmap <buffer> <F5> <Plug>(seeing_is_believing-run)
  autocmd FileType ruby xmap <buffer> <F5> <Plug>(seeing_is_believing-run)
  autocmd FileType ruby imap <buffer> <F5> <Plug>(seeing_is_believing-run)
endif

" --- Unused plugins
" Plug 'vim-scripts/scratch.vim'

call plug#end()

" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------

set nocompatible                      " essential
set history=1000                      " lots of command line history
set cf                                " error files / jumping
set ffs=unix,dos,mac                  " support these files
" Enable the matchit-plugin that comes bundled with vim
runtime macros/matchit.vim

filetype plugin indent on             " load filetype plugin

" Setting needed to be able to type swedish letter "å" with Auto Pairs ...
if !exists('g:AutoPairsShortcutFastWrap')
  let g:AutoPairsShortcutFastWrap = ''
end

set isk+=_,$,@,%,#,-                  " none word dividers
set viminfo='1000,f1,:100,@100,/20
set modeline                          " make sure modeline support is enabled
set autoread                          " reload files (no local changes only)
set tabpagemax=50                     " open 50 tabs max
set hidden                            " Don't unload files when abandoned

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

" ---------------------------------------------------------------------------
" Colors / Theme
" ---------------------------------------------------------------------------

try
  " Default to use solarized
  set background=light
  set t_Co=256
  colorscheme solarized
  syntax on
  set hlsearch
catch /^Vim\%((\a\+)\)\=:E185/
  " Fall back if theme not installed (and term possibly not color)
  if &t_Co > 2 || has("gui_running")
    if has("terminfo")
      set t_Co=16
      set t_AB=[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
      set t_AF=[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
    else
      set t_Co=16
      set t_Sf=[3%dm
      set t_Sb=[4%dm
    endif
    syntax on
    set hlsearch
  endif
endtry


" ---------------------------------------------------------------------------
"  Highlight
" ---------------------------------------------------------------------------

"highlight Comment         ctermfg=DarkGrey guifg=#444444
"highlight StatusLineNC    ctermfg=Black ctermbg=White cterm=bold
highlight StatusLine      ctermfg=White ctermbg=DarkBlue cterm=bold

" ----------------------------------------------------------------------------
"   Highlight Trailing Whitespace
" ----------------------------------------------------------------------------

set list listchars=trail:.,tab:>.,extends:>,precedes:<
"highlight SpecialKey ctermfg=DarkGray ctermbg=Yellow

" Highlight long lines

augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=LightGrey guibg=#eee8d5
  autocmd BufEnter * match OverLength /\%>80v./
augroup END

" ----------------------------------------------------------------------------
"  Backups
" ----------------------------------------------------------------------------

"set nobackup                           " do not keep backups after close
"set nowritebackup                      " do not keep a backup while working
"set noswapfile                         " don't keep swp files either
set backupdir+=$HOME/.vim/backup        " store backups under ~/.vim/backup
set backupcopy=yes                     " keep attributes of original file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=~/.vim/swap,~/tmp,.      " keep swp files under ~/.vim/swap

" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set ruler                  " show the cursor position all the time
"set noshowcmd              " don't display incomplete commands
set nolazyredraw           " turn off lazy redraw
set number                 " line numbers
set wildmenu               " turn on wild menu
set wildmode=list:longest,full
set ch=2                   " command line height
set backspace=2            " allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l,[,] " backspace and cursor keys wrap to
"set shortmess=filtIoOA     " shorten messages
set report=0               " tell us about changes
set nostartofline          " don't jump to the start of line when scrolling

" ----------------------------------------------------------------------------
" Visual Cues
" ----------------------------------------------------------------------------

set showmatch              " brackets/braces that is
set mat=2                  " duration to show matching brace (1/10 sec)
set incsearch              " do incremental searching
set laststatus=2           " always show the status line
set ignorecase             " ignore case when searching
set hlsearch               " highlight searches
set visualbell             " shut up

" Format of status line:
" %-0{minwid}.{maxwid}{item}
if has("statusline")
  set statusline=%n               " Buffer number
  set statusline+=\ 
  set statusline+=%-F             " Path to file
  set statusline+=\ 
  set statusline+=%(%m\ %)        " Modified?
  set statusline+=%(%y\ %)        " File type"
  set statusline+=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\"}
                                  " Current encoding
  set statusline+=%([%{&ff}]%)    " New line style (dos/unix)
  "set statusline+=%q              " Quickfix List? -- Doesn't work on Vim < 7.2
  set statusline+=%h              " Help?
  set statusline+=%w              " Preview?
  set statusline+=%r              " Readonly?
  set statusline+=%=              " --------- (split)
  set statusline+=%-14.(%l,%c%V%) " Line,Column
  set statusline+=%P              " Percent of file
endif

" ----------------------------------------------------------------------------
" Text Formatting
" ----------------------------------------------------------------------------

set autoindent             " automatic indent new lines
set smartindent            " be smart about it
set nowrap                 " do not wrap lines
set softtabstop=2          " yep, two
set shiftwidth=2           " ..
set tabstop=4
set expandtab              " expand tabs to spaces
set nosmarttab             " fuck tabs
set formatoptions+=n       " support for numbered/bullet lists
set textwidth=80           " wrap at 80 chars by default
set virtualedit=block      " allow virtual edit in visual block ..


" ---------------
" Pandoc Markdown
" ---------------

let g:pandoc#syntax#conceal#blacklist=[
    \ 'titleblock',
    \ 'image',
    \ 'subscript',
    \ 'superscript',
    \ 'strikeout',
    \ 'atx',
    \ 'codeblock_start',
    \ 'codeblock_delim',
    \ 'definition',
    \ 'list'
    \  ]

" ----------------------------------------------------------------------------
"  Mappings
" ----------------------------------------------------------------------------

" remap <LEADER> to ',' (instead of '\')
let mapleader = ","

" Leave insert mode with jj
inoremap jj <Esc>

" Faster split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" quickfix mappings
"map <F7>  :cn<CR>
"map <S-F7> :cp<CR>
"map <A-F7> :copen<CR>

" emacs movement keybindings in insert mode
imap <C-a> <C-o>0
imap <C-e> <C-o>$
"map <C-e> $
"map <C-a> 0

" reflow paragraph with Q in normal and visual mode
nnoremap Q gqap
vnoremap Q gq

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" do not menu with left / right in command line
cnoremap <Left> <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>

" ,l to turn off search highlighting until next search
nnoremap <silent> <leader>l :<C-u>nohlsearch<CR><C-l>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" Delete buffer without closing window/pane
nnoremap <leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <leader>bd! :bp<bar>sp<bar>bn<bar>bd!<CR>

" Autoformat entire file (and return cursor to position)
map ,= gg=G''


" ----------------------------------------------------------------------------
"  Auto Commands
" ----------------------------------------------------------------------------

" jump to last position of buffer when opening
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                         \ exe "normal g'\"" | endif

" don't use cindent for javascript
autocmd FileType javascript setlocal nocindent

" ----------------------------------------------------------------------------
"  NetRW - read write network (AND local!) files
" ----------------------------------------------------------------------------

" List files as tree
let g:netrw_liststyle=3

" ----------------------------------------------------------------------------
"  LookupFile
" ----------------------------------------------------------------------------

"let g:LookupFile_TagExpr = '".ftags"'
"let g:LookupFile_MinPatLength = 2
"let g:LookupFile_ShowFiller = 0                  " fix menu flashiness
"let g:LookupFile_PreservePatternHistory = 1      " preserve sorted history?
"let g:LookupFile_PreserveLastPattern = 0         " start with last pattern?
"
"nmap <unique> <silent> <D-f> <Plug>LookupFile
"imap <unique> <silent> <D-f> <C-O><Plug>LookupFile

" ----------------------------------------------------------------------------
"  On MacOS X
" ----------------------------------------------------------------------------

if system('uname') =~ 'Darwin'
"  let $PATH = $HOME .
"    \ '/usr/local/bin:/usr/local/sbin:' .
"    \ '/usr/pkg/bin:' .
"    \ '/opt/local/bin:/opt/local/sbin:' .
"    \ $PATH

  " Use Marked to preview markdown files
  nnoremap <leader>m :silent !open -a "Marked 2" '%:p'<cr>
endif

" ---------------------------------------------------------------------------
"  sh config
" ---------------------------------------------------------------------------

au Filetype sh,bash set ts=4 sts=4 sw=4 expandtab
let g:is_bash = 1

" ---------------------------------------------------------------------------
"  Misc mappings
" ---------------------------------------------------------------------------

map <unique> <silent> <Leader>f <Plug>SimpleFold_Foldsearch
map <leader>d :e %:h/<CR>
map <leader>dt :tabnew %:h/<CR>

" I use these commands in my TODO file
"map ,a o<ESC>:r!date +'\%A, \%B \%d, \%Y'<CR>:r!date +'\%A, \%B \%d, \%Y' \| sed 's/./-/g'<CR>A<CR><ESC>
"map ,o o[ ] 
"map ,O O[ ] 
"map ,x :s/^\[ \]/[x]/<CR>
"map ,X :s/^\[x\]/[ ]/<CR>


" ---------------------------------------------------------------------------
" Custom functions
" ---------------------------------------------------------------------------

" Wrap a command with Preserve () and the cursor will be restored after
" execution.
" From
" http://technotales.wordpress.com/2010/03/31/preserve-a-vim-function-that-keeps-your-state/
" via
" http://vimcasts.org/episodes/tidying-whitespace/
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let save_cursor = getpos(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call setpos('.', save_cursor)
endfunction

" ---------------------------------------------------------------------------
"  Open URL on current line in browser
" ---------------------------------------------------------------------------

function! Browser ()
    let line0 = getline (".")
    let line = matchstr (line0, "http[^ )]*")
    let line = escape (line, "#?&;|%")
    exec ':silent !open ' . "\"" . line . "\""
endfunction
map <leader>w :call Browser ()<CR>

" Strip whitespace in entire file (confirm with `a` to strip all)
function! StripWhitespace ()
    call Preserve (':%s/\s\+$//ce')
endfunction
map <leader>s :call StripWhitespace ()<CR>

" ---------------------------------------------------------------------------
" File Types
" ---------------------------------------------------------------------------

au BufRead,BufNewFile *.rpdf       set ft=ruby
au BufRead,BufNewFile *.rxls       set ft=ruby
au BufRead,BufNewFile *.ru         set ft=ruby
au BufRead,BufNewFile *.god        set ft=ruby
au BufRead,BufNewFile *.rtxt       set ft=html spell
au BufRead,BufNewFile *.sql        set ft=pgsql
au BufRead,BufNewFile *.rl         set ft=ragel
au BufRead,BufNewFile *.svg        set ft=svg
au BufRead,BufNewFile *.haml       set ft=haml
au BufRead,BufNewFile *.md         set ft=pandoc tw=80 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.markdown   set ft=pandoc tw=80 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.ronn       set ft=pandoc tw=80 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.opml       set ft=xml


au Filetype gitcommit set tw=68  spell
au Filetype ruby      set tw=80  ts=2
au Filetype ruby      compiler ruby
"au Filetype html,xml,xsl,rhtml source $HOME/.vim/scripts/closetag.vim
au Filetype xml       set foldmethod=syntax
let g:xml_syntax_folding = 1

au Filetype javascript setlocal ts=4 sts=4 sw=4
au Filetype perl setlocal ts=4 sts=4 sw=4

au BufNewFile,BufRead *.mustache        setf mustache

" --------------------------------------------------------------------------
" ManPageView
" --------------------------------------------------------------------------

let g:manpageview_pgm= 'man -P "/usr/bin/less -is"'
let $MANPAGER = '/usr/bin/less -is'

" --------------------------------------------------------------------------
" rails.vim
" --------------------------------------------------------------------------

"let g:rails_subversion=1
"let g:rails_menu=2

" make file executable
command -nargs=* Xe !chmod +x <args>
command! -nargs=0 Xe !chmod +x %
