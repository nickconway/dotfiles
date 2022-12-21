return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-github.nvim" },
        { "nvim-telescope/telescope-fzy-native.nvim" },
        { "nvim-telescope/telescope-file-browser.nvim" },

    },
    config = function()
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = require('telescope.actions').close
                    }
                }
            },
            extensions = {
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
        vim.keymap.set('n', '<leader>pv', ':Telescope file_browser<CR>', opts)

    end
}
