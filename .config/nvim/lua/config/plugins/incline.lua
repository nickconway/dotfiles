return {
    "b0o/incline.nvim",
    event = "VeryLazy",
    config = function()
        local navic = require("nvim-navic")
        require("incline").setup({
            window = {
                padding = 0,
                margin = { horizontal = 1, vertical = 0 },
            },
            render = function(props)
                local res = {}
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
