return {
    "goolord/alpha-nvim",
    opts = function()
        local function is_git_repo()
            vim.fn.system("git rev-parse --is-inside-work-tree")
            return vim.v.shell_error == 0
        end

        local function get_git_root()
            local dot_git_path = vim.fn.finddir(".git", ".;")
            return vim.fn.fnamemodify(dot_git_path, ":h")
        end

        local builtin = require("telescope.builtin")
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local function get_files()
            if vim.fn.getcwd() == vim.fn.getenv("HOME") then
                local topts = {}

                topts.entry_maker = function(entry)
                    local str = entry
                    str = string.gsub(str, ".config/yadm/alt/", "")
                    str = string.gsub(str, "##template.*", "")
                    return {
                        value = string.format("%s/%s", vim.fn.getenv("HOME"), entry),
                        display = str,
                        ordinal = entry,
                    }
                end

                pickers
                    .new(topts, {
                        prompt_title = "Yadm Files",
                        finder = finders.new_oneshot_job({ "get-yadm-files" }, topts),
                        previewer = conf.file_previewer(topts),
                        sorter = conf.file_sorter(topts),
                    })
                    :find()
            elseif is_git_repo() then
                builtin.git_files({ cwd = get_git_root() })
            else
                builtin.find_files()
            end
        end

        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.header.val = {
            [[⠭⠵⠖⠀⠀⠀⠀⠀⠀⠀⠠⠀⠠⠀⡠⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠄⠠⠀⠀⠀  ]],
            [[⠀⠂⠀⠀⠀⠀⠀⢀⡀⠀⠀⠁⢠⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠠⠀⠀⠔⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢦⠀⠀⠀⠀⠀⠀⠀⠀⡀⠉⠳⢦⣀⠀⠀⠀⠁⠀⠈⣐⠲⠶]],
            [[⠀⠀⣀⠠⣒⣼⡵⠋⠀⠀⠀⡴⢃⠀⠀⠀⠀⠀⢀⠐⠀⠀⠀⠀⠀⠀⠈⠀⠁⠀⠀⠣⠀⠀⠀⠀⠂⠀⠀⠀⠀⠀⠀⠂⡀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠈⠑⠦⣀⠀⠀⠀⠐⠁⠢]],
            [[⡶⠞⠊⣽⡵⠟⠁⠀⠀⣀⡞⠀⠀⠀⠀⠀⠀⡠⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠀⠀⠀⠀⠈⠀⠑⢄⠀⠀⠀⠀⠉⠒⠤⢀⠀⠀]],
            [[⠀⣠⢟⠟⠁⠀⠀⢀⠄⡼⢀⠀⠀⢠⠀⠀⡔⠀⠠⢀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⢀⠁⠢⡀⠀⠀⠠⢀⣀⠀⠀]],
            [[⡼⠡⠂⠀⠀⣀⡴⡱⢊⠁⠀⠀⠀⠂⠀⡜⠀⣆⢠⣼⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⠀⠀⠀⠀⠀⡀⡀⠀⢦⡀⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡈⠣⡐⢄⡑⠂⠀⠀⢹⣿⢟]],
            [[⠀⠁⢀⠤⢊⠏⡰⢁⠊⠀⠄⠀⠀⠀⢰⠃⠘⢨⣽⣿⠀⣸⠀⠀⢻⠀⠀⠀⠀⠀⠀⠀⠐⠀⠤⡀⠀⠣⠂⠀⠀⢆⠀⠀⠐⡄⠀⠁⠂⢢⠀⠀⠀⠀⢀⠑⣄⠀⠀⠻⣦⡈⠢⠈⠢⣀⠢⡀⢣⠑]],
            [[⣠⠔⠁⠠⠂⠐⡡⠃⢀⠔⠀⠀⠀⠀⡎⠀⡇⡞⣿⣿⠀⢿⣼⢠⣸⣇⠀⠘⣤⡀⠀⢃⣆⠐⡌⣶⠄⠀⢷⣀⠀⠈⢷⣄⡠⠽⣴⡀⠀⠳⡃⠀⠀⠈⠪⢢⡈⢵⣄⠀⠹⡷⡄⠀⢡⡙⢇⠠⠀⢣]],
            [[⠁⠀⠀⠀⠰⡴⠁⠀⠙⠀⡄⠀⡄⢀⠇⢀⢁⣿⣿⣿⡾⡞⣿⢸⣿⡿⡄⠀⢹⢳⠀⠘⡼⣆⢸⣼⣿⣦⠈⢿⣧⠀⠈⢿⣷⣄⠹⣧⡀⠀⠙⣄⠠⡀⠀⠈⢳⣄⢻⣷⣤⡙⣌⢦⡀⢳⣮⡳⣤⠀]],
            [[⠀⠀⠀⢀⡖⠁⠀⠀⠀⠸⠀⠐⠇⡀⢀⣾⣼⣿⣿⣿⣿⣧⣿⡆⣿⣷⣷⡀⠈⣿⣧⠀⢷⣏⢦⢹⣼⡿⣷⣌⢟⢷⡄⠘⣿⣿⣦⡙⣷⡀⡀⠘⣄⠩⣂⠀⠸⣿⠿⠷⠀⢀⡝⠾⢟⢄⠻⡏⠛⠊]],
            [[⠀⠀⠀⡜⠑⠀⠀⠀⠀⠀⢀⠜⢠⠇⣿⣿⣿⡏⢹⢹⣿⣿⣿⣽⣿⡟⣿⣷⠀⢹⣿⢧⢸⣿⡀⣳⣯⢷⣟⣿⣯⣿⣻⣦⣹⣍⣿⣿⣾⣷⣄⠀⠺⣆⠹⣦⣷⣽⣰⣦⣀⠹⣧⠀⢸⣾⣏⠙⠄⠀]],
            [[⠀⠀⢠⠅⠀⠀⠀⠀⠀⠀⡞⠀⡜⢰⢹⣿⢻⣇⠀⠈⣿⣿⣿⣾⣿⣇⠻⡇⢣⢸⣿⠈⢧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠛⣿⠿⣿⡿⣿⣿⣦⡀⠣⠣⡸⢷⣽⣿⣞⢿⠀⢻⠀⠀⣏⢿⡄⠀⠀]],
            [[⠀⠀⠈⠀⠀⠀⠀⠀⠀⢰⠁⢀⠁⣸⣿⡁⠆⢻⣆⠀⠙⢿⣿⣿⣿⡈⠀⠻⡌⢻⣏⠆⠼⢿⠁⠀⢿⣿⣿⣿⣿⣿⡿⠁⠀⠈⣰⡟⠃⠀⣹⣿⣝⣠⣷⠉⢢⡝⠘⢻⠟⠀⣼⠀⠀⣿⢦⢻⡄⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⡆⠀⣼⠀⢸⣿⣷⠀⠀⠻⣦⡀⠀⠉⠉⠀⠁⠀⠀⠁⠈⠻⠀⠀⠈⠀⢀⠈⠙⠻⠿⠟⠋⠀⠀⣠⡾⠋⠀⠀⠐⢻⣿⡍⣽⡇⣀⠼⠑⡠⠐⢀⠌⠈⢀⡴⠋⠀⠈⠋⣄]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⠀⠀⠰⢸⠘⢹⣧⠀⠀⠈⠻⠷⡶⠤⠂⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣶⣶⣤⣤⣶⡶⠟⠋⠀⠠⠐⠀⠀⣸⣿⣇⣿⡿⠤⡤⠂⢀⡴⢃⣠⣾⡍⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠘⠀⢹⢿⡄⠀⠀⡆⠀⠀⠀⠀⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⢲⣾⣿⣿⣿⣿⡶⠒⠀⠀⠈⠁⠐⢤⡀⠀⣿⣿⡿⢿⠴⠒⠒⢛⣴⢻⡋⠉⢿⡀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠈⣷⢀⠐⠀⠀⠀⠀⠻⣭⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⠋⠉⠁⠀⠀⠀⡇⠀⠀⢠⣄⣤⣿⡇⠀⠀⠀⣠⡞⠹⠋⠸⠀⠀⠀⠁⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⡟⠃⠀⠀⠀⠀⠀⠘⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⣿⠀⠀⠰⠆⠀⠀⠁⠀⡀⣸⣿⣟⣿⣿⡷⣶⠏⣿⣧⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢦⡀⠀⠀⠀⠀⠀⢀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢾⠀⠀⢰⡇⠀⣀⣴⠟⠀⣿⣿⣿⣿⣿⣧⣿⢀⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠢⣄⠀⠀⠀⠀⠻⠯⠟⠳⠆⠀⠀⠀⠀⠀⠀⣼⠇⠀⣨⣵⠾⠋⠁⣠⣾⣿⣿⣿⣿⣿⡟⢻⣼⠉⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣾⣿⠛⣁⣤⣶⣿⣿⣿⣿⣿⣿⣿⠁⠁⠈⢿⠀⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣷⣤⡀⠀⠀⠀⠀⣀⣤⣶⣿⣿⡿⣻⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣶⣶⣶⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣈⠛⠷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⡄⠀⠉⠳⠦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠉⠀⢀⡀⠀⠠⠚⠙⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⢁⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠛⠁⠀⠀⠀⠀⢠⠊⠀⠊⠀⠀⠠⠀⠈⠙⢲⡀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠼⢁⣴⢯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⠀⠀⠀⠀⠀⠀⡐⠀⠈⠀⠀⠀⠁⠀⠀⠀⠀⠈⣇⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⢋⣴⠟⣱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠁⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡄⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⢏⡔⣻⠋⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠁⠀⠐⡀⠀⣤⣤⣲⡴⠖⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣄⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡖⡣⢋⡼⠃⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⠄⠀⠀⣾⣷⣾⠿⠋⠀⠀⠀⡠⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢦⣀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠟⣀⡞⠁⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⡀⠀⠉⠛⠟⠀⠀⠀⠀⠚⢠⣴⢦⠴⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠲⠬⣕]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢃⢴⠏⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀⠀⠀⠀⡀⠀⠀⠁⠀⠀⠀⠀⣰⣴⣶⣿⠦⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⢧⣾⠏⠀⠀⣴⠀⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⢰⣦⣴⠶⠀⠀⠀⠀⠀⠀⠀⠀⠙⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⢫⠏⠀⠀⠘⣿⠀⠻⣿⣿⡿⠏⠀⠀⠐⠲⠃⠀⠀⠙⠉⠀⠀⠀⠸⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⢀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡿⢁⡞⠀⠀⠀⣼⣿⣁⠀⠈⠉⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠐⠟⠁⠀⠔⠀⠀⠀⠀⠀⠀⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        }

        dashboard.section.buttons.val = {
            dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("<leader>ff", "  Find file", get_files),
            dashboard.button("s", "󰋃  Open last session", function()
                require("persistence").load()
            end),
            dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
            dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
            dashboard.button("u", "  Update plugins", ":Lazy sync<CR>"),
            dashboard.button("r", "  Recently opened files", "<cmd>Telescope oldfiles<CR>"),
            dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<CR>"),
            dashboard.button("q", "  Quit", ":qa<CR>"),
        }
        dashboard.section.header.opts.hl = "AlphaHeader"
        dashboard.opts.layout[1].val = 6
        return dashboard
    end,
    config = function(_, dashboard)
        require("alpha").setup(dashboard.opts)
        vim.api.nvim_create_autocmd("User", {
            callback = function()
                local stats = require("lazy").stats()
                local ms = math.floor(stats.startuptime * 100) / 100
                local version = "  󰥱 v"
                    .. vim.version().major
                    .. "."
                    .. vim.version().minor
                    .. "."
                    .. vim.version().patch
                dashboard.section.footer.val = version
                    .. " 󱐌 Lazy-loaded "
                    .. stats.loaded
                    .. " plugins in "
                    .. ms
                    .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}
