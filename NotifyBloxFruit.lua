---- Notify

--// Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Enemies = workspace:WaitForChild("Enemies")
local Lighting = game:GetService("Lighting")

--// Constants
local SEA2_PLACE_ID = 2753915549
local SEA2_PLACE_ID = 4442272183
local SEA3_PLACE_ID = 7449423635
local jobId = tostring(game.JobId)
local playerCount = #Players:GetPlayers()
local joinScript = string.format(
    'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, "%s", game.Players.LocalPlayer)',
    jobId
)

--// Webhook Configuration
local Dora = {
    ["Mirage Island"] = "https://discord.com/api/webhooks/1380459386081902592/9bN2NFLdi0HQvwuRGj6L0njsBa5TQdA_cuc6bdQPC5lWzyZC00dpX8MmMzyrM7xzg0Y0",
    ["Kitsune Island"] = "https://discord.com/api/webhooks/1372583122343821444/28vI4H32zRdy_a6Z_QH2ynyuQRl7snfIxU0xiZSF4UnKl-3hhgT6-y-EwBeAq7xQbNvF",
    ["Prehistoric Island"] = "https://discord.com/api/webhooks/1372584042410545204/Va7WQ9WDHGKlRsgkn6fSD2UnXCqKkdJjkd3ByGrBy68gIbe_Sub3qxrZyzwuvci_5ISY",
    ["Full Moon"] = "https://discord.com/api/webhooks/1374815906135539832/XUCn6Fwqg9IEQwH0Y2vnqUX7t3PkG25_hTQ-56iYN8XjTJLelNGOPvhTl7oLsJJref7I",
    ["Near Full Moon"] = "https://discord.com/api/webhooks/1371833001234923570/VJSR5cyCueolCLtKA1wmB8G5lX505sPX5E9NE8vfKoB3ZSnaDTF1k4GpmrlxA04yz_wX",
    ["Rip Indra"] = "https://discord.com/api/webhooks/1374816635042402398/PThu03Wn8pWv7l6pVowHt0E4bdVgjPybKybwfNltr2pZc7XITEW3oqp7ZSN6rbFqKlpy",
    ["Dough King"] = "https://discord.com/api/webhooks/1374816635042402398/PThu03Wn8pWv7l6pVowHt0E4bdVgjPybKybwfNltr2pZc7XITEW3oqp7ZSN6rbFqKlpy",
    ["Cake Prince"] = "https://discord.com/api/webhooks/1374816635042402398/PThu03Wn8pWv7l6pVowHt0E4bdVgjPybKybwfNltr2pZc7XITEW3oqp7ZSN6rbFqKlpy",
    ["Tyrant of the Skies"] = "https://discord.com/api/webhooks/1374816635042402398/PThu03Wn8pWv7l6pVowHt0E4bdVgjPybKybwfNltr2pZc7XITEW3oqp7ZSN6rbFqKlpy",
    ["Darkbeard"] = "https://discord.com/api/webhooks/1374816635042402398/PThu03Wn8pWv7l6pVowHt0E4bdVgjPybKybwfNltr2pZc7XITEW3oqp7ZSN6rbFqKlpy",
    ["Soul Reaper"] = "https://discord.com/api/webhooks/1374816635042402398/PThu03Wn8pWv7l6pVowHt0E4bdVgjPybKybwfNltr2pZc7XITEW3oqp7ZSN6rbFqKlpy",
    ["Cursed Captain"] = "https://discord.com/api/webhooks/1374816635042402398/PThu03Wn8pWv7l6pVowHt0E4bdVgjPybKybwfNltr2pZc7XITEW3oqp7ZSN6rbFqKlpy",
    ["Legendary Sword"] = "https://discord.com/api/webhooks/1374833599718625490/C5xZWPnjAwXgBi-o-3O-576UVimCYKsk_KkthLGJyuH4u7zk38v6tKYEJJsQdjdA8wKK"
}

