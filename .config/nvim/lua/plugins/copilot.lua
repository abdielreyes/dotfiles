-- lua/plugins/copilot.lua
return {

  -- GitHub Copilot core (inline OFF, we’ll use cmp instead)
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      panel = { enabled = false },
      suggestion = {
        enabled = false,      -- <= IMPORTANT: let cmp show Copilot items
        auto_trigger = false,
      },
      filetypes = { ["*"] = true },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },

  -- Copilot as a completion source for nvim-cmp
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  ---------------------------------------------------------------------------
  -- 3) Copilot Chat
  ---------------------------------------------------------------------------
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      "zbirenbaum/copilot.lua",           -- shared auth/session
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",    -- optional but recommended
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },

    cmd = {
      "CopilotChat",
      "CopilotChatToggle",
      "CopilotChatOpen",
      "CopilotChatClose",
    },

    keys = function()
      local chat = require("CopilotChat")
      return {
        { "<leader>ac", function() chat.toggle() end, desc = "Copilot Chat (Toggle)" },
        { "<leader>aq", function() chat.ask() end, desc = "Ask About Current Buffer" },

        -- Visual Mode: ask Copilot about selection
        { "gax", function() chat.ask("Explain") end, mode = { "v" }, desc = "Explain Selection" },
        { "gaf", function() chat.ask("Fix") end,     mode = { "v" }, desc = "Fix Selection" },
        { "gat", function() chat.ask("Tests") end,   mode = { "v" }, desc = "Generate Tests" },
      }
    end,

    opts = {
      window = {
        layout = "float",
        width = 0.45,
        height = 0.80,
        border = "rounded",
      },
      mappings = {
        close = "q",
        submit_prompt = "<CR>",
      },
      context = "buffer",  -- use current buffer as default context
    },
  },
}

