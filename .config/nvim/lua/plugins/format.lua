-- lua/plugins/format.lua
-- Pure LSP formatting (no Conform, no null-ls)
return {
	{
		-- This plugin is just a placeholder to run config inside Lazy's system.
		-- It does NOT install anything.
		"nvim-lua/plenary.nvim",
		lazy = false,

		config = function()
			-------------------------------------------------------------------
			-- :Format and :format commands
			-------------------------------------------------------------------
			vim.api.nvim_create_user_command("Format", function()
				vim.lsp.buf.format({ async = true })
			end, {})

			-------------------------------------------------------------------
			-- <leader>fm to format document
			-------------------------------------------------------------------
			vim.keymap.set("n", "<leader>fm", function()
				vim.lsp.buf.format({ async = true })
			end, { desc = "Format Code" })

			-------------------------------------------------------------------
			-- OPTIONAL: format on save
			-- Enable by removing "--" from the autocmd below.
			-------------------------------------------------------------------
			-- vim.api.nvim_create_autocmd("BufWritePre", {
			--   pattern = { "*.js", "*.ts", "*.tsx", "*.jsx", "*.lua", "*.go", "*.py", "*.c", "*.cpp" },
			--   callback = function()
			--     vim.lsp.buf.format()
			--   end,
			-- })

			-------------------------------------------------------------------
			-- OPTIONAL: Recommended formatting control.
			-- Disable formatting from certain LSPs that conflict.
			-------------------------------------------------------------------
			local disable_format_for = {
				-- Add servers you DON'T want formatting your files:
				-- ["tsserver"] = true,
				-- ["vtsls"] = true,      -- if you use Prettier externally
				-- ["eslint"] = true,
			}

			-- Hook into your global on_attach if you have one
			local orig_on_attach = vim.lsp.on_attach or function() end

			vim.lsp.on_attach = function(client, bufnr)
				-- Disable formatting for certain servers
				if disable_format_for[client.name] then
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end

				-- Call user-defined on_attach if any
				orig_on_attach(client, bufnr)
			end
		end,
	},
}
