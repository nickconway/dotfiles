return {
    "SmiteshP/nvim-navic",
    dependencies = {
        "neovim/nvim-lspconfig",
    },
    opts = function()
        vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicText", { default = true, bg = "none", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, bg = "none", fg = "#ffffff" })

        return {
            separator = " ",
            highlight = true,
            depth_limit = 5,
            lazy_update_context = true,
        }
    end,
}
