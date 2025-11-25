return {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
        default = {
            dir_path = "assets",
            show_dir_path_in_prompt = true,
            relative_to_current_file = false,
        },
    },
    keys = {
        { "<leader>P", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
}
