hl.on("hyprland.shutdown", function()
    Session("save")
    hl.dispatch(hl.dsp.exec_cmd("hyprshutdown"))
end)
