--package.path = package.path .. ";lua/?/init.lua"

local t = require("plenary.busted")
local mock = require("luassert.mock")
--local stub = require("luassert.stub")

t.describe("completion module", function()
	local curl = require("curl")
	local config = require("chatgpt.config")
	local completion = require("chatgpt.completion")

	t.it("sends a valid request", function()
		local curlMock = mock(curl, true)

		curlMock.get_json.returns({
			choices = {
				{
					message = {
						content = "Neo... vim",
					},
				},
			},
		})

		local configMock = mock(config, true)
		configMock.api_key = "some-key"

		local response = completion.send_request("What is your name?")
		assert.same(response, "Neo... vim")
	end)
end)
