return {
    "tpope/vim-dadbod",
    dependencies = {
        "kristijanhusak/vim-dadbod-ui",
        "kristijanhusak/vim-dadbod-completion",
    },
    cmd = "DBUIToggle",
    keys = {
        { "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
    }
}
