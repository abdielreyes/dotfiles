return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "gruvbox",
				},
				sections = {
					lualine_c = {
						{
							"filename",
							path = 1,
						},
					},
				},
				-- sections = {lualine_c = {require('auto-session.lib').current_session_name}}
			})
		end,
	},
}
