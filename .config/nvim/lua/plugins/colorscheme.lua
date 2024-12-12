--colorscheme
return {
	{

		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	config = function()
 --            vim.cmd.colorscheme("gruvbox")
 --            vim.o.background = "dark"
	-- 	end,
	-- },
}
