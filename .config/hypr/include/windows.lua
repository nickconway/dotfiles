-- if BackgroundRed then
-- hl.window_rule({ match = { title = "^(Picture in picture)$" }, darkwindow:shade "none"})
-- hl.window_rule({ match = { class = "^(feh)$" }, darkwindow:shade "none"})
-- hl.window_rule({ match = { fullscreen = "false" }, darkwindow:shade multi-chroma count=2 similarity[0]=0.1 similarity[1]=0.02 amount[0]=1.4 amount[1]=1.4 targetOpacity[0]=0.83 targetOpacity[1]=0.83 bg[0]=[$backgroundRed $backgroundGreen $backgroundBlue] bg[1]=[0 0 0]})
-- end

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

hl.window_rule({ match = { title = "^(Picture(-| )in(-| )[Pp]icture)$" }, float = true })
hl.window_rule({ match = { title = "^(Picture(-| )in(-| )[Pp]icture)$" }, pin = true })
hl.window_rule({ match = { title = "^(Picture(-| )in(-| )[Pp]icture)$" }, opacity = "1.0 override" })
hl.window_rule({
    match = { title = "^(Picture(-| )in(-| )[Pp]icture)$" },
    move = { "(monitor_w - window_w - 30)", "(monitor_h - window_h-30)" },
})
hl.window_rule({ match = { title = "^(Picture(-| )in(-| )[Pp]icture)$" }, no_initial_focus = true })
hl.window_rule({ match = { title = "^(Picture(-| )in(-| )[Pp]icture)$" }, keep_aspect_ratio = true })

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
