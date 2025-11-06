-- Auto-install tools via Mason, cross-platform
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        -- LSPs
        "vtsls", "eslint-lsp", "html-lsp", "css-lsp", "json-lsp", "yaml-language-server",
        "tailwindcss-language-server", "lua-language-server", "pyright", "gopls",
        "bash-language-server", "clangd", "jdtls",

        -- Formatters/Linters
        "prettier", "stylua", "shfmt", "black", "isort",
        "gofumpt", "goimports", "clang-format",
      },
      auto_update = true,
      run_on_start = true,
    },
  },
}

