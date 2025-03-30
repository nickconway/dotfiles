return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

        require("dapui").setup({
            force_buffers = false,
            icons = { expanded = "", collapsed = "", current_frame = "" },
            mappings = {
                -- Use a table to apply multiple mappings
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            -- Use this to override mappings for specific elements
            element_mappings = {
                -- Example:
                -- stacks = {
                --   open = "<CR>",
                --   expand = "o",
                -- }
            },
            -- Expand lines larger than the window
            -- Requires >= 0.7
            expand_lines = vim.fn.has("nvim-0.7") == 1,
            -- Layouts define sections of the screen to place windows.
            -- The position can be "left", "right", "top" or "bottom".
            -- The size specifies the height/width depending on position. It can be an Int
            -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
            -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
            -- Elements are the elements shown in the layout (in order).
            -- Layouts are opened in order so that earlier layouts take priority in window sizing.
            layouts = {
                {
                    elements = {
                        -- Elements can be strings or table with id and size keys.
                        { id = "scopes", size = 0.25 },
                        "breakpoints",
                        "stacks",
                        "watches",
                    },
                    size = 40, -- 40 columns
                    position = "left",
                },
                {
                    elements = {
                        "repl",
                        "console",
                    },
                    size = 0.25, -- 25% of total lines
                    position = "bottom",
                },
            },
            controls = {
                -- Requires Neovim nightly (or 0.8 when released)
                enabled = true,
                -- Display controls in this element
                element = "repl",
                icons = {
                    pause = "",
                    play = "",
                    step_into = "",
                    step_over = "",
                    step_out = "",
                    step_back = "",
                    run_last = "",
                    terminate = "",
                },
            },
            floating = {
                max_height = nil,   -- These can be integers or a float between 0 and 1.
                max_width = nil,    -- Floats will be treated as percentage of your screen.
                border = "rounded", -- Border style. Can be "single", "double" or "rounded"
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            windows = { indent = 1 },
            render = {
                max_type_length = nil, -- Can be integer or nil.
                max_value_lines = 100, -- Can be integer or nil.
            },
        })

        local icons = {
            Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
            Breakpoint          = " ",
            BreakpointCondition = " ",
            BreakpointRejected  = { " ", "DiagnosticError" },
            LogPoint            = ".>",
        }
        for name, sign in pairs(icons) do
            sign = type(sign) == "table" and sign or { sign }
            vim.fn.sign_define(
                "Dap" .. name,
                { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
            )
        end

        local dap, dapui                                      = require("dap"), require("dapui")
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"]     = function()
            dapui.close()
        end
    end,
    keys = {
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
        { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
        { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
        { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
        { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
        { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
        { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
        { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
        { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
        { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
        { "<leader>du", function() require("dapui").toggle({}) end,                                           desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end,                                               desc = "Eval",                   mode = { "n", "v" } },
        { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end,                      desc = "Debug Nearest" },
    },
}
