set nocompatible              " be iMproved, required

"Syntax Highlighting
filetype on
filetype plugin indent on
syntax enable

" Set color
color default

"Autoindent
set autoindent

" Spaces not tabs
set expandtab
set smarttab

" 4 character tab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set ai "Auto Indent
set si "Smart Indent
set wrap "Wrap line

" Enable mouse support
set mouse=a

" Line Numbers
set number

" Highlight from search
set hlsearch

" remove buffer upon tab close
set nohidden

" set history
set history=200

" Make :w sudo save the file
nmap <leader>w :w!<cr>
command W w !sudo tee % > /dev/null

" configure backspace
set backspace=eol,start,indent

" show mathcing bracketes
set showmatch
set mat=2

" Adding a marker at the 80 column mark 
"highlight OverLength ctermbg = grey
"match OverLength /\%>79v.\+/

" Highlight trailing whitespace
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red

" set up ctrl-c and ctrl-v
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" filetypes
autocmd BufRead,BufNewFile  *.ml* set ts=2 sw=2 sts=2 expandtab cc=80
autocmd BufRead,BufNewFile  *.oscar set expandtab smarttab ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.tex set ts=2 sw=2 sts=2 expandtab cc=200
au BufWriteCmd *.tex write | ! pdflatex -file-line-error -halt-on-error %
