return {
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
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"stylua",
					-- "eslint_d",
					"prettier",
					"refactoring",
					"clang_format",
					"checkstyle",
					"sql_format",
					"black",
					"isort",
					"jq",
					"rubocop",
					"erb_lint",
					"erb_format",
					--[[ "stylelint", ]]
				},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			-- none-ls is a mantained null-ls project
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			null_ls.setup({
				sources = {
					--code actions
					null_ls.builtins.code_actions.gitsigns,
					null_ls.builtins.code_actions.refactoring,

					--now eslint has moved to lspconfig file
					-- require("none-ls.code_actions.eslint_d"),
					--formatting
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.sqlformat,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.rubocop,
					null_ls.builtins.formatting.erb_format,
					--[[ null_ls.builtins.diagnostics.stylelint, ]]

					--diagnostics
					null_ls.builtins.diagnostics.rubocop,
					null_ls.builtins.diagnostics.erb_lint,
					--[[ null_ls.builtins.diagnostics.stylelint, ]]
					-- require("none-ls.diagnostics.eslint_d"),
					--keymaps
					vim.keymap.set("n", "<leader>fm", function()
						vim.lsp.buf.format({ async = true })
					end, {}),
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			})
		end,
	},
}
