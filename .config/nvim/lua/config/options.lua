-- Core editor options and sensible defaults
vim.opt.termguicolors = true        -- enable true color
vim.opt.number = true               -- show absolute line numbers
vim.opt.relativenumber = true       -- relative numbers for quick movement
vim.opt.mouse = "a"                 -- mouse support
vim.opt.clipboard = "unnamedplus"   -- use system clipboard
vim.opt.updatetime = 200            -- faster CursorHold & diagnostics update
vim.opt.timeoutlen = 400            -- which-key and mappings feel snappy
vim.opt.completeopt = "menu,menuone,popup,noinsert,noselect"
vim.opt.splitbelow = true           -- new splits open below
vim.opt.splitright = true           -- new vertical splits open right
vim.opt.ignorecase = true           -- case-insensitive search...
vim.opt.smartcase = true            -- ...unless uppercase used
vim.opt.signcolumn = "yes"          -- always show sign column
vim.opt.scrolloff = 6               -- keep context around cursor
vim.opt.expandtab = true            -- spaces instead of tabs
vim.opt.shiftwidth = 2              -- indentation width
vim.opt.tabstop = 2                 -- render tabs as 2 spaces

