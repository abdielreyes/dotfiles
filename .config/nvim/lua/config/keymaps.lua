-- Global leaders
vim.g.mapleader = " "        -- Space as main leader
vim.g.maplocalleader = " "   -- Space as local leader

local map = vim.keymap.set

-- Basic I/O
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- Buffer navigation with Tab / Shift-Tab
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })

-- Exit insert mode quickly using 'jk'
map("i", "jk", "<Esc>", { desc = "Exit Insert Mode" })

-- Window navigation with Ctrl-h/j/k/l
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- File explorer toggle (Neo-tree)
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle File Explorer" })

