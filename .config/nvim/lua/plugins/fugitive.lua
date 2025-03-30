return {
    "tpope/vim-fugitive",
    dependencies = {
        "tpope/vim-rhubarb"
    },
    keys = {
        { "<leader>ga",  "<cmd>Git add %<CR>",          desc = "Git add current file" },
        { "<leader>gA",  "<cmd>Git add --all<CR>",      desc = "Git add all files" },
        { "<leader>gb",  "<cmd>Git branch<CR>",         desc = "Git branch" },
        { "<leader>gcc", "<cmd>Git commit -v<CR>",      desc = "Git commit" },
        { "<leader>gca", "<cmd>Git commit -a -v<CR>",   desc = "Git commit --all" },
        { "<leader>gcm", [[:Git commit -a m ""<Left>]], desc = "Git commit -m",       silent = false },
        { "<leader>gcM", [[:Git commit -a m ""<Left>]], desc = "Git commit -a -m",    silent = false },
        { "<leader>gG",  "<cmd>Git<CR>",                desc = "Git Status" },
        { "<leader>gB",  "<cmd>GBrowse<CR>",            desc = "Git Browse",          mode = "n" },
        { "<leader>gB",  "<ESC><cmd>'<,'>GBrowse<CR>",  desc = "Git Browse",          mode = "x" },
    },
}
