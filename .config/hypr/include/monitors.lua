hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "1" })
hl.monitor({ output = "Sunshine", position = "100000x100000" })

hl.exec_cmd("hyprctl output create headless Sunshine")
