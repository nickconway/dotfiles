hl.workspace_rule({
    workspace = "special:scratch",
    on_created_empty = "[size (monitor_w*0.75) (monitor_h*0.75); float; center] TMUX_SESSION_NAME=Scratch kitty",
})

hl.workspace_rule({
    workspace = "special:update",
    on_created_empty = "[size (monitor_w*0.75) (monitor_h*0.75); float; center] kitty tmux new -As Upgrade -e PROMPT_GUI=y upgrade",
})

hl.workspace_rule({
    workspace = "special:theme",
    on_created_empty = "[size (monitor_w*0.75) (monitor_h*0.75); float; center] kitty tmux new -As Theme _log change-theme",
})

hl.workspace_rule({
    workspace = "special:audio",
    on_created_empty = "[size (monitor_w*0.75) (monitor_h*0.75); float; center] pavucontrol",
})

hl.workspace_rule({
    workspace = "special:top",
    on_created_empty = "[size (monitor_w*0.75) (monitor_h*0.75); float; center] kitty btop",
})
