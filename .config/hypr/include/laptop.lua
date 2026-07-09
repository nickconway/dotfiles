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
    hl.exec_cmd("chromium --app='https://x.com'")
end)

hl.timer(function()
    if Run("grep close /proc/acpi/button/lid/*/state") ~= "" then
        hl.exec_cmd("systemctl suspend")
    end
end, { timeout = 5000, type = "repeat" })
