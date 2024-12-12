local keymap = vim.keymap

-- general keymaps

keymap.set("i", "jk", "<ESC>") -- normal mode pressing jk
keymap.set("n", "<leader>nh", ":nohl<CR>") -- in normal mode, delete highlights
keymap.set("x", "x", '"_x') -- dont copy deleted char in registry

keymap.set("n", "<leader>sv", "<C-w>v") -- split vertical window
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
-- you can resize windows with mouse
keymap.set("n", "<leader>se", "<C-w>=") -- make splitted windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window



keymap.set("n", "<TAB>", ":bnext<CR>") -- go to next buffer
keymap.set("n", "<S-TAB>", ":bprevious<CR>") -- go to prev buffer
keymap.set("n", "<leader>q", ":bp|bd #<CR>") -- close current buffer
keymap.set("n", "<leader>w", ":w<CR>") -- save current buffer
keymap.set({"n","i","v"}, "<C-s>", ":w<CR>") -- save ctrl s
