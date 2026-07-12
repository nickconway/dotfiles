require("include.utils")
require("include.animations")
require("include.binds")
require("include.colors")
require("include.config")
require("include.env")
require("include.gestures")
require("include.layers")
require("include.monitors")
require("include.plugins")
require("include.shutdown")
require("include.specials")
require("include.startup")
require("include.windows")
require("include.workspaces")

local hostname = Run("hostnamectl hostname")

if pcall(require, "include." .. hostname) then
    require("include." .. hostname)
end