local TuanAnhIos = {
    ["Mirage Island"] = "https://discord.com/api/webhooks/1384083264167350272/5WMffqRckI3YzT3zzfRdeFKXs3zjJ3fjclFxR2nKzkbw49rAWDy4s-kNxa7l8cyDX5k0",
    ["Kitsune Island"] = "https://discord.com/api/webhooks/1384083264167350272/5WMffqRckI3YzT3zzfRdeFKXs3zjJ3fjclFxR2nKzkbw49rAWDy4s-kNxa7l8cyDX5k0",
    ["Prehistoric Island"] = "https://discord.com/api/webhooks/1384083264167350272/5WMffqRckI3YzT3zzfRdeFKXs3zjJ3fjclFxR2nKzkbw49rAWDy4s-kNxa7l8cyDX5k0",
    ["Full Moon"] = "https://discord.com/api/webhooks/1384083264167350272/5WMffqRckI3YzT3zzfRdeFKXs3zjJ3fjclFxR2nKzkbw49rAWDy4s-kNxa7l8cyDX5k0",
    ["Near Full Moon"] = "https://discord.com/api/webhooks/1384083264167350272/5WMffqRckI3YzT3zzfRdeFKXs3zjJ3fjclFxR2nKzkbw49rAWDy4s-kNxa7l8cyDX5k0",
    ["Rip Indra"] = "https://discord.com/api/webhooks/1384083264167350272/5WMffqRckI3YzT3zzfRdeFKXs3zjJ3fjclFxR2nKzkbw49rAWDy4s-kNxa7l8cyDX5k0",
    ["Dough King"] = "https://discord.com/api/webhooks/1384083264167350272/5WMffqRckI3YzT3zzfRdeFKXs3zjJ3fjclFxR2nKzkbw49rAWDy4s-kNxa7l8cyDX5k0",
    ["Cake Prince"] = "https://discord.com/api/webhooks/1384083264167350272/5WMffqRckI3YzT3zzfRdeFKXs3zjJ3fjclFxR2nKzkbw49rAWDy4s-kNxa7l8cyDX5k0",
    ["Tyrant of the Skies"] = "https://discord.com/api/webhooks/1384083264167350272/5WMffqRckI3YzT3zzfRdeFKXs3zjJ3fjclFxR2nKzkbw49rAWDy4s-kNxa7l8cyDX5k0",
    ["Darkbeard"] = "https://discord.com/api/webhooks/1384083264167350272/5WMffqRckI3YzT3zzfRdeFKXs3zjJ3fjclFxR2nKzkbw49rAWDy4s-kNxa7l8cyDX5k0",
    ["Soul Reaper"] = "https://discord.com/api/webhooks/1384083264167350272/5WMffqRckI3YzT3zzfRdeFKXs3zjJ3fjclFxR2nKzkbw49rAWDy4s-kNxa7l8cyDX5k0",
    ["Cursed Captain"] = "https://discord.com/api/webhooks/1384083264167350272/5WMffqRckI3YzT3zzfRdeFKXs3zjJ3fjclFxR2nKzkbw49rAWDy4s-kNxa7l8cyDX5k0",
    ["Legendary Sword"] = "https://discord.com/api/webhooks/1384083264167350272/5WMffqRckI3YzT3zzfRdeFKXs3zjJ3fjclFxR2nKzkbw49rAWDy4s-kNxa7l8cyDX5k0"
}

--// Enable/Disable webhook groups - Dễ dàng bật/tắt từng group
local WebhookURLs = getgenv().WebhookURLs or {
    [Dora] = true,           -- Default: true
    [TuanAnhIos] = true,     -- Default: true
    -- Có thể thêm nhiều webhook group khác ở đây
}


    

