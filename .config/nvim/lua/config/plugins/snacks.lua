return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    --@type snacks.Config
    opts = {
        animate = { enabled = true },
        bigfile = { enabled = true },
        bufdelete = { enabled = true },

        dashboard = {
            enabled = true,
            preset = {
                header = [[
⠭⠵⠖⠀⠀⠀⠀⠀⠀⠀⠠⠀⠠⠀⡠⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠄⠠⠀⠀⠀
⠀⠂⠀⠀⠀⠀⠀⢀⡀⠀⠀⠁⢠⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠠⠀⠀⠔⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢦⠀⠀⠀⠀⠀⠀⠀⠀⡀⠉⠳⢦⣀⠀⠀⠀⠁⠀⠈⣐⠲⠶
⠀⠀⣀⠠⣒⣼⡵⠋⠀⠀⠀⡴⢃⠀⠀⠀⠀⠀⢀⠐⠀⠀⠀⠀⠀⠀⠈⠀⠁⠀⠀⠣⠀⠀⠀⠀⠂⠀⠀⠀⠀⠀⠀⠂⡀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠈⠑⠦⣀⠀⠀⠀⠐⠁⠢
⡶⠞⠊⣽⡵⠟⠁⠀⠀⣀⡞⠀⠀⠀⠀⠀⠀⡠⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠀⠀⠀⠀⠈⠀⠑⢄⠀⠀⠀⠀⠉⠒⠤⢀⠀⠀
⠀⣠⢟⠟⠁⠀⠀⢀⠄⡼⢀⠀⠀⢠⠀⠀⡔⠀⠠⢀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⢀⠁⠢⡀⠀⠀⠠⢀⣀⠀⠀
⡼⠡⠂⠀⠀⣀⡴⡱⢊⠁⠀⠀⠀⠂⠀⡜⠀⣆⢠⣼⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⠀⠀⠀⠀⠀⡀⡀⠀⢦⡀⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡈⠣⡐⢄⡑⠂⠀⠀⢹⣿⢟
⠀⠁⢀⠤⢊⠏⡰⢁⠊⠀⠄⠀⠀⠀⢰⠃⠘⢨⣽⣿⠀⣸⠀⠀⢻⠀⠀⠀⠀⠀⠀⠀⠐⠀⠤⡀⠀⠣⠂⠀⠀⢆⠀⠀⠐⡄⠀⠁⠂⢢⠀⠀⠀⠀⢀⠑⣄⠀⠀⠻⣦⡈⠢⠈⠢⣀⠢⡀⢣⠑
⣠⠔⠁⠠⠂⠐⡡⠃⢀⠔⠀⠀⠀⠀⡎⠀⡇⡞⣿⣿⠀⢿⣼⢠⣸⣇⠀⠘⣤⡀⠀⢃⣆⠐⡌⣶⠄⠀⢷⣀⠀⠈⢷⣄⡠⠽⣴⡀⠀⠳⡃⠀⠀⠈⠪⢢⡈⢵⣄⠀⠹⡷⡄⠀⢡⡙⢇⠠⠀⢣
⠁⠀⠀⠀⠰⡴⠁⠀⠙⠀⡄⠀⡄⢀⠇⢀⢁⣿⣿⣿⡾⡞⣿⢸⣿⡿⡄⠀⢹⢳⠀⠘⡼⣆⢸⣼⣿⣦⠈⢿⣧⠀⠈⢿⣷⣄⠹⣧⡀⠀⠙⣄⠠⡀⠀⠈⢳⣄⢻⣷⣤⡙⣌⢦⡀⢳⣮⡳⣤⠀
⠀⠀⠀⢀⡖⠁⠀⠀⠀⠸⠀⠐⠇⡀⢀⣾⣼⣿⣿⣿⣿⣧⣿⡆⣿⣷⣷⡀⠈⣿⣧⠀⢷⣏⢦⢹⣼⡿⣷⣌⢟⢷⡄⠘⣿⣿⣦⡙⣷⡀⡀⠘⣄⠩⣂⠀⠸⣿⠿⠷⠀⢀⡝⠾⢟⢄⠻⡏⠛⠊
⠀⠀⠀⡜⠑⠀⠀⠀⠀⠀⢀⠜⢠⠇⣿⣿⣿⡏⢹⢹⣿⣿⣿⣽⣿⡟⣿⣷⠀⢹⣿⢧⢸⣿⡀⣳⣯⢷⣟⣿⣯⣿⣻⣦⣹⣍⣿⣿⣾⣷⣄⠀⠺⣆⠹⣦⣷⣽⣰⣦⣀⠹⣧⠀⢸⣾⣏⠙⠄⠀
⠀⠀⢠⠅⠀⠀⠀⠀⠀⠀⡞⠀⡜⢰⢹⣿⢻⣇⠀⠈⣿⣿⣿⣾⣿⣇⠻⡇⢣⢸⣿⠈⢧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠛⣿⠿⣿⡿⣿⣿⣦⡀⠣⠣⡸⢷⣽⣿⣞⢿⠀⢻⠀⠀⣏⢿⡄⠀⠀
⠀⠀⠈⠀⠀⠀⠀⠀⠀⢰⠁⢀⠁⣸⣿⡁⠆⢻⣆⠀⠙⢿⣿⣿⣿⡈⠀⠻⡌⢻⣏⠆⠼⢿⠁⠀⢿⣿⣿⣿⣿⣿⡿⠁⠀⠈⣰⡟⠃⠀⣹⣿⣝⣠⣷⠉⢢⡝⠘⢻⠟⠀⣼⠀⠀⣿⢦⢻⡄⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⡆⠀⣼⠀⢸⣿⣷⠀⠀⠻⣦⡀⠀⠉⠉⠀⠁⠀⠀⠁⠈⠻⠀⠀⠈⠀⢀⠈⠙⠻⠿⠟⠋⠀⠀⣠⡾⠋⠀⠀⠐⢻⣿⡍⣽⡇⣀⠼⠑⡠⠐⢀⠌⠈⢀⡴⠋⠀⠈⠋⣄
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⠀⠀⠰⢸⠘⢹⣧⠀⠀⠈⠻⠷⡶⠤⠂⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣶⣶⣤⣤⣶⡶⠟⠋⠀⠠⠐⠀⠀⣸⣿⣇⣿⡿⠤⡤⠂⢀⡴⢃⣠⣾⡍⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠘⠀⢹⢿⡄⠀⠀⡆⠀⠀⠀⠀⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⢲⣾⣿⣿⣿⣿⡶⠒⠀⠀⠈⠁⠐⢤⡀⠀⣿⣿⡿⢿⠴⠒⠒⢛⣴⢻⡋⠉⢿⡀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠈⣷⢀⠐⠀⠀⠀⠀⠻⣭⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⠋⠉⠁⠀⠀⠀⡇⠀⠀⢠⣄⣤⣿⡇⠀⠀⠀⣠⡞⠹⠋⠸⠀⠀⠀⠁⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⡟⠃⠀⠀⠀⠀⠀⠘⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⣿⠀⠀⠰⠆⠀⠀⠁⠀⡀⣸⣿⣟⣿⣿⡷⣶⠏⣿⣧⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢦⡀⠀⠀⠀⠀⠀⢀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢾⠀⠀⢰⡇⠀⣀⣴⠟⠀⣿⣿⣿⣿⣿⣧⣿⢀⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠢⣄⠀⠀⠀⠀⠻⠯⠟⠳⠆⠀⠀⠀⠀⠀⠀⣼⠇⠀⣨⣵⠾⠋⠁⣠⣾⣿⣿⣿⣿⣿⡟⢻⣼⠉⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣾⣿⠛⣁⣤⣶⣿⣿⣿⣿⣿⣿⣿⠁⠁⠈⢿⠀⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣷⣤⡀⠀⠀⠀⠀⣀⣤⣶⣿⣿⡿⣻⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣶⣶⣶⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣈⠛⠷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⡄⠀⠉⠳⠦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠉⠀⢀⡀⠀⠠⠚⠙⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⢁⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠛⠁⠀⠀⠀⠀⢠⠊⠀⠊⠀⠀⠠⠀⠈⠙⢲⡀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠼⢁⣴⢯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⠀⠀⠀⠀⠀⠀⡐⠀⠈⠀⠀⠀⠁⠀⠀⠀⠀⠈⣇⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⢋⣴⠟⣱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠁⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡄⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⢏⡔⣻⠋⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠁⠀⠐⡀⠀⣤⣤⣲⡴⠖⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣄⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡖⡣⢋⡼⠃⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⠄⠀⠀⣾⣷⣾⠿⠋⠀⠀⠀⡠⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢦⣀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠟⣀⡞⠁⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⡀⠀⠉⠛⠟⠀⠀⠀⠀⠚⢠⣴⢦⠴⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠲⠬⣕
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢃⢴⠏⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀⠀⠀⠀⡀⠀⠀⠁⠀⠀⠀⠀⣰⣴⣶⣿⠦⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⢧⣾⠏⠀⠀⣴⠀⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⢰⣦⣴⠶⠀⠀⠀⠀⠀⠀⠀⠀⠙⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⢫⠏⠀⠀⠘⣿⠀⠻⣿⣿⡿⠏⠀⠀⠐⠲⠃⠀⠀⠙⠉⠀⠀⠀⠸⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⢀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡿⢁⡞⠀⠀⠀⣼⣿⣁⠀⠈⠉⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠐⠟⠁⠀⠔⠀⠀⠀⠀⠀⠀⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ]],

                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('smart')" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
            sections = {
                { section = "header" },
                { section = "keys",         gap = 1,                padding = 1 },
                { section = "recent_files", title = "Recent Files", gap = 1,    padding = 1, indent = 2 },
                { section = "projects",     title = "Projects",     gap = 1,    padding = 1, indent = 2 },
                {
                    icon = " ",
                    title = "Git Status",
                    section = "terminal",
                    enabled = function()
                        return Snacks.git.get_root() ~= nil
                    end,
                    cmd = "git status --short --branch --renames",
                    padding = 1,
                    indent = 3,
                },
                {
                    icon = " ",
                    title = "Git Status",
                    section = "terminal",
                    enabled = function()
                        return Snacks.git.get_root() == nil and vim.fn.getcwd():find(vim.fn.getenv("HOME"), 1, true) == 1
                    end,
                    cmd = "yadm status --short --branch --renames",
                    padding = 1,
                    indent = 3,
                },
                { section = "startup" },
            },
        },

        debug = { enabled = true },
        explorer = {
            enabled = true,
            replace_netrw = true
        },
        git = { enabled = true },
        gitbrowse = { enabled = true },
        image = {
            enabled = true,
            formats = { "png", "jpg", "jpeg", "gif", "bmp", "webp", "tiff", "heic", "avif", "mp4", "mov", "avi", "mkv", "webm" },
            force = false, -- try displaying the image, even if the terminal does not support it
            markdown = {
                -- enable image viewer for markdown files
                -- if your env doesn't support unicode placeholders, this will be disabled
                enabled = true,
                max_width = 80,
                max_height = 40,
            },
            -- window options applied to windows displaying image buffers
            -- an image buffer is a buffer with `filetype=image`
            wo = {
                wrap = false,
                number = false,
                relativenumber = false,
                cursorcolumn = false,
                signcolumn = "no",
                foldcolumn = "0",
                list = false,
                spell = false,
                statuscolumn = "",
            }
        },

        indent = { enabled = true },

        input = {
            enabled = true,
            icon = " ",
            icon_hl = "SnacksInputIcon",
            icon_pos = "left",
            prompt_pos = "title",
            win = { style = "input" },
            expand = true,
        },

        layout = { enabled = true },
        lazygit = { enabled = true },

        picker = {
            enabled = true,
            matcher = {
                frecency = true
            }
        },

        notifier = {
            enabled = true,
            timeout = 3000,
            style = "compact"
        },

        notify = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = {
            enabled = true,
            left = { "mark", "sign", "git", "fold" }, -- priority of signs on the left (high to low)
            right = {},                               -- priority of signs on the right (high to low)
            folds = {
                open = true,                          -- show open fold icons
                git_hl = true,                        -- use Git Signs hl for fold icons
            },
            git = {
                patterns = { "GitSign", "MiniDiffSign" },
            },
            refresh = 50
        },
        words = { enabled = true },
        rename = { enabled = true },
    },
    keys = {
        -- find
        { "<leader>fb", function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff", function() Snacks.picker.smart() end,                                   desc = "Find Files" },
        { "<leader>fl", function() Snacks.picker.grep() end,                                    desc = "Grep" },
        { "<leader>fh", function() Snacks.picker.help() end,                                    desc = "Help" },
        {
            "<leader>fg",
            function()
                if Snacks.git.get_root() ~= nil then
                    Snacks.picker.git_files()
                    return
                end

                require("snacks").picker({
                    finder = "proc",
                    cmd = "yadm",
                    args = { "ls-files" },
                    cwd = "~",
                    title = "YADM Files",
                    transform = function(item)
                        item.file = '~/' .. item.text
                    end,
                })
            end,
            desc = "Find Git Files"
        },
        { "<leader>fp", function() Snacks.picker.projects() end,        desc = "Projects" },
        { "<leader>fr", function() Snacks.picker.recent() end,          desc = "Recent" },
        { "<leader>fn", function() Snacks.picker.notifications() end,   desc = "Notification History" },
        { "<leader>f:", function() Snacks.picker.command_history() end, desc = "Command History" },

        {
            "<leader>fC",
            function()
                vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
                    callback = function(event)
                        if vim.bo[event.buf].filetype == "snacks_picker_input" then
                            local f = io.open(os.getenv("HOME") .. "/.cache/nvim/colorscheme", "w+")
                            if f then
                                vim.defer_fn(function()
                                    f:write(vim.g.colors_name)
                                    if vim.g.colors_name:find("noctu") then
                                        vim.opt.termguicolors = false
                                    else
                                        vim.opt.termguicolors = true
                                    end
                                    f:close()
                                end, 100)
                            end
                        end
                    end
                })

                Snacks.picker.colorschemes()
            end,
            desc = "Colorschemes"
        },

        -- Git
        { "<leader>gb", function() Snacks.picker.git_branches() end,          desc = "Git Branches" },
        { "<leader>gl", function() Snacks.picker.git_log() end,               desc = "Git Log" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end,          desc = "Git Log Line" },
        { "<leader>gs", function() Snacks.picker.git_status() end,            desc = "Git Status" },
        { "<leader>gS", function() Snacks.picker.git_stash() end,             desc = "Git Stash" },
        { "<leader>gd", function() Snacks.picker.git_diff() end,              desc = "Git Diff (Hunks)" },
        { "<leader>gf", function() Snacks.picker.git_log_file() end,          desc = "Git Log File" },

        -- Grep
        { "<leader>sb", function() Snacks.picker.lines() end,                 desc = "Buffer Lines" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end,          desc = "Grep Open Buffers" },
        { "<leader>sg", function() Snacks.picker.grep() end,                  desc = "Grep" },
        { "<leader>sw", function() Snacks.picker.grep_word() end,             desc = "Visual selection or word", mode = { "n", "x" } },

        -- Search
        { '<leader>s"', function() Snacks.picker.registers() end,             desc = "Registers" },
        { '<leader>s/', function() Snacks.picker.search_history() end,        desc = "Search History" },
        { "<leader>sa", function() Snacks.picker.autocmds() end,              desc = "Autocmds" },
        { "<leader>sb", function() Snacks.picker.lines() end,                 desc = "Buffer Lines" },
        { "<leader>sc", function() Snacks.picker.command_history() end,       desc = "Command History" },
        { "<leader>sC", function() Snacks.picker.commands() end,              desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,    desc = "Buffer Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end,                  desc = "Help Pages" },
        { "<leader>sH", function() Snacks.picker.highlights() end,            desc = "Highlights" },
        { "<leader>si", function() Snacks.picker.icons() end,                 desc = "Icons" },
        { "<leader>sj", function() Snacks.picker.jumps() end,                 desc = "Jumps" },
        { "<leader>sk", function() Snacks.picker.keymaps() end,               desc = "Keymaps" },
        { "<leader>sl", function() Snacks.picker.loclist() end,               desc = "Location List" },
        { "<leader>sm", function() Snacks.picker.marks() end,                 desc = "Marks" },
        { "<leader>sM", function() Snacks.picker.man() end,                   desc = "Man Pages" },
        { "<leader>sp", function() Snacks.picker.lazy() end,                  desc = "Search for Plugin Spec" },
        { "<leader>sq", function() Snacks.picker.qflist() end,                desc = "Quickfix List" },
        { "<leader>sR", function() Snacks.picker.resume() end,                desc = "Resume" },
        { "<leader>su", function() Snacks.picker.undo() end,                  desc = "Undo History" },
        { "<leader>uC", function() Snacks.picker.colorschemes() end,          desc = "Colorschemes" },

        -- LSP
        { "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
        { "gD",         function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
        { "gr",         function() Snacks.picker.lsp_references() end,        nowait = true,                     desc = "References" },
        { "gI",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
        { "gy",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
        { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

        -- Other
        { "<leader>a",  function() Snacks.explorer() end,                     desc = "File Explorer" },
        { "<leader>z",  function() Snacks.zen() end,                          desc = "Toggle Zen Mode" },
        { "<leader>Z",  function() Snacks.zen.zoom() end,                     desc = "Toggle Zoom" },
        { "<leader>.",  function() Snacks.scratch() end,                      desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end,               desc = "Select Scratch Buffer" },
        { "<leader>n",  function() Snacks.notifier.show_history() end,        desc = "Notification History" },
        { "<leader>bd", function() Snacks.bufdelete() end,                    desc = "Delete Buffer" },
        { "<leader>bD", function() Snacks.bufdelete.all() end,                desc = "Delete All Buffers" },
        { "<leader>bO", function() Snacks.bufdelete.other() end,              desc = "Delete Other Buffers" },
        { "<leader>cR", function() Snacks.rename.rename_file() end,           desc = "Rename File" },
        { "<leader>gB", function() Snacks.gitbrowse() end,                    desc = "Git Browse",               mode = { "n", "v" } },
        { "<leader>gg", function() Snacks.lazygit() end,                      desc = "Lazygit" },
        { "<leader>un", function() Snacks.notifier.hide() end,                desc = "Dismiss All Notifications" },
        { "<c-/>",      function() Snacks.terminal() end,                     desc = "Toggle Terminal" },
        { "<c-_>",      function() Snacks.terminal() end,                     desc = "which_key_ignore" },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end,       desc = "Next Reference",           mode = { "n", "t" } },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end,      desc = "Prev Reference",           mode = { "n", "t" } },

        {
            "<leader>N",
            desc = "Neovim News",
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                    width = 0.6,
                    height = 0.6,
                    wo = {
                        spell = false,
                        wrap = false,
                        signcolumn = "yes",
                        statuscolumn = " ",
                        conceallevel = 3,
                    },
                })
            end,
        }
    },

    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end

                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                    "<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.indent():map("<leader>ug")
                Snacks.toggle.dim():map("<leader>uD")
            end,
        })
    end
}
