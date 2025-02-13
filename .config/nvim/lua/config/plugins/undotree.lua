return {
	"mbbill/undotree",
	cmd = "UndotreeToggle",
	keys = {
		{ "<leader>U", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" },
	},
	config = function()
		vim.g.undotree_SetFocusWhenToggle = true
	end,
}
