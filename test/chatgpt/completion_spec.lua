package.path = package.path .. ";lua/?/init.lua"

local t = require("plenary.busted")
local mock = require("luassert.mock")
--local stub = require("luassert.stub")

t.describe("completion module", function()
	local completion = require("completion")
	local curl = require("curl")
	completion.setup({ api_key = os.getenv("OPENAI_API_KEY") })

	t.it("send valid requests", function()
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

		local response = completion.send_request("What is your name?")
		assert.same(response, "Neo... vim")
	end)
end)
