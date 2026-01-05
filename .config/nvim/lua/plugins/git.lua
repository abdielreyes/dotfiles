-- Git integration plugins
return {
	-- Fugitive: Premier git plugin for Vim/Neovim
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
		keys = {
			{ "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
			{ "<leader>gp", "<cmd>Git push<cr>", desc = "Git Push" },
			{ "<leader>gl", "<cmd>Git pull<cr>", desc = "Git Pull" },
			{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
			{ "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git Diff" },
			{ "<leader>gv", "<cmd>Gvdiffsplit<cr>", desc = "Git Diff (vertical)" },
		},
	},

	-- Gitsigns: Git decorations and hunk operations
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = false, -- Don't show inline, only in statusline
				delay = 500,
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				-- Navigation
				map("n", "]h", function()
					if vim.wo.diff then
						return "]h"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, "Next Hunk", { expr = true })

				map("n", "[h", function()
					if vim.wo.diff then
						return "[h"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, "Previous Hunk", { expr = true })

				-- Actions
				map("n", "<leader>ghs", gs.stage_hunk, "Stage Hunk")
				map("n", "<leader>ghr", gs.reset_hunk, "Reset Hunk")
				map("v", "<leader>ghs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage Hunk")
				map("v", "<leader>ghr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset Hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
				map("n", "<leader>gB", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<leader>gtb", gs.toggle_current_line_blame, "Toggle Blame Line")
				map("n", "<leader>ghd", gs.diffthis, "Diff This Hunk")
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, "Diff This Hunk (~)")
				map("n", "<leader>gtd", gs.toggle_deleted, "Toggle Deleted")

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},
}
