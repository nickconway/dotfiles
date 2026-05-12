Bind({ MainMod, "B" }, hl.dsp.focus({ workspace = "1" }))
Bind({ MainMod, "T" }, hl.dsp.focus({ workspace = "2" }))
Bind({ MainMod, "D" }, hl.dsp.focus({ workspace = "3" }))
Bind({ MainMod, "X" }, hl.dsp.focus({ workspace = "4" }))
Bind({ MainMod, "M" }, hl.dsp.focus({ workspace = "5" }))
Bind({ MainMod, "F" }, hl.dsp.focus({ workspace = "6" }))

hl.workspace_rule({ workspace = "1", on_created_empty = "chromium" })
hl.workspace_rule({ workspace = "2", on_created_empty = "kitty" })
hl.workspace_rule({ workspace = "3", on_created_empty = "flatpak run dev.vencord.Vesktop" })
hl.workspace_rule({
    workspace = "4",
    on_created_empty = "chromium --app='https://messages.google.com/web' & flatpak run app.bluebubbles.BlueBubbles",
})
hl.workspace_rule({ workspace = "5", on_created_empty = "thunderbird-beta" })
hl.workspace_rule({ workspace = "6", on_created_empty = "feishin --ozone-platform-hint=auto" })
