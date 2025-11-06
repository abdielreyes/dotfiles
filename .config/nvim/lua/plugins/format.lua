-- Conform.nvim: on-save formatting via external tools (Prettier, Black, etc.)
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- format before saving
    opts = {
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
      -- Choose formatters per filetype; mason can install many of these
      formatters_by_ft = {
        -- Web / React / Next / Tailwind files
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        markdown = { "prettier" },

        -- Scripting / infra
        sh = { "shfmt" },
        bash = { "shfmt" },
        yaml = { "prettier" },

        -- General purpose
        lua = { "stylua" },
        python = { "black", "isort" },
        go = { "gofumpt", "goimports" },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
    },
  },
}

