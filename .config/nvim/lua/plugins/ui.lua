-- UI: statusline (lualine) + discoverable keymaps (which-key) + icons
return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Icons provider (which-key recomienda mini.icons cuando está disponible)
  { "echasnovski/mini.icons", version = false, lazy = true },

  -- which-key v3+: usa opts.win y spec API
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- NEW: opts.win (antes era opts.window)
      win = { border = "rounded" },
      -- Spec nueva: solo define grupos; NO crea un <leader>f “ejecutable”
      spec = {
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>w", group = "window" },
      },
      -- Si quieres forzar uso de devicons en lugar de mini.icons:
      -- icons = { preset = "classic" },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)        -- aplica opciones
      wk.add(opts.spec)     -- registra grupos con la spec nueva
    end,
  },
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      -- Try to pull Catppuccin integration if installed (nice themed highlights)
      local highlights = nil
      pcall(function()
        highlights = require("catppuccin.groups.integrations.bufferline").get()
      end)

      return {
        options = {
          -- Show LSP diagnostics (icons shown on tabs)
          diagnostics = "nvim_lsp",
          -- Add left offset when Neo-tree is visible
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left",
            },
          },
          separator_style = "thin",
          show_close_icon = false,
          always_show_bufferline = true,
          -- Use numbers or icons on tabs; "buffer_id" is nice for <leader>1..9
          numbers = "buffer_id",
        },
        highlights = highlights,
      }
    end,
    config = function(_, opts)
      require("bufferline").setup(opts)

      -- === Keymaps (in English comments) ===
      local map = vim.keymap.set
      local o = { noremap = true, silent = true }

      -- Next/Prev buffer (you already had <Tab>/<S-Tab>, keep them)
      map("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", o)  -- next
      map("n", "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", o)  -- prev

      -- Pick buffer by letter (fast jump)
      map("n", "<leader>bb", "<cmd>BufferLinePick<cr>", o)

      -- Close current / others / right
      map("n", "<leader>bd", "<cmd>bdelete<cr>", o)                 -- delete current
      map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", o)   -- close others
      map("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>", o)    -- close to the right

      -- Go to buffer 1..9 quickly (works well with numbers="buffer_id")
      for i = 1, 9 do
        map("n", "<leader>" .. i, function()
          require("bufferline").go_to_buffer(i, true)
        end, o)
      end
    end,
  },
}

