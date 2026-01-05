-- Luacheck configuration for Neovim config
-- https://luacheck.readthedocs.io/en/stable/config.html

-- Use LuaJIT standard (same as Neovim)
std = "luajit"

-- Recognize 'vim' as a global
globals = {
	"vim",
}

-- Ignore warnings about line length
ignore = {
	"631", -- Line is too long
}

-- Don't report unused self arguments in methods
self = false
