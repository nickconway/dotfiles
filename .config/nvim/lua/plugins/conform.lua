return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "black" },
            sh = { "shfmt" },
            javascript = { "prettierd", "prettier" },
            typescript = { "prettierd", "prettier" },
        },
        default_format_opts = {
            async = false,
            lsp_format = "fallback",
        },
    },
}
