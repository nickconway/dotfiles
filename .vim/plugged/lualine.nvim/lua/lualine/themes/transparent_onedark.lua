local c = require('onedark.colors')
local colors = {
    bg = c.bg0,
    fg = c.fg,
    red = c.red,
    green = c.green,
    yellow = c.yellow,
    blue = c.blue,
    purple = c.purple,
    cyan = c.cyan,
    gray = c.grey
}

local transparent_one_dark = {
    inactive = {
        a = {fg = colors.gray, bg = none, gui = 'bold'},
        b = {fg = colors.gray, bg = none},
        c = {fg = colors.gray, bg = none},
        x = {fg = colors.gray, bg = none},
        y = {fg = colors.gray, bg = none},
        z = {fg = colors.gray, bg = none},
    },
    normal = {
        a = {fg = colors.gray, bg = none, gui = 'bold'},
        b = {fg = colors.gray, bg = none},
        c = {fg = colors.gray, bg = none},
        x = {fg = colors.gray, bg = none},
        y = {fg = colors.gray, bg = none},
        z = {fg = colors.gray, bg = none},
    },
    visual = {
        a = {fg = colors.bg, bg = colors.purple, gui = 'bold'},
        b = {fg = colors.gray, bg = none, gui = 'bold'},
        c = {fg = colors.gray, bg = none, gui = 'bold'},
        x = {fg = colors.gray, bg = none, gui = 'bold'},
        y = {fg = colors.gray, bg = none, gui = 'bold'},
        z = {fg = colors.gray, bg = none, gui = 'bold'}
    },
    replace = {
        a = {fg = colors.bg, bg = colors.red, gui = 'bold'},
        b = {fg = colors.gray, bg = none, gui = 'bold'},
        c = {fg = colors.gray, bg = none, gui = 'bold'},
        x = {fg = colors.gray, bg = none, gui = 'bold'},
        y = {fg = colors.gray, bg = none, gui = 'bold'},
        z = {fg = colors.gray, bg = none, gui = 'bold'}
    },
    insert = {
        a = {fg = colors.bg, bg = colors.green, gui = 'bold'},
        b = {fg = colors.gray, bg = none, gui = 'bold'},
        c = {fg = colors.gray, bg = none, gui = 'bold'},
        x = {fg = colors.gray, bg = none, gui = 'bold'},
        y = {fg = colors.gray, bg = none, gui = 'bold'},
        z = {fg = colors.gray, bg = none, gui = 'bold'}
    },
    command = {
        a = {fg = colors.bg, bg = colors.yellow, gui = 'bold'},
        b = {fg = colors.gray, bg = none, gui = 'bold'},
        c = {fg = colors.gray, bg = none, gui = 'bold'},
        x = {fg = colors.gray, bg = none, gui = 'bold'},
        y = {fg = colors.gray, bg = none, gui = 'bold'},
        z = {fg = colors.gray, bg = none, gui = 'bold'}
    }
}

return transparent_one_dark;
