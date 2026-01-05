-- lua/plugins/copilot.lua
return {

	---------------------------------------------------------------------------
	-- Copilot core (inline disabled; you use cmp)
	---------------------------------------------------------------------------
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		opts = {
			panel = { enabled = false },
			suggestion = {
				enabled = false, -- we use cmp for suggestions
				auto_trigger = false,
			},
			filetypes = { ["*"] = true },
		},
		config = function(_, opts)
			require("copilot").setup(opts)
		end,
	},

	---------------------------------------------------------------------------
	-- Copilot completion source for cmp
	---------------------------------------------------------------------------
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		event = "InsertEnter",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	-- copilot chat
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
			{ "zbirenbaum/copilot.lua" },
		},
		build = "make tiktoken",
		event = "InsertEnter", -- same trigger as copilot.lua
		-- ✅ which-key will detect these always
		keys = {
			{ "<leader>ai", group = "AI" }, -- <== top-level group

			{ "<leader>aic", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Chat" },
			{ "<leader>aio", "<cmd>CopilotChatOpen<cr>", desc = "Open Chat" },
			{
				"<leader>aie",
				function()
					require("CopilotChat").ask("Explain")
				end,
				mode = "v",
				desc = "Explain Selection",
			},

			{
				"<leader>aif",
				function()
					require("CopilotChat").ask("Fix")
				end,
				mode = "v",
				desc = "Fix Selection",
			},

			{
				"<leader>ait",
				function()
					require("CopilotChat").ask("Tests")
				end,
				mode = "v",
				desc = "Generate Tests",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-*",
				callback = function()
					vim.opt_local.relativenumber = false
					vim.opt_local.number = false
					vim.opt_local.conceallevel = 0
				end,
			})
			vim.g.copilot_no_tab_map = true
			vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "copilot-chat", -- buffer type used by CopilotChat input
				callback = function()
					local ok, cmp = pcall(require, "cmp")
					if not ok then
						return
					end

					cmp.setup.buffer({
						-- Don't auto-popup; use <C-Space> or type '/' to trigger
						completion = { autocomplete = false },
						preselect = cmp.PreselectMode.None,

						mapping = {
							["<Tab>"] = function(fallback)
								if cmp.visible() then
									cmp.confirm({ select = true })
								else
									fallback()
								end
							end,

							["<S-Tab>"] = function(fallback)
								if cmp.visible() then
									cmp.select_prev_item()
								else
									fallback()
								end
							end,

							["<CR>"] = function()
								if cmp.visible() then
									-- 1) confirm the current suggestion
									cmp.confirm({ select = true })
									-- 2) then submit the chat prompt (on the next tick)
									vim.schedule(function()
										local keys = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
										vim.api.nvim_feedkeys(keys, "n", false)
									end)
								else
									-- no popup: just submit the prompt
									local keys = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
									vim.api.nvim_feedkeys(keys, "n", false)
								end
							end,
						},
					})
				end,
			})
		end,
		opts = {

			-- See Configuration section for options
			context = "buffer",
			model = "claude-sonnet-4.5",
		},
	},
}
