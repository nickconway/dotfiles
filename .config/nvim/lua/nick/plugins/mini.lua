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
    end,
}
