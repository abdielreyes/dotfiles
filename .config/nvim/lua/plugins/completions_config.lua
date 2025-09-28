return {
	{
		"windwp/nvim-ts-autotag",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local ts_autotag = require("nvim-ts-autotag")
			ts_autotag.setup({})
		end,
	},
	{
		"windwp/nvim-autopairs",
		--[[ event = "InsertEnter", ]]
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {

			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
			},
			{
				"onsails/lspkind.nvim",
			},
			{
				"zbirenbaum/copilot.lua",
				config = function()
					require("copilot").setup({})
				end,
			},
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup({})
				end,
			},
			{
				"CopilotC-Nvim/CopilotChat.nvim",
				dependencies = {
					{ "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
					{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
				},
				build = "make tiktoken",
				config = function()
					require("CopilotChat").setup({})

					vim.keymap.set("n", "<leader>ac", function()
						vim.cmd("CopilotChatToggle")
					end, { desc = "Toggle Chat Window" })
				end, -- Only on MacOS or Linux
			},
		},
		config = function()
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local lspkind = require("lspkind")
			--snippets

			require("luasnip.loaders.from_vscode").lazy_load()
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			cmp.setup({
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 20,
						ellipsis_char = "...",
						show_labelDetails = true,
						symbol_map = { Copilot = "" },
						before = function(_, vim_item)
							return vim_item
						end,
					}),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<Tab>"] = cmp.mapping(function(fallback)
						local luasnip = require("luasnip")
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.choice_active() then
							luasnip.change_choice(1)
						else
							fallback()
						end
					end),
				}),
				sources = cmp.config.sources({
					{ name = "copilot" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "path" },
					{ name = "buffer", keyword_length = 3 },
				}, {}),
			})
		end,
	},
}
