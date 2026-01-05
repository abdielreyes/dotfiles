-- lua/plugins/lint.lua
-- Comprehensive linting via nvim-lint
-- Configured via centralized language definitions
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile", "BufWritePost" },
	config = function()
		local lint = require("lint")
		local languages = require("config.languages")

		-- Configure linters by filetype from centralized config
		lint.linters_by_ft = languages.get_linters_by_ft()

		-- Auto-lint on these events
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = function()
				-- Only lint if the buffer is valid and has a filetype
				if vim.api.nvim_buf_is_valid(0) and vim.bo.filetype ~= "" then
					lint.try_lint()
				end
			end,
		})

		-- Manual linting command
		vim.api.nvim_create_user_command("Lint", function()
			lint.try_lint()
		end, { desc = "Run linter on current buffer" })

		-- Keymap to trigger manual linting
		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting" })
    -- inline diagnostic
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●", -- símbolo bonito; puede ser "■", "▎", "●", "●"
				spacing = 1,
				severity_sort = true,
			},
			underline = true,
			signs = true,
			update_in_insert = false,
		})
	end,
}
