local lsp_servers = {
	"lua_ls",
	"bashls",
	"clangd",
	"jdtls",
	"sqlls",
	"marksman",
	"pyright",
	"html",
	"cssls",
	"ts_ls",
	"tailwindcss",
	"emmet_ls",
	"eslint",
}
return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				auto_install = true,
				ensure_installed = lsp_servers,
			})
		end,
	},
	{
		"princejoogie/tailwind-highlight.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local tw_highlight = require("tailwind-highlight")
			--here have to specify the languages needed for lsp
			for _, server in ipairs(lsp_servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
				})
			end
			--config for tailwind colorizing
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					tw_highlight.setup(client, bufnr, {
						single_column = false,
						mode = "background",
						debounce = 200,
					})
				end,
			})
			local opts = {}
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		end,
	},
}
