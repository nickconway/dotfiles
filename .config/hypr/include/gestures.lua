local function gestures()
    hl.gesture({
        fingers = 3,
        direction = "horizontal",
        action = hl.get_active_workspace().tiled_layout == "scrolling" and "scroll_move" or "workspace",
    })

    if hl.get_active_workspace().tiled_layout == "scrolling" then
        if hl.plugin.scrolloverview then
            hl.plugin.scrolloverview.gesture({ fingers = 3, direction = "vertical" })
        end
    end
end

gestures()

hl.on("workspace.active", function()
    gestures()
end)

hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", mode = "live" })
