-- Helper function to reload a module
local t = require("plenary.busted")
local mock = require("luassert.mock")
--local stub = require("luassert.stub")

-- TODO: Fix
--t.describe("ChatGPT plugin", function()
--	local completion = require("chatgpt.completion")
--
--	t.it("sets up the ChatGPT command", function()
--		local completionMock = mock(completion, true)
--		local result = vim.cmd("ChatGPT")
--		print(result)
--		completionMock.complete.thenReturn("Neo... vim")
--		assert.same(response, "Neo... vim")
--	end)
--end)
