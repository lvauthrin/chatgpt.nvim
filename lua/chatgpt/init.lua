local M = {}

function M.setup(cfg)
	-- TODO: Make this debug
	print("Loading ChatGPT Plugin...")
	local config = require("chatgpt.config")

	assert(cfg, "config is required")
	assert(cfg.api_key and type(cfg.api_key) == "string", "Config must have an `api_key` property.")

	config.api_key = cfg.api_key
end

vim.api.nvim_create_user_command("ChatGPT", function(opts)
	require("chatgpt.completion").complete(opts.args)
end, {
	nargs = "*",
})

return M
