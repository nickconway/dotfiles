hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = "1.6", bitdepth = 10 })
-- hl.monitor({ output = "eDP-2", mode = "preferred", position = "auto-down", scale = "1.6", bitdepth = 10 })
hl.monitor({ output = "eDP-2", disabled = true })

hl.workspace_rule({
    workspace = "s[false]",
    layout = "scrolling",
    gaps_out = 0,
    gaps_in = 0,
    no_rounding = true,
    no_border = true,
})

hl.on("hyprland.start", function()
    hl.exec_cmd("zenbook-auto-backlight")

    hl.exec_cmd("zen-browser")
    hl.exec_cmd("vesktop")
    hl.exec_cmd("thunderbird-beta")
    hl.exec_cmd("feishin --ozone-platform-hint=auto --password-store='kwallet6'")
    hl.exec_cmd("chromium --app='https://messages.google.com/web'")
    hl.exec_cmd("sleep 1 && chromium --app='https://x.com'")
end)

hl.timer(function()
    if Run("grep close /proc/acpi/button/lid/*/state") ~= "" then
        hl.exec_cmd("systemctl suspend")
    end
end, { timeout = 5000, type = "repeat" })

Bind("F1", hl.dsp.exec_cmd("media -a volume mute"), { locked = true })
Bind("F2", hl.dsp.exec_cmd("media -a volume lower"), { locked = true, repeating = true })
Bind("F3", hl.dsp.exec_cmd("media -a volume raise"), { locked = true, repeating = true })
Bind("F5", hl.dsp.exec_cmd("brightness lower"), { locked = true, repeating = true })
Bind("F6", hl.dsp.exec_cmd("brightness raise"), { locked = true, repeating = true })
