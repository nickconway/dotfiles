return {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
    config = function()
        require("null-ls").setup({
            -- sources = {
            --     require("null-ls").builtins.code_actions.eslint,
            --     require("null-ls").builtins.diagnostics.eslint,
            --     require("null-ls").builtins.formatting.prettier,
            --     require("null-ls").builtins.formatting.black,
            -- },
        })

        require("mason-null-ls").setup({
            ensure_installed = {},
            automatic_installation = true,
            handlers = {},
        })
    end,
}
