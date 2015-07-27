set background=dark
set pastetoggle=<F2>
set nocompatible
set backspace=indent,eol,start
set lbr nu et ts=4 sw=4 ai si sc bs=2 wb nobk vb so=1 ru ls=2 ww=b,s,h,l,<,>,[,]
set com=sr:/*,mb:*,el:*/,://,b:#,:XCOMM,n:>,fb:-,n:\:
set nojs vi=""
set mps+=<:>
set clipboard=autoselect,exclude:.*
set nowrap
set softtabstop=4
set undolevels=1000
set undoreload=10000
color delek

filetype off
syntax on
filetype plugin indent on

syn sync maxlines=200
syn sync minlines=50
let g:tex_fast="Mm"

let g:rainbow_active = 1

let mapleader = ","
let g:EasyMotion_leader_key = "<leader><leader>"
nnoremap <leader>s :mks!<CR>
nnoremap <leader>l :source Session.vim <CR>
nnoremap <leader>n :noh<CR>
nmap <space> <leader><leader>
hi EasyMotionTarget ctermbg=none ctermfg=green
hi EasyMotionShade  ctermbg=none ctermfg=blue

noremap <Up> <NOP>
noremap <Right> <NOP>
noremap <Left> <NOP>
noremap <Down> <NOP>
nnoremap gr gT

set timeoutlen=200

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=100

  " Sets tabwidth for python to be 2
  autocmd FileType py setlocal shiftwidth=2 tabstop=2

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent                " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif


"Vim UI
set tabpagemax=15
set showmode
set cursorline
hi cursorline guibg=#333333
hi CursorColumn guibg=#333333
set linespace=0
set nu
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase
set foldenable
set foldmethod=marker
set commentstring=/*%s*/
set foldnestmax=10
ia sopl System.out.println("
ia sopf System.out.printf("
ia sop System.out.print("
ia imv #include <stdio.h><CR><CR>int main(void)<CR>{<CR><CR>return 0;<CR>}<UP><UP><UP><TAB>o
ia pf printf("<LEFT>
ia teh the
ia hte the
ia oyu you
noremap \c :call Cjam()<CR>
function! Cjam() 
    normal im€kbimport java.util.*;Publi€kb€kb€kb€kb€kbpublic class {}kkkkkkopsvm €kb	kkoScanner s;Istatic joScanner s = new S€kb€kb€kb€kb€kb€kb€kb€kb€kb€kb€kb€kb€kb€kb€kb€kb€kbs = new Scanner(System.in);s.€kb€kbint cases = new Scanner€kb€kb€kb€kb€kb€kb€kb€kb€kb€kb€kbs.nextInt();for(int i = 0; i < cases; i++) {solv€kb€kb€kb€kbString result €kb €kb = solve();sop €kb€kbf(ACases €kb€kb #%d: %s\n", i+1, result);ko}k:12,15d
endfunction
noremap \p :set ft=php<CR>
noremap \o :set ft=html<CR>
inoremap <c-w> <esc><c-w>
inoremap jk <esc>
syn on

set viminfo='10,\"100,:20,%,n~/.viminfo
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" F9/F10 compile/run default file.
" F11/F12 compile/run alternate file.

map <leader>f :w <bar> set makeprg=javac\ %<CR>:make<CR>:cw<CR>
map <leader>g :!echo %\|awk -F. '{print $1}'\|xargs java<CR>
noremap [[ :cp<CR>
noremap ]] :cn<CR>
" map <F11> :set makeprg=javac\ #<CR>:make<CR>
" map <F12> :!echo #\|awk -F. '{print $1}'\|xargs java<CR>

map! <leader>f <Esc>:w <bar> set makeprg=javac\ %<CR>:make<CR>:cw<CR>
map! <leader>g <Esc>:!echo %\|awk -F. '{print $1}'\|xargs java<CR>
" map! <F11> <Esc>set makeprg=javac\ #<CR>:make<CR>
" map! <F12> <Esc>!echo #\|awk -F. '{print $1}'\|xargs java<CR>

" Tip: load a file into the default buffer, and its driver
" into the alternate buffer, then use F9/F12 to build/run.
" Note: # (alternate filename) isn't set until you :next to it!
" Tip2: You can make then run without hitting ENTER to continue. F9-F12

" With these you can cl/cn/cp (quickfix commands) to browse the errors
" after you compile it with :make

set makeprg=javac\ %
set errorformat=%A:%f:%l:\ %m,%-Z%p^,%-C%.%#

" If two files are loaded, switch to the alternate file, then back.
" That sets # (the alternate file).
if argc() == 2
  n
  e #
endif
