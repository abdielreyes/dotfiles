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
						"eslint_d",
						"prettierd",
						"refactoring",
						"clang_format",
						"checkstyle",
						"sql_format",
						"black",
						"isort",
						"jq"
					},
				})
			end,
		},
		{
			"nvimtools/none-ls.nvim",
			dependencies = {
				"nvimtools/none-ls-extras.nvim"
			},
			config = function()
				-- none-ls is a mantained null-ls project
				local null_ls = require("null-ls")
				null_ls.setup({
					sources = {
						--code actions
						null_ls.builtins.code_actions.gitsigns,
						null_ls.builtins.code_actions.refactoring,
						require("none-ls.code_actions.eslint_d"),
						--formatting
						null_ls.builtins.formatting.clang_format,
						null_ls.builtins.formatting.stylua,
						null_ls.builtins.formatting.prettierd,
						null_ls.builtins.formatting.sqlformat,
						null_ls.builtins.formatting.black,
						null_ls.builtins.formatting.isort,
						--diagnostics
						require("none-ls.diagnostics.eslint_d"),
					},
				})
			end,
		},
	},
}
