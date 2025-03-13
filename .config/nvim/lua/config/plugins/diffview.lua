return {
    "sindrets/diffview.nvim",
    command = "DiffviewOpen",
    opts = {
        enhanced_diff_hl = true,
        view = {
            merge_tool = {
                layout = "diff3_mixed",
            }
        }
    }
}
