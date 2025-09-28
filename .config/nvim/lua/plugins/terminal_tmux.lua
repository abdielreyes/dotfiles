return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		{ "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
		{ "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
		{ "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
		{ "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
		{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
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
			vim.keymap.set("n", '<leader>t"', ":ToggleTerm size=20 direction=horizontal<CR>")
			vim.keymap.set("n", "<leader>t%", ":ToggleTerm size=40 direction=vertical<CR>")
			vim.keymap.set("n", "<leader>tf", ":ToggleTerm  direction=float<CR>")

			vim.keymap.set("n", [[<c-t>]], '<cmd>exe v:count1 . "ToggleTerm size=20 direction=horizontal"<CR>')
			vim.keymap.set("i", [[<c-t>]], '<cmd>exe v:count1 . "ToggleTerm size=20 direction=horizontal"<CR>')
			vim.keymap.set("t", [[<c-t>]], '<cmd>exe v:count1 . "ToggleTerm size=20 direction=horizontal"<CR>')
		end,
	},
}
