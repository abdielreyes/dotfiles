-- lua/plugins/conform.lua
-- Code formatting via conform.nvim
-- Configured via centralized language definitions
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    local conform = require("conform")
    local languages = require("config.languages")

    -- Configure formatters by filetype from centralized config
    conform.setup({
      formatters_by_ft = languages.get_formatters_by_ft(),

      -- Format on save (optional, can be disabled)
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },

      -- Customize formatters if needed
      formatters = {},
    })

    -- Manual format command
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      conform.format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })

    -- Keymap for manual formatting
    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
      conform.format({ async = true, lsp_fallback = true })
    end, { desc = "Format Code" })
  end,
}
