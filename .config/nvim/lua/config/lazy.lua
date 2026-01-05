-- Bootstrap and configure lazy.nvim (plugin manager)
local uv = vim.uv or vim.loop
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Clone lazy.nvim on first run
if not uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

-- Prepend lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Register our plugin modules, keep everything lazy-loaded by default
require("lazy").setup({
	spec = {
		{ import = "plugins.theme" }, -- colorscheme
		{ import = "plugins.ui" }, -- statusline + which-key
		{ import = "plugins.lsp" }, -- language servers
		{ import = "plugins.cmp" }, -- completion
		{ import = "plugins.snippets" }, -- snippets
		{ import = "plugins.explorer" }, -- file explorer + telescope
		{ import = "plugins.treesitter" }, -- treesitter
		{ import = "plugins.conform" }, -- formatting via conform.nvim
		{ import = "plugins.format" }, -- LSP formatting control
		{ import = "plugins.dashboard" }, -- welcome screen
		{ import = "plugins.copilot" }, -- copilot autocompletion and chat
    { import = "plugins.lint"} -- linting via nvim-lint
	},
	defaults = { lazy = true },
	install = { colorscheme = { "catppuccin" } },
	change_detection = { notify = false }, -- avoid noisy notifications on file changes
	rocks = { enabled = false, hererocks = false },
})

-- Add Mason's bin to PATH (works on macOS and Linux)
do
	local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
	if not string.find(vim.env.PATH or "", mason_bin, 1, true) then
		vim.env.PATH = mason_bin .. ":" .. (vim.env.PATH or "")
	end
end
