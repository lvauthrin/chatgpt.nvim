local M = {}

function M.get_json(url, headers, body)
	local header_string = ""
	headers = headers or {}

	for key, value in pairs(headers) do
		header_string = header_string .. " -H '" .. key .. ": " .. value .. "'"
	end

	local curl_cmd = {
		"curl",
		"-s",
		header_string,
		"'" .. url .. "'",
	}

	if body ~= nil then
		table.insert(curl_cmd, "-d '" .. vim.fn.json_encode(body) .. "'")
	end

	local curl_cmd_ln = table.concat(curl_cmd, " ")
	--print("Sending request: " .. vim.inspect(curl_cmd_ln))

	local response = vim.fn.system(curl_cmd_ln)

	if response == nil then
		print("Could not get response from: " .. vim.inspect(curl_cmd_ln))
	end

	--vim.notify("Using response: " .. vim.inspect(response), vim.log.levels.INFO)
	-- TODO: This call is synchronous but should it be async?
	return vim.fn.json_decode(response)
end

return M
