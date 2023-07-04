return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        'linrongbin16/lsp-progress.nvim',
    },
    config = function()
        require('lsp-progress').setup()

        local colors = require("onedark.colors")
        local transparent = require("lualine.themes.onedark")

        transparent.normal.a.bg = "none"
        transparent.normal.a.fg = colors.grey
        transparent.normal.b.bg = "none"
        transparent.normal.b.fg = colors.grey
        transparent.normal.c.bg = "none"
        transparent.normal.c.fg = colors.grey
        transparent.inactive.c.bg = "none"

        local function LSPs()
            return require('lsp-progress').progress({
                format = function(messages)
                    local active_clients = vim.lsp.get_active_clients()
                    local client_count = #active_clients
                    if #messages > 0 then
                        return " LSP:"
                            .. client_count
                            .. " "
                            .. table.concat(messages, " ")
                    end
                    if #active_clients <= 0 then
                        return " LSP:" .. client_count
                    else
                        local client_names = {}
                        for i, client in ipairs(active_clients) do
                            if client and client.name ~= "" then
                                table.insert(client_names, "[" .. client.name .. "]")
                                print(
                                    "client[" .. i .. "]:" .. vim.inspect(client.name)
                                )
                            end
                        end
                        return " LSP:"
                            .. client_count
                            .. " "
                            .. table.concat(client_names, " ")
                    end
                end,
            })
        end

        local lualine_sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = {
                'filename',
                LSPs,
                {
                    require("noice").api.statusline.mode.get,
                    cond = require("noice").api.statusline.mode.has,
                    fmt = function(name, context)
                        return name:gsub('%-%- INSERT %-%-', '')
                    end
                }
            },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        }

        local winbar_sections = {
            lualine_c = {
                "navic",
                color_correction = nil,
                navic_opts = nil,
                {
                    draw_empty = true,
                }
            },
        }

        require("lualine").setup({
            options = {
                disabled_filetypes = {
                    statusline = { 'alpha' },
                    winbar = { 'alpha' },
                },
                ignore_focus = {},
                always_divide_middle = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
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

        -- refresh lualine
        vim.cmd([[
            augroup lualine_augroup
                autocmd!
                autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
            augroup END
        ]])
    end,
}
