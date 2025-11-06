return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = false,
      popup_border_style = "rounded",

      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {},
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        group_empty_dirs = false,
        hijack_netrw_behavior = "disabled",   -- IMPORTANT when using oil.nvim
      },

      window = {
        position = "left",
        width = 32,
        mappings = {
          ["<space>"] = "toggle_node",
          ["<cr>"] = "open",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["h"] = "prev_source",
          ["l"] = "next_source",
        },
      },

      event_handlers = {
        -- keeps default behaviors
      },
    },
  },
    {
      "stevearc/oil.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      lazy = false,                     -- Load immediately
      opts = {
        default_file_explorer = true,   -- Oil replaces netrw
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = { show_hidden = true },
      },
    },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help" },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { width = 0.85, height = 0.80 },
        sorting_strategy = "ascending",
      },
    },
  },
}
