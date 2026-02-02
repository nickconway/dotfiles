local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
end

local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
end

return {
    "NeogitOrg/neogit",
    keys = {
        {
            "<leader>gg",
            function()
                if is_git_repo() then
                    vim.env.GIT_DIR = get_git_root() .. "/.git"
                    vim.env.GIT_WORK_TREE = get_git_root()
                else
                    vim.env.GIT_DIR = vim.fn.system("yadm user-config")
                    vim.env.GIT_WORK_TREE = vim.fn.expand("~")
                end
                local neogit = require("neogit")
                neogit.open()
            end,
            desc = "NeoGit",
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed, not both.
        "nvim-telescope/telescope.nvim", -- optional
        -- "ibhagwan/fzf-lua",              -- optional
    },
    config = function()
        require("neogit").setup({
            kind = "floating", -- opens neogit in a split
            signs = {
                -- { CLOSED, OPENED }
                section = { "", "" },
                item = { "", "" },
                hunk = { "", "" },
            },
            integrations = { diffview = true },
        })
    end,
}
