hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-3", default = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-2", default = true })

hl.monitor({ output = "DP-1", mode = "3840x2160@240", scale = "1.33", bitdepth = 10, position = "0x0" })
hl.monitor({ output = "DP-2", mode = "3840x2160@120", scale = "1.33", bitdepth = 10, position = "-2880x0" })
hl.monitor({ output = "DP-3", mode = "3840x2160@120", scale = "1.33", bitdepth = 10, position = "2880x0" })

hl.on("hyprland.start", function()
    hl.exec_cmd("[workspace 1 silent] zen-browser")
    hl.exec_cmd("[workspace 2 silent] vesktop")
    hl.exec_cmd("[workspace 2 silent] thunderbird-beta")
    hl.exec_cmd("[workspace 3 silent] feishin --ozone-platform-hint=auto --password-store='kwallet6'")
    hl.exec_cmd("[workspace 3 silent] chromium --app='https://messages.google.com/web'")
    hl.exec_cmd("[workspace 3 silent] sleep 1 && chromium --app='https://x.com'")

    hl.exec_cmd("beacn-utility --background")
end)

hl.timer(function()
    local monitor = hl.get_monitor("DP-2")
    local monitor2 = hl.get_monitor("DP-3")

    if (monitor and monitor.width ~= 3840) or (monitor2 and monitor2.width ~= 3840) then
        hl.notification.create({
            text = (monitor and monitor.name .. monitor.width or "1")
                .. (monitor2 and monitor2.name .. monitor2.width or "2"),
            timeout = 3000,
        })

        local monitor3 = hl.get_monitor("DP-1")

        if monitor3 and monitor3.width ~= 1920 then
            hl.monitor({ output = "DP-1", mode = "1920x1080@60", scale = "1", bitdepth = 8 })
            hl.monitor({ output = "DP-2", mode = "1920x1080@60", scale = "1", bitdepth = 8 })
            hl.monitor({ output = "DP-3", mode = "1920x1080@60", scale = "1", bitdepth = 8 })
        else
            hl.monitor({ output = "DP-2", mode = "3840x2160@120", scale = "1.33", bitdepth = 10, position = "-2880x0" })
            hl.monitor({ output = "DP-3", mode = "3840x2160@120", scale = "1.33", bitdepth = 10, position = "2880x0" })
            hl.monitor({ output = "DP-1", mode = "3840x2160@240", scale = "1.33", bitdepth = 10, position = "0x0" })
        end
    end
end, { timeout = 5000, type = "repeat" })

hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "Linear", loop = true })
