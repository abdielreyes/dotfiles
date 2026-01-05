-- Centralized language configuration
-- Defines LSP servers, formatters, and linters for each language

local M = {}

-- Language configurations
-- Each entry contains:
--   lsp: LSP server name (as used by mason-lspconfig)
--   lsp_pkg: Package name in Mason registry (if different from lsp name)
--   formatters: List of formatter tools (tool names for both nvim-lint and Mason)
--   linters: List of linter names (as used by nvim-lint)
--   linter_pkgs: Optional map of linter name -> Mason package name (when they differ)
--   lsp_config: Optional LSP-specific configuration
M.languages = {
	lua = {
		lsp = "lua_ls",
		lsp_pkg = "lua-language-server",
		formatters = { "stylua" },
		linters = { "luacheck" }, -- Add luacheck for additional linting
		lsp_config = {
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT", -- Neovim uses LuaJIT
					},
					diagnostics = {
						enable = true, -- explicitly enable diagnostics
						globals = { "vim" }, -- recognize 'vim' global
					},
					workspace = {
						checkThirdParty = false,
						-- Make the server aware of Neovim runtime files
						library = {
							vim.env.VIMRUNTIME,
							-- Uncomment below to add all plugins to workspace
							-- "${3rd}/luv/library",
							-- "${3rd}/busted/library",
						},
					},
					telemetry = {
						enable = false, -- don't send telemetry
					},
					format = {
						enable = false, -- use stylua via conform instead
					},
				},
			},
		},
	},

	typescript = {
		lsp = "vtsls",
		formatters = { "prettier" },
		linters = { "eslint_d" },
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		lsp_config = {
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
		},
	},

	svelte = {
		lsp = "svelte",
		lsp_pkg = "svelte-language-server",
		formatters = { "prettier" },
		linters = { "eslint_d" },
		filetypes = { "svelte" },
		lsp_config = {
			settings = {
				svelte = {
					plugin = {
						svelte = { compilerWarnings = { ["a11y-click-events-have-key-events"] = "ignore" } },
					},
				},
			},
		},
	},

	astro = {
		lsp = "astro",
		lsp_pkg = "astro-language-server",
		formatters = { "prettier" },
		linters = {},
		filetypes = { "astro" },
		lsp_config = {
			init_options = {
				typescript = {}, -- Will use the TypeScript installation
			},
			on_attach = function(client, bufnr) end,
		},
	},

	html = {
		lsp = "html",
		lsp_pkg = "html-lsp",
		formatters = { "prettier" },
		linters = {},
		lsp_config = {},
	},

	css = {
		lsp = "cssls",
		lsp_pkg = "css-lsp",
		formatters = { "prettier" },
		linters = {},
		lsp_config = {},
	},

	json = {
		lsp = "jsonls",
		lsp_pkg = "json-lsp",
		formatters = { "prettier" },
		linters = {}, -- JSON LSP provides diagnostics
		lsp_config = {},
	},

	yaml = {
		lsp = "yamlls",
		lsp_pkg = "yaml-language-server",
		formatters = { "prettier" },
		linters = { "yamllint" },
		lsp_config = {},
	},

	tailwindcss = {
		lsp = "tailwindcss",
		lsp_pkg = "tailwindcss-language-server",
		formatters = {},
		linters = {},
		filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
		lsp_config = {
			settings = {
				tailwindCSS = {
					experimental = { classRegex = { "tw`([^`]*)", "tw%(([^)]*)%)" } },
				},
			},
		},
	},

	python = {
		lsp = "pyright",
		formatters = { "black", "isort" },
		linters = { "ruff" },
		lsp_config = {},
	},

	go = {
		lsp = "gopls",
		formatters = { "gofumpt", "goimports" },
		linters = { "golangci-lint" },
		lsp_config = {
			settings = {
				gopls = { gofumpt = true, analyses = { unusedparams = true }, staticcheck = true },
			},
		},
	},

	bash = {
		lsp = "bashls",
		lsp_pkg = "bash-language-server",
		formatters = { "shfmt" },
		linters = { "shellcheck" },
		filetypes = { "sh", "bash" },
		lsp_config = {},
	},

	c_cpp = {
		lsp = "clangd",
		formatters = { "clang-format" },
		linters = {},
		filetypes = { "c", "cpp", "objc", "objcpp" },
		lsp_config = {
			cmd = { "clangd", "--background-index", "--clang-tidy" },
		},
	},

	java = {
		lsp = "jdtls",
		formatters = {},
		linters = {},
		-- Java uses special setup via nvim-jdtls plugin
		use_jdtls_plugin = true,
	},

	ruby = {
		lsp = "ruby_lsp",
		lsp_pkg = "ruby-lsp",
		formatters = { "rubocop" },
		linters = { "rubocop" },
		filetypes = { "ruby" },
		lsp_config = {},
	},

	markdown = {
		lsp = nil, -- No LSP for markdown by default
		formatters = { "prettier" },
		linters = { "markdownlint" }, -- nvim-lint linter name
		linter_pkgs = { markdownlint = "markdownlint-cli2" }, -- Mason package name
	},

	dockerfile = {
		lsp = nil,
		formatters = {},
		linters = { "hadolint" },
	},
}

