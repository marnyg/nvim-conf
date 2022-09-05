local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true, silent = true })
map("n", "<leader>fp", "<cmd>Telescope projects<cr>", { noremap = true, silent = true })
