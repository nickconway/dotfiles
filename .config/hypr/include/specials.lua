hl.on("workspace.created", function(ws)
    if not ws.is_empty then
        return
    end

    if ws.name == "special:scratch" then
        Exec("TMUX_SESSION_NAME=Scratch kitty", {
            rules = { float = true, center = true, size = { "monitor_w * 0.75", "monitor_h * 0.75" } }
        })
    elseif ws.name == "special:update" then
        Exec("kitty tmux new -As Upgrade -e PROMPT_GUI=y inhibit upgrade", {
            rules = { float = true, center = true, size = { "monitor_w * 0.75", "monitor_h * 0.75" } }
        })
    elseif ws.name == "special:theme" then
        Exec("nohup _log change-theme &>/dev/null", {
            rules = { float = true, center = true, size = { "monitor_w * 0.75", "monitor_h * 0.75" } }
        })
    elseif ws.name == "special:audio" then
        Exec("pavucontrol", {
            rules = { float = true, center = true, size = { "monitor_w * 0.75", "monitor_h * 0.75" } }
        })
    elseif ws.name == "special:top" then
        Exec("kitty btop", {
            rules = { float = true, center = true, size = { "monitor_w * 0.75", "monitor_h * 0.75" } }
        })
    end
end)
