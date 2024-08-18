return {
	"mbbill/undotree",
	cmd = "UndotreeToggle",
	keys = {
		{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" },
	},
	config = function()
		vim.g.undotree_SetFocusWhenToggle = true
	end,
}
