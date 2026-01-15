local debounce = function(ms, fn)
    local timer = vim.uv.new_timer()
    if timer == nil then
        return
    end

    return function(...)
        local argv = { ... }
        timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
        end)
    end
end

return {
    "mfussenegger/nvim-lint",
    opts = {
        events = { "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged", "TextChangedI" },
        linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
        },
    },
    config = function(_, opts)
        local lint = require("lint")
        lint.linters_by_ft = opts.linters_by_ft

        local _lint = function()
            local names = lint._resolve_linter_by_ft(vim.bo.filetype)

            -- Add fallback linters.
            if #names == 0 then
                vim.list_extend(names, lint.linters_by_ft["_"] or {})
            end

            -- Add global linters.
            vim.list_extend(names, lint.linters_by_ft["*"] or {})

            -- Filter out linters that don't exist or don't match the condition.
            local ctx = { filename = vim.api.nvim_buf_get_name(0) }
            ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
            names = vim.tbl_filter(function(name)
                local linter = lint.linters[name]
                if not linter then
                    require("lazy.core.util").warn("Linter not found: " .. name, { title = "nvim-lint" })
                end
                return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
            end, names)

            -- Run linters.
            if #names > 0 then
                lint.try_lint(names)
            end
        end

        vim.api.nvim_create_autocmd(opts.events, {
            group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
            callback = debounce(100, _lint),
        })
    end,
}
