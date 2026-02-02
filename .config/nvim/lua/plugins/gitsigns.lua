return {
    "lewis6991/gitsigns.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "purarue/gitsigns-yadm.nvim",
            opts = {
                yadm_repo_git = vim.fn.system("yadm user-config"),
            },
        },
    },
    event = "BufEnter",
    keys = {
        { "<leader>gn", "<cmd>Gitsigns next_hunk<CR>", desc = "Next hunk" },
        { "<leader>gh", "<cmd>Gitsigns preview_hunk_inline<CR>", desc = "Preview hunk" },
        { "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>", desc = "Previous hunk" },
    },
    config = function()
        require("gitsigns").setup({
            current_line_blame = true,
            attach_to_untracked = true,
            numhl = true,
            _on_attach_pre = function(bufnr, callback)
                if vim.fn.executable("yadm") == 1 then
                    require("gitsigns-yadm").yadm_signs(callback, { bufnr = bufnr })
                else
                    callback()
                end
            end,
        })
    end,
}
