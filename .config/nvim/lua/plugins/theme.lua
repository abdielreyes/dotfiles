-- Colorscheme (Catppuccin) with common integrations enabled
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- load before other UI plugins
    opts = {
      flavour = "mocha", -- dark variant
      integrations = {
        which_key = true,
        treesitter = true,
        cmp = true,
        gitsigns = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin") -- apply theme
    end,
  },
}
