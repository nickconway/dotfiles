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

if pcall(require, "lua/plugins/hyprvim") then
    local hyprvim = require("lua/plugins/hyprvim")

    hyprvim.setup({
        keymaps = {
            NORMAL = {
                {
                    MainMod .. " + SPACE",
                    hl.dsp.submap("LEADER"),
                    { desc = "+Leader" },
                },
            },
        },
        notifications = {
            all = true,
        },
        which_key = {
            enabled = true,
            delay_ms = 0,
            vim_delay_ms = 300,
            position = "bottom-center",
            auto_show = {
                enabled = { "NORMAL", "VISUAL", "V-LINE", "INSERT", "LEADER" },
            },
        },
    })

    hl.define_submap("LEADER", "NORMAL", function()
        Bind("SPACE", hyprvim.whichkey.toggle)
        Bind("Q", hl.dsp.window.kill(), { desc = "Kill Window" })
        Bind("catchall", function() end)
    end)
end
