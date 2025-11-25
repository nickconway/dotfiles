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
                    opts.dir = os.getenv("HOME")
                else
                    vim.fn.system("tmux display-popup -w 90% -h 80% -B -E lazygit")
                    return
                end

                local Terminal = require("toggleterm.terminal").Terminal
                local term = Terminal:new(opts)
                term:toggle()
            end,
            desc = "LazyGit",
        },
    },
    opts = {
        shade_terminals = false,
    },
}
