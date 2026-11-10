hl.on("workspace.created", function()
    local ws = hl.get_active_special_workspace()

    if ws and ws.windows == 0 then
        if ws.name == "special:scratch" then
            Exec("[size (monitor_w*0.75) (monitor_h*0.75); float; center] TMUX_SESSION_NAME=Scratch kitty")
        elseif ws.name == "special:update" then
            Exec(
                "[size (monitor_w*0.75) (monitor_h*0.75); float; center] kitty tmux new -As Upgrade -e PROMPT_GUI=y inhibit upgrade"
            )
        elseif ws.name == "special:theme" then
            Exec("[size (monitor_w*0.75) (monitor_h*0.75); float; center] nohup change-theme &>/dev/null")
        elseif ws.name == "special:audio" then
            Exec("[size (monitor_w*0.75) (monitor_h*0.75); float; center] pavucontrol")
        elseif ws.name == "special:top" then
            Exec("[size (monitor_w*0.75) (monitor_h*0.75); float; center] kitty btop")
        end
    end
end)
