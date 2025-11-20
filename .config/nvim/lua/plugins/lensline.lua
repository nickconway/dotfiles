return {
    'oribarilan/lensline.nvim',
    branch = 'release/2.x',
    event = 'LspAttach',
    opts = {
        profiles = {
            {
                name = 'minimal',
                style = {
                    placement = 'inline',
                    prefix = '',
                    -- render = "focused", optionally render lenses only for focused function
                }
            }
        }
    },
    keys = {
        {
            "<leader>uo",
            "<cmd>LenslineToggleView<cr>",
            mode = "n",
            desc = "Toggle Lensline"
        }
    }
}
