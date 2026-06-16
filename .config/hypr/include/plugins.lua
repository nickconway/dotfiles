if hl.plugin.darkwindow ~= nil then
    hl.plugin.darkwindow.load_shader("none", {
        from = "tint",
        args = "tintColor=[0 0 0] tintStrength=0",
    })

    hl.plugin.darkwindow.load_shader("multi-chroma", {
        path = "~/.config/hypr/shaders/multi-chroma.glsl",
        args = "count=1 similarity[0]=0.1 amount[0]=1.4 targetOpacity[0]=0.83 bg[0]=[0 0 0]",
        introduces_transparency = true,
    })

    -- hl.plugin.darkwindow.load_shader("grayscale", {
    --     path = "~/.config/hypr/shaders/grayscale.glsl",
    --     args = "scale=1",
    --     introduces_transparency = false,
    -- })
end

if pcall(function()
    require("lua/plugins/hyprvim")
end) then
    require("lua/plugins/hyprvim").setup({
        keymaps = {},
        notifications = {
            all = true,
        },
        which_key = {
            enabled = true,
            delay_ms = 0,
            vim_delay_ms = 300,
            position = "bottom-center",
            auto_show = {
                disabled = nil,
            },
        },
    })
end
