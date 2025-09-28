local keymap = vim.keymap

-- general keymaps

keymap.set("i", "jk", "<ESC>") -- normal mode pressing jk
keymap.set("n", "<leader>nh", ":nohl<CR>") -- in normal mode, delete highlights
keymap.set("x", "x", '"_x') -- dont copy deleted char in registry

keymap.set("n", "<leader>s%", "<C-w>v") -- split vertical window
keymap.set("n", '<leader>s"', "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window
-- you can resize windows with mouse or

vim.api.nvim_set_keymap("n", "<C-M-h>", ":vertical resize +2<CR>", { noremap = true, silent = true }) -- Reducir ancho
vim.api.nvim_set_keymap("n", "<C-M-l>", ":vertical resize -2<CR>", { noremap = true, silent = true }) -- Aumentar ancho
vim.api.nvim_set_keymap("n", "<C-M-j>", ":resize -2<CR>", { noremap = true, silent = true }) -- Reducir altura
vim.api.nvim_set_keymap("n", "<C-M-k>", ":resize +2<CR>", { noremap = true, silent = true }) -- Aumentar altura

keymap.set("n", "<leader>se", "<C-w>=") -- make splitted windows equal width

keymap.set("n", "<TAB>", ":bnext<CR>") -- go to next buffer
keymap.set("n", "<S-TAB>", ":bprevious<CR>") -- go to prev buffer
keymap.set("n", "<leader>q", ":q <CR>") -- close current window
keymap.set("n", "<leader>x", ":bp|bd #<CR>") -- close current buffer
keymap.set("n", "<leader>w", ":w<CR>") -- save current buffer
--[[ keymap.set({ "n", "i", "v" }, "<C-s>", ":w<CR>") -- save ctrl s ]]
