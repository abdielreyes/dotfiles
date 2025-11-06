-- Treesitter for better syntax highlighting, indentation and TSX, Go, Java, etc.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- keep parsers up to date
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- Install parsers for the languages you use
      ensure_installed = {
        "lua", "vim", "vimdoc",
        "javascript", "typescript", "tsx", "json", "yaml", "html", "css",
        "java", "python", "go", "bash", "c", "cpp",
        "markdown", "markdown_inline",
      },
      highlight = { enable = true }, -- modern tree-based highlighting
      indent = { enable = true },    -- smarter indentation
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

