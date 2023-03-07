local M = {}
M.config = {}

function M.send_request(prompt)
	local json = vim.fn.json_encode({
		model = "gpt-3.5-turbo",
		messages = {
			{
				role = "user",
				content = prompt,
			},
		},
	})

	-- TODO: This won't work for nested quotes in the json (escaped quotes)
	-- local escaped_json = string.gsub(json, '"', '\\"')

	local curl_cmd = {
		"curl",
		"-s",
		"-H",
		"'Authorization: Bearer " .. M.config.api_key .. "'",
		"-H",
		"'Content-Type: application/json'",
		"https://api.openai.com/v1/chat/completions",
		"-d '" .. json .. "'",
	}

	local curl_cmd_ln = table.concat(curl_cmd, " ")

	--vim.notify("Using cmd: " .. vim.inspect(curl_cmd_ln), vim.log.levels.INFO)
	vim.notify("Sending request... " .. vim.inspect(prompt), vim.log.levels.INFO)
	local response = vim.fn.system(curl_cmd_ln)

	if response == nil then
		vim.notify("Could not get response from ChatGPT")
	end

	--vim.notify("Using response: " .. vim.inspect(response), vim.log.levels.INFO)
	-- TODO: This call is synchronous but should it be async?
	local parsed_response = vim.fn.json_decode(response)

	if parsed_response == nil then
		vim.notify("Could not parse response from ChatGPT: " .. response)
	end

	if parsed_response.choices == nil or #parsed_response.choices == 0 then
		vim.notify("No choices in response: " .. vim.inspect(parsed_response.choices))
	end

	vim.notify("Received " .. #parsed_response.choices .. " response")

	-- TODO: Remove this or move to debug
	print(parsed_response.choices)

	if parsed_response.choices[1].message == nil or parsed_response.choices[1].message.content == nil then
		vim.notify("No content in response: " .. vim.inspect(parsed_response.choices))
	end

	---- TODO: This returns a list.  Need bounds checking and possibly a way to view all
	return parsed_response.choices[1].message.content
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

function M.setup(config)
	-- TODO: Make this debug
	vim.notify("Loading ChatGPT Plugin...", vim.log.levels.INFO)

	assert(config, "config is required")
	assert(config.api_key and type(config.api_key) == "string", "Config must have an `api_key` property.")

	M.config.api_key = config.api_key

	vim.cmd([[command! -nargs=? ChatGPT lua require('chatgpt').complete('<args>')]])
end

return M
