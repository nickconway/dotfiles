return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- See the full "keymap" documentation for information on defining your own keymap.
        keymap = {
            preset = "none",
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<CR>"] = { "accept", "fallback" },
            ["<Esc>"] = { "hide", "fallback" },

            ["<Tab>"] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.accept()
                    else
                        return cmp.select_next()
                    end
                end,
                "snippet_forward",
                "fallback",
            },

            ["<S-Tab>"] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.accept()
                    else
                        return cmp.select_prev()
                    end
                end,
                "snippet_backward",
                "fallback",
            },

            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },

            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },

            ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- Will be removed in a future release
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },

        cmdline = {
            completion = {
                menu = {
                    auto_show = true,
                },
            },

            keymap = {
                preset = "none",
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<CR>"] = { "accept", "fallback" },
                ["<Esc>"] = {
                    "hide",
                    function(cmp)
                        if cmp.is_visible() then
                            cmp.cancel()
                        else
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, true, true), "n", true)
                        end
                    end,
                },

                ["<Tab>"] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_next()
                        end
                    end,
                    "snippet_forward",
                    "fallback",
                },

                ["<S-Tab>"] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_prev()
                        end
                    end,
                    "snippet_backward",
                    "fallback",
                },

                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },

                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },

                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            },

            sources = function()
                local type = vim.fn.getcmdtype()
                -- Search forward and backward
                if type == "/" or type == "?" then
                    return { "buffer" }
                end
                -- Commands
                if type == ":" or type == "@" then
                    return { "cmdline", "buffer" }
                end
                return {}
            end,
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = function()
                local success, node = pcall(vim.treesitter.get_node)
                if
                    success
                    and node
                    and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
                then
                    return { "buffer" }
                else
                    return { "lsp", "path", "snippets", "buffer" }
                end
            end,
        },

        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                window = {
                    border = "rounded",
                },
            },
            ghost_text = {
                enabled = true,
            },
            list = {
                selection = {
                    preselect = false,
                },
            },
            menu = {
                border = "rounded",
            },
        },

        signature = {
            enabled = true,
            window = {
                show_documentation = false,
                border = "rounded",
            },
        },
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
        require("blink.cmp").setup(opts)
        vim.lsp.config("*", {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
        })
    end,
}
