local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
--true if packer was just installed
local packer_bootstrap = ensure_packer()

-- autocommand that reloads neovim when this file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

-- list plugins
return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim") -- this plugin is used by other plugins

	use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
	-- window navigation
	use("christoomey/vim-tmux-navigator") -- move between windows
	use("szw/vim-maximizer") -- maximizes and restores current window
	-- essential plugins
	use("tpope/vim-surround") -- surround quotes ysw" ds"
	use("vim-scripts/ReplaceWithRegister") -- yw copy grw replace text
	use("numToStr/Comment.nvim") -- commenting with gc

	-- file explorer
	use("nvim-tree/nvim-tree.lua")
	use("nvim-tree/nvim-web-devicons") -- icons

	-- status line
	use({ "nvim-lualine/lualine.nvim", requires = { "nvim-tree/nvim-web-devicons", opt = true } })
	use({ "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" })

	-- fuzzy file finder
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

	-- autocompletion
	-- language server, linters and formatters
	use("neovim/nvim-lspconfig") -- configure lsp servers
	use("williamboman/mason.nvim") -- managing lsp servers
	use("williamboman/mason-lspconfig.nvim") -- managing lsp servers
	-- completion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}) -- enhanced lsp utils
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use({
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	})
	use({
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	})
	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configures formatting and linting
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls
	-- treesitter configuration syntax highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- smooth scroll
	use("karb94/neoscroll.nvim")
	-- multiple cursors
	use("mg979/vim-visual-multi")
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({})
		end,
	})
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})
	if packer_bootstrap then
		packer.sync()
	end
end)
