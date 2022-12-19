require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = require('telescope.actions').close
            }
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
        file_browser = {
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
                ["i"] = {
                    -- your custom insert mode mappings
                },
                ["n"] = {
                    -- your custom normal mode mappings
                },
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true
        }
    }
}

require('telescope').load_extension('fzy_native')
require('telescope').load_extension('gh')
require('telescope').load_extension('session-lens')
require('telescope').load_extension('noice')
require("telescope").load_extension("file_browser")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pb', builtin.buffers, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>pf', builtin.find_files, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>pg', builtin.git_files, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ph', builtin.help_tags, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>pl', builtin.live_grep, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>pp', ':SearchSession<CR>', { noremap = true, silent = true })
