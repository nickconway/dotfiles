-- hl.gesture({
--     fingers = 3,
--     direction = "horizontal",
--     action = hl.get_active_workspace().tiled_layout == "scrolling" and "scroll_move" or "workspace",
-- })

if hl.plugin.scrolloverview then
    hl.gesture({
        fingers = 3,
        direction = "vertical",
        action = function()
            hl.plugin.scrolloverview.overview("toggle")
        end,
    })
end

hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", mode = "live" })
