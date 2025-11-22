return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			sh = { "shfmt" },
		},
		default_format_opts = {
			async = false,
			lsp_format = "fallback",
		},
	},
}
