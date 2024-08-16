return {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    keys = {
        {
            "<leader>cc",
            "<esc><cmd>lua vim.fn.mkdir(\"" ..
            os.getenv("HOME") .. "/Pictures/CodeSnap\", \"p\")<cr>" .. "<cmd>CodeSnapSave<cr>",
            mode = "x",
            desc = "Save selected code snapshot into clipboard"
        },
        {
            "<leader>cC",
            "<esc><cmd>lua vim.fn.mkdir(\"" ..
            os.getenv("HOME") .. "/Pictures/CodeSnap\", \"p\")<cr>" .. "<cmd>CodeSnapSaveHighlight<cr>",
            mode = "x",
            desc = "Save selected code snapshot into clipboard and highlight"
        },
    },
    opts = {
        save_path = "~/Pictures/CodeSnap",
        code_font_family = "Hack Nerd Font",
        has_breadcrumbs = true,
        bg_theme = "summer",
        watermark = "",
        mac_window_bar = false,
        bg_x_padding = 50,
        bg_y_padding = 40,
    },
}
