local api = vim.api
local map = api.nvim_set_keymap

vim.g.mapleader = ','
map('', 'Q', '', {}) -- Begone, foul beast. I can invoke your wrath with gQ anyway.

map('n','<F1>',':e $MYVIMRC<CR>',{})
map('n','<leader><F1>',' :source $MYVIMRC<CR>',{})


map('n','<C-n>',' :NvimTreeToggle<CR>',{})
map('n','<leader>.',' :lcd %:p:h<CR>',{})



-- better window movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true})

-- TODO fix this
-- Terminal window navigation
vim.cmd([[
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l
  inoremap <C-h> <C-\><C-N><C-w>h
  inoremap <C-j> <C-\><C-N><C-w>j
  inoremap <C-k> <C-\><C-N><C-w>k
  inoremap <C-l> <C-\><C-N><C-w>l
  tnoremap <Esc> <C-\><C-n>
]])
-- resize with arrows
map('n', '<C-Up>', ':resize -2<CR>', {silent = true})
map('n', '<C-Down>', ':resize +2<CR>', {silent = true})
map('n', '<C-Left>', ':vertical resize -2<CR>', {silent = true})
map('n', '<C-Right>', ':vertical resize +2<CR>', {silent = true})

-- better indenting
map('v', '<', '<gv', {noremap = true, silent = true})
map('v', '>', '>gv', {noremap = true, silent = true})

-- Tab switch buffer
map('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
map('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})

-- Move selected line / block of text in visual mode
map('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
map('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

-- Better nav for omnicomplete
vim.cmd('inoremap <expr> <c-j> (\"\\<C-n>\")')
vim.cmd('inoremap <expr> <c-k> (\"\\<C-p>\")')

vim.cmd('vnoremap p "0p')
vim.cmd('vnoremap P "0P')
-- vim.api.nvim_set_keymap('v', 'p', '"0p', {silent = true})
-- vim.api.nvim_set_keymap('v', 'P', '"0P', {silent = true})

vim.api.nvim_set_keymap('', '<C-q>', ':call QuickFixToggle()<CR>', {noremap = true, silent = true})

-- Telescope
map('n','<leader>ff', '<cmd>Telescope find_files<cr>', {noremap = true, silent = true})
map('n','<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true, silent = true})
map('n','<leader>fb', '<cmd>Telescope buffers<cr>', {noremap = true, silent = true})
map('n','<leader>fh', '<cmd>Telescope help_tags<cr>', {noremap = true, silent = true})
