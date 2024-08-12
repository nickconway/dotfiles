return {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "jay-babu/mason-null-ls.nvim",
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
                    null_ls.builtins.formatting.shfmt.with({
                        extra_args = { "-i", "1" },
                    })
                end,
                stylua = function()
                    null_ls.builtins.formatting.stylua.with({})
                end,
            },
        })
        require("null-ls").setup({})
    end,
}
