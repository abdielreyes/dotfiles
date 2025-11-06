-- LSP stack for Neovim 0.11 using the new native API
return {
  { "williamboman/mason.nvim", build = ":MasonUpdate", opts = {} },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "vtsls", "eslint", "html", "cssls", "tailwindcss", "jsonls", "yamlls",
        "lua_ls", "pyright", "gopls", "bashls", "clangd",
      },
      automatic_installation = true,
    },
  },

  { "mfussenegger/nvim-jdtls", ft = { "java" } },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then capabilities = cmp_lsp.default_capabilities(capabilities) end

      local function on_attach(_, bufnr)
        local function map(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr })
        end
        map("n", "gd", vim.lsp.buf.definition)
        map("n", "gr", vim.lsp.buf.references)
        map("n", "K",  vim.lsp.buf.hover)
        map("n", "<leader>rn", vim.lsp.buf.rename)
        map("n", "<leader>ca", vim.lsp.buf.code_action)
        map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end)
      end

      -- NEW: keep track of servers we define
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
        table.insert(defined, server)  -- NEW: record server name
      end

      -- Servers
      define("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            format = { enable = false },
          },
        },
      })

      define("vtsls", {
        settings = {
          vtsls = { tsserver = { globalPlugins = {} } },
          typescript = {
            preferences = { importModuleSpecifier = "non-relative" },
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayVariableTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
            },
          },
          javascript = { inlayHints = { includeInlayParameterNameHints = "all" } },
        },
      })

      define("eslint", { settings = { workingDirectory = { mode = "auto" } } })


      define("html", {})
      define("cssls", {})
      define("jsonls", {})
      define("yamlls", {})

      define("tailwindcss", {
        settings = {
          tailwindCSS = {
            experimental = { classRegex = { "tw`([^`]*)", "tw%(([^)]*)%)" } },
          },
        },
      })

      define("pyright", {})

      define("gopls", {
        settings = {
          gopls = { gofumpt = true, analyses = { unusedparams = true }, staticcheck = true },
        },
      })

      define("bashls", {})

      define("clangd", {
        cmd = { "clangd", "--background-index", "--clang-tidy" },
      })

      -- NEW: enable all servers we defined (fixes your error)
      vim.lsp.enable(defined)

      -- Java via nvim-jdtls (unchanged)
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

