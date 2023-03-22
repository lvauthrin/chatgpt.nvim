vim.api.nvim_create_user_command("ChatGPT", function(opts)
	require("chatgpt.completion").complete(opts.args)
end, {
	nargs = "*",
})
