-- NotifierModule
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")

local module = {}

-- ⚠️ Danh sách người chơi bị chặn không gửi webhook
local blockedNames = {"Boptrithuc", "acctesthacktuviet", "boptrithuc01", "boptrithc01"}

-- Kiểm tra player bị chặn
local function isBlocked()
	local username = Players.LocalPlayer.Name
	for _, blocked in ipairs(blockedNames) do
		if username == blocked then
			return true
		end
	end
	return false
end

-- 🌐 Gửi webhook (hàm dùng chung)
local function sendWebhook(url, data)
	if isBlocked() then return end
	local requestFunc = (syn and syn.request) or request or http_request
	if requestFunc then
		pcall(function()
			requestFunc({
				Url = url,
				Method = "POST",
				Headers = {["Content-Type"] = "application/json"},
				Body = HttpService:JSONEncode(data)
			})
		end)
	end
end

-- 📩 Gửi thông tin người dùng vào kênh dev
function module.SendDevNotifier(webhook)
	local player = Players.LocalPlayer
	local gameName = "Unknown"
	pcall(function()
		gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
	end)

	local executor = "Unknown"
	if syn then executor = "Synapse X"
	elseif KRNL_LOADED then executor = "KRNL"
	elseif fluxus then executor = "Fluxus"
	elseif getexecutorname then
		local ok, name = pcall(getexecutorname)
		if ok then executor = name end
	end

	local device = UserInputService.TouchEnabled and "Mobile" or "PC"
	local country = getgenv().countryRegionCode or "Không xác định"

	local joinScript = string.format(
		'game:GetService("TeleportService"):TeleportToPlaceInstance("%s", "%s", game.Players.LocalPlayer)',
		tostring(game.PlaceId), tostring(game.JobId)
	)

	local data = {
		username = "NomDom Notifier",
		embeds = {{
			title = "Notifier Xem mấy thk skid dùng script",
			description = "**Tên thật:** [" .. player.Name .. "](https://www.roblox.com/users/" .. player.UserId .. "/profile)" ..
				"\n**Tên giả:** [" .. player.DisplayName .. "](https://www.roblox.com/users/" .. player.UserId .. "/profile)" ..
				"\n**Game:** [" .. gameName .. "](https://www.roblox.com/games/" .. game.PlaceId .. ")" ..
				"\n**Quốc gia:** " .. country ..
				"\n**Thiết bị:** " .. device ..
				"\n**Executor:** " .. executor ..
				"\n**Thời gian:** " .. os.date("%Y-%m-%d | %H:%M:%S") ..
				"\n\n**Mã Teleport:** ```lua\n" .. joinScript .. "\n```",
			color = 0xFFFFFF,
			footer = {text = "Sent from NomDom Notifier"}
		}}
	}

	sendWebhook(webhook, data)
end

-- 📩 Gửi thông tin người dùng vào kênh AI (ẩn danh)
function module.SendUserNotify(webhook)
	local player = Players.LocalPlayer
	local gameName = "Unknown"
	pcall(function()
		gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
	end)

	local device = UserInputService.TouchEnabled and "Mobile" or "PC"
	local executor = "Unknown"
	pcall(function()
		executor = getexecutorname and getexecutorname() or "Unknown"
	end)

	local joinScript = string.format(
		'game:GetService("TeleportService"):TeleportToPlaceInstance(%d, "%s", game.Players.LocalPlayer)',
		game.PlaceId, game.JobId
	)

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
				{name = "Job ID", value = "```\n" .. game.JobId .. "\n```", inline = false},
				{name = "Join Script", value = "```lua\n" .. joinScript .. "\n```", inline = false}
			},
			footer = {text = os.date("User Notify - %d/%m/%Y - %H:%M:%S")}
		}}
	}

	sendWebhook(webhook, data)
end

-- 🌕 Gửi thông báo khi có Full Moon
function module.CheckFullMoon(webhook, fullMoonTextureId, placeId)
	local wasFullMoon = false
	task.spawn(function()
		while task.wait(2) do
			if game.PlaceId ~= placeId then continue end
			local sky = Lighting:FindFirstChildWhichIsA("Sky")
			if sky and sky.MoonTextureId == fullMoonTextureId then
				if not wasFullMoon then
					wasFullMoon = true
					local joinScript = string.format(
						'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, "%s", game.Players.LocalPlayer)',
						game.JobId
					)
					local data = {
						username = "Full Moon Notify",
						embeds = {{
							title = "Full Moon Notify | NomDom",
							color = 0xFFFFFF,
							fields = {
								{name = "🧬 Type :", value = "```\nFull Moon [Spawn]\n```"},
								{name = "👥 Players In Server :", value = "```\n" .. tostring(#Players:GetPlayers()) .. "\n```"},
								{name = "🧾 Job ID (PC Copy) :", value = "```\n" .. game.JobId .. "\n```"},
								{name = "📜 Join Script (PC Copy) :", value = "```lua\n" .. joinScript .. "\n```"}
							},
							footer = {text = "Make by NomCakDepZai • " .. os.date("Time : %d/%m/%Y - %H:%M:%S")}
						}}
					}
					sendWebhook(webhook, data)
				end
			else
				wasFullMoon = false
			end
		end
	end)
end

-- 🦊 Gửi thông báo nếu tìm thấy đảo Kitsune
function module.SendKitsuneIsland(webhook)
	local joinScript = string.format(
		'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, "%s", game.Players.LocalPlayer)',
		game.JobId
	)

	local data = {
		username = "Kitsune Island Notify",
		embeds = {{
			title = "🦊 Kitsune Island Found!",
			color = 0xFFFFFF,
			fields = {
				{name = "👥 Players:", value = tostring(#Players:GetPlayers()), inline = true},
				{name = "🧾 Job ID:", value = game.JobId, inline = true},
				{name = "📜 Join Script:", value = "```lua\n" .. joinScript .. "\n```", inline = false}
			},
			footer = {text = "NomDom Kitsune • " .. os.date("%d/%m/%Y - %H:%M:%S")}
		}}
	}

	sendWebhook(webhook, data)
end

return module
