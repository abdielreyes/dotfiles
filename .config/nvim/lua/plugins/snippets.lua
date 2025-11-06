-- Snippet engine (LuaSnip) and a large community snippets collection
return {
	{
		"L3MON4D3/LuaSnip",
		-- Stable v2 line; safe for most setups
		version = "v2.*",
		-- TIP: install_jsregexp is optional; comment it out if toolchain is missing
		-- build = "make install_jsregexp",
		event = "InsertEnter", -- lazy-load when entering insert mode
		dependencies = {
			"rafamadriz/friendly-snippets", -- VSCode-style snippets collection
		},
		config = function()
			local ls = require("luasnip")
			-- Lazy load community snippets (only when needed)
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Core behavior: keep snippet history; update on text change
			ls.config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = true,
			})

			-- (Optional) Some comfy keymaps for jumping inside snippets
			-- You already move with <Tab>/<S-Tab> via nvim-cmp, so no extra maps here.
			-- Uncomment if you want direct LuaSnip jumps (independent of cmp):
			-- vim.keymap.set({ "i", "s" }, "<C-j>", function()
			--   if ls.expand_or_jumpable() then ls.expand_or_jump() end
			-- end, { silent = true })
			-- vim.keymap.set({ "i", "s" }, "<C-k>", function()
			--   if ls.jumpable(-1) then ls.jump(-1) end
			-- end, { silent = true })
		end,
	},
}
