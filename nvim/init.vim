"*****************************************************************************
"" SETUP DEIN
"*****************************************************************************"

if &compatible
  set nocompatible
endif

let pluginDir=expand("$HOME/.config/nvim/dein")
let installDir=pluginDir . "/repos/github.com/Shougo/dein.vim"
echo installDir
" Auto install Dein
if (!isdirectory(installDir))
  echo "Installing Dein..."
  echo ""
  call system(expand("mkdir -p " . pluginDir . "/repos/github.com/Shuogo/"))
  call system(expand("git clone git@github.com:Shougo/dein.vim.git " . installDir))
  let gotDein=1
endif

" Required:
execute 'set runtimepath+=' . installDir
set runtimepath?

if dein#load_state(pluginDir)
    call dein#begin(pluginDir)
    " Let dein manage dein
    " Required:
    call dein#add(installDir)

    " dein commands in vim
    call dein#add('haya14busa/dein-command.vim')

    " airline for a better status bar
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    " deoplete for autocompletion
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/deol.nvim')
    call dein#add('deoplete-plugins/deoplete-go', {'build': 'make', 'on_ft': 'go'})
    call dein#add('landaire/deoplete-swift', {'on_ft': 'swift'})
    call dein#add('keith/swift.vim', {'on_ft': 'swift'})
    call dein#add('zchee/deoplete-jedi', {'on_ft': 'python'})
    call dein#add('Shougo/echodoc.vim')

    " ale for linting
    call dein#add('dense-analysis/ale')

    " snippets support
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')

    " Better go development
    call dein#add('fatih/vim-go', {'on_ft': 'go'})

    " Python development
    call dein#add('psf/black', {'on_ft': 'python', 'rev': '19.10b0'})
    call dein#add('davidhalter/jedi-vim', {'on_ft': 'python'})

    " I want to close buffers
    call dein#add('mhinz/vim-sayonara')

    " Nerdtree, duh
    call dein#add('scrooloose/nerdtree')

    " fuzzy finding
    call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

    " fugitive for git plugins
    call dein#add('tpope/vim-fugitive')

    " comment ez
    call dein#add('scrooloose/nerdcommenter')

    " colorz
    call dein#add('jibben/onehalf')

    " these need to be added last
    call dein#add('ryanoasis/vim-devicons')

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" Check if all of the plugins are already installed, in other case it will
" install them (useful to add plugins in the .vimrc)
if dein#check_install()
  call dein#install()
endif


"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"
" Set color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme onehalfdark
" colorscheme onehalfjib

"Autoindent
set autoindent

"" Encoding
set encoding=UTF-8
set fileencoding=UTF-8
set fileencodings=UTF-8
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

set ai "Auto Indent
set si "Smart Indent
set wrap "Wrap line

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Make :w sudo save the file
nmap <leader>w :w!<cr>
command W w !sudo tee % > /dev/null

" show matching bracketes
" set showmatch
" set mat=2

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" More natural split opening
set splitbelow
set splitright

" Toggle paste mode
set pastetoggle=<leader>p

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number

if $COLORTERM == 'gnome-terminal'
set term=gnome-256color
elseif $TERM == 'xterm'
  set term=xterm-256color
endif

if &term =~ '256color'
  set t_ut=
endif

" Use classic vim cursor
set guicursor=

" Make scrolling buffer around cursor
set scrolloff=3

" Status bar
set laststatus=2

" Always show tab bar
set showtabline=2

" Use modeline overrides
set modeline
set modelines=10

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Highlight trailing whitespace
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

"*****************************************************************************
"" Custom commands
"*****************************************************************************

" Easier pane movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Move between open buffers.
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

"*****************************************************************************
"" Plugin specific
"*****************************************************************************

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 5
let g:deoplete#max_list = 10
" tab for deoplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" auto close scratch on insert exit
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" NERDtree
autocmd vimenter * NERDTree
autocmd vimenter * wincmd p
nmap <Leader>n :NERDTreeFind<CR>
nmap <Leader>m :NERDTreeToggle<CR>
let g:NERDTreeWinSize=30

" Airline
let g:airline_theme = 'bubblegum'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

" Ale
let g:ale_linters = {
            \ 'python': ['flake8'],
            \ 'go': ['gopls', 'golint', 'govet'],
            \}

" Fuzzy search
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>

" Ripgrep (trailing space here intentionally)
nmap <Leader>rg :Rg 
nnoremap <Leader>rr :Rg <C-R><C-W><CR>

" Space after comment char for NERDcomment
let NERDSpaceDelims=1
map <leader>/ <plug>NERDCommenterToggle

" Easy kill buffers
nmap <leader>ss :Sayonara!<CR>

"*****************************************************************************
"" Templates development
"*****************************************************************************

autocmd BufRead,BufNewFile *.template set noexpandtab

"*****************************************************************************
"" Go development
"*****************************************************************************

" go
" vim-go
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 0

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_extra_types = 1

let g:go_decls_mode = 'fzf'

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

augroup go

  au!
  au FileType go nmap <Leader>gf :GoFmt
  au FileType go nmap <Leader>go :GoDoc
  au FileType go nmap <Leader>gd :GoDef
  au FileType go nmap <Leader>gb :GoBuild
  au FileType go nmap <Leader>gt :GoTest
  au FileType go nmap <Leader>gr :GoRun
  au FileType go nmap <Leader>gi :GoInfo
  au FileType go nmap <Leader>gl :GoDecls<cr>
  au FileType go nmap <Leader>g; :GoDeclsDir<cr>

augroup END

"*****************************************************************************
"" Python development
"*****************************************************************************

" Black configuration for formatting.
let g:black_linelength = 120
let g:black_skip_string_normalization = 1

" jedi-vim for python navigation.

" Use deoplete for autocompletion, so we don't need jedi completion.
let g:jedi#completions_enabled = 0
" Don't screw with my other configs.
let g:jedi#auto_vim_configuration = 0
let g:jedi#auto_initialization = 0

autocmd BufNewFile,BufRead *.py setlocal ft=python

augroup python

    au!
    au Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
    au Filetype python set pastetoggle=<leader>pp
    au Filetype python nnoremap <silent> <buffer> gd :call jedi#goto()<cr>
    au Filetype python nnoremap <silent> <buffer> <leader>pa :call jedi#goto_assignments()<cr>
    au Filetype python nnoremap <silent> <buffer> <leader>pd :call jedi#show_documentation()<cr>
    au Filetype python nnoremap <silent> <buffer> <leader>pu :call jedi#usages()<cr>
    au Filetype python nnoremap <silent> <buffer> <leader>pr :call jedi#rename()<cr>
    au Filetype python nnoremap <silent> <buffer> <leader>pb :Black

augroup END

"*****************************************************************************
"" Web development
"*****************************************************************************

autocmd BufNewFile,BufRead *.html ft=html

augroup html

    au!
    au Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 textwidth=240

augroup END

"*****************************************************************************
"" COLORS
"*****************************************************************************
hi SpellBad term=reverse ctermbg=131 gui=undercurl guisp=Maroon
