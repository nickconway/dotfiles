return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "petertriho/cmp-git" },

        -- Snippets
        { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
        { "rafamadriz/friendly-snippets" },
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "lazydev", group_index = 0 },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "cmp" },
                { name = "path" },
            },
            formatting = {
                expandable_indicator = true,
                fields = { "abbr", "kind", "menu" },
                format = require("lspkind").cmp_format({
                    before = require("tailwindcss-colorizer-cmp").formatter,
                    mode = "symbol_text", -- show only symbol annotations
                    maxwidth = 50, -- prevent the popup from showing more than provided characters
                    ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                }),
            },
            experimental = {
                ghost_text = {
                    hl_group = "CmpGhostText",
                },
            },
        })

        cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
                { name = "git" },
                { name = "buffer" },
            }),
        })
        require("cmp_git").setup()

        cmp.setup.filetype({ "sql" }, {
            sources = {
                { name = "vim-dadbod-completion" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "cmp" },
                { name = "path" },
            },
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "cmdline" },
                { name = "buffer" },
                { name = "path" },
            }),
        })
    end,
}
