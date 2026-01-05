-- Auto-detect indentation from file content
return {
	{
		"tpope/vim-sleuth",
		event = { "BufReadPre", "BufNewFile" },
	},
}
