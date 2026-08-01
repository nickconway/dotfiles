hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = {
        start = function(e)
            if hl.get_active_workspace().tiled_layout == "scrolling" then
                Focus_Group_Aware(e.delta.x > 0 and "left" or "right")
            else
                hl.dispatch(hl.dsp.focus({ workspace = ("m" .. (e.delta.x > 0 and "+" or "-") .. "1") }))
            end
        end,
    },
})

if hl.get_active_workspace().tiled_layout == "scrolling" then
    if hl.plugin.scrolloverview then
        hl.plugin.scrolloverview.gesture({ fingers = 3, direction = "vertical" })
    end
end

hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", mode = "live" })

hl.gesture({
    fingers = 4,
    direction = "vertical",
    action = {
        start = function(e)
            Volume(-0.25 * e.delta.y)
        end,
        update = function(e)
            Volume(-0.25 * e.delta.y)
        end,
    },
})
