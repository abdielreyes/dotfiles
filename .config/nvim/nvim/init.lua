require("plugins-setup")
-- core
require("core.options")
require("core.keymaps")
require("core.colorscheme")
--plugins
require("plugins.comment")
require("plugins.lualine")
require("plugins.nvim-cmp")
require("plugins.nvim-tree")
require("plugins.treesitter")
require("plugins.gitsigns")
require("plugins.autopairs")
require("plugins.neoscroll")

-- LSP
require("plugins.lsp.mason")
require("plugins.lsp.lspsaga")
require("plugins.lsp.lspconfig")
require("plugins.lsp.null-ls")

-- To auth copilot, run  :Copilot auth
