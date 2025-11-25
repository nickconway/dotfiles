return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({})

        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers")
                .new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                })
                :find()
        end

        vim.keymap.set("n", "<leader>hn", function()
            harpoon:list():select(1)
        end, { desc = "File 1" })
        vim.keymap.set("n", "<leader>he", function()
            harpoon:list():select(2)
        end, { desc = "File 2" })
        vim.keymap.set("n", "<leader>hi", function()
            harpoon:list():select(3)
        end, { desc = "File 3" })
        vim.keymap.set("n", "<leader>ho", function()
            harpoon:list():select(4)
        end, { desc = "File 4" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<leader>hs", function()
            harpoon:list():prev()
        end, { desc = "Previous File" })
        vim.keymap.set("n", "<leader>ht", function()
            harpoon:list():next()
        end, { desc = "Next File" })

        vim.keymap.set("n", "<leader>hh", function()
            toggle_telescope(harpoon:list())
        end, { desc = "Open Harpoon Window" })
        vim.keymap.set("n", "<leader>ha", function()
            harpoon:list():add()
        end, { desc = "Add File" })
    end,
}
