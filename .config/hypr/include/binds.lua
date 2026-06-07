MainMod = "SUPER"

local function focus_group_aware(direction)
    local win = hl.get_active_window()

    if not win then
        hl.dispatch(hl.dsp.focus({ direction = direction }))
        return
    end

    local group = win.group

    if group then
        if direction == "left" then
            if group.current_index > 1 then
                hl.dispatch(hl.dsp.group.prev())
                return
            end
        elseif direction == "right" then
            if group.current_index < group.size then
                hl.dispatch(hl.dsp.group.next())
                return
            end
        end
    end

    hl.dispatch(hl.dsp.focus({ direction = direction }))
end

Bind = function(keys, action, opts)
    hl.bind(table.concat(keys, " + "), action, opts or {})
end

Bind({ MainMod, "SHIFT", "O" }, function()
    if hl.plugin.darkwindow and BackgroundRed and BackgroundGreen and BackgroundBlue then
        hl.plugin.darkwindow.dsp_shade({
            shader = "multi-chroma count=2 similarity[0]=0.1 similarity[1]=0.02 amount[0]=1.4 amount[1]=1.4 targetOpacity[0]=0.83 targetOpacity[1]=0.83 bg[0]=["
                .. BackgroundRed
                .. " "
                .. BackgroundGreen
                .. " "
                .. BackgroundBlue
                .. "] bg[1]=[0 0 0]",
            window = "activewindow",
        })
    else
        hl.notification.create({ text = "Darkwindow plugin not setup", timeout = 5000 })
    end
end)

Bind({ MainMod, "Return" }, hl.dsp.exec_cmd("TMUX_AUTO_SESSION=y kitty --single-instance"))

Bind({ MainMod, "Q" }, hl.dsp.window.close())
Bind({ MainMod, "E" }, hl.dsp.exec_cmd("nautilus -w"))
Bind({ MainMod, "SHIFT", "B" }, hl.dsp.exec_cmd("zen-browser"))
Bind({ MainMod, "SHIFT", "F" }, hl.dsp.window.float())
Bind({ "ALT", "Tab" }, hl.dsp.exec_cmd("rofi -show window -config ~/.config/rofi/styles/style_2.rasi"))
Bind({ MainMod, "SHIFT", "P" }, hl.dsp.window.pseudo())
Bind({ MainMod, "J" }, hl.dsp.layout("togglesplit"))
Bind({ MainMod, "Period" }, hl.dsp.exec_cmd("nohup picker emoji &>/dev/null"))
Bind({ MainMod, "W" }, hl.dsp.exec_cmd("power-menu"))
Bind({ MainMod, "L" }, hl.dsp.exec_cmd("loginctl lock-session"))
Bind({ MainMod, "SHIFT", "L" }, hl.dsp.exec_cmd("systemctl suspend"))

Bind({ MainMod, "CTRL", "SHIFT", "P" }, function()
    hl.dsp.window.float()
    hl.dsp.exec_cmd("caelestia resizer pip")
end)

