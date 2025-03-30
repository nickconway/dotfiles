return {
    "ramilito/kubectl.nvim",
    keys = {
        { "<leader>K", '<cmd>lua require("kubectl").toggle()<cr>', desc = "Kubectl" },
    },
    opts = {},
}
