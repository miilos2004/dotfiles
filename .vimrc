" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"if has("vms")
"  set nobackup        " do not keep a backup file, use versions instead
"else
  set backup        " keep a backup file
"endif

set ruler        " show the cursor position all the time
set showcmd        " display incomplete commands
set incsearch        " do incremental searching
set number        " line number on
:set guioptions-=T  "remove toolbar
:se autochdir
set showmode
set nowrap
set softtabstop=4
set tabstop=4     "each tab ha 4_spaces equivalent width
set shiftwidth=4  " Indentation width when using >> and << re-indentation
set expandtab     "tab are expanded to spaces
set smarttab
set wildchar=<Tab>
set wildmenu
set wildmode=list,full      "when browsing, first show all files, and then go through the matches

set history=500        " keep 50 lines of command line history
set undolevels=100
set mouse=a
set showmatch           " show parentasis match

"make search partially case sensitivity
set smartcase


"set spell spelllang=en_us
set lines=999 columns=999  " to maximize the window size
runtime macros/matchit.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In an xterm the mouse should work quite well, thus enable it.
" set mouse=a

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

set hlsearch
set gfn=Courier\ 12


  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on


" Switch on syntax highlighting.
syntax on
" syntax off
syntax enable
colorscheme desert

  " Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
au!

  " For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

augroup END


au BufNewFile,BufRead,BufEnter  *.v,*.sv,*.svh  setf verilog_systemverilog
set autoindent        " always set autoindenting on

"colors slat
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" execute pathogen#infect()
"
"macros
map @i o`uvm_info("", $sformatf(""), UVM_MEDIUM)
map @e o`uvm_error("", $sformatf(""))
map @f o`uvm_fatal("", $sformatf(""))
" convert TAB to SPACE
map #2 :1,$s/\t/    /g
"show edits
map #3 :w !diff % -
map #4 :cal SetSyn("verilog")
"Toggle spelling on/off with F7
set spelllang=en_us    " set spell language to English
map <F7> :call ToggleSpell()<CR>
function! ToggleSpell()
  echo &spell
  if &spell == 1
    echo "spell check is turned off "
    set mousemodel=extend
    set nospell
  else
    echo "spell check is turned ON "
    set mousemodel=popup
    set spell
  endif
endfunction


"files skeleton
au BufNewFile *.xml 0r ~/.vim/skeleton/xml.skel | let IndentStyle = "xml"
au BufNewFile *.sv 0r ~/.vim/skeleton/sv.skel | let IndentStyle = "sv"
au BufNewFile *.pl 0r ~/.vim/skeleton/perl.skel | let IndentStyle = "perl"
"au BufNewFile *.er 0r ~/.vim/skeleton/temp.skel | let IndentStyle

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
