return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}, -- this is equalent to setup({}) function
    },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = true,
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },
    {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup({
                easing_function = "circular", -- Default easing function
            })
        end,
    },
    {
        "numToStr/Comment.nvim",
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    {
        "nmac427/guess-indent.nvim",
        config = function()
            require("guess-indent").setup({
                auto_cmd = true,
                override_editorconfig = false,
            })
        end,
    },
}
