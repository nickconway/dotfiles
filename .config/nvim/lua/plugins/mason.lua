local function map(modes, lhs, rhs, desc, opts)
    local options = { silent = true, noremap = true }
    if desc then
        options = { silent = true, noremap = true, desc = desc }
    end

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    if type(lhs) == "string" then
        vim.keymap.set(modes, lhs, rhs, options)
    elseif type(lhs) == "table" then
        for _, key in pairs(lhs) do
            vim.keymap.set(modes, key, rhs, options)
        end
    end
end

return {
    "mason-org/mason.nvim",
    dependencies = {
        { "mason-org/mason-lspconfig.nvim" },
        { "simrat39/rust-tools.nvim" },
        { "jay-babu/mason-nvim-dap.nvim" },
        { "Hoffs/omnisharp-extended-lsp.nvim" },
    },
    build = ":MasonUpdate",
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    },
    config = function(_, opts)
        require("mason").setup(opts)

        map("n", "<leader>cm", "<cmd>Mason<cr>", "Mason")

        local mr = require("mason-registry")
        mr:on("package:install:success", function()
            vim.defer_fn(function()
                -- trigger FileType event to possibly load this newly installed LSP server
                require("lazy.core.handler.event").trigger({
                    event = "FileType",
                    buf = vim.api.nvim_get_current_buf(),
                })
            end, 100)
        end)

        mr.refresh(function()
            for _, tool in ipairs(opts.ensure_installed or {}) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end)

        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = {
                "ts_ls",
                "lua_ls",
                "bashls",
                "rust_analyzer",
                "tailwindcss",
                "svelte",
                "hyprls",
                "gopls",
            },
        })

        require("mason-nvim-dap").setup({
            automatic_installation = true,
            ensure_installed = {
                "python",
            },
            handlers = {
                function(config)
                    require("mason-nvim-dap").default_setup(config)
                end,
                python = function(config)
                    config.adapters = {
                        type = "executable",
                        command = "python",
                        args = {
                            "-m",
                            "debugpy.adapter",
                        },
                    }
                    require("mason-nvim-dap").default_setup(config) -- don't forget this!
                end,
                coreclr = function(config)
                    config.adapters = {
                        type = "executable",
                        command = "netcoredbg",
                        args = { "--interpreter=vscode" },
                    }
                    require("mason-nvim-dap").default_setup(config) -- don't forget this!
                end,
            },
        })
    end,
}
