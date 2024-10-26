return {
    "SmiteshP/nvim-navic",
    dependencies = {
        "neovim/nvim-lspconfig",
    },
    opts = function()
        vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, link = "File" })
        vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, link = "Module" })
        vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, link = "Namespace" })
        vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, link = "Conditional" })
        vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, link = "Class" })
        vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, link = "Method" })
        vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, link = "Property" })
        vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, link = "Field" })
        vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, link = "Constructor" })
        vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, link = "Enum" })
        vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, link = "Interface" })
        vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, link = "Function" })
        vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, link = "Variable" })
        vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, link = "Constant" })
        vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, link = "String" })
        vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, link = "Number" })
        vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, link = "Boolean" })
        vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, link = "Variable" })
        vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, link = "Identifier" })
        vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, link = "Key" })
        vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, link = "Null" })
        vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, link = "EnumMember" })
        vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, link = "Struct" })
        vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, link = "Event" })
        vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, link = "Operator" })
        vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, link = "TypeParameter" })
        vim.api.nvim_set_hl(0, "NavicText", { default = true, link = "Normal" })
        vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, link = "Normal" })

        return {
            separator = " ",
            highlight = true,
            depth_limit = 5,
            lazy_update_context = true,
        }
    end,
}
