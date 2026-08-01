Bind = function(keys, action, opts)
    hl.bind(type(keys) == "table" and table.concat(keys, " + ") or keys, action, opts or {})
end

Run = function(cmd)
    local file = io.popen(cmd)

    if file then
        return file:read("*a"):match("^%s*(.-)%s*$")
    end
end

Focus = function(class, cmd)
    for _, m in ipairs(hl.get_monitors()) do
        local window = hl.get_windows({ class = class, workspace = hl.get_active_workspace(m) })[1]

        if window ~= nil then
            hl.dispatch(hl.dsp.focus({ window = window }))
            return
        end
    end

    hl.exec_cmd(cmd or class)
end

Session = function(op, name, icon)
    local cmd = "hyprsession " .. op

    if name then
        cmd = cmd .. " " .. name
    end

    if icon then
        cmd = cmd .. " " .. icon
    end

    hl.exec_cmd(cmd)
end

Focus_Group_Aware = function(direction)
    local win = hl.get_active_window()

    if not win then
        hl.dispatch(hl.dsp.focus({ direction = direction }))
        return
    end

    local group = win.group

    if group then
        if direction == "left" then
            if group.current_index > 1 then
                hl.dispatch(hl.dsp.group.prev())
                return
            end
        elseif direction == "right" then
            if group.current_index < group.size then
                hl.dispatch(hl.dsp.group.next())
                return
            end
        end
    end

    hl.dispatch(hl.dsp.focus({ direction = direction }))
end

Zoom = function(offset)
    local current = hl.get_config("cursor.zoom_factor")

    if offset ~= nil then
        current = current + offset
    else
        current = current == 1 and 1.5 or 1
    end

    hl.config({ cursor = { zoom_factor = current } })
end

Volume = function(change)
    hl.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. math.abs(change) .. "%" .. (change < 0 and "-" or "+"))
end
