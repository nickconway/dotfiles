local function toggle_game_mode(mode)
    local options = {
        general = {
            gaps_in = 0,
            gaps_out = 0,
            border_size = 0,
        },

        animations = {
            enabled = false,
        },

        decoration = {
            shadow = { enabled = false },
            blur = { enabled = false },
            rounding = 0,
        },
    }

    local current_mode = (hl.get_config("animations.enabled") == false)

    if mode == true and current_mode == false then
        hl.config(options)
    elseif mode == false and current_mode == true then
        hl.exec_cmd("hyprctl reload")
    end
end

if hl.plugin.darkwindow ~= nil then
    if BackgroundRed then
        hl.window_rule({
            match = { fullscreen = "false" },
            ["darkwindow:shade"] = "multi-chroma count=2 similarity[0]=0.1 similarity[1]=0.02 amount[0]=1.4 amount[1]=1.4 targetOpacity[0]=0.83 targetOpacity[1]=0.83 bg[0]=["
                .. BackgroundRed
                .. " "
                .. BackgroundGreen
                .. " "
                .. BackgroundBlue
                .. "] bg[1]=[0 0 0]",
        })
    end

    hl.window_rule({ match = { title = "^([Pp]icture(-| )in(-| )[Pp]icture)$" }, ["darkwindow:shade"] = "none" })
    hl.window_rule({ match = { class = "^(feh)$" }, ["darkwindow:shade"] = "none" })

    hl.window_rule({
        match = { content = "video" },
        opacity = "1.0 override 1.0 override",
        ["darkwindow:shade"] = "none",
    })

    hl.window_rule({
        match = {
            title = ".*(YouTube|Twitch|Netflix|Prime Video).*",
        },
        opacity = "1.0 override 1.0 override",
        ["darkwindow:shade"] = "none",
    })
end

hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ match = { class = ".*" }, idle_inhibit = "fullscreen" })

hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, opacity = "0.0 override" })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_anim = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_initial_focus = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, max_size = { 1, 1 } })

hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, float = true })
hl.window_rule({ match = { class = "^(pinentry-gtk)$" }, float = true })

hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_blur = true })

hl.window_rule({ match = { class = "^(chromium)$" }, opacity = "1.0 override 0.9 override" })
hl.window_rule({
    match = { class = "^(chromium)$, match:title ^(.*YouTube.*)$" },
    opacity = "1.0 override 1.0 override",
})
hl.window_rule({ match = { class = "^(zen-alpha)$" }, opacity = "1.0 override 0.9 override" })
hl.window_rule({
    match = { class = "^(zen-alpha)$, match:title ^(.*YouTube.*)$" },
    opacity = "1.0 override 1.0 override",
})
hl.window_rule({ match = { class = "^(Brave-browser-beta)$" }, opacity = "1.0 override 0.9 override" })
hl.window_rule({
    match = { class = "^(Brave-browser-beta)$, match:title ^(.*YouTube.*)$" },
    opacity = "1.0 override 1.0 override",
})

hl.window_rule({ match = { title = "^([Pp]icture(-| )in(-| )[Pp]icture)$" }, float = true })
hl.window_rule({ match = { title = "^([Pp]icture(-| )in(-| )[Pp]icture)$" }, pin = true })
hl.window_rule({ match = { title = "^([Pp]icture(-| )in(-| )[Pp]icture)$" }, opacity = "1.0 override" })
hl.window_rule({
    match = { title = "^([Pp]icture(-| )in(-| )[Pp]icture)$" },
    move = { "(monitor_w - window_w - 30)", "(monitor_h - window_h-30)" },
})
hl.window_rule({ match = { title = "^([Pp]icture(-| )in(-| )[Pp]icture)$" }, no_initial_focus = true })
hl.window_rule({ match = { title = "^([Pp]icture(-| )in(-| )[Pp]icture)$" }, keep_aspect_ratio = true })

