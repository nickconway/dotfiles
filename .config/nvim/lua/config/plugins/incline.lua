return {
    "b0o/incline.nvim",
    event = "VeryLazy",
    config = function()
        local navic = require("nvim-navic")
        local devicons = require("nvim-web-devicons")
        require("incline").setup({
            window = {
                padding = 0,
                margin = { horizontal = 1, vertical = 0 },
            },
            render = function(props)
                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                if filename == "" then
                    filename = "[No Name]"
                end
                local ft_icon, ft_color = devicons.get_icon_color(filename)
                local modified = vim.bo[props.buf].modified
                local res = {
                    -- { " ", filename, gui = modified and "bold" or "" },
                    -- " ",
                    -- ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
                }
                if props.focused then
                    local crumbs = {}
                    for idx, item in ipairs(navic.get_data() or {}) do
                        if idx == #navic.get_data() then
                            table.insert(crumbs, 1, {
                                { item.icon, group = "NavicIcons" .. item.type },
                                { item.name, group = "NavicText" },
                            })
                        else
                            table.insert(crumbs, 1, {
                                { item.icon, group = "NavicIcons" .. item.type },
                                { item.name, group = "NavicText" },
                                { "  ", group = "NavicSeparator" },
                            })
                        end
                    end
                    -- if #crumbs > 0 then
                    --     table.insert(res, 1, " |")
                    -- end
                    for idx, item in ipairs(crumbs) do
                        if idx > 5 then
                            table.insert(res, 1, {
                                { "...", group = "NavicText" },
                                { "  ", group = "NavicSeparator" },
                            })
                            break
                        end
                        table.insert(res, 1, item)
                    end
                end
                return res
            end,
        })
    end,
}
