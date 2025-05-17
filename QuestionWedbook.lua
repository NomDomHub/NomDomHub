local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local UserInput = game:GetService("UserInputService")
local Market = game:GetService("MarketplaceService")
local player = Players.LocalPlayer

-- Lấy tên game
local gameName = "Unknown"
pcall(function()
	gameName = Market:GetProductInfo(game.PlaceId).Name
end)

-- Lấy thiết bị và executor
local device = UserInput.TouchEnabled and "Mobile" or "PC"
local executor = "Unknown"
pcall(function()
	executor = getexecutorname and getexecutorname() or "Unknown"
end)

-- Gửi webhook
local function sendWebhook(answer)
	local joinScript = string.format(
		'game:GetService("TeleportService"):TeleportToPlaceInstance(%d, "%s", game.Players.LocalPlayer)',
		game.PlaceId, game.JobId or "Unknown"
	)

	local data = {
		username = "Active Script Statistics Notify",
		embeds = {{
			title = "Active Script Statistics Notify | NomDom",
			color = 0xFFFFFF,
			fields = {
				{name = "Username", value = "```\n" .. player.Name .. "\n```", inline = true},
				{name = "Game", value = "```\n" .. gameName .. "\n```", inline = false},
				{name = "Device", value = "```\n" .. device .. "\n```", inline = true},
				{name = "Executor", value = "```\n" .. executor .. "\n```", inline = true},
				{name = "Answer", value = "```\n" .. answer .. "\n```", inline = false},
				{name = "Join Script", value = "```lua\n" .. joinScript .. "\n```", inline = false}
			},
			footer = {text = os.date("User Notify - %d/%m/%Y - %H:%M:%S")}
		}}
	}

	local blockedNames = {"Boptrithuc", "acctesthacktuviet", "boptrithuc01"}
	for _, name in ipairs(blockedNames) do
		if player.Name == name then return end
	end

	local req = (syn and syn.request) or request or http_request
	if req then
		pcall(function()
			req({
				Url = "https://discord.com/api/webhooks/1372951128852926606/DhA_39RHMRnq-Orp5AZa8SjwEE4OywjSMlMj4Ka11d5CSEoNH8gbus4cc-qjk4oPJmBY",
				Method = "POST",
				Headers = {["Content-Type"] = "application/json"},
				Body = HttpService:JSONEncode(data)
			})
		end)
	end
end

-- Tạo thông báo chọn Yes/No
local Bindable = Instance.new("BindableFunction")
local notificationSent = false

function Bindable.OnInvoke(response)
	if not notificationSent then
		notificationSent = true

		if response == "Yes" then
			game.StarterGui:SetCore("SendNotification", {
				Title = "Shark [AI]",
				Text = "Thế dùng đi",
				Icon = "rbxassetid://81747018704333",
				Duration = 5
			})
			game.StarterGui:SetCore("SendNotification", {
				Title = "Duck [AI]",
				Text = "Chúc chú em dùng script vui vẻ",
				Icon = "rbxassetid://78304081979681",
				Duration = 5
			})
		else
			game.StarterGui:SetCore("SendNotification", {
				Title = "Yae Miko [AI]",
				Text = "Xin lỗi , đợi Developer fix",
				Icon = "rbxassetid://70924166490606",
				Duration = 5
			})
		end

		sendWebhook(response)
	end
end

-- Hiển thị câu hỏi ban đầu
game.StarterGui:SetCore("SendNotification", {
	Title = "NomDom [AI]",
	Text = "Script có hoạt động không ?",
	Icon = "rbxassetid://96047972824190",
	Duration = 9999999,
	Button1 = "Yes",
	Button2 = "No",
	Callback = Bindable
})
