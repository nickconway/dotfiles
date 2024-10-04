local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
end

local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local function get_files()
    if vim.fn.getcwd() == vim.fn.getenv("HOME") then
        local topts = {}

        topts.entry_maker = function(entry)
            local str = entry
            str = string.gsub(str, ".config/yadm/alt/", "")
            str = string.gsub(str, "##template.*", "")
            return {
                value = string.format("%s/%s", vim.fn.getenv("HOME"), entry),
                display = str,
                ordinal = entry,
            }
        end

        pickers
            .new(topts, {
                prompt_title = "Yadm Files",
                finder = finders.new_oneshot_job({ "get-yadm-files" }, topts),
                previewer = conf.file_previewer(topts),
                sorter = conf.file_sorter(topts),
            })
            :find()
    elseif is_git_repo() then
        require("telescope.builtin").git_files({ cwd = get_git_root() })
    else
        require("telescope.builtin").find_files()
    end
end

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-github.nvim" },
        { "nvim-telescope/telescope-fzy-native.nvim" },
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "pschmitt/telescope-yadm.nvim" },
    },
    cmd = "Telescope",
    keys = {
        { "<leader>fb", "<cmd>Telescope buffers<cr>",                         desc = "Buffers" },
        {
            "<leader>fc",
            function()
                vim.cmd("Telescope colorscheme")
                vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
                    callback = function(event)
                        if vim.bo[event.buf].filetype == "TelescopePrompt" then
                            local f = io.open(os.getenv("HOME") .. "/.cache/nvim/colorscheme", "w+")
                            if f then
                                vim.defer_fn(function()
                                    f:write(vim.g.colors_name)
                                    f:close()
                                end, 100)
                            end
                        end
                    end
                })
            end,
            desc = "Colorschemes"
        },
        { "<leader>ff", get_files,                                            desc = "Files" },
        { "<leader>fF", "<cmd>Telescope find_files<CR>",                      desc = "All files" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>",                       desc = "Help tags" },
        { "<leader>fl", "<cmd>Telescope live_grep<cr>",                       desc = "Live grep" },
        { "<leader>fm", "<cmd>lua require('telescope.builtin').resume()<cr>", desc = "Last" },
        { "<leader>fm", "<cmd>Telescope oldfiles<cr>",                        desc = "Recent files" },
        { "<leader>fs", "<cmd>SearchSession<CR>",                             desc = "Sessions" },
        { "<leader>fo", "<cmd>Telescope file_browser<CR>",                    desc = "File browser" },
    },
    config = function()
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = require("telescope.actions").close,
                    },
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--trim", -- add this value
                },
            },
            extensions = {
                file_browser = {
                    theme = "ivy",
                    -- disables netrw and use telescope-file-browser in its place
                    hijack_netrw = true,
                    mappings = {
                        ["i"] = {
                            -- your custom insert mode mappings
                        },
                        ["n"] = {
                            -- your custom normal mode mappings
                        },
                    },
                },
                fzy_native = {
                    override_generic_sorter = false,
                    override_file_sorter = true,
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                colorscheme = {
                    enable_preview = true
                },
            },
        })

        require("telescope").load_extension("gh")
        require("telescope").load_extension("noice")
        require("telescope").load_extension("file_browser")
        require("telescope").load_extension("fzy_native")
    end,
}