Bind({ MainMod, "M" }, hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
Bind({ MainMod, "SHIFT", "M" }, hl.dsp.exec_cmd("~/.config/rofi/scripts/music-menu"))

Bind({ "ALT", "SPACE" }, hl.dsp.exec_cmd("picker all"))

Bind({ MainMod, "R" }, hl.dsp.exec_cmd("toggle bit-depth"))

Bind({ MainMod, "P" }, hl.dsp.exec_cmd("RBW_PROFILE=gui nohup picker password &>/dev/null"))

Bind({ MainMod, "SUPER_L" }, hl.dsp.exec_cmd("toggle bar"))
Bind({ MainMod, "SUPER_R" }, hl.dsp.exec_cmd("toggle bar"))

Bind({ MainMod, "SHIFT", "C" }, hl.dsp.exec_cmd("change-theme"))
Bind({ MainMod, "Grave" }, hl.dsp.workspace.toggle_special("scratch"))
Bind({ MainMod, "SHIFT", "U" }, hl.dsp.workspace.toggle_special("update"))

Bind({ MainMod, "O" }, hl.dsp.exec_cmd("hyprctl dispatch overview:toggle"))

Bind({ MainMod, "N" }, hl.dsp.exec_cmd("show-notifications"))

Bind({ MainMod, "D" }, hl.dsp.exec_cmd("wayscriber --active"))
Bind({ MainMod, "SHIFT", "D" }, hl.dsp.exec_cmd("toggle dnd"))

Bind({ MainMod, "V" }, hl.dsp.exec_cmd("nohup picker clipboard &> /dev/null"))

Bind({ MainMod, "SHIFT", "S" }, hl.dsp.exec_cmd("screenshot monitor"))
Bind({ MainMod, "S" }, hl.dsp.exec_cmd("~/.config/rofi/scripts/screenshot-menu"))
Bind({ MainMod, "C" }, hl.dsp.exec_cmd("picker color"))

Bind({ "XF86AudioLowerVolume" }, hl.dsp.exec_cmd("volume lower"), { locked = true, repeating = true })
Bind({ "F2" }, hl.dsp.exec_cmd("volume lower"), { locked = true, repeating = true })
Bind({ MainMod, "SHIFT", "down" }, hl.dsp.exec_cmd("volume lower"), { locked = true, repeating = true })

Bind({ "XF86AudioRaiseVolume" }, hl.dsp.exec_cmd("volume raise"), { locked = true, repeating = true })
Bind({ "F3" }, hl.dsp.exec_cmd("volume raise"), { locked = true, repeating = true })
Bind({ MainMod, "SHIFT", "up" }, hl.dsp.exec_cmd("volume raise"), { locked = true, repeating = true })

Bind({ "XF86AudioMute" }, hl.dsp.exec_cmd("volume mute"))
Bind({ "F1" }, hl.dsp.exec_cmd("volume mute"))

Bind({ "XF86AudioPlay" }, hl.dsp.exec_cmd("media play-pause"), { locked = true })
Bind({ "XF86AudioNext" }, hl.dsp.exec_cmd("media next"), { locked = true })
Bind({ "XF86AudioPrev" }, hl.dsp.exec_cmd("media previous"), { locked = true })

Bind({ "XF86MonBrightnessUp" }, hl.dsp.exec_cmd("brightness raise"), { locked = true, repeating = true })
Bind({ "F6" }, hl.dsp.exec_cmd("brightness raise"), { locked = true, repeating = true })
Bind({ MainMod, "ALT", "up" }, hl.dsp.exec_cmd("brightness raise"), { locked = true, repeating = true })

Bind({ "XF86MonBrightnessDown" }, hl.dsp.exec_cmd("brightness lower"), { locked = true, repeating = true })
Bind({ "F5" }, hl.dsp.exec_cmd("brightness lower"), { locked = true, repeating = true })
Bind({ MainMod, "ALT", "down" }, hl.dsp.exec_cmd("brightness lower"), { locked = true, repeating = true })

Bind({ MainMod, "left" }, function()
    focus_group_aware("left")
end)
Bind({ MainMod, "right" }, function()
    focus_group_aware("right")
end)
Bind({ MainMod, "up" }, function()
    focus_group_aware("up")
end)
Bind({ MainMod, "down" }, function()
    focus_group_aware("down")
end)

Bind({ MainMod, "SHIFT", "left" }, hl.dsp.focus({ workspace = "m-1" }))
Bind({ MainMod, "SHIFT", "right" }, hl.dsp.focus({ workspace = "m+1" }))

Bind({ MainMod, "SHIFT", "ALT", "left" }, hl.dsp.focus({ workspace = "r-1" }))
Bind({ MainMod, "SHIFT", "ALT", "right" }, hl.dsp.focus({ workspace = "r+1" }))

Bind({ MainMod, "1" }, hl.dsp.focus({ workspace = "1" }))
Bind({ MainMod, "2" }, hl.dsp.focus({ workspace = "2" }))
Bind({ MainMod, "3" }, hl.dsp.focus({ workspace = "3" }))
Bind({ MainMod, "4" }, hl.dsp.focus({ workspace = "4" }))
Bind({ MainMod, "5" }, hl.dsp.focus({ workspace = "5" }))
Bind({ MainMod, "6" }, hl.dsp.focus({ workspace = "6" }))
Bind({ MainMod, "7" }, hl.dsp.focus({ workspace = "7" }))
Bind({ MainMod, "8" }, hl.dsp.focus({ workspace = "8" }))
Bind({ MainMod, "9" }, hl.dsp.focus({ workspace = "9" }))
Bind({ MainMod, "0" }, hl.dsp.focus({ workspace = "10" }))

Bind({ MainMod, "SHIFT", "1" }, hl.dsp.window.move({ workspace = "1" }))
Bind({ MainMod, "SHIFT", "2" }, hl.dsp.window.move({ workspace = "2" }))
Bind({ MainMod, "SHIFT", "3" }, hl.dsp.window.move({ workspace = "3" }))
Bind({ MainMod, "SHIFT", "4" }, hl.dsp.window.move({ workspace = "4" }))
Bind({ MainMod, "SHIFT", "5" }, hl.dsp.window.move({ workspace = "5" }))
Bind({ MainMod, "SHIFT", "6" }, hl.dsp.window.move({ workspace = "6" }))
Bind({ MainMod, "SHIFT", "7" }, hl.dsp.window.move({ workspace = "7" }))
Bind({ MainMod, "SHIFT", "8" }, hl.dsp.window.move({ workspace = "8" }))
Bind({ MainMod, "SHIFT", "9" }, hl.dsp.window.move({ workspace = "9" }))
Bind({ MainMod, "SHIFT", "0" }, hl.dsp.window.move({ workspace = "10" }))

local workspace = function(ws)
    hl.exec_cmd(
        "(if [[ $(hyprctl monitors -j | jq -r '.[].id' | wc -l) -eq 1 ]]; then echo true; else echo false; fi) > /tmp/hyprland-one-monitor"
    )

    local file = io.open("/tmp/hyprland-one-monitor")

    if not file then
        return
    end

    local one_monitor = (file:read() == "true")

    if ws == "next" and one_monitor then
        return hl.dsp.focus({ workspace = "e+1" })
    elseif ws == "next" and not one_monitor then
        return hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "r" })
    elseif ws == "previous" and one_monitor then
        return hl.dsp.focus({ workspace = "e-1" })
    elseif ws == "previous" and not one_monitor then
        return hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "l" })
    end
