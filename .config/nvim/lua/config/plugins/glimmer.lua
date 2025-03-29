local function animation(color)
    return {
        name = "fade",
        settings = {
            from_color = color,
            to_color = "Normal",
            max_duration = 500,
            min_duration = 500,
        }
    }
end

return {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    opts = {
        enabled = true,
        disable_warnings = false,

        default_animation = animation,
        refresh_interval_ms = 6,

        overwrite = {
            auto_map = true,

            yank = {
                enabled = true,
                default_animation = animation(),
            },
            search = {
                enabled = true,
                next_mapping = "nzzzv",
                prev_mapping = "Nzzzv",
                default_animation = animation(),
            },
            paste = {
                enabled = true,
                paste_mapping = "p",
                Paste_mapping = "P",
                default_animation = animation(),
            },
            undo = {
                enabled = true,
                undo_mapping = "u",
                default_animation = animation("DiffDelete"),
            },
            redo = {
                enabled = true,
                redo_mapping = "<c-r>",
                default_animation = animation("DiffAdd"),
            },
        },
        transparency_color = "#000000",
        virt_text = {
            priority = 2048,
        }
    }
}
