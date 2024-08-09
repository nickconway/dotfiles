return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-github.nvim" },
        { "nvim-telescope/telescope-fzy-native.nvim" },
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "pschmitt/telescope-yadm.nvim" },
    },
    config = function()
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = require("telescope.actions").close,
                    },
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--trim", -- add this value
                },
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
                fzy_native = {
                    override_generic_sorter = false,
                    override_file_sorter = true,
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
        })

        require("telescope").load_extension("gh")
        require("telescope").load_extension("noice")
        require("telescope").load_extension("file_browser")
        require("telescope").load_extension("fzy_native")
    end,
}
