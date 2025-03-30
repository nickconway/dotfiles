local function file_exists(name)
    local f = io.open(name, "r")
    return f ~= nil and io.close(f)
end

return {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    lazy = false,
    enabled = file_exists(os.getenv("HOME") .. "/.cache/wal/colors"),
    priority = 1000,
    opts = {
        transparent_background = true,
        plugins = {
            markdown = true,
        }
    },
}
