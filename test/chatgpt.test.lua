-- Helper function to reload a module
function import(module)
	if package.loaded[module] then
		require("plenary.reload").reload_module(module)
		return require(module)
	else
		return require(module)
	end
end

local chatgpt = import("chatgpt")
chatgpt.setup({ api_key = os.getenv("OPENAI_API_KEY") })

-- TODO: Think about how this can be tested
--vim.cmd("ChatGPT")
--vim.cmd("ChatGPT How do you print a table in lua?")
