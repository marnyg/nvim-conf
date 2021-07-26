"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = ""
let g:vim_bootstrap_editor = "nvim"				" nvim or vim

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/CSApprox'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'xarthurx/taskwarrior.vim'

Plug 'rbgrouleff/bclose.vim' 
Plug 'ptzz/lf.vim'
Plug 'jceb/vim-orgmode'

Plug 'sillybun/vim-repl'
Plug 'hkupty/iron.nvim'
"" Color
""Plug 'tomasr/molokai'

if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'do': './install --xdg' }
  Plug 'junegunn/fzf.vim'
endif
" Vim-Session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

"" Snippets
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

Plug 'neovim/nvim-lsp'
Plug 'scalameta/nvim-metals'
" Complementary plugins that I recommend and will go over down below
Plug 'haorenW1025/completion-nvim'
Plug 'haorenW1025/diagnostic-nvim'
call plug#end()



let g:metals_server_version = '0.9.0+236-8d0924af-SNAPSHOT'

"" fzf.vim
""set wildmode=list:longest,list:full
""set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,1TB**
""let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -o -path '__pycache__/**' -prune -o -path 'MEGA*/**' -prune -o -path '1TB/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
""
""lsp setup
"lua << EOF
"  local nvim_lsp = require'nvim_lsp'
"  local M = {}
"  M.on_attach = function()
"      require'diagnostic'.on_attach() -- needed for the diagnostic plugin
"      require'completion'.on_attach() -- needed for the completion plugin
"    end
"  nvim_lsp.pyls.setup{
"    on_attach = M.on_attach
"  }
"EOF
""lua << EOF
""
""
""
""
""
""
""EOF

""lua require'nvim_lsp'.pyls.setup{}
""lua require'nvim_lsp'.bashls.setup{}


""lsp bindings
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-d> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gf    <cmd>lua vim.lsp.buf.formatting()<CR>
""nnoremap <silent> <c-f> <cmd>luafile ~/.config/nvim/config/luascripts/formatRegion.lua<CR>
nnoremap <silent> <c-f> <cmd>lua vim.lsp.buf.range_formatting({})<CR>

""completions
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <silent> ]p    :NextDiagnostic<CR>
nnoremap <silent> [p    :PrevDiagnostic<CR>
set completeopt=menuone,noinsert,noselect
set shortmess+=c

""diagnostic
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_trimmed_virtual_text = '20'


" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

au BufReadPost,BufNewFile *.py set foldmethod=indent

set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()


