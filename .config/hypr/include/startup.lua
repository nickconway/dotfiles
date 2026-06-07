hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    hl.exec_cmd(
        "quickshell-configs spawn -d || (swaync & waybar & waybar-auto-hide & hyprpaper &> /tmp/hyprpaper.log &)"
    )

    hl.exec_cmd("hypridle &> /tmp/hypridle.log &")

    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("modprobe -c | grep asus_nb_wmi && sudo modprobe -r asus_nb_wmi")
    hl.exec_cmd("hyprshade auto")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("kdeconnectd")
    hl.exec_cmd("kdeconnect-indicator")
    hl.exec_cmd("flatpak run com.github.wwmm.easyeffects --gapplication-service")
    hl.exec_cmd("pypr --debug /tmp/pypr.log")
    hl.exec_cmd("hostname | grep -x desktop && LOG=y hyprland-fix-monitors")
    hl.exec_cmd("steam -silent")
    hl.exec_cmd("LOG=y install-yeetmouse")
    hl.exec_cmd("localsend --hidden")
    hl.exec_cmd("vicinae server")

    hl.exec_cmd("hyprautorotate")
    hl.exec_cmd("zenbook-duo-auto-brightness")

    hl.exec_cmd("bitwarden")
    hl.exec_cmd("openrgb --startminimized")

    hl.exec_cmd("LOG=y ups-commands")

    hl.exec_cmd("hyprctl output create headless Sunshine")
    hl.exec_cmd("sunshine")

    hl.exec_cmd("hyprpm reload")
end)
