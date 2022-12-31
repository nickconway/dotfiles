return {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
        require("null-ls").setup({
            sources = {
                require("null-ls").builtins.code_actions.eslint,
                require("null-ls").builtins.diagnostics.eslint,
                require("null-ls").builtins.formatting.prettier,
            }
        })
    end
}
