return {
    "lewis6991/gitsigns.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = "BufEnter",
    keys = {
        { "<leader>gn", "<cmd>Gitsigns next_hunk<CR>", desc = "Next hunk" },
        { "<leader>gh", "<cmd>Gitsigns preview_hunk_inline<CR>", desc = "Preview hunk" },
        { "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>", desc = "Previous hunk" },
    },
    opts = {
        current_line_blame = true,
        attach_to_untracked = true,
        numhl = true,
        worktrees = {
            {
                toplevel = vim.fn.system("yadm enter 'git config get core.worktree'"),
                gitdir = vim.fn.system("yadm user-config -d"),
            },
        }
    },
}
