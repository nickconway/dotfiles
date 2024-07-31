return {
    "soulis-1256/eagle.nvim",
    config = function()
        local colors = require("onedark.colors")

        require("eagle").setup({
            border = "rounded",
            border_color = colors.grey,
        })
    end
}
