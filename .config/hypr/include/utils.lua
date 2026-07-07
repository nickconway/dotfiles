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
