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

hl.on("window.destroy", function()
    if hl.get_active_workspace().name == "game" and (hl.get_active_workspace().windows == 0) then
        local ws = hl.get_last_workspace(hl.get_active_monitor())

        if ws == nil then
            for _, w in ipairs(hl.get_workspaces()) do
                if w.monitor.id == hl.get_active_monitor().id then
                    ws = w
                    break
                end
            end
        end

        if ws == nil then
            return
        end

        hl.dispatch(hl.dsp.focus({ workspace = ws }))
    end
end)

hl.on("workspace.active", function()
    if hl.get_active_special_workspace() then
        hl.dispatch(hl.dsp.workspace.toggle_special({}))
    end
end)
