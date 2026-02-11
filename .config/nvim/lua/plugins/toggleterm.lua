local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
end

return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        {
            "<leader>lg",
            function()
                local opts = {
                    cmd = "lazygit",
                    hidden = true,
                    dir = "git_dir",
                    direction = "float",
                    float_opts = {
                        border = "none",
                    },
                    -- function to run on opening the terminal
                    on_open = function(term)
                        vim.cmd("startinsert!")
                        vim.api.nvim_buf_set_keymap(
                            term.bufnr,
                            "n",
                            "q",
                            "<cmd>close<CR>",
                            { noremap = true, silent = true }
                        )
                    end,
                    -- function to run on closing the terminal
                    on_close = function(_)
                        vim.cmd("startinsert!")
                    end,
                }

                if not is_git_repo() then
                    opts.cmd = "yadm enter lazygit"
                else
                    opts.cmd = "lazygit"
                end

                vim.cmd("bufdo update")
                require("toggleterm.terminal").Terminal:new(opts):toggle()
            end,
            desc = "LazyGit",
        },
    },
    opts = {
        shade_terminals = false,
    },
}
