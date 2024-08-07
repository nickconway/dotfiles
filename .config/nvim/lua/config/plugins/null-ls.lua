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
                stylua = function(source_name, methods)
                    null_ls.register(null_ls.builtins.formatting.stylua)
                end,
            },
        })
        require("null-ls").setup({
            sources = {
                null_ls.builtins.formatting.stylua.with({
                    extra_args = { "--config-path", vim.fn.expand("~/.config/stylua.toml") },
                }),
            },
        })
    end,
}
