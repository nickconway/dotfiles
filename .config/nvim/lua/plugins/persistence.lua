return {
    "folke/persistence.nvim",
    event = "BufReadPre",
    enabled = os.getenv("AUTOSESSION_DISABLED"),
    opts = {},
}
