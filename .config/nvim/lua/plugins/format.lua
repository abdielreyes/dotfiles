-- lua/plugins/format.lua
-- DEPRECATED: Formatting is now handled by conform.nvim (see plugins/conform.lua)
-- This file only contains LSP formatting control settings
return {
	{
		-- This plugin is just a placeholder to run config inside Lazy's system.
		"nvim-lua/plenary.nvim",
		lazy = false,

		config = function()
			-------------------------------------------------------------------
			-- Disable formatting from certain LSPs to avoid conflicts
			-- conform.nvim will handle formatting instead
			-------------------------------------------------------------------
			local disable_format_for = {
				-- Disable formatting for LSPs where we use dedicated formatters via conform
				["vtsls"] = true, -- Use prettier via conform
				["tsserver"] = true, -- Use prettier via conform
				["html"] = true, -- Use prettier via conform
				["cssls"] = true, -- Use prettier via conform
				["jsonls"] = true, -- Use prettier via conform
				["yamlls"] = true, -- Use prettier via conform
				["lua_ls"] = true, -- Use stylua via conform
				["pyright"] = true, -- Use black/isort via conform
				["gopls"] = true, -- Use gofumpt/goimports via conform
			}

			-- Hook into LSP attach to disable formatting
			local orig_on_attach = vim.lsp.on_attach or function() end

			vim.lsp.on_attach = function(client, bufnr)
				-- Disable formatting for servers listed above
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
