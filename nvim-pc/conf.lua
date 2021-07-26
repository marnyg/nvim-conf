--- vim:sw=2 fdm=marker
--- Type za to toggle one fold or zi to toggle 'foldenable'. See :help fold-commands for more info.
local api, fn, cmd = vim.api, vim.fn, vim.cmd
--- {{{1 [[ OPTIONS ]]
--
--



print("dsa")

vim.o.termguicolors = true
vim.wo.number = true
vim.wo.signcolumn = 'number' -- Display signs in the number column
vim.wo.list = true
vim.wo.linebreak = true
vim.wo.breakindent = true
vim.o.showmode = false
vim.o.pumblend = 10
vim.g.vimsyn_embed = 'l' -- Highlight Lua code inside .vim files

vim.o.expandtab = true; vim.bo.expandtab = true
vim.o.shiftwidth = 2; vim.bo.shiftwidth = 2
vim.o.tabstop = 2; vim.bo.tabstop = 2

vim.o.inccommand = 'split'

-- I'm used to text editors opening side panels to the right of/below the current one
vim.o.splitright = true
vim.o.splitbelow = true

-- CursorHold autocmds are dependent on updatetime. The default is 4000, which is too long for many things
vim.o.updatetime = 300
vim.o.hidden = true
vim.o.undofile = true; vim.bo.undofile = true -- Persistent undo is a neat feature
vim.o.shortmess = vim.o.shortmess .. 'cI' -- No startup screen, no ins-completion-menu messages
vim.o.completeopt = 'menuone,noselect' -- Required for nvim-compe
--- {{{1 [[ MAPPINGS ]]
-- I really only set custom mappings for stuff that I use often.
-- I prefer offloading the creation of mappings to vim-unimpaired.
-- For stuff that I don't use all that often, I prefer creating custom commands,
-- which I think are more versatile and easier to remember.
local map = api.nvim_set_keymap

-- <Space> seems to be a popular leader key (it's better than the default \ IMO).
vim.g.mapleader = ' '

map('', 'Y', 'y$', {}) -- I like consistency.
map('', 'Q', '', {}) -- Begone, foul beast. I can invoke your wrath with gQ anyway.

-- I do not enjoy accidentally nuking an entire line and not being able to undo the action :)
-- Incidentally, Vim has the <C-u> mapping in defaults.vim
map('i', '<C-u>', '<C-g>u<C-u>', {noremap = true})
map('i', '<C-w>', '<C-g>u<C-w>', {noremap = true})

-- Stolen from https://github.com/neovim/neovim/issues/6289
map('n', '<C-l>', '<Cmd>nohlsearch<CR><C-l>', {noremap = true})

-- Not being able to navigate lines visually annoyed me when I was a beginner
map('', 'j', "(v:count? 'j' : 'gj')", {noremap = true, expr = true})
map('', 'k', "(v:count? 'k' : 'gk')", {noremap = true, expr = true})

-- Custom text object: "around document". Useful to format/indent an entire file with gqad or =ad
map('o', 'ad', '<Cmd>normal! ggVG<CR>', {noremap = true})
map('x', 'ad', 'gg0oG$', {noremap = true})

--- {{{1 [[ PLUGINS ]]
-- Bootstrap packer.nvim
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.isdirectory(install_path) == 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  cmd 'packadd packer.nvim'
end

local packer = require('packer')
packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  -- This one is cheating: it bundles vim-sensible + vim-sleuth + a truckload of syntax files.
  use 'sheerun/vim-polyglot'
  -- My colorscheme of choice is usually Dracula, but it's probably not everyone's cup of tea.
  -- I think this one has broader appeal and as a bonus, it has highlights for LSP, treesitter and telescope
  use {'sainnhe/sonokai', config = 'vim.cmd "colorscheme sonokai"'}
  use 'editorconfig/editorconfig-vim'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  -- Lazy load vim-unimpaired because it slows down startuptime a bit
  use {'tpope/vim-unimpaired', keys = {'[', ']', '<', '>', '=', 'y'}}
  use 'tpope/vim-repeat'
  use 'Raimondi/delimitMate'
  use {'itchyny/lightline.vim',
    setup = function()
      vim.g.lightline = {
        colorscheme = 'sonokai',
        active = {
          left = {{'mode', 'paste'},
                  {'gitbranch', 'readonly', 'filename', 'modified'}},
        },
        component_function = {
          gitbranch = 'FugitiveHead',
        },
      }
    end,
  }
  use {'norcalli/nvim-colorizer.lua', config = [[require('colorizer').setup{'html', 'css', 'scss'}]]}
  use {'neovim/nvim-lspconfig', requires = {'kosayoda/nvim-lightbulb'}, config = '_G.lspconfig_init()'}
  use {'hrsh7th/nvim-compe', requires = {'hrsh7th/vim-vsnip'}, config = '_G.compe_init()'}
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function()
      local map = vim.api.nvim_set_keymap
      map('n', '<Leader>fb', '<Cmd>Telescope buffers<CR>', {noremap = true})
      map('n', '<Leader>ff', '<Cmd>Telescope find_files<CR>', {noremap = true})
    end,
  }
end)
--- {{{1 [[ LSPCONFIG ]]
local function custom_lsp_attach(client, bufnr)
  local cap = client.resolved_capabilities

  --- Mappings
  local function bmap(mode, lhs, rhs)
    api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, {noremap = true})
  end

  bmap('n', ']E', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  bmap('n', '[E', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
  bmap('n', 'gl', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
  if cap.goto_definition then
    bmap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>')
  end
  if cap.hover then
    bmap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  end
  if cap.code_action then
    bmap('n', 'gA', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
    bmap('x', 'gA', '<Cmd>lua vim.lsp.buf.range_code_action()<CR>')
  end

  --- Commands
  if cap.rename then
    cmd 'command! -buffer -nargs=? LspRename lua vim.lsp.buf.rename(<f-args>)'
  end
  if cap.find_references then
    cmd 'command! -buffer LspReferences lua vim.lsp.buf.references()'
  end
  if cap.workspace_symbol then
    cmd 'command! -buffer -nargs=? LspWorkspaceSymbol lua vim.lsp.buf.workspace_symbol(<f-args>)'
  end
  if cap.call_hierarchy then
    cmd 'command! -buffer LspIncomingCalls lua vim.lsp.buf.incoming_calls()'
    cmd 'command! -buffer LspOutgoingCalls lua vim.lsp.buf.outgoing_calls()'
  end
  if cap.workspace_folder_properties.supported then
    cmd 'command! -buffer LspListWorkspaceFolders lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))'
    cmd 'command! -buffer -nargs=? -complete=dir LspAddWorkspaceFolder lua vim.lsp.buf.add_workspace_folder(<f-args>)'
    cmd 'command! -buffer -nargs=? -complete=dir LspRemoveWorkspaceFolder lua vim.lsp.buf.remove_workspace_folder(<f-args>)'
  end
  if cap.document_symbol then
    cmd 'command! -buffer LspDocumentSymbol lua vim.lsp.buf.document_symbol()'
  end
  if cap.goto_definition then
    cmd 'command! -buffer LspDefinition lua vim.lsp.buf.definition()'
  end
  if cap.type_definition then
    cmd 'command! -buffer LspTypeDefinition lua vim.lsp.buf.type_definition()'
  end
  if cap.declaration then
    cmd 'command! -buffer LspDeclaration lua vim.lsp.buf.declaration()'
  end
  if cap.implementation then
    cmd 'command! -buffer LspImplementation lua vim.lsp.buf.implementation()'
  end
end

function _G.lspconfig_init()
  api.nvim_exec([[
  augroup lsp_lightbulb
    autocmd!
    autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()
  augroup END
  ]], false)

  local lspconfig = require('lspconfig')
  lspconfig.sumneko_lua.setup {
    cmd = {'lua-language-server'},
    on_attach = custom_lsp_attach,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = {
            [fn.expand('$VIMRUNTIME/lua')] = true,
          },
        },
      },
    },
  }
end
--- {{{1 [[ NVIM-COMPE ]]
function _G.compe_init()
  local compe = require('compe')
  compe.setup {
    enabled = true,
    preselect = 'enable',
    source = {
      path = true,
      buffer = true,
      nvim_lsp = true,
      nvim_lua = true,
      vsnip = true,
    }
  }

  local function t(str)
    return api.nvim_replace_termcodes(str, true, true, true)
  end

  local function check_back_space()
    local col = fn.col('.') - 1
    return not not (col == 0 or fn.getline('.'):sub(col, col):match('%s'))
  end

  -- Use (s-)tab to:
  --- move to prev/next item in completion menuone
  --- jump to prev/next snippet's placeholder
  function _G.tab_complete()
    if fn.pumvisible() == 1 then
      return t '<C-n>'
    elseif fn['vsnip#available'](1) == 1 then
      return t '<Plug>(vsnip-expand-or-jump)'
    elseif check_back_space() then
      return t '<Tab>'
    else
      return fn['compe#complete']()
    end
  end
  function _G.s_tab_complete()
    if fn.pumvisible() == 1 then
      return t '<C-p>'
    elseif fn['vsnip#jumpable'](-1) == 1 then
      return t '<Plug>(vsnip-jump-prev)'
    else
      return t '<S-Tab>'
    end
  end

  map('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
  map('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
  map('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
  map('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})

  map('i', '<CR>', [[compe#confirm({ 'keys': "\<Plug>delimitMateCR" })]], {expr = true, silent = true})
end
--- {{{1 [[ COMMANDS ]]
-- LspLog: take a quick peek at the latest LSP log messages. Useful for debugging
-- LspStop: stop all active clients
-- Redirect: show the results of an ex command in a buffer rather than the built-in pager
api.nvim_exec([[
command! LspLog execute '<mods> pedit +$' v:lua.vim.lsp.get_log_path()
command! LspStop lua vim.lsp.stop_client(vim.lsp.get_active_clients())
command! -nargs=* -complete=command Redirect <mods> new | setl nonu nolist noswf bh=wipe bt=nofile | call append(0, split(execute(<q-args>), "\n"))
]], false)
--- {{{1 [[ AUTOCOMMANDS ]]
-- hl_yank: highlight the area that was just yanked
-- restore_curpos: restore the last position of the cursor in a file. Taken from Vim's defaults.vim
api.nvim_exec([[
augroup hl_yank
  autocmd!
  autocmd TextYankPost * lua require('vim.highlight').on_yank()
augroup END

augroup restore_curpos
  autocmd!
  autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif
augroup END
]], false)
---- load plugins
--
--require("pluginsList.lua")
--require("web-devicons.lua")
--
--require("kommentary.lua")
--
--require("utils.lua")
--require("nvimTree.lua")
--require("bufferline.lua")
--require("statusline.lua")
--require("telescope-nvim.lua")
--require("markdown-preview.lua")
--
---- lsp
--require("nvim-lspconfig.lua")
--require("nvim-compe.lua")
--require('snips.lua')
--
--
---- gi
--require("gitsigns.lua")
--require("nvim-toggleterm.lua")
--require "colorizer".setup()
--
--local cmd = vim.cmd
--local g = vim.g
--local indent = 4
--
--cmd "colorscheme base16-onedark"
--cmd "syntax enable"
--cmd "syntax on"
--
---- no wrap on all windows
--cmd "autocmd WinEnter * set nowrap"
--
--g.auto_save = 1
--g.indentLine_char_list = {'▏'}
--g.mapleader = " "
--
--
--require("treesitter.lua")
--require("mappings.lua")
--
---- highlights
--cmd("hi LineNr guibg=NONE")
--cmd("hi SignColumn guibg=NONE")
--cmd("hi VertSplit guibg=NONE")
--cmd("hi DiffAdd guifg=#81A1C1 guibg = none")
--cmd("hi DiffChange guifg =#3A3E44 guibg = none")
--cmd("hi DiffModified guifg = #81A1C1 guibg = none")
--cmd("hi EndOfBuffer guifg=#282c34")
--
--cmd("hi TelescopeBorder   guifg=#3e4451")
--cmd("hi TelescopePromptBorder   guifg=#3e4451")
--cmd("hi TelescopeResultsBorder  guifg=#3e4451")
--cmd("hi TelescopePreviewBorder  guifg=#525865")
--cmd("hi PmenuSel  guibg=#98c379")
--
---- tree folder name , icon color
--cmd("hi NvimTreeFolderIcon guifg = #61afef")
--cmd("hi NvimTreeFolderName guifg = #61afef")
--cmd("hi NvimTreeIndentMarker guifg=#545862")
--
--require("nvim-autopairs").setup()
--require("lspkind").init({ File = " " })
--
--
--vim.cmd("autocmd BufReadPre *.zig set filetype=zig")
--vim.cmd("autocmd BufReadPre *.graphql,*.gql,*.graphqls set filetype=graphql")
--vim.cmd("autocmd BufReadPre *.ek set syntax=typescript")
--vim.cmd("autocmd BufReadPre *.fish set syntax=sh")
--vim.cmd("autocmd BufReadPre *.scm set syntax=lisp")
