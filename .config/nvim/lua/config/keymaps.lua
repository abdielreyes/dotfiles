-- Global leaders
vim.g.mapleader = " "        -- Space as main leader
vim.g.maplocalleader = " "   -- Space as local leader

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Basic I/O
map("n", "<leader>w", "<cmd>w<cr>", opts) -- save
map("n", "<leader>q", "<cmd>q<cr>", opts) -- quit

-- Buffer navigation with Tab / Shift-Tab
map("n", "<Tab>", "<cmd>bnext<cr>", opts)     -- next buffer
map("n", "<S-Tab>", "<cmd>bprevious<cr>", opts) -- previous buffer

-- Exit insert mode quickly using 'jk'
map("i", "jk", "<Esc>", opts)

-- Window navigation with Ctrl-h/j/k/l
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Alternative window navigation via leader
map("n", "<leader>h", "<C-w>h", opts)
map("n", "<leader>j", "<C-w>j", opts)
map("n", "<leader>k", "<C-w>k", opts)
map("n", "<leader>l", "<C-w>l", opts)


-- File explorer toggle (Neo-tree)
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", opts)

-- LSP common actions (work across all servers)
map("n", "gd", vim.lsp.buf.definition, opts)          -- go to definition
map("n", "gr", vim.lsp.buf.references, opts)          -- find references
map("n", "K",  vim.lsp.buf.hover, opts)               -- hover docs
map("n", "<leader>rn", vim.lsp.buf.rename, opts)      -- rename symbol
map("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- code actions
-- map("n", "<leader>f", function()
--   vim.lsp.buf.format({ async = true })                -- async format
-- end, opts)
vim.keymap.set("n", "<leader>fm", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format Code" })
