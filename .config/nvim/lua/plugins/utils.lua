return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local ts_autotag = require("nvim-ts-autotag")
			ts_autotag.setup({})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				close_on_exit = false,
				autochdir = true,
				shell = vim.o.shell,
				direction = "horizontal",
				size = 20,
				open_mapping = "<c-t>",
			})
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end

			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
			vim.keymap.set("n", "<leader>th", ":ToggleTerm size=20 direction=horizontal<CR>")
			vim.keymap.set("n", "<leader>tv", ":ToggleTerm size=40 direction=vertical<CR>")
			vim.keymap.set("n", "<leader>tf", ":ToggleTerm  direction=float<CR>")

			vim.keymap.set("n", [[<c-t>]], '<cmd>exe v:count1 . "ToggleTerm size=40 direction=vertical"<CR>')
			vim.keymap.set("i", [[<c-t>]], '<cmd>exe v:count1 . "ToggleTerm size=40 direction=vertical"<CR>')
			vim.keymap.set("t", [[<c-t>]], '<cmd>exe v:count1 . "ToggleTerm size=40 direction=vertical"<CR>')
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				easing_function = "sine", -- Default easing function
			})
		end,
	},
	{
		"justinmk/vim-sneak",
		config = function()
			vim.g["sneak#label"] = 1
			vim.g["sneak#s_next"] = 1
		end,
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup({

				pre_hook = function(ctx)
					local utils = require("Comment.utils")
					local location = nil
					if ctx.ctype == utils.ctype.block then
						location = require("ts_context_commentstring.utils").get_cursor_location()
					elseif ctx.cmotion == utils.cmotion.v or ctx.cmotion == utils.cmotion.V then
						location = require("ts_context_commentstring.utils").get_visual_start_location()
					end
					return require("ts_context_commentstring.internal").calculate_commentstring({
						key = ctx.ctype == utils.ctype.line and "__default" or "__multiline",
						location = location,
					})
				end,
			})
		end,
	},
	{

		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	{
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({
				auto_cmd = true,
				override_editorconfig = false,
			})
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				patterns = {
					"init.lua",
					".git",
					"_darcs",
					".hg",
					".bzr",
					".svn",
					"Makefile",
					"package.json",
					"pom.xml",
					"package-lock.json",
				},
				exclude_dirs = {
					"~/",
					"/home/abdiel",
				},
			})
		end,
	},
}
