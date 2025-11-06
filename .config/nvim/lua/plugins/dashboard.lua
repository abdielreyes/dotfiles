-- Pretty start screen with quick actions (files, grep, explorer, Lazy, Mason)
return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Header ASCII (simple, you can replace with your logo)
      dashboard.section.header.val = {
        "┌──────────────────────────────────────────┐",
        "│              Welcome to NVIM             │",
        "└──────────────────────────────────────────┘",
      }

      -- Quick buttons (adapt to your flow)
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent",    ":Telescope oldfiles<CR>"),
        dashboard.button("g", "  Live grep", ":Telescope live_grep<CR>"),
        dashboard.button("t", "  Explorer",  ":Neotree toggle<CR>"),
        dashboard.button("l", "󰒲  Lazy",      ":Lazy<CR>"),
        dashboard.button("m", "  Mason",     ":Mason<CR>"),
        dashboard.button("q", "  Quit",      ":qa<CR>"),
      }

      -- Footer (can be dynamic)
      dashboard.section.footer.val = "Happy hacking!"

      -- Layout + options
      dashboard.config.opts.noautocmd = true
      alpha.setup(dashboard.config)

      -- Open alpha when launching without file; if a file is passed, don't override
      -- This is usually handled by alpha itself, but we ensure no flicker:
      if vim.fn.argc() == 0 then
        vim.cmd("Alpha")
      end
    end,
  },
}
