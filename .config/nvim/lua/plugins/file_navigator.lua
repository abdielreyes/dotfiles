return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim",        -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				event_handlers = {
					{
						event = "neo_tree_buffer_enter",
						handler = function()
							vim.cmd("highlight! Cursor blend=100")
						end,
					},
					{
						event = "neo_tree_buffer_leave",
						handler = function()
							vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
						end,
					},
					{
						event = "file_opened",
						handler = function(file_path)
							-- auto close
							-- vimc.cmd("Neotree close")
							-- OR
							--require("neo-tree.command").execute({ action = "close" })
						end,
					},
				},
			},
		})
		vim.keymap.set("n", "<leader>n", ":Neotree filesystem focus left toggle<cr>")
		vim.keymap.set("n", "<leader>N", ":Neotree buffers focus right toggle<cr>")
	end,
}
