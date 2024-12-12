return {
	{
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
						"prettierd",
						"refactoring",
						"clang_format",
						"checkstyle",
						"sql_format",
						"black",
						"isort",
						"jq",
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
						null_ls.builtins.formatting.prettierd,
						null_ls.builtins.formatting.sqlformat,
						null_ls.builtins.formatting.black,
						null_ls.builtins.formatting.isort,
						--diagnostics
						-- require("none-ls.diagnostics.eslint_d"),
						--keymaps
						vim.keymap.set("n", "<leader>gf", function()
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
									-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
									-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
									-- vim.lsp.buf.formatting_sync()
									vim.lsp.buf.format({ async = false })
								end,
							})
						end
					end,
				})
			end,
		},
	},
}
