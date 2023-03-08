package.path = package.path .. ";lua/?/init.lua"

local t = require("plenary.busted")

t.describe("Curl module", function()
	t.it("get_json should parse json responses", function()
		local response = require("curl").get_json("https://www.postman-echo.com/get?choice=message", {
			["Content-Type"] = "application/json",
		})

		response.headers["x-amzn-trace-id"] = ""

		assert.same(response, {
			args = {
				choice = "message",
			},
			headers = {
				accept = "*/*",
				["content-type"] = "application/json",
				host = "www.postman-echo.com",
				["user-agent"] = "curl/7.85.0",
				["x-amzn-trace-id"] = "",
				["x-forwarded-port"] = "443",
				["x-forwarded-proto"] = "https",
			},
			url = "https://www.postman-echo.com/get?choice=message",
		})
	end)
end)
