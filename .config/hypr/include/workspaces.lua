hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })

hl.workspace_rule({
    workspace = "m[0]s[false]",
    layout = "scrolling",
    gaps_out = 0,
    gaps_in = 0,
    no_rounding = true,
    no_border = true,
})

hl.workspace_rule({ workspace = "name:game", monitor = "1", default = false })

local gameTimer = hl.timer(function()
    local ws = hl.get_active_workspace()

    if ws == nil or ws.name ~= "game" or ws.is_empty then
        return
    end

    hl.timer(function()
        ws = hl.get_active_workspace()

        if ws == nil or ws.name ~= "game" or ws.is_empty then
            return
        end

        hl.dispatch(hl.dsp.focus({ workspace = hl.get_last_workspace(hl.get_active_monitor()) }))
    end, { timeout = 500, type = "oneshot" })
end, { timeout = 1000, type = "repeat" })

gameTimer:set_enabled(false)

hl.on("window.close", function()
    gameTimer:set_enabled(true)
    hl.timer(function()
        gameTimer:set_enabled(false)
    end, { timeout = 2000, type = "oneshot" })
end)

hl.on("window.destroy", function()
    gameTimer:set_enabled(true)
    hl.timer(function()
        gameTimer:set_enabled(false)
    end, { timeout = 2000, type = "oneshot" })
end)

hl.on("workspace.active", function()
    if hl.get_active_special_workspace() then
        hl.dispatch(hl.dsp.workspace.toggle_special({}))
    end
end)
