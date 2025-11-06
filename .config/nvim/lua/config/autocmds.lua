-- Central autocommand group for user-defined events
local aug = vim.api.nvim_create_augroup("user_cmds", { clear = true })

-- Visual highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = aug,
	callback = function()
		vim.highlight.on_yank()
	end,
})
