return {
    "nvim-lualine/lualine.nvim",
    dependencies = {},
    config = function()
        local colors = require("onedark.colors")
        local transparent = require("lualine.themes.onedark")

        transparent.normal.a.bg = nil
        transparent.normal.a.fg = colors.grey
        transparent.normal.b.bg = nil
        transparent.normal.b.fg = colors.grey
        transparent.normal.c.bg = nil
        transparent.normal.c.fg = colors.grey
        transparent.inactive.c.bg = nil

        local lualine_sections = {
            lualine_a = { "mode" },
            lualine_b = { { "filename", path = 1 } },
            lualine_c = {
                "branch",
                "diff",
                "diagnostics",
                {
                    require("noice").api.statusline.mode.get,
                    cond = require("noice").api.statusline.mode.has,
                    fmt = function(name, _)
                        name = name:gsub("INSERT", "")
                        name = name:gsub("VISUAL", "")
                        name = name:gsub(" LINE", "")
                        name = name:gsub("-- --", "")
                        return name
                    end,
                },
            },
            lualine_x = { function()
                return require('lsp-progress').progress()
            end, "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        }

        require("lualine").setup({
            options = {
                disabled_filetypes = {
                    statusline = { "alpha" },
                    tabline = { "alpha" },
                    winbar = { "alpha" },
                },
                ignore_focus = {},
                always_divide_middle = true,
                refresh = {
                    statusline = 500,
                    tabline = 500,
                    winbar = 500,
                },
                theme = transparent,
                section_separators = { left = "|", right = "|" },
                component_separators = { left = "|", right = "|" },
                padding = 1,
                globalstatus = true,
                icons_enabled = true,
            },
            sections = lualine_sections,
            inactive_sections = lualine_sections,
        })
    end,
}
