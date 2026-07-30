hl.curve("Linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("Bouncy", { type = "bezier", points = { { 0, 0.9 }, { 0.05, 1.5 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "Bouncy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "Bouncy", style = "popin" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "Bouncy", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 15, bezier = "Linear" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "Linear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "Bouncy" })
