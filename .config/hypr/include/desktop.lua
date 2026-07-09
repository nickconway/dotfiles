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
    hl.exec_cmd("[workspace 3 silent] chromium --app='https://x.com'")
end)

hl.timer(function()
    local monitor = hl.get_monitor("DP-3")

    if monitor == nil then
        return
    end

    if monitor.width ~= 3840 then
        hl.monitor({ output = "DP-1", mode = "1920x1080", scale = "1.33", bitdepth = 10 })
        hl.timer(function()
            hl.monitor({ output = "DP-1", mode = "preferred", scale = "1.33", bitdepth = 10 })
        end, { type = "oneshot", timeout = 5000 })
    end
end, { timeout = 5000, type = "repeat" })

hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "Linear", loop = true })
