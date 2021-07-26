
" Required:
filetype plugin indent on


"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8


"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" session management
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number
set relativenumber
set pumblend=40

let no_buffers_menu=1
""silent! colorscheme molokai

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1

  " IndentLine
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1
endif



"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

inoremap <C-L> <C-G>u<Esc>[s1z=`]a<C-G>u 
nnoremap zz [s1z=
set breakindent
set linebreak
"autocmd BufEnter *.md :set spell spelllang=nb
"autocmd BufEnter eksamenV2016.md :setlocal spellfile+=oneoff.utf-8.add


let g:task_rc_override = 'rc.defaultwidth=0'


if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

set autoread

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1


"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

"" netrw
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
set splitbelow
set splitright


""orgmode
let g:org_agenda_files=['~/notes/org/index.org','~/notes/org/projects.org','~/notes/org/somdayMaby.org','~/notes/org/tickler.ort','~/notes/org/shopping.org']


