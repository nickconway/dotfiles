return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
    },
    config = function()
        local colors = require("onedark.colors")
        local transparent = require("lualine.themes.onedark")

        transparent.normal.a.bg = "none"
        transparent.normal.a.fg = colors.grey
        transparent.normal.b.bg = "none"
        transparent.normal.b.fg = colors.grey
        transparent.normal.c.bg = "none"
        transparent.normal.c.fg = colors.grey
        transparent.inactive.c.bg = "none"

        local lualine_sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = {
                { 'filename', path = 1 },
                {
                    require("noice").api.statusline.mode.get,
                    cond = require("noice").api.statusline.mode.has,
                    fmt = function(name, _)
                        name = name:gsub("INSERT", "")
                        name = name:gsub("VISUAL", "")
                        name = name:gsub(" LINE", "")
                        name = name:gsub("-- --", "")
                        return name
                    end
                },
            },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        }

        local winbar_sections = {
            lualine_c = {
                {
                    function()
                        return require("nvim-navic").get_location()
                    end,
                    cond = function()
                        return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
                    end,
                },
            },
        }

        require("lualine").setup({
            options = {
                disabled_filetypes = {
                    statusline = { 'alpha' },
                    tabline = { 'alpha' },
                    winbar = { 'alpha' },
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
            winbar = winbar_sections,
            inactive_winbar = winbar_sections,
        })
    end,
}
