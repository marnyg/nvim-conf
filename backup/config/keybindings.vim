"*****************************************************************************
"" Mappings
"*****************************************************************************
"Taskwarrior
"noremap <Leader>t :TW <CR>
let maplocalleader = ";"
"" Clean search (highlight)

nnoremap <silent> <leader><space> :noh<cr>

"" Open current line on GitHub
nnoremap <Leader>o :.Gbrowse<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>
"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>
""Repl python

nmap <localleader>t    <Plug>(iron-send-motion)
vmap <localleader>v    <Plug>(iron-visual-send)
nmap <localleader>r    <Plug>(iron-repeat-cmd)
nmap <localleader>l    <Plug>(iron-send-line)
nmap <localleader><CR> <Plug>(iron-cr)
nmap <localleader>i    <plug>(iron-interrupt)
nmap <localleader>q    <Plug>(iron-exit)
nmap <localleader>c    <Plug>(iron-clear)


noremap <C-P> @:<CR>


"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>

noremap <leader>w :w<CR>
noremap <leader>q :q<CR>
"" bind F1 and F2 to open vimrc
noremap  <F1> :e $MYVIMRC<CR>
noremap <leader><F1> :source $MYVIMRC<CR>

"" Makes netrw use ranger controls(j,l)
function! NetrwBuf()
  nmap <buffer> h -
  nmap <buffer> l <CR>
endfunction
augroup FILETYPES
  autocmd FileType netrw call NetrwBuf()
augroup END

"" Split
"" use  <C-w>s
"" use  <C-w>v
""

noremap ` :e. <CR>

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>x :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

nnoremap <silent> <C-Left> :vertical resize +5 <CR>
nnoremap <silent> <C-right> :vertical resize -5 <CR>
nnoremap <silent> <C-Down> :resize -5 <CR>
nnoremap <silent> <C-Up> :resize +5 <CR>
nnoremap <space> <c-w>w

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

map <Leader>tt :vnew term://zsh<CR>