--// Universal Webhook Sender - Gửi tới tất cả webhook được enable
function sendBossWebhook(eventName, swordName)
    -- Determine current sea based on PlaceId
    local currentSea = "Unknown Sea"
    if game.PlaceId == SEA1_PLACE_ID then
        currentSea = "First Sea"
    elseif game.PlaceId == SEA2_PLACE_ID then
        currentSea = "Second Sea"
    elseif game.PlaceId == SEA3_PLACE_ID then
        currentSea = "Third Sea"
    end
    
    local displayName = eventName
    if eventName == "Legendary Sword" and swordName then
        displayName = "Legendary Sword (" .. swordName .. ")"
    end
    
    local data = {
        username = "Notify",
        embeds = {{
            title = displayName .. " | Lag Cat",
            color = tonumber(0xFFFFFF),
            fields = {
                { name = "🧬 Type :", value = "```\n" .. displayName .. " [Spawn]\n```", inline = false },
                { name = "👥 Players In Server :", value = "```\n" .. tostring(playerCount) .. "\n```", inline = false },
                                { name = "🌊 Sea :", value = "```\n" .. currentSea .. "\n```", inline = false },
                { name = "🧾 Job ID (Pc Copy):", value = "```\n" .. jobId .. "\n```", inline = false },
                { name = "📜 Join Script (Pc Copy):", value = "```lua\n" .. joinScript .. "\n```", inline = false },
                { name = "🧾 Job ID (Mobile Copy):", value = jobId, inline = false },
                { name = "📜 Join Script (Mobile Copy):", value = joinScript, inline = false }
            },
            footer = {
                text = "Make by Dora • " .. os.date("Time : %d/%m/%Y - %H:%M:%S")
            }
        }}
    }
    
    local payload = HttpService:JSONEncode(data)
    local request = http_request or request or HttpPost or (syn and syn.request)
    
    if request then
        -- Duyệt qua tất cả webhook groups được enable
        for webhookGroup, isEnabled in pairs(WebhookURLs) do
            if isEnabled and webhookGroup[eventName] then
                -- Gửi request tới webhook tương ứng
                request({
                    Url = webhookGroup[eventName],
                    Method = "POST",
                    Headers = { ["Content-Type"] = "application/json" },
                    Body = payload
                })
            end
        end
    end
end

--// Sent flags for each checker
local sentDarkbeard = false
local sentCursedCaptain = false
local sentRipIndra = false
local sentDoughKing = false
local sentCakePrince = false
local sentTyrantSkies = false
local sentSoulReaper = false
local sentMirage = false
local sentKitsune = false
local sentPrehistoric = false
local sentFullMoon = false
local sentNearFullMoon = false

--// Darkbeard Only (World 2)
task.spawn(function()
    while true do
        task.wait(0.2)
        if game.PlaceId == SEA2_PLACE_ID and not sentDarkbeard then
            if ReplicatedStorage:FindFirstChild("Darkbeard") or Enemies:FindFirstChild("Darkbeard") then
                sendBossWebhook("Darkbeard")
                sentDarkbeard = true
            end
        end
    end
end)

--// Cursed Captain Only (World 2)
task.spawn(function()
    while true do
        task.wait(0.2)
        if game.PlaceId == SEA2_PLACE_ID and not sentCursedCaptain then
            if ReplicatedStorage:FindFirstChild("Cursed Captain") or Enemies:FindFirstChild("Cursed Captain") then
                sendBossWebhook("Cursed Captain")
                sentCursedCaptain = true
            end
        end
    end
end)

--// Rip Indra Only (World 3)
task.spawn(function()
    while true do
        task.wait(0.2)
        if game.PlaceId == SEA3_PLACE_ID and not sentRipIndra then
            if ReplicatedStorage:FindFirstChild("Rip Indra") or Enemies:FindFirstChild("Rip Indra") then
                sendBossWebhook("Rip Indra")
                sentRipIndra = true
            end
        end
    end
end)

--// Dough King Only (World 3)
task.spawn(function()
    while true do
        task.wait(0.2)
        if game.PlaceId == SEA3_PLACE_ID and not sentDoughKing then
            if ReplicatedStorage:FindFirstChild("Dough King") or Enemies:FindFirstChild("Dough King") then
                sendBossWebhook("Dough King")
                sentDoughKing = true
            end
        end
    end
end)

--// Cake Prince Only (World 3)
task.spawn(function()
    while true do
        task.wait(0.2)
        if game.PlaceId == SEA3_PLACE_ID and not sentCakePrince then
            if ReplicatedStorage:FindFirstChild("Cake Prince") or Enemies:FindFirstChild("Cake Prince") then
                sendBossWebhook("Cake Prince")
                sentCakePrince = true
            end
        end
    end
end)

