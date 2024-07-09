return {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
        require("mini.ai").setup()
        require("mini.jump").setup()
        require("mini.files").setup({
            mappings = {
                go_in_plus = "<CR>",
            }
        })
        require("mini.surround").setup()

        local miniclue = require('mini.clue')
        miniclue.setup({
            triggers = {
                -- Leader triggers
                { mode = 'n', keys = '<Leader>' },
                { mode = 'x', keys = '<Leader>' },

                -- Built-in completion
                { mode = 'i', keys = '<C-x>' },

                -- `g` key
                { mode = 'n', keys = 'g' },
                { mode = 'x', keys = 'g' },

                -- Marks
                { mode = 'n', keys = "'" },
                { mode = 'n', keys = '`' },
                { mode = 'x', keys = "'" },
                { mode = 'x', keys = '`' },

                -- Registers
                { mode = 'n', keys = '"' },
                { mode = 'x', keys = '"' },
                { mode = 'i', keys = '<C-r>' },
                { mode = 'c', keys = '<C-r>' },

                -- Window commands
                { mode = 'n', keys = '<C-w>' },

                -- `z` key
                { mode = 'n', keys = 'z' },
                { mode = 'x', keys = 'z' },
            },

            clues = {
                -- Enhance this by adding descriptions for <Leader> mapping groups
                miniclue.gen_clues.builtin_completion(),
                miniclue.gen_clues.g(),
                miniclue.gen_clues.marks(),
                miniclue.gen_clues.registers({
                    show_contents = true,
                }),
                miniclue.gen_clues.windows({
                    submode_move = true,
                    submode_navigate = true,
                    submode_resize = true,
                }),
                miniclue.gen_clues.z(),

                { mode = "n", keys = "<Leader>b", desc = "Buffers" },
                { mode = "n", keys = "<Leader>d", desc = "DAP" },
                { mode = "n", keys = "<Leader>f", desc = "Find" },
                { mode = "n", keys = "<Leader>h", desc = "Harpoon" },
                { mode = "n", keys = "<Leader>l", desc = "Lazy" },
                { mode = "n", keys = "<Leader>s", desc = "Save / Search" },
                { mode = "n", keys = "<Leader>w", desc = "Window" },
            },

            window = {

            }
        })
    end,
}