-- Get list of all LSP servers to install
function M.get_lsp_servers()
	local servers = {}
	for _, lang in pairs(M.languages) do
		if lang.lsp and not lang.use_jdtls_plugin then
			table.insert(servers, lang.lsp)
		end
	end
	return servers
end

-- Get list of all Mason packages (LSPs, formatters, linters)
function M.get_mason_packages()
	local packages = {}
	local seen = {}

	for _, lang in pairs(M.languages) do
		-- Add LSP package
		if lang.lsp then
			local pkg = lang.lsp_pkg or lang.lsp
			if not seen[pkg] then
				table.insert(packages, pkg)
				seen[pkg] = true
			end
		end

		-- Add formatters
		if lang.formatters then
			for _, fmt in ipairs(lang.formatters) do
				if not seen[fmt] then
					table.insert(packages, fmt)
					seen[fmt] = true
				end
			end
		end

		-- Add linters (check for custom Mason package names)
		if lang.linters then
			for _, linter in ipairs(lang.linters) do
				-- Use custom Mason package name if specified, otherwise use linter name
				local pkg = (lang.linter_pkgs and lang.linter_pkgs[linter]) or linter
				if not seen[pkg] then
					table.insert(packages, pkg)
					seen[pkg] = true
				end
			end
		end
	end

	return packages
end

-- Get linters by filetype for nvim-lint
function M.get_linters_by_ft()
	local linters_by_ft = {}

	for lang_key, lang in pairs(M.languages) do
		if lang.linters and #lang.linters > 0 then
			-- Use custom filetypes if specified, otherwise use language key
			local filetypes = lang.filetypes or { lang_key }

			for _, ft in ipairs(filetypes) do
				linters_by_ft[ft] = lang.linters
			end
		end
	end

	return linters_by_ft
end

-- Get formatters by filetype for conform.nvim
function M.get_formatters_by_ft()
	local formatters_by_ft = {}

	for lang_key, lang in pairs(M.languages) do
		if lang.formatters and #lang.formatters > 0 then
			-- Use custom filetypes if specified, otherwise use language key
			local filetypes = lang.filetypes or { lang_key }

			for _, ft in ipairs(filetypes) do
				formatters_by_ft[ft] = lang.formatters
			end
		end
	end

	return formatters_by_ft
end

-- Get LSP configuration for a specific server
function M.get_lsp_config(server_name)
	for _, lang in pairs(M.languages) do
		if lang.lsp == server_name then
			return lang.lsp_config or {}
		end
	end
	return {}
end

return M