--// Tyrant of the Skies Only (World 3)
task.spawn(function()
    while true do
        task.wait(0.2)
        if game.PlaceId == SEA3_PLACE_ID and not sentTyrantSkies then
            if ReplicatedStorage:FindFirstChild("Tyrant of the Skies") or Enemies:FindFirstChild("Tyrant of the Skies") then
                sendBossWebhook("Tyrant of the Skies")
                sentTyrantSkies = true
            end
        end
    end
end)

--// Soul Reaper Only (World 3)
task.spawn(function()
    while true do
        task.wait(0.2)
        if game.PlaceId == SEA3_PLACE_ID and not sentSoulReaper then
            if ReplicatedStorage:FindFirstChild("Soul Reaper") or Enemies:FindFirstChild("Soul Reaper") then
                sendBossWebhook("Soul Reaper")
                sentSoulReaper = true
            end
        end
    end
end)

--// Mirage Island Only (World 3)
task.spawn(function()
    while true do
        task.wait(0.2)
        if game.PlaceId == SEA3_PLACE_ID and not sentMirage then
            local locs = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("Locations")
            if locs and locs:FindFirstChild("Mirage Island") then
                sendBossWebhook("Mirage Island")
                sentMirage = true
            end
        end
    end
end)

--// Kitsune Island Only (World 3)
task.spawn(function()
    while true do
        task.wait(0.2)
        if game.PlaceId == SEA3_PLACE_ID and not sentKitsune then
            local locs = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("Locations")
            if locs and locs:FindFirstChild("Kitsune Island") then
                sendBossWebhook("Kitsune Island")
                sentKitsune = true
            end
        end
    end
end)

--// Prehistoric Island Only (World 3)
task.spawn(function()
    while true do
        task.wait(0.2)
        if game.PlaceId == SEA3_PLACE_ID and not sentPrehistoric then
            local locs = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("Locations")
            if locs and locs:FindFirstChild("Prehistoric Island") then
                sendBossWebhook("Prehistoric Island")
                sentPrehistoric = true
            end
        end
    end
end)

--// Full Moon Only (World 3)
task.spawn(function()
    while true do
        task.wait(0.2)
        if game.PlaceId == SEA3_PLACE_ID and not sentFullMoon then
            if Lighting.Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
                sendBossWebhook("Full Moon")
                sentFullMoon = true
            end
        end
    end
end)

--// Near Full Moon Only (World 3)
task.spawn(function()
    while true do
        task.wait(0.2)
        if game.PlaceId == SEA3_PLACE_ID and not sentNearFullMoon then
            if Lighting.Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
                sendBossWebhook("Near Full Moon")
                sentNearFullMoon = true
            end
        end
    end
end)

--// Legendary Sword Dealer Only (World 2)
task.spawn(function()
    local previousSword = nil
    local sentLegendarySword = false
    
    while true do
        task.wait(0.5)
        if game.PlaceId == SEA2_PLACE_ID then
            -- Reset flag when checking for new sword
            if not previousSword then
                sentLegendarySword = false
            end
            
            local currentSword = nil
            local success, result
            
            -- Check for Shizu
            success, result = pcall(function()
                return ReplicatedStorage.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1")
            end)
            if success and result then
                currentSword = "Shizu"
            end
            
            -- Check for Oroshi if Shizu not found
            if not currentSword then
                success, result = pcall(function()
                    return ReplicatedStorage.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2")
                end)
                if success and result then
                    currentSword = "Oroshi"
                end
            end
            
            -- Check for Saishi if others not found
            if not currentSword then
                success, result = pcall(function()
                    return ReplicatedStorage.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3")
                end)
                if success and result then
                    currentSword = "Saishi"
                end
            end

            -- Send webhook if new sword found and not already sent
            if currentSword and currentSword ~= previousSword and not sentLegendarySword then
                sendBossWebhook("Legendary Sword", currentSword)
                previousSword = currentSword
                sentLegendarySword = true
            elseif not currentSword and previousSword then
                -- Dealer left, reset for next detection
                previousSword = nil
                sentLegendarySword = false
            end
        else
            -- Reset when not in World 2
            previousSword = nil
            sentLegendarySword = false
            task.wait(5) -- Longer wait when not in correct world
        end
    end
end)
