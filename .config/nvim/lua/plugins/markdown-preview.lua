return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install && git restore .",
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    keys = {
        {
            "<leader>mp",
            function()
                vim.cmd("MarkdownPreview")
            end,
            mode = "n",
            desc = "Preview Markdown File",
        },
    },
}
