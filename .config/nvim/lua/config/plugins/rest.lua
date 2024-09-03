return {
    "rest-nvim/rest.nvim",
    keys = {
        { "<leader>rr", "<cmd>Rest run<cr>", desc = "Rest Run Under Cursor" },
        { "<leader>rl", "<cmd>Rest last<cr>", desc = "Rest Run Last" }
    },
    config = function()
        ---@type rest.Opts
        vim.g.rest_nvim = {
        }
    end
}
