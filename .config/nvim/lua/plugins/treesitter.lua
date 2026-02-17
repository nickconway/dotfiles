return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    main = "nvim-treesitter.config",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            branch = "main",
        },
    },
    build = ":TSUpdate",
    init = function()
        local parsers = {
            "bash",
            "c",
            "cpp",
            "css",
            "scss",
            "diff",
            "go",
            "html",
            "hyprlang",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "printf",
            "python",
            "query",
            "regex",
            "rust",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        }

        require("nvim-treesitter").install(parsers)

        local patterns = { "sh" }
        local count = #patterns

        for i, p in ipairs(parsers) do
            patterns[count + i] = p
        end

        vim.filetype.add({
            pattern = { [".*/hypr/.*%.conf.*"] = "hyprlang" },
        })

        require("nvim-treesitter.parsers").comment = {
            install_info = {
                url = "https://github.com/OXY2DEV/tree-sitter-comment",
                queries = "queries/",
            },
        }

        require("nvim-treesitter").install("comment")

        vim.api.nvim_create_autocmd("FileType", {
            pattern = patterns,
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
