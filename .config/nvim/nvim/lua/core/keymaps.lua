-- leader key
vim.g.mapleader = " "

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

keymap.set("n", "<leader>to", ":tabnew<CR>") -- opens new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to prev tab

keymap.set("n", "<TAB>", ":bnext<CR>") -- go to next buffer
keymap.set("n", "<S-TAB>", ":bprevious<CR>") -- go to prev buffer
keymap.set("n", "<leader>q", ":bp|bd #<CR>") -- close current buffer

keymap.set("n", "<leader>rl", ":luafile ~/.config/nvim/init.lua <CR>")
-- plugin keymaps

-- minimizes and maximizes window
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
