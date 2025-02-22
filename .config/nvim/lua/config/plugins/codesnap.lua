local function snap(cmd)
    vim.fn.mkdir(os.getenv("HOME") .. "/Pictures/CodeSnap", "p")
    return "<esc><cmd>" .. cmd .. "<cr>"
end

return {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    keys = {
        {
            "<leader>cc",
            snap("CodeSnapSave"),
            mode = "x",
            desc = "Save selected code snapshot into clipboard"
        },
        {
            "<leader>cC",
            snap("CodeSnapSaveHighlight"),
            mode = "x",
            desc = "Save selected code snapshot into clipboard and highlight"
        },
        {
            "<leader>cA",
            snap("CodeSnapASCII"),
            mode = "x",
            desc = "Save selected code ASCII into clipboard"
        },
    },
    opts = {
        save_path = "~/Pictures/CodeSnap",
        code_font_family = "Hack Nerd Font",
        has_breadcrumbs = true,
        has_line_number = true,
        bg_theme = "summer",
        watermark = "",
        mac_window_bar = false,
        bg_x_padding = 50,
        bg_y_padding = 40,
    },
}
