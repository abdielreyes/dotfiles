-- Core editor options and sensible defaults
vim.o.termguicolors = true        -- enable true color
vim.o.number = true               -- show absolute line numbers
vim.o.relativenumber = true       -- relative numbers for quick movement
vim.o.mouse = "a"                 -- mouse support
vim.o.clipboard = "unnamedplus"   -- use system clipboard
vim.o.updatetime = 200            -- faster CursorHold & diagnostics update
vim.o.timeoutlen = 400            -- which-key and mappings feel snappy
-- vim.o.completeopt = "menu,menuone,noselect" -- completion UX
vim.o.completeopt = "menu,menuone,popup,noinsert,noselect"
vim.o.splitbelow = true           -- new splits open below
vim.o.splitright = true           -- new vertical splits open right
vim.o.ignorecase = true           -- case-insensitive search...
vim.o.smartcase = true            -- ...unless uppercase used
vim.o.signcolumn = "yes"          -- always show sign column
vim.o.scrolloff = 6               -- keep context around cursor
vim.o.expandtab = true            -- spaces instead of tabs
vim.o.shiftwidth = 2              -- indentation width
vim.o.tabstop = 2                 -- render tabs as 2 spaces

