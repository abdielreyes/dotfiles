-- syntax highlighting
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "VeryLazy",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@conditional.outer",
							["ic"] = "@conditional.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
						},
					},
				},
				ensure_installed = {
					"lua",
					"luadoc",
					"bash",
					"javascript",
					"typescript",
					"tsx",
					"json",
					"ruby",
					"java",
					"ruby",
					"embedded_template",
				},
			})
			vim.treesitter.language.register("erb", "embedded_template")
		end,
	},
}
