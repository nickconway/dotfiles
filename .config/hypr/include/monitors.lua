hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "1" })

hl.exec_cmd("hyprctl output create headless Sunshine")
hl.monitor({ output = "Sunshine", mode = "3840x2160@120", position = "100000x100000", scale = "1", disabled = true })
