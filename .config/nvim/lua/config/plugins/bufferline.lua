return {
    "akinsho/bufferline.nvim",
    opts = function()
        ---@param buf number?
        local function bufremove(buf)
            buf = buf or 0
            buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

            if vim.bo.modified then
                local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
                if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
                    return
                end
                if choice == 1 then -- Yes
                    vim.cmd.write()
                end
            end

            for _, win in ipairs(vim.fn.win_findbuf(buf)) do
                vim.api.nvim_win_call(win, function()
                    if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
                        return
                    end
                    -- Try using alternate buffer
                    local alt = vim.fn.bufnr("#")
                    if alt ~= buf and vim.fn.buflisted(alt) == 1 then
                        vim.api.nvim_win_set_buf(win, alt)
                        return
                    end

                    -- Try using previous buffer
                    local has_previous = pcall(vim.cmd, "bprevious")
                    if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
                        return
                    end

                    -- Create new listed buffer
                    local new_buf = vim.api.nvim_create_buf(true, false)
                    vim.api.nvim_win_set_buf(win, new_buf)
                end)
            end
            if vim.api.nvim_buf_is_valid(buf) then
                pcall(vim.cmd, "bdelete! " .. buf)
            end
        end

        local diagnostics_icons = {
            Error = " ",
            Warn  = " ",
            Hint  = " ",
            Info  = " ",
        }

        vim.opt.mousemoveevent = true
        local o = {
            options = {
                style_preset = require("bufferline").style_preset.minimal,
                show_close_icon = true,
                show_buffer_close_icons = true,
                separator_style = { "", "" },
                close_command = function(n) bufremove(n) end,
                right_mouse_command = function(n) bufremove(n) end,
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                auto_toggle_bufferline = true,
                diagnostics_indicator = function(_, _, diag)
                    local icons = diagnostics_icons
                    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                        .. (diag.warning and icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
                indicator = {
                    style = 'none',
                },
                hover = {
                    enabled = true,
                    delay = 0,
                    reveal = { 'close' }
                },
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
                get_element_icon = function(opts)
                    return require("nvim-web-devicons").get_icon_by_filetype(opts.filetype)
                end,
            }
        }
        return o
    end
}
