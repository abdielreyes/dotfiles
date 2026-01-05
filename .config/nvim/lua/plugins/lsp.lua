-- LSP stack for Neovim 0.11 using the new native API
-- Configured via centralized language definitions
return {
  { "williamboman/mason.nvim", build = ":MasonUpdate", opts = {} },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = function()
      local languages = require("config.languages")
      return {
        ensure_installed = languages.get_lsp_servers(),
        automatic_installation = true,
      }
    end,
  },

  -- Auto-install all tools (LSPs, formatters, linters) via Mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    opts = function()
      local languages = require("config.languages")
      return {
        ensure_installed = languages.get_mason_packages(),
        auto_update = true,
        run_on_start = true,
      }
    end,
  },

  { "mfussenegger/nvim-jdtls", ft = { "java" } },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local languages = require("config.languages")

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then capabilities = cmp_lsp.default_capabilities(capabilities) end

      -- Disable formatting from certain LSPs to avoid conflicts with conform.nvim
      local disable_format_for = {
        ["vtsls"] = true,
        ["tsserver"] = true,
        ["html"] = true,
        ["cssls"] = true,
        ["jsonls"] = true,
        ["yamlls"] = true,
        ["lua_ls"] = true,
        ["pyright"] = true,
        ["gopls"] = true,
      }

      local function on_attach(client, bufnr)
        -- Disable formatting for servers where conform.nvim handles it
        if disable_format_for[client.name] then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
        end

        -- LSP navigation
        map("n", "<leader>cd", vim.lsp.buf.definition, "Go to Definition")
        map("n", "<leader>cr", vim.lsp.buf.references, "Go to References")
        map("n", "<leader>cD", vim.lsp.buf.declaration, "Go to Declaration")
        map("n", "<leader>ci", vim.lsp.buf.implementation, "Go to Implementation")
        map("n", "<leader>ct", vim.lsp.buf.type_definition, "Go to Type Definition")

        -- LSP actions
        map("n", "<leader>ch", vim.lsp.buf.hover, "Hover Documentation")
        map("n", "<leader>cs", vim.lsp.buf.signature_help, "Signature Help")
        map("n", "<leader>cn", vim.lsp.buf.rename, "Rename Symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format Buffer")
        map("v", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format Selection")

        -- LSP diagnostics
        map("n", "<leader>ce", vim.diagnostic.open_float, "Show Line Diagnostics")
        map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
        map("n", "<leader>cq", vim.diagnostic.setloclist, "Diagnostics to Location List")
      end

      -- Keep track of servers we define
      local defined = {}

      local function define(server, cfg)
        cfg = cfg or {}
        cfg.capabilities = vim.tbl_deep_extend("force", cfg.capabilities or {}, capabilities)
        if cfg.on_attach then
          local user = cfg.on_attach
          cfg.on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            user(client, bufnr)
          end
        else
          cfg.on_attach = on_attach
        end
        vim.lsp.config(server, cfg)
        table.insert(defined, server)
      end

      -- Dynamically configure all LSP servers from language config
      for _, lang in pairs(languages.languages) do
        if lang.lsp and not lang.use_jdtls_plugin then
          define(lang.lsp, lang.lsp_config)
        end
      end

      -- Enable all configured servers
      vim.lsp.enable(defined)

      -- Java via nvim-jdtls (special setup)
      local ok_jdtls, jdtls = pcall(require, "jdtls")
      if ok_jdtls then
        local function start_jdtls()
          local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
          local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name
          local mason = vim.fn.stdpath("data") .. "/mason"
          local jdtls_base = mason .. "/packages/jdtls"
          local launcher = vim.fn.glob(jdtls_base .. "/plugins/org.eclipse.equinox.launcher_*.jar")

          -- auto-detect platform dir for jdtls
          local uname = (vim.uv or vim.loop).os_uname().sysname
          local config_dir = jdtls_base .. (uname == "Darwin" and "/config_mac"
                                            or uname == "Windows_NT" and "/config_win"
                                            or "/config_linux")

          local cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true", "-Dlog.level=ALL",
            "-Xms1g", "--add-modules=ALL-SYSTEM",
            "--add-opens", "java.base/java.util=ALL-UNNAMED",
            "--add-opens", "java.base/java.lang=ALL-UNNAMED",
            "-jar", launcher, "-configuration", config_dir, "-data", workspace_dir,
          }

          local function on_attach_java(client, bufnr)
            on_attach(client, bufnr)
            jdtls.setup_dap({ hotcodereplace = "auto" })
            jdtls.setup.add_commands()
          end

          jdtls.start_or_attach({
            cmd = cmd,
            on_attach = on_attach_java,
            capabilities = capabilities,
            root_dir = jdtls.setup.find_root({ "gradlew", "mvnw", ".git" }),
            settings = {
              java = {
                configuration = { updateBuildConfiguration = "interactive" },
                format = { enabled = false },
              },
            },
          })
        end

        vim.api.nvim_create_autocmd("FileType", {
          pattern = "java",
          callback = start_jdtls,
        })
      end
    end,
  },
}