hl.window_rule({ match = { title = "^(Discord Popout)$" }, float = true })
hl.window_rule({ match = { title = "^(Discord Popout)$" }, pin = true })
hl.window_rule({ match = { title = "^(Discord Popout)$" }, opacity = "1.0 override" })
hl.window_rule({
    match = { title = "^(Discord Popout)$" },
    move = { "(monitor_w - window_w-30)", "(monitor_h - window_h-30)" },
})
hl.window_rule({ match = { title = "^(Discord Popout)$" }, no_initial_focus = true })

hl.window_rule({ match = { title = "^(_crx_.*)$" }, float = true })

hl.window_rule({ match = { title = "^(Floating Window - Show Me The Key)$" }, float = true })
hl.window_rule({ match = { title = "^(Floating Window - Show Me The Key)$" }, pin = true })
hl.window_rule({ match = { title = "^(Floating Window - Show Me The Key)$" }, no_blur = true })
hl.window_rule({ match = { title = "^(Floating Window - Show Me The Key)$" }, size = { 600, 64 } })
hl.window_rule({
    match = { title = "^(Floating Window - Show Me The Key)$" },
    move = { "(monitor_w - window_w - 30)", "(monitor_h - window_h-30)" },
})

hl.window_rule({ match = { class = "^(steam)$, match:title ^(notificationtoasts)" }, no_initial_focus = true })
hl.window_rule({ match = { class = "^(steam)$, match:title ^(notificationtoasts)" }, pin = true })

hl.window_rule({ match = { class = "^(mpv)$" }, center = true })
hl.window_rule({ match = { class = "^(mpv)$" }, float = true })
hl.window_rule({ match = { class = "^(mpv)$" }, keep_aspect_ratio = true })
hl.window_rule({ match = { class = "^(feh)$" }, center = true })
hl.window_rule({ match = { class = "^(feh)$" }, float = true })
hl.window_rule({ match = { class = "^(feh)$" }, keep_aspect_ratio = true })
hl.window_rule({ match = { class = "^(com.gabm.satty)$" }, center = true })
hl.window_rule({ match = { class = "^(com.gabm.satty)$" }, float = true })
hl.window_rule({ match = { class = "^(com.gabm.satty)$" }, keep_aspect_ratio = true })

hl.window_rule({ match = { modal = "true" }, float = true })

hl.window_rule({ match = { float = false, workspace = "w[tv1]s[false]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]s[false]" }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]s[false]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]s[false]" }, rounding = 0 })

local game_classes = { "steam_app_.*", "gamescope.*", "lutris_.*" }

-- for _, c in ipairs(game_classes) do
--     hl.window_rule({
--         workspace = "name:game",
--         match = {
--             class = c,
--         },
--     })
-- end

hl.on("window.active", function()
    for _, w in ipairs(hl.get_windows()) do
        for _, c in ipairs(game_classes) do
            if w.class:match(c) then
                toggle_game_mode(true)
                return
            end
        end
    end

    toggle_game_mode(false)
end)

hl.on("window.active", function(window)
    local ws = hl.get_active_workspace()
    if ws == nil or ws.tiled_layout ~= "scrolling" then
        return
    end

    if
        window == nil
        or window.floating
        or window.workspace == nil
        or window.layout == nil
        or window.layout.name ~= "scrolling"
        or window.layout.column == nil
    then
        return
    end

    local max_index = 0
    local column_index = window.layout.column.index

    for _, w in ipairs(hl.get_windows({ workspace = ws })) do
        if
            not w.floating
            and w.workspace ~= nil
            and w.workspace.id == w.workspace.id
            and w.layout ~= nil
            and w.layout.name == "scrolling"
            and w.layout.column ~= nil
        then
            if w.layout.column.index > max_index then
                max_index = w.layout.column.index
            end
        end
    end

    if column_index > 0 and column_index ~= max_index then
        hl.config({ scrolling = { focus_fit_method = 0 } })
    else
        hl.config({ scrolling = { focus_fit_method = 1 } })
    end

    -- Handles cursor warping shennanigans with centered floating windows
    local cursor = hl.get_cursor_pos()
    if cursor ~= nil then
        hl.dispatch(hl.dsp.layout("focus l"))
        hl.dispatch(hl.dsp.layout("focus r"))
        hl.dispatch(hl.dsp.cursor.move({
            x = cursor.x,
            y = cursor.y,
        }))
    end
end)
