local o = vim.o
local wo = vim.wo
local bo = vim.bo

o.smartcase = true
o.laststatus = 2
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.scrolloff = 12
vim.cmd('syntax on') -- syntax highlighting
vim.o.pumheight = 10 -- Makes popup menu smaller
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.cmdheight = 2 -- More space for displaying messages
vim.o.mouse = "a" -- Enable your mouse
vim.o.splitbelow = true -- Horizontal splits will automatically be below
vim.o.termguicolors = true -- set term gui colors most terminals support this
vim.o.splitright = true -- Vertical splits will automatically be to the right
-- vim.o.t_Co = "256" -- Support 256 colors
vim.o.conceallevel = 0 -- So that I can see `` in markdown files
vim.cmd('set ts=4') -- Insert 2 spaces for a tab
vim.cmd('set sw=4') -- Change the number of space characters inserted for indentation
vim.cmd('set expandtab') -- Converts tabs to spaces
vim.bo.smartindent = true -- Makes indenting smartjj
vim.wo.cursorline = true -- set highlighting of the current line
vim.o.showtabline = 2 -- Always show tabs
vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore
vim.o.backup = false -- This is recommended by coc
vim.o.writebackup = false -- This is recommended by coc
vim.o.swapfile = false -- Do not write any swp files
vim.o.undodir = vim.fn.stdpath('cache') .. '/undo' -- Set undo directory
vim.o.undofile = true -- Enable persistent undo
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.o.updatetime = 300 -- Faster completion
vim.o.timeoutlen = 500 -- By default timeoutlen is 1000 ms
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.cmd('filetype plugin on') -- filetype detection

-- ... snip ...

-- window-local options
wo.relativenumber = true
wo.number = true
wo.wrap = false
wo.signcolumn = 'number' -- Display signs in the number column



-- buffer-local options
bo.expandtab = true

vim.cmd('let g:nvcode_termcolors=256')
vim.cmd('colorscheme lunar')
vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
vim.cmd('set shortmess+=c') -- Don't pass messages to |ins-completion-menu|.
vim.cmd('set inccommand=split') -- Make substitution work in realtime
