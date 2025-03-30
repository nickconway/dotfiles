return {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        require("mason-null-ls").setup({
            ensure_installed = {
                "black",
                "prettierd",
                "stylua",
                "shellcheck",
                "shfmt",
                "staticcheck",
            },
            automatic_installation = true,
            handlers = {
                function(source_name, methods)
                    require("mason-null-ls").default_setup(source_name, methods)
                end,
                shfmt = function()
                    null_ls.register(null_ls.builtins.formatting.shfmt.with({
                        extra_args = { "-i", vim.opt.tabstop, "-ci", "-bn" },
                    }))
                end,
                stylua = function()
                    null_ls.register(null_ls.builtins.formatting.stylua.with({
                        condition = function(utils)
                            return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
                        end,
                    }))
                end,
            },
        })
        require("null-ls").setup({
            sources = {
                -- Anything not supported by mason.
            },
        })
    end,
}
