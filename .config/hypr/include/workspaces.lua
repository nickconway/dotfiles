Run = function(fn)
    local f = io.popen(fn)
    if f == nil then
        return ""
    end
    local out = f:read("l")
    f:close()
    return out
end

hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })

if Run("hostnamectl hostname") == "desktop" then
    Bind({ MainMod, "B" }, hl.dsp.focus({ window = "zen-browser" }))
    Bind({ MainMod, "T" }, hl.dsp.focus({ window = "kitty" }))
    Bind({ MainMod, "D" }, hl.dsp.focus({ window = "vesktop" }))
    Bind({ MainMod, "M" }, hl.dsp.focus({ window = "thunderbird" }))
    Bind({ MainMod, "F" }, hl.dsp.focus({ window = "feishin" }))

    hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
    hl.workspace_rule({ workspace = "2", monitor = "DP-3", default = true })
    hl.workspace_rule({ workspace = "3", monitor = "DP-2", default = true })

    hl.on("hyprland.start", function()
        hl.exec_cmd("[workspace 1 silent] zen-browser")
        hl.exec_cmd("[workspace 2 silent] kitty")
        hl.exec_cmd("[workspace 2 silent] vesktop")
        hl.exec_cmd("[workspace 2 silent] thunderbird-beta")
        hl.exec_cmd("[workspace 3 silent] feishin --ozone-platform-hint=auto --password-store='kwallet6'")
        hl.exec_cmd("[workspace 3 silent] zen-pwa 'https://messages.google.com/web'")
        hl.exec_cmd("[workspace 3 silent] zen-pwa 'https://bluebubbles.app/web/'")
        hl.exec_cmd("[workspace 3 silent] zen-pwa 'https://x.com'")
    end)
elseif Run("hostnamectl hostname") == "laptop" then
    Bind({ MainMod, "B" }, hl.dsp.focus({ workspace = "1" }))
    Bind({ MainMod, "T" }, hl.dsp.focus({ workspace = "2" }))
    Bind({ MainMod, "D" }, hl.dsp.focus({ workspace = "3" }))
    Bind({ MainMod, "X" }, hl.dsp.focus({ workspace = "4" }))
    Bind({ MainMod, "M" }, hl.dsp.focus({ workspace = "5" }))
    Bind({ MainMod, "F" }, hl.dsp.focus({ workspace = "6" }))

    hl.workspace_rule({ workspace = "1", on_created_empty = "zen-browser" })
    hl.workspace_rule({ workspace = "2", on_created_empty = "kitty" })
    hl.workspace_rule({ workspace = "3", on_created_empty = "vesktop" })
    hl.workspace_rule({
        workspace = "4",
        on_created_empty = "zen-pwa 'https://messages.google.com/web' & zen-pwa 'https://bluebubbles.app/web/'",
    })
    hl.workspace_rule({ workspace = "5", on_created_empty = "thunderbird-beta" })
    hl.workspace_rule({ workspace = "6", on_created_empty = "feishin --ozone-platform-hint=auto" })
end

hl.workspace_rule({ workspace = "name:game", monitor = "1", default = false })

hl.on("window.destroy", function()
    if hl.get_active_workspace().name == "game" and (hl.get_active_workspace().windows == 0) then
        hl.dispatch(hl.dsp.focus({ workspace = hl.get_last_workspace(hl.get_active_monitor()) }))
    end
end)

hl.on("workspace.active", function()
    if hl.get_active_special_workspace() then
        hl.dispatch(hl.dsp.workspace.toggle_special({}))
    end
end)
