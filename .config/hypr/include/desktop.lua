hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-3", default = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-2", default = true })

hl.monitor({ output = "DP-1", mode = "3840x2160@240", scale = "1.33", bitdepth = 10, position = "0x0" })
hl.monitor({ output = "DP-2", mode = "3840x2160@120", scale = "1.33", bitdepth = 10, position = "-2880x0" })
hl.monitor({ output = "DP-3", mode = "3840x2160@120", scale = "1.33", bitdepth = 10, position = "2880x0" })

hl.window_rule({ match = { class = "vesktop" }, workspace = "2 silent" })
hl.window_rule({ match = { class = "chrome-x.com__-Default" }, workspace = "3 silent" })
hl.window_rule({ match = { class = "chrome-messages.google.com__web-Default" }, workspace = "3 silent" })

hl.on("hyprland.start", function()
    hl.exec_cmd("zen-browser", {
        workspace = "1 silent"
    })

    hl.exec_cmd("betterbird", {
        workspace = "2 silent"
    })

    Exec("vesktop", {
        rules = { workspace = "2 silent" },
        wait_for = "betterbird"
    })

    hl.exec_cmd("feishin --ozone-platform-hint=auto --password-store='kwallet6'", {
        workspace = "3 silent"
    })

    Exec("chromium --app='https://x.com'", {
        rules = { workspace = "3 silent" },
        wait_for = "feishin"
    })

    Exec("chromium --app='https://messages.google.com/web'", {
        rules = { workspace = "3 silent" },
        wait_for = "x.com"
    })
end)

hl.timer(function()
    local monitor = hl.get_monitor("DP-2")
    local monitor2 = hl.get_monitor("DP-3")

    if (monitor and monitor.width ~= 3840) or (monitor2 and monitor2.width ~= 3840) then
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
