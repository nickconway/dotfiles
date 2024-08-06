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
            default_command_agent = "Ollama",
            default_chat_agent = "Ollama",
            command_prompt_prefix_template = "{{agent}}",
            agents = {
                {
                    provider = "ollama",
                    name = "Ollama",
                    disable = false,
                    chat = true,
                    command = true,
                    model = {
                        model = "llama3.1",
                        temperature = 0.4,
                        top_p = 1,
                        min_p = 0.05,
                    },
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
            },
        })
    end,
}
