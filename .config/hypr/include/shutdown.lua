hl.on("hyprland.shutdown", function()
    hl.dispatch(hl.dsp.exec_cmd("hyprshutdown"))
end)
