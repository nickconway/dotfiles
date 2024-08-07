return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		require("mason-null-ls").setup({
			ensure_installed = {
				"black",
				"stylua",
				"shellcheck",
				"shfmt",
				"staticcheck",
			},
			automatic_installation = false,
			handlers = {},
		})
		require("null-ls").setup({
			sources = {},
		})
	end,
}
