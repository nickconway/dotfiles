hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = hl.get_active_workspace().tiled_layout == "scrolling" and "scroll_move" or "workspace",
})
hl.gesture({ fingers = 3, direction = "pinch", action = "cursorZoom", mode = "live" })

if hl.plugin.scrolloverview then
    hl.plugin.scrolloverview.gesture({ fingers = 3, direction = "vertical" })
end
