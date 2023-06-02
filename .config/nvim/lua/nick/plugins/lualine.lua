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
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
        }
    end
}
