hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "pinch", action = "cursorZoom", mode = "live" })

if hl.plugin.scrolloverview then
    hl.plugin.scrolloverview.gesture({ fingers = 3, direction = "vertical" })
end
