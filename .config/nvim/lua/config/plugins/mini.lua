return {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
        require("mini.ai").setup()
        require("mini.jump").setup()
        require("mini.files").setup({
            mappings = {
                go_out_plus = '<BS>',
                go_in_plus = "<CR>",
                reset = 'r',
            }
        })
        require("mini.surround").setup({
            mappings = {
                add = 'gsa',            -- Add surrounding in Normal and Visual modes
                delete = 'gsd',         -- Delete surrounding
                find = 'gsf',           -- Find surrounding (to the right)
                find_left = 'gsF',      -- Find surrounding (to the left)
                highlight = 'gsh',      -- Highlight surrounding
                replace = 'gsr',        -- Replace surrounding
                update_n_lines = 'gsn', -- Update `n_lines`

                suffix_last = 'l',      -- Suffix to search with "prev" method
                suffix_next = 'n',      -- Suffix to search with "next" method
            },
        })
    end,
}
