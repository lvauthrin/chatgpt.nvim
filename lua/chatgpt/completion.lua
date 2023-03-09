local M = {}

function M.send_request(prompt)
	local curl = require("curl")
	local config = require("chatgpt.config")

	local body = {
		model = "gpt-3.5-turbo",
		messages = {
			{
				role = "user",
				content = prompt,
			},
		},
	}

	local response = curl.get_json("https://api.openai.com/v1/chat/completions", {
		Authorization = "Bearer " .. config.api_key,
		["Content-Type"] = "application/json",
	}, body)

	if response == nil then
		vim.notify("Could not parse response from ChatGPT: " .. response)
	end

	--vim.notify("Using response: " .. vim.inspect(response), vim.log.levels.INFO)
	--print(vim.inspect(response.choices))

	return response.choices[1].message.content
end

function M.complete(prompt)
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))

	if prompt == nil or prompt == "" then
		local lines = vim.api.nvim_buf_get_lines(0, row - 1, row, true)
		prompt = lines[1]
	end

	--vim.notify("Using prompt: " .. prompt, vim.log.levels.DEBUG)

	local ans = M.send_request(prompt)
	local ans_arr = vim.split(ans, "\n")
	--vim.notify("Using prompt: " .. vim.inspect(ans_arr), vim.log.levels.DEBUG)

	vim.api.nvim_buf_set_text(0, row, col, row, col, ans_arr)
end

return M
