return {
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
				easing_function = "quintic", -- Default easing function
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
	{
		"rcarriga/nvim-notify",
	},
}
