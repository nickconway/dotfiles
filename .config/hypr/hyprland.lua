local file = io.popen("lspci | grep -i 'vga.*nvidia'")
NVIDIA = file and file:read("*a") ~= "" or false

local colors_file_path = os.getenv("HOME") .. "/.config/hypr/include/colors.lua"
file = io.open(colors_file_path, "r")

if file == nil then
    file = io.open(colors_file_path, "w")
    if file ~= nil then
        file:write('Color0Alpha = ""', "\n", 'Color2 = ""', "\n", 'Color3 = ""', "\n", 'BackgroundRed = ""')
        file:close()
    end
else
    file:close()
end

require("include.colors")

require("include.animations")
require("include.binds")
require("include.config")
require("include.env")
require("include.gestures")
require("include.layers")
require("include.monitors")
require("include.plugins")
require("include.specials")
require("include.startup")
require("include.windows")
require("include.workspaces")

hl.timer(function()
    local monitor = hl.get_monitor("DP-3")

    if monitor == nil then
        return
    end

    if monitor.width ~= 3840 then
        hl.monitor({ output = "DP-1", mode = "1920x1080", scale = "1.33", bitdepth = 10 })
        hl.timer(function()
            hl.monitor({ output = "DP-1", mode = "preferred", scale = "1.33", bitdepth = 10 })
        end, { type = "oneshot", timeout = 5000 })
    end
end, { timeout = 5000, type = "repeat" })