end

Bind({ MainMod, "SHIFT", "CTRL", "left" }, workspace("previous"))
Bind({ MainMod, "SHIFT", "CTRL", "right" }, workspace("next"))
Bind({ MainMod, "CTRL", "left" }, hl.dsp.focus({ workspace = "r-1" }))
Bind({ MainMod, "CTRL", "right" }, hl.dsp.focus({ workspace = "r+1" }))

Bind({ MainMod, "mouse_down" }, hl.dsp.focus({ workspace = "e+1" }))
Bind({ MainMod, "mouse_up" }, hl.dsp.focus({ workspace = "e-1" }))

Bind({ MainMod, "mouse:272" }, hl.dsp.window.drag(), { mouse = true })
Bind({ MainMod, "SHIFT", "mouse:272" }, hl.dsp.window.resize(), { mouse = true })
Bind({ MainMod, "mouse:273" }, hl.dsp.window.resize(), { mouse = true })
Bind({ MainMod, "SHIFT", "mouse:273" }, hl.dsp.window.resize(), { mouse = true })

Bind({ MainMod, "U" }, hl.dsp.exec_cmd("pypr fetch_client_menu"))
Bind({ MainMod, "SHIFT", "Z" }, hl.dsp.exec_cmd("pypr zoom ++0.5"))
Bind({ MainMod, "Z" }, hl.dsp.exec_cmd("pypr zoom"))

local StartX = 0
local StartY = 0
local IsDragging = false

local function cloneStart()
    local cursor = hl.get_cursor_pos()
    if not cursor then
        return
    end

    StartX = cursor.x
    StartY = cursor.y
    IsDragging = true
end

local function cloneEnd()
    if not IsDragging then
        return
    end
    IsDragging = false

    local cursor = hl.get_cursor_pos()
    if not cursor then
        return
    end

    local monitor = hl.get_monitor_at_cursor().position
    local x = math.min(StartX, cursor.x) - monitor.x
    local y = math.min(StartY, cursor.y) - monitor.y
    local w = math.abs(StartX - cursor.x)
    local h = math.abs(StartY - cursor.y)

    hl.dispatch(hl.dsp.exec_cmd("kitty --single-instance", { float = true, move = { x, y }, size = { w, h } }))
end

Bind({ MainMod, "ALT", "mouse:272" }, cloneStart, { description = "Start dragging a kitty", mouse = true })
Bind({ MainMod, "ALT", "mouse:272" }, cloneEnd, { description = "End dragging a kitty", mouse = true, release = true })

Bind({ MainMod, "SHIFT", "T" }, function()
    local ws = hl.get_active_workspace()

    if not ws then
        return
    end

    local new_layout = ws.tiled_layout == "dwindle" and "scrolling" or "dwindle"

    hl.workspace_rule({
        layout = new_layout,
        workspace = tostring(ws.id),
        no_rounding = true,
        gaps_out = 0,
        gaps_in = 0,
    })

    hl.notification.create({
        text = " 󱂬    Workspace layout set to " .. new_layout,
        duration = 5000,
        icon = 5,
    })
end)

Bind({ "mouse:274" }, function()
    local active = hl.get_active_window()

    if active ~= nil and active.title:match("[Pp]icture[ -]in[ -][Pp]icture") then
        hl.dispatch(hl.dsp.window.drag())
    end
end, {
    mouse = true,
    non_consuming = true,
})
