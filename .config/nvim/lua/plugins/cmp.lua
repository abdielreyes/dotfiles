-- Completion engine (nvim-cmp) with Tab navigation and LuaSnip expansion
return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter", -- load when entering insert mode
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP completions
			"hrsh7th/cmp-buffer", -- buffer words
			"hrsh7th/cmp-path", -- filesystem paths
			"hrsh7th/cmp-cmdline", -- command line completion
			"L3MON4D3/LuaSnip", -- snippet engine
			"saadparwaiz1/cmp_luasnip", -- snippet completions
			"onsails/lspkind.nvim", -- icons for completion items
			"zbirenbaum/copilot-cmp", -- <= ensure present
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local luasnip = require("luasnip")

			cmp.setup({
				-- Window size config
				window = {
					completion = cmp.config.window.bordered({
						--            winhighlight = "Normal:CmpPmenu,CursorLine:CmpPmenuSel,Search:None",
						col_offset = -3,
						side_padding = 0,
						max_width = 40, -- <—— SMALL width
					}),
					documentation = cmp.config.window.bordered({
						max_width = 50, -- <—— SMALL width
						max_height = 12, -- <—— SMALL doc
					}),
				},

				-- Tell cmp how to expand snippet bodies
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				-- Keymaps inside completion menu; Tab cycles items or jumps in snippets
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(), -- trigger completion
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- accept selected
					["<Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end,
					["<S-Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end,
				}),

				-- Completion sources priority
				sources = cmp.config.sources({
					{ name = "copilot" }, -- <= Copilot
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				}, { { name = "buffer" } }),

				-- Pretty formatting with icons + truncation
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "…", -- Optional: label Copilot items clearly
						symbol_map = { Copilot = "" },
					}),
				},

				experimental = { ghost_text = true }, -- faint inline suggestion
			})
		end,
	},
}
