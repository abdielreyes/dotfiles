local opt = vim.opt
-- leader key
vim.g.mapleader = " "
-- encoding
opt.encoding = "utf-8"
-- line numbers
opt.relativenumber = false
opt.number = true
opt.ruler = true
-- tabs and indent
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
-- opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

--clipboard
opt.clipboard:append("unnamedplus")

--split windows
opt.splitright = true
opt.splitbelow = true

-- hello-hello is same word
opt.iskeyword:append("-")

--scrolloff
opt.scrolloff = 10
