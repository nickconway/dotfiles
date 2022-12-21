return {
    'nvim-lualine/lualine.nvim',
    config = function()
        local c = require("onedark.colors")
        local transparent = require("lualine.themes.onedark")

        transparent.normal.a.bg = "none"
        transparent.normal.a.fg = c.grey
        transparent.normal.b.bg = "none"
        transparent.normal.b.fg = c.grey
        transparent.normal.c.bg = "none"
        transparent.normal.c.fg = c.grey

        require('lualine').setup {
            options = {
                theme = transparent,
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
                padding = 1,
                globalstatus = true,
            },
            sections = {
                lualine_x = { 'encoding', 'fileformat', 'filetype' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        }
    end
}
