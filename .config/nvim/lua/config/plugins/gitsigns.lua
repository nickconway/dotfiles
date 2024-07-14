return {
    'lewis6991/gitsigns.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "seanbreckenridge/gitsigns-yadm.nvim",
    },
    config = function()
        require("gitsigns").setup {
            current_line_blame = true,
            _on_attach_pre = function(_, callback)
                if vim.fn.executable("yadm") == 1 then
                    require("gitsigns-yadm").yadm_signs(callback)
                else
                    callback()
                end
            end,
        }
    end
}
