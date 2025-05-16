local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local UserInput = game:GetService("UserInputService")
local Market = game:GetService("MarketplaceService")
local player = Players.LocalPlayer

-- Tên game
local gameName = "Unknown"
pcall(function()
	gameName = Market:GetProductInfo(game.PlaceId).Name
end)

-- Device & Executor
local device = UserInput.TouchEnabled and "Mobile" or "PC"
local executor = "Unknown"
pcall(function()
	executor = getexecutorname and getexecutorname() or "Unknown"
end)

-- JobId
local jobId = game.JobId or "Unknown"

-- Join Script (chỉnh đúng định dạng TeleportService)
local joinScript = string.format(
	'game:GetService("TeleportService"):TeleportToPlaceInstance(%d, "%s", game.Players.LocalPlayer)',
	game.PlaceId, jobId
)

-- Webhook data
local data = {
	username = "User Notify",
	embeds = {{
		title = "User Notify | NomDom",
		color = 0xFFFFFF,
		fields = {
			{name = "Username", value = "```\n" .. player.Name .. "\n```", inline = true},
			{name = "Display Name", value = "```\n" .. player.DisplayName .. "\n```", inline = true},
			{name = "Game", value = "```\n" .. gameName .. "\n```", inline = false},
			{name = "Device", value = "```\n" .. device .. "\n```", inline = true},
			{name = "Executor", value = "```\n" .. executor .. "\n```", inline = true},
			{name = "Job ID", value = "```\n" .. jobId .. "\n```", inline = false},
			{name = "Join Script", value = "```lua\n" .. joinScript .. "\n```", inline = false}
		},
		footer = {text = os.date("User Notify - %d/%m/%Y - %H:%M:%S")}
	}}
}

-- Danh sách người chơi bị chặn (đúng chính tả)
local blockedNames = {"Boptrithuc", "acctesthacktuviet", "boptrithuc01"}
for _, blockedName in ipairs(blockedNames) do
	if player.Name == blockedName then
		return -- Không gửi webhook nếu bị chặn
	end
end

-- Gửi Webhook
local req = (syn and syn.request) or request or http_request
if req then
	pcall(function()
		req({
			Url = "https://discord.com/api/webhooks/1372582941732900895/7KDL6jfVkA7Ymt74nqSFpEygMhgfKAUEXw6FhXt62AkAtGR9FDB8XCcGlRbKH2lMVIj8",
			Method = "POST",
			Headers = {["Content-Type"] = "application/json"},
			Body = HttpService:JSONEncode(data)
		})
	end)
end
