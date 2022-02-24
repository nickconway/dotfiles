require('lualine').setup{
    options = {
        theme = 'transparent_onedark',
        section_separators = {left = '', right = ''},
        component_separators = {left = '', right = ''},
        padding = 1
    },
    sections = {
        lualine_x = {'tabs', 'encoding', 'fileformat', 'filetype'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
}
