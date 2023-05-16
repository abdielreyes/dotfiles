local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end
-- recommended settings for this plugin
vim.g.loaded = 1
vim.g.loaded_newtrwPlugin = 1
vim.g.nvim_tree_auto_close = 1
-- -- quits when there are no more buffers
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	nested = true,
-- 	callback = function()
-- 		if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
-- 			vim.cmd("quit")
-- 		end
-- 	end,
-- })
nvimtree.setup({
	-- disable window_picker for
	-- explorer to work well with
	-- window splits
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
	git = {
		enable = false,
	},
})
