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
                    provider = "ollama",
                    name = "Ollama",
                    chat = true,
                    command = true,
                    model = {
                        model = "llama3.1",
                        temperature = 0.4,
                        top_p = 1,
                        min_p = 0.05,
                    },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
            },
        })
    end,
}
