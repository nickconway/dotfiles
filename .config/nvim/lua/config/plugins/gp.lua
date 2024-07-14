return {
    "robitx/gp.nvim",
    config = function()
        require("gp").setup({
            openai_api_key = "1234",
            providers = {
                ollama = {
                    endpoint = os.getenv("OLLAMA_URL") .. "/v1/chat/completions",
                },
            },
            agents = {
                {
                    name = "ChatGPT3-5",
                    disable = true,
                },
                {
                    name = "ChatGPT4o",
                    disable = true,
                },
                {
                    name = "Ollama",
                    provider = "ollama",
                    chat = true,
                    command = true,
                    model = { model = "llama3" },
                    -- system_prompt = "Answer any query with just: Sure thing..",
                },
            },
        })
    end,
}
