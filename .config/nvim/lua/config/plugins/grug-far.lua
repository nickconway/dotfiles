return {
    'MagicDuck/grug-far.nvim',
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
        {
            "<leader>sr",
            function()
                local grug = require("grug-far")
                local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                grug.grug_far({
                    transient = true,
                    prefills = {
                        filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                    },
                })
            end,
            mode = { "n", "v" },
            desc = "Search and Replace",
        },
        {
            "<leader>sR",
            function()
                local grug = require("grug-far")
                local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                grug.grug_far({
                    transient = true,
                    prefills = {
                        search = vim.fn.expand("<cword>"),
                        filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                    },
                })
            end,
            mode = { "n", "v" },
            desc = "Search and Replace Current Word",
        },
        {
            "<leader>sf",
            function()
                local grug = require("grug-far")
                local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                grug.grug_far({
                    transient = true,
                    prefills = {
                        filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        paths = vim.fn.expand("%")
                    },
                })
            end,
            mode = { "n", "v" },
            desc = "Search and Replace in Current File",
        },
        {
            "<leader>sF",
            function()
                local grug = require("grug-far")
                local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                grug.grug_far({
                    transient = true,
                    prefills = {
                        search = vim.fn.expand("<cword>"),
                        filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        paths = vim.fn.expand("%")
                    },
                })
            end,
            mode = { "n", "v" },
            desc = "Search and Replace Current Word in Current File",
        },
    },
}
