local focus = function(class, cmd)
    local window = hl.get_windows({ class = class, workspace = hl.get_active_workspace() })[1]
    if window ~= nil then
        hl.dispatch(hl.dsp.focus({ window = window }))
    else
        hl.exec_cmd(cmd or class)
    end
end

hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })

hl.workspace_rule({
    workspace = "m[0]s[false]",
    layout = "scrolling",
    gaps_out = 0,
    gaps_in = 0,
    no_rounding = true,
    no_border = true,
})

Bind({ MainMod, "B" }, function()
    focus("zen", "zen-browser")
end)
Bind({ MainMod, "T" }, function()
    focus("kitty")
end)
Bind({ MainMod, "D" }, function()
    focus("vesktop")
end)
Bind({ MainMod, "M" }, function()
    focus("thunderbird", "thunderbird-beta")
end)
Bind({ MainMod, "F" }, function()
    focus("feishin")
end)

if Run("hostnamectl hostname") == "desktop" then
    hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
    hl.workspace_rule({ workspace = "2", monitor = "DP-3", default = true })
    hl.workspace_rule({ workspace = "3", monitor = "DP-2", default = true })

    hl.on("hyprland.start", function()
        hl.exec_cmd("[workspace 1 silent] zen-browser")
        hl.exec_cmd("[workspace 2 silent] kitty")
        hl.exec_cmd("[workspace 2 silent] vesktop")
        hl.exec_cmd("[workspace 2 silent] thunderbird-beta")
        hl.exec_cmd("[workspace 3 silent] feishin --ozone-platform-hint=auto --password-store='kwallet6'")
        hl.exec_cmd("[workspace 3 silent] chromium --app='https://messages.google.com/web'")
        hl.exec_cmd("[workspace 3 silent] chromium --app='https://bluebubbles.app/web/'")
        hl.exec_cmd("[workspace 3 silent] chromium --app='https://x.com'")
    end)
elseif Run("hostnamectl hostname") == "laptop" then
    hl.workspace_rule({
        workspace = "s[false]",
        layout = "scrolling",
        gaps_out = 0,
        gaps_in = 0,
        no_rounding = true,
        no_border = true,
    })

    hl.on("hyprland.start", function()
        hl.exec_cmd("zen-browser")
        hl.exec_cmd("kitty")
        hl.exec_cmd("vesktop")
        hl.exec_cmd("thunderbird-beta")
        hl.exec_cmd("feishin --ozone-platform-hint=auto --password-store='kwallet6'")
        hl.exec_cmd("chromium --app='https://messages.google.com/web'")
        hl.exec_cmd("chromium --app='https://bluebubbles.app/web/'")
        hl.exec_cmd("chromium --app='https://x.com'")
    end)
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
