----- Load hiệu ứng chạy script

loadstring(game:HttpGet("https://raw.githubusercontent.com/NomDomHub/NomDomHub/refs/heads/main/Loading.lua"))()


loadstring(game:HttpGet("https://raw.githubusercontent.com/NomDomHub/NomDomHub/refs/heads/main/QuestionWedbook.lua"))()



-- Tải thư viện Fluent
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/UiHack/refs/heads/main/Fluent"))()

local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer

-- Tạo bảng chứa tên người chơi đặc biệt
local specialUsers = {
    "Boptrithuc",
    "boptrithuc01",
    "acctesthacktuviet",
    "noxeldp"
}

-- Kiểm tra xem tên người chơi có nằm trong danh sách đặc biệt không
local isSpecialUser = false
for _, name in ipairs(specialUsers) do
    if player.Name == name then
        isSpecialUser = true
        break
    end
end

-- Tạo cửa sổ Fluent
local window = Fluent:CreateWindow({
    Title = isSpecialUser and "NomDom Hub [Premium]" or "NomDom Hub [Freemium]",
    SubTitle = "by Sus",
    TabWidth = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled) and 160 or 190,  -- Mobile: 160, PC: 190
    Theme = "Dark",
    Acrylic = false,
    Size = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled) and UDim2.fromOffset(600, 430) or UDim2.fromOffset(700, 490),  -- Giữ như trước
    MinimizeKey = Enum.KeyCode.End
})






local tabs = {
    PhanMain = window:AddTab({ Title = "--------- Main ---------" }),
    Infor = window:AddTab({ Title = "Information", Icon = "info" }), -- ID của icon info
    Main = window:AddTab({ Title = "Fuction", Icon = "grid" }), -- ID của icon tool
    Localplayer = window:AddTab({ Title = "Localplayer", Icon = "user" }), -- ID của icon user
    Joinid = window:AddTab({ Title = "Join Server, Game", Icon = "gamepad" }),
    Game = window:AddTab({ Title = "Game, User Information", Icon = "clipboard" }),
    Setting = window:AddTab({ Title = "Setting", Icon = "settings" }),--- ID của icon setting
    PhanScripts = window:AddTab({ Title = "-------- Scripts --------" }),
    ScriptPaid = window:AddTab({ Title = "Paid" }),
    Bloxfruit = window:AddTab({ Title = "Blox Fruit" }),
    Growagarden = window:AddTab({ Title = "Grow A Garden" }),
    Deedrails = window:AddTab({ Title = "Deed Rails" }),
    BubbleRubber = window:AddTab({ Title = "Bubble Rubber Simulator" }),
    Bluelock = window:AddTab({ Title = "Blue Lock" }),
    Brookhaven = window:AddTab({ Title = "Brookhaven" }),
    Arisecrossover = window:AddTab({ Title = "Arise Crossover" }),
    Forsaken = window:AddTab({ Title = "Forsaken" }),
    Bladeball = window:AddTab({ Title = "Blade Ball" }),
    Fisch = window:AddTab({ Title = "Fisch" }),
    Petgo = window:AddTab({ Title = "Pet Go" }),
    Volleyball = window:AddTab({ Title = "Volleyball Legends" }),
    Basketball = window:AddTab({ Title = "Basketball" }),
    Mm2 = window:AddTab({ Title = "Mm2" }),
    Tsb = window:AddTab({ Title = "The Strongest Battlegrounds" }),
    Rivals = window:AddTab({ Title = "Rivals" }),
    CongDongVietNam = window:AddTab({ Title = "Cộng Đồng Việt Nam" }),
    AnimeSaga = window:AddTab({ Title = "Anime Saga" }),
    AnimeRangersX = window:AddTab({ Title = "Anime Rangers X" }),
    AnimeVanguards = window:AddTab({ Title = "Anime Vanguards" }),
    AnimeLastStand = window:AddTab({ Title = "Anime Last Stand" }),
    AttackOnTitanRevolution = window:AddTab({ Title = "Attack on Titan Revolution" }),
    Door = window:AddTab({ Title = "Door" }),
    KingLegacy = window:AddTab({ Title = "King Legacy" }),
    BeeSwarmSimulator = window:AddTab({ Title = "Bee Swarm Simulator" }),
    Evade = window:AddTab({ Title = "Evade" }),
    GymLeague = window:AddTab({ Title = "Gym League" }),
    MemeSea = window:AddTab({ Title = "Meme Sea" }),
    Misc = window:AddTab({ Title = "Misc" }),
}





local Options = Fluent.Options
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local speaker = Players.LocalPlayer

local Community = tabs.Infor:AddSection("Community")

-- ⚙️ Phần Thông Tin
Community:AddButton({
    Title = "NomDom Community",
    Description = "Discord",
    Callback = function()
        setclipboard("https://discord.gg/XJZmMVuU")
    end
})

Community:AddButton({
    Title = "YT NomDom",
    Description = "Youtube",
    Callback = function()
        setclipboard("https://www.youtube.com/channel/NomDomDZ")
    end
})

local Developer = tabs.Infor:AddSection("Developer")

-- Developer Section with Paragraphs
Developer:AddParagraph({ Title = "Sus", Content = "Developer" })
Developer:AddParagraph({ Title = "KhangG", Content = "Helper" })


local Fps = tabs.Main:AddSection("Lock Fps")

local selectedFPS = 60
local isFPSLooping = false
local fpsLoopThread = nil

Fps:AddInput("FPSInput", {
    Title = "Enter Fps to Lock",
    Default = "",
    Placeholder = "Fps",
    Numeric = true,
    Finished = true,
    Callback = function(value)
        local num = tonumber(value)
        if num and num > 0 then
            selectedFPS = num
            -- Không có thông báo Fluent:Notify
        else
            -- Không có thông báo Fluent:Notify
        end
    end
})

Fps:AddToggle("LockFPSToggle", {
    Title = "Lock Fps",
    Default = false,
    Callback = function(state)
        if state then
            if typeof(setfpscap) == "function" then
                setfpscap(selectedFPS)
                isFPSLooping = false -- Đảm bảo vòng lặp không chạy nếu setfpscap có
                if fpsLoopThread and task.cancel then task.cancel(fpsLoopThread) end
                fpsLoopThread = nil
            else
                isFPSLooping = true
                local interval = 1 / selectedFPS

                fpsLoopThread = task.spawn(function()
                    local lastTick = tick()
                    while isFPSLooping do
                        local now = tick()
                        local elapsed = now - lastTick
                        local wait_time = interval - elapsed

                        if wait_time > 0 then
                            task.wait(wait_time)
                        end

                        lastTick = tick()

                        -- Thêm một yield nhỏ để tránh lỗi và cho phép dừng thread
                        if not task.wait(0.001) then
                            break -- Thread bị hủy
                        end
                    end
                end)
            end
        else
            if typeof(setfpscap) == "function" then
                setfpscap(999)
            end

            isFPSLooping = false -- Dừng vòng lặp
            if fpsLoopThread and task.cancel then task.cancel(fpsLoopThread) end
            fpsLoopThread = nil
        end
    end
})



local Player = tabs.Localplayer:AddSection("Player")

Player:AddButton({
    Title = "Reset Character",
    Description = "",
    Callback = function()
        local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildWhichIsA("Humanoid")

if humanoid then
    humanoid.Health = 0
end
    end
})    Player:AddButton({
    Title = "Kick Player",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer:Kick("")
    end
})    Player:AddButton({
    Title = "Exit The Game",
    Description = "",
    Callback = function()
        -- Thoát khỏi game
game:Shutdown()

    end
})

-- 🧍 WalkSpeed & Jump
local Walkspeed = tabs.Localplayer:AddSection("WalkSpeed")
local tpwalking = false
local currentSpeed = 90
local overrideSpeed = nil
local heartbeatConnection = nil
local originalWalkSpeed = 16

local function startTeleportWalk(character)
    if not character then return end
    local hum = character:WaitForChild("Humanoid", 5)
    if not hum then return end

    hum.HealthChanged:Connect(function()
        local hpPercent = (hum.Health / hum.MaxHealth) * 100
        if not overrideSpeed then
            currentSpeed = hpPercent <= 30 and 190 or 90
        end
    end)

    if heartbeatConnection then heartbeatConnection:Disconnect() end
    heartbeatConnection = RunService.Heartbeat:Connect(function(dt)
        if tpwalking and hum and hum.Parent then
            local moveDir = hum.MoveDirection
            if moveDir.Magnitude > 0 then
                character:TranslateBy(moveDir * currentSpeed * dt)
            end
        end
    end)
end

Players.LocalPlayer.CharacterAdded:Connect(function(char)
    if tpwalking then
        task.wait(1)
        startTeleportWalk(char)
    end
end)

if speaker.Character then
    startTeleportWalk(speaker.Character)
end

Walkspeed:AddToggle("tpwalk_toggle", {
    Title = "Walk speed",
    Default = false,
    Callback = function(state)
        tpwalking = state
        local char = speaker.Character
        if char then
            if tpwalking then
                startTeleportWalk(char)
                local hum = char:WaitForChild("Humanoid", 5)
                if hum then hum.WalkSpeed = currentSpeed end
            else
                local hum = char:WaitForChild("Humanoid", 5)
                if hum then hum.WalkSpeed = originalWalkSpeed end
                if heartbeatConnection then heartbeatConnection:Disconnect() end
            end
        end
    end
})

Walkspeed:AddInput("speed_input", {
    Title = "Speed",
    Placeholder = "Enter speed",
    Numeric = true,
    Finished = true,
    Callback = function(value)
        local speed = tonumber(value)
        if speed then
            overrideSpeed = speed
            currentSpeed = speed
        else
            overrideSpeed = nil
        end
    end
})

-- 🦘 Jump Settings
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Jump = tabs.Localplayer:AddSection("Jump")

local infiniteJumpEnabled = false
local customJumpPowerEnabled = false
local jumpPowerOverride = nil

-- Infinite Jump Handler
UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                humanoid.Jump = true
            end
        end
    end
end)

-- Infinite Jump Toggle
Jump:AddToggle("infinite_jump", {
    Title = "Infiniti Jump",
    Default = false,
    Callback = function(state)
        infiniteJumpEnabled = state
    end
})

-- High Jump Toggle
Jump:AddToggle("custom_jump_toggle", {
    Title = "High Jump",
    Default = false,
    Callback = function(state)
        customJumpPowerEnabled = state
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = state and (jumpPowerOverride or 50) or 50
        end
    end
})

-- Jump Power Input
Jump:AddInput("jump_power", {
    Title = "Jump Power",
    Placeholder = "Enter jump height",
    Numeric = true,
    Finished = true,
    Callback = function(value)
        jumpPowerOverride = tonumber(value)
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and customJumpPowerEnabled then
            humanoid.JumpPower = jumpPowerOverride or 50
        end
    end
})

-- Optional: Auto apply custom JumpPower on respawn
LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid")
    if customJumpPowerEnabled and jumpPowerOverride then
        char.Humanoid.JumpPower = jumpPowerOverride
    end
end)


-- 🚷 NoClip
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Noclip = tabs.Localplayer:AddSection("No Clip")
local NoClip = false
local NoClipConnection

Noclip:AddToggle("NoClip", {
    Title = "NoClip",
    Default = false,
    Callback = function(state)
        NoClip = state

        if NoClip then
            -- Bắt đầu NoClip
            NoClipConnection = RunService.Stepped:Connect(function()
                local char = LocalPlayer.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide == true then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            -- Tắt NoClip
            if NoClipConnection then
                NoClipConnection:Disconnect()
                NoClipConnection = nil
            end

            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})



local Misc = tabs.Localplayer:AddSection("Misc")

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")



-- Biến kiểm soát trạng thái bật tắt
local isFullBright = false

-- Toggle Full Bright
Misc:AddToggle("FullBrightToggle", {
    Title = "Full Bright",
    Default = false,
    Callback = function(state)
        isFullBright = state

        -- Nếu tắt thì khôi phục lại Lighting mặc định
        if not state then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 1000
            Lighting.GlobalShadows = true
        end
    end
})

-- Hàm chạy mỗi frame
RunService.RenderStepped:Connect(function()
    if isFullBright then
        Lighting.Brightness = 10
        Lighting.ClockTime = 12
        Lighting.FogEnd = 1e10
        Lighting.GlobalShadows = false
    end
end)



-- Biến để lưu trạng thái của toggle
local isTeleportEnabled = false  

-- Thêm toggle vào tab Misc
Misc:AddToggle("TeleportToggle", {
    Title = "Click to teleport",   -- Tiêu đề của Toggle
    Default = false,  -- Trạng thái mặc định (tắt)
    Callback = function(state)
        isTeleportEnabled = state  -- Lưu trạng thái của toggle
        if isTeleportEnabled then
            print("NomDom Hub On Top")
        else
            print("NomDom Hub On Top")
        end
    end
})

-- Lấy đối tượng LocalPlayer và Mouse
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Đảm bảo rằng có GUI và nhân vật đã được tải
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Hàm xử lý khi click chuột trái
mouse.Button1Down:Connect(function()
    -- Kiểm tra xem teleport có được bật không
    if isTeleportEnabled then
        -- Lấy vị trí click chuột
        local clickPosition = mouse.Hit.p
        
        -- Dịch chuyển nhân vật đến vị trí click (thêm chút cao hơn để tránh vướng mặt đất)
        humanoidRootPart.CFrame = CFrame.new(clickPosition + Vector3.new(0, 2, 0))
    end
end)

local Players = game:GetService("Players")
local player = Players.LocalPlayer


-- Hàm cập nhật zoom khi bật toggle
local function updateZoom(state)
    if state then
        player.CameraMinZoomDistance = 0 -- ✅ thay vì 0.5 như trước
        player.CameraMaxZoomDistance = math.huge
    end
end

-- Đảm bảo thiết lập lại khi respawn
player.CharacterAdded:Connect(function()
    if player:GetAttribute("ZoomEnabled") then
        updateZoom(true)
    end
end)

-- Toggle trong UI
Misc:AddToggle("camera_zoom_toggle", {
    Title = "Camera Is Not Locked",
    Default = false,
    Callback = function(state)
        player:SetAttribute("ZoomEnabled", state)
        updateZoom(state)
    end
})

-- Thiết lập ban đầu
if player.Character then
    updateZoom(true)
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer


-- Lưu giá trị gốc mặc định trước khi chỉnh
local defaultMaxZoom = player.CameraMaxZoomDistance

Misc:AddToggle("unlimited_zoom_toggle", {
    Title = "Infinite Zoom",
    Default = true,
    Callback = function(state)
        if state then
            player.CameraMaxZoomDistance = math.huge
        else
            player.CameraMaxZoomDistance = defaultMaxZoom
        end
    end
})







local Joinid = tabs.Joinid:AddSection("Join ID")




-- Tạo ô nhập
local jobInput = Joinid:AddInput("Input", {
    Title = "Job ID",
    Default = "",
    Placeholder = "Paste Job ID Here",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        _G.Job = Value
    end
})

-- Nút Join xử lý thông minh
Joinid:AddButton({
    Title = "Join",
    Description = "",
    Callback = function()
        local text = _G.Job or ""
        if text ~= "" then
            pcall(function()
                if text:lower() == "teleport" then
                    local function getServerID()
                        return "dffebadf-3464-4ab7-af0e-b10499120fa3" -- Thay bằng JobId hợp lệ nếu có
                    end
                    local serverID = getServerID()
                    if serverID then
                        game:GetService("TeleportService"):TeleportToPlaceInstance(2753915549, serverID, game.Players.LocalPlayer)
                    end

                elseif text:match("TeleportService") then
                    loadstring(text)()

                elseif text:match("InvokeServer") then
                    loadstring(text)()

                elseif text:match("%d+%.%d+%.%d+%.%d+") and text:match("TeleportService") then
                    loadstring(text)()
                end
            end)

            _G.Job = ""
            if jobInput and jobInput.SetValue then
                jobInput:SetValue("")
            end
        end
    end
})

-- Nút Clear input
Joinid:AddButton({
    Title = "Clear",
    Description = "",
    Callback = function()
        _G.Job = ""
        if jobInput and jobInput.SetValue then
            jobInput:SetValue("")
        end
    end
})





Joinid:AddButton({
    Title="Copy Job ID",
    Description="",
    Callback=function()
        setclipboard(tostring(game.JobId))
    end
})
local Toggle = tabs.Joinid:AddToggle("MyToggle", {Title="Spam Tham Gia Job ID", Default=false })
Toggle:OnChanged(function(Value)
_G.Join=Value
    end)
    spawn(function()
while wait() do
if _G.Join then
game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId,_G.Job, game.Players.LocalPlayer)
end
end
end)


Joinid:AddButton({
Title = "Rejoin Server",
Description = "",
Callback = function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end
})

-- Tạo section
local JoinGameSection = tabs.Joinid:AddSection("Join Game")

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

-- Danh sách game
local gameList = {
    ["Blox Fruits"] = 2753915549,
    ["Grow A Garden"] = 126884695634066,
    ["Deed Rails"] = 116495829188952,
    ["Bubble Rubber Simulator"] = 85896571713843,
    ["Blue Lock"] = 18668065416,
    ["Arise Crossover"] = 87039211657390,
    ["Forsaken"] = 85896571713843,
    ["Blade Ball"] = 13772394625,
    ["Fish"] = 16732694052,
    ["Pet Go"] = 18901165922,
    ["Volleyball Legends"] = 73956553001240,
    ["Basketball"] = 130739873848552,
    ["Mm2"] = 142823291,
    ["The Strongest Battlegrounds"] = 10449761463,
    ["Cộng Đồng Việt Nam"] = 18192562963,
    ["Anime Saga"] = 17850641257,
    ["Anime Rangers"] = 72829404259339,
    ["Anime Vanguards"] = 16146832113,
    ["Anime Last Stand"] = 12886143095,
    ["Attack On Titan Revolution"] = 13379208636,
    ["Door"] = 6516141723,
    ["King Legacy"] = 4520749081,
    ["Rivals"] = 17625359962,
    ["Brookhaven"] = 4924922222,
    ["Meme Sea"] = 10260193230,
    ["Gym League"] = 17450551531,
    ["Evade"] = 9872472334,
    ["Bee Swarm Simulator"] = 1537690962,
}




-- Biến lưu game đã chọn
local selectedGame = nil

-- Dropdown chọn game
JoinGameSection:AddDropdown("Chọn Game", {
    Title = "Choose a game",
    Values = (function()
        local names = {}
        for name in pairs(gameList) do
            table.insert(names, name)
        end
        table.sort(names)
        return names
    end)(),
    Callback = function(value)
        selectedGame = gameList[value]
    end
})

-- Nút Join Game
JoinGameSection:AddButton({
    Title = "Join game",
    Description = "",
    Callback = function()
        if selectedGame then
            TeleportService:Teleport(selectedGame, Players.LocalPlayer)
        end
    end
})






local Hop = tabs.Joinid:AddSection("Hop")

Hop:AddButton({
Title = "Hop Low Server",
Description = "",
Callback = function()
    getgenv().AutoTeleport = true
    getgenv().DontTeleportTheSameNumber = true 
    getgenv().CopytoClipboard = false
    if not game:IsLoaded() then
        print("Hop Low Server")
    end
    local maxplayers = math.huge
    local serversmaxplayer;
    local goodserver;
    local gamelink = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100" 
    function serversearch()
        for _, v in pairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync(gamelink)).data) do
            if type(v) == "table" and v.playing ~= nil and maxplayers > v.playing then
                serversmaxplayer = v.maxPlayers
                maxplayers = v.playing
                goodserver = v.id
            end
        end       
    end
    function getservers()
        serversearch()
        for i,v in pairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync(gamelink))) do
            if i == "nextPageCursor" then
                if gamelink:find("&cursor=") then
                    local a = gamelink:find("&cursor=")
                    local b = gamelink:sub(a)
                    gamelink = gamelink:gsub(b, "")
                end
                gamelink = gamelink .. "&cursor=" ..v
                getservers()
            end
        end
    end 
    getservers()
    if AutoTeleport then
        if DontTeleportTheSameNumber then 
            if #game:GetService("Players"):GetPlayers() - 4  == maxplayers then
                return warn("It has same number of players (except you)")
            elseif goodserver == game.JobId then
                return warn("Your current server is the most empty server atm") 
            end
        end
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, goodserver)
    end
end
})

Hop:AddButton({
Title = "Hop Server",
Description = "",
Callback = function()
    local HttpService = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    
    -- Kiểm tra nếu game có thể gửi request HTTP
    local success, response = pcall(function()
        return game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
    end)

    if not success then
        print("Hop Failed")
        return
    end
    
    local Servers = HttpService:JSONDecode(response).data
    local AvailableServers = {}

    for _, v in pairs(Servers) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            table.insert(AvailableServers, v.id)
        end
    end

    if #AvailableServers > 0 then
        local RandomServer = AvailableServers[math.random(1, #AvailableServers)]
        
        -- Kiểm tra nếu TPS có thể teleport
        local teleportSuccess, teleportError = pcall(function()
            TPS:TeleportToPlaceInstance(game.PlaceId, RandomServer)
        end)

        if not teleportSuccess then
            print("Lỗi Teleport: " .. teleportError)
        end
    else
        print("Không có máy chủ")
    end
end
})









-------[  Hiển thị thông tin   ]---











-- 🌐 Dịch vụ cần thiết
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalizationService = game:GetService("LocalizationService")

local LocalPlayer = Players.LocalPlayer

-- === 1. Player Information ===
local sectionPlayer = tabs.Game:AddSection("Player Information")

sectionPlayer:AddParagraph({
    Title = "Username",
    Content = LocalPlayer.Name or "N/A"
})

sectionPlayer:AddParagraph({
    Title = "Display Name",
    Content = LocalPlayer.DisplayName or "N/A"
})

-- 🌍 Bảng mã quốc gia → tên quốc gia
local countryMap = {
    VN = "Vietnam",
    TH = "Thailand",
    ID = "Indonesia",
    PH = "Philippines",
    MY = "Malaysia",
    US = "United States",
    BR = "Brazil",
    KR = "South Korea",
    JP = "Japan",
    DE = "Germany",
    FR = "France",
    RU = "Russia"
}

-- 🛰️ Lấy mã quốc gia bằng LocalizationService
if not getgenv().countryRegionCode then
    local success, regionCode = pcall(function()
        return LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer)
    end)
    getgenv().countryRegionCode = success and regionCode or "Unknown"
end

-- 🌐 Đổi mã quốc gia sang tên đầy đủ
local fullCountryName = countryMap[getgenv().countryRegionCode] or "Unknown"

-- 📌 Hiển thị tên quốc gia
sectionPlayer:AddParagraph({
    Title = "Country",
    Content = fullCountryName
})

-- === 2. Server Info ===
local sectionServer = tabs.Game:AddSection("Server")

local OSTimeParagraph = sectionServer:AddParagraph({
    Title = "Time Zone",
    Content = ""
})

local ServerTimeParagraph = sectionServer:AddParagraph({
    Title = "Time",
    Content = ""
})

local FPSParagraph = sectionServer:AddParagraph({
    Title = "FPS",
    Content = ""
})

-- ⏰ Cập nhật thời gian hệ thống kèm mã quốc gia
local function UpdateOS()
    local date = os.date("*t")
    local hour = date.hour
    local ampm = hour < 12 and "AM" or "PM"
    local formattedTime = string.format("%02i:%02i:%02i %s", ((hour - 1) % 12) + 1, date.min, date.sec, ampm)
    local formattedDate = string.format("%02d/%02d/%04d", date.day, date.month, date.year)

    OSTimeParagraph:SetDesc(formattedDate .. " - " .. formattedTime .. " [ " .. getgenv().countryRegionCode .. " ]")
end

-- 🕹️ Cập nhật thời gian trong game
local function UpdateGameTime()
    local gameTime = math.floor(workspace.DistributedGameTime + 0.5)
    local hours = math.floor(gameTime / 3600) % 24
    local minutes = math.floor(gameTime / 60) % 60
    local seconds = gameTime % 60
    ServerTimeParagraph:SetDesc(hours .. " Hour (h) " .. minutes .. " Minute (m) " .. seconds .. " Second (s)")
end

-- 🎮 Cập nhật FPS
local lastTick = tick()
local frameCount = 0
RunService.RenderStepped:Connect(function()
    frameCount += 1
    local now = tick()
    if now - lastTick >= 1 then
        lastTick = now
        FPSParagraph:SetDesc(frameCount .. " FPS")
        frameCount = 0
    end
end)

-- 🔁 Cập nhật mỗi giây
task.spawn(function()
    while true do
        UpdateOS()
        UpdateGameTime()
        task.wait(1)
    end
end)















-- === 2. Executor ===
local sectionExecute = tabs.Game:AddSection("Executor")

local executor = "Unknown"
if syn then
    executor = "Synapse X"
elseif KRNL_LOADED then
    executor = "KRNL"
elseif fluxus then
    executor = "Fluxus"
elseif getexecutorname then
    local success, execName = pcall(getexecutorname)
    if success and type(execName) == "string" then
        executor = execName
    end
end

sectionExecute:AddParagraph({
    Title = "Use Client",
    Content = executor
})

local execStatus = (executor == "Xeno" or executor:lower():find("solara")) and "May Error" or "Working"
sectionExecute:AddParagraph({
    Title = "Status",
    Content = execStatus
})

-- === 3. Device Information ===
local sectionDevice = tabs.Game:AddSection("Device Information")

local deviceType = UserInputService.TouchEnabled and "Mobile"
    or (UserInputService.KeyboardEnabled and not UserInputService.GamepadEnabled and "PC")
    or "Console"

sectionDevice:AddParagraph({
    Title = "Device Type",
    Content = deviceType
})

-- === 4. Game Information ===
local sectionGame = tabs.Game:AddSection("Game Information")

-- Đảm bảo game đã load trước khi gọi GetProductInfo
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local gameName = "Unknown"
pcall(function()
    local info = MarketplaceService:GetProductInfo(game.PlaceId)
    if info and info.Name then
        gameName = info.Name
    end
end)

sectionGame:AddParagraph({
    Title = "Game Name",
    Content = gameName
})

sectionGame:AddParagraph({
    Title = "Game ID (PlaceId)",
    Content = tostring(game.PlaceId)
})

sectionGame:AddParagraph({
    Title = "Server ID",
    Content = game.JobId or "N/A"
})








local Shop = tabs.ScriptPaid:AddSection("Shop")

Shop:AddButton({
    Title = "Shyun.shop",
    Description = "For Vietnamese People Only.",
    Callback = function()
        setclipboard("https://shyun.shop")
    end
})

Shop:AddButton({
    Title = "Yukstore.com",
    Description = "For Vietnamese People Only.",
    Callback = function()
        setclipboard("https://yukstore.com")
    end
})





local ScriptPaidMup = tabs.ScriptPaid:AddSection("Discord")






ScriptPaidMup:AddButton({
    Title = "Banana Hub",
    Description = "Click to copy discord link.",
    Callback = function()
        setclipboard("https://discord.gg/chuoihub")
    end
})

ScriptPaidMup:AddButton({
    Title = "Maru Hub",
    Description = "Click to copy discord link.",
    Callback = function()
        setclipboard("https://discord.gg/maruhub")
    end
})

ScriptPaidMup:AddButton({
    Title = "W-azure",
    Description = "Click to copy discord link.",
    Callback = function()
       setclipboard("https://discord.gg/w-azure") 
    end
})

ScriptPaidMup:AddButton({
    Title = "HoHo Hub",
    Description = "Click to copy discord link.",
    Callback = function()
        setclipboard("https://discord.gg/hohohub")
    end
})

ScriptPaidMup:AddButton({
    Title = "Tekkit Hub",
    Description = "Click to copy discord link.",
    Callback = function()
        setclipboard("https://discord.gg/tekkit")
    end
})

ScriptPaidMup:AddButton({
    Title = "Nousigi Hub",
    Description = "Click to copy discord link.",
    Callback = function()
        setclipboard("https://discord.gg/nousigi")
    end
})

ScriptPaidMup:AddButton({
    Title = "Native Hub",
    Description = "Click to copy discord link.",
    Callback = function()
        setclipboard("https://discord.gg/natives")
    end
})

ScriptPaidMup:AddButton({
    Title = "Switch Hub",
    Description = "Click to copy discord link.",
    Callback = function()
        setclipboard("https://discord.gg/switchhub")
    end
})

ScriptPaidMup:AddButton({
    Title = "Xeon Hub",
    Description = "Click to copy discord link.",
    Callback = function()
        setclipboard("https://discord.gg/xenonhub")
    end
})
















local Mainbf = tabs.Bloxfruit:AddSection("Main")---- Add mục Main 






Mainbf:AddButton({
    Title = "Fast Attack",
    Description = "",
    Callback = function()   
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDom/refs/heads/main/FastAttack.lua"))()
    end
})

Mainbf:AddButton({
    Title = "W azure",
    Description = "No Key",
    Callback = function()   
        getgenv().Team = "Marines" --Marines Pirates
        getgenv().AutoLoad = true --Will Load Script On Server Hop
        getgenv().SlowLoadUi = false
        getgenv().ForceUseSilentAimDashModifier = false --Force turn on silent aim, if error then executor problem
        getgenv().ForceUseWalkSpeedModifier = true --Force turn on Walk Speed Modifier, if error then executor problem
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))()
    end
})

Mainbf:AddButton({
    Title = "Redz Hub",
    Description = "No Key",
    Callback = function()  
        local Settings = {
            JoinTeam = "Pirates"; -- Pirates/Marines
            Translator = true; -- true/false
        }
        loadstring(game:HttpGet("https://raw.githubusercontent.com/newredz/BloxFruits/refs/heads/main/Source.luau"))()
    end
})
Mainbf:AddButton({
    Title = "Xero Hub",
    Description = "No Key",
    Callback = function()
        getgenv().Team = "Marines"
    getgenv().Hide_Menu = false
    getgenv().Auto_Execute = false
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xero2409/XeroHub/refs/heads/main/main.lua"))()  
    end
})    Mainbf:AddButton({
    Title = "Banana Fake ( Min Gamming )",
    Description = "No Key",
    Callback = function()
        getgenv().Team = "Pirates"
loadstring(game:HttpGet("https://raw.githubusercontent.com/MinGamingHubNew/Banana/refs/heads/main/Banana.lua"))()
    end
})    Mainbf:AddButton({
    Title = "Relz Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/farghii/relzhub/refs/heads/main/loader.lua"))()
    end
})    Mainbf:AddButton({
    Title = "Zinner Hub",
    Description = "Need Key",
    Callback = function()
        getgenv().Team = "Pirates"
loadstring(game:HttpGet("https://raw.githubusercontent.com/HoangNguyenk8/Roblox/refs/heads/main/BF-Main.luau"))()
    end
})     Mainbf:AddButton({
    Title = "Aurora Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Jadelly261/BloxFruits/main/Aurora", true))() 
    end
})      Mainbf:AddButton({
    Title = "Vocano Hub V3",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/indexeduu/BF-NewVer/refs/heads/main/V3New.lua"))() 
    end
})   Mainbf:AddButton({
    Title = "Vxeze Hub",
    Description = "No Ket",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dex-Bear/Vxezehub/refs/heads/main/VxezeHubMain"))()
    end
})    Mainbf:AddButton({
    Title = "Hiru Hub",
    Description = "I don't know",
    Callback = function()
        getgenv().DuyKiddoDevTeam = true
getgenv().Team = "Pirates"
getgenv().Chat = "Hiru Hub On Top"
loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStupid/Source/main/HiruHubKiddo.lua"))()
    end
})     Mainbf:AddButton({
    Title = "Lilnhan V4",
    Description = "No Key",
    Callback = function()
        getgenv().Teams = "Marines"  --Pirates
loadstring(game:HttpGet("https://raw.githubusercontent.com/NewBetaLua/Lilnhan/refs/heads/main/LilnhanHubV4"))()
    end
})     Mainbf:AddButton({
    Title = "Lilnhan V3",
    Description = "No Key",
    Callback = function()
        getgenv().Teams = "Marines"  --Pirates
loadstring(game:HttpGet("https://raw.githubusercontent.com/NewBetaLua/Lilnhan/refs/heads/main/LilnhanHubV3"))()
    end
})     Mainbf:AddButton({
    Title = "Than Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thantzy/thanhub/refs/heads/main/thanv1"))()
    end
})    Mainbf:AddButton({
    Title = "Yuri Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Jadelly261/BloxFruits/main/YuriMain", true))()
    end
})     Mainbf:AddButton({
    Title = "Skull Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/hungquan99/SkullHub/main/loader.lua'))()
    end
})     Mainbf:AddButton({
    Title = "Zen Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Zenhubtop/zen_hub_pr/main/zennewwwwui.lua", true))()
    end
})     Mainbf:AddButton({
    Title = "Mozil Hub V4",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MozilOnTopp/MozilHub/refs/heads/main/BloxFruits"))()
    end
})    Mainbf:AddButton({
    Title = "Doramon Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/obfmoonsec/Masterhub/refs/heads/main/obf"))()
    end
})    Mainbf:AddButton({
    Title = "Maru Hub Fake",
    Description = "No Key",
    Callback = function()
        getgenv().Team = "Marines" 
loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/KimP/refs/heads/main/MaruHub"))()
    end
})    Mainbf:AddButton({
    Title = "Banana Hub Fake",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kimprobloxdz/Banana-Free/refs/heads/main/Protected_5609200582002947.lua.txt"))() 
    end
})    Mainbf:AddButton({
    Title = "J97 Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kimprobloxdz/Jack-J97/refs/heads/main/Jack-J97.txt"))() 
    end
})    Mainbf:AddButton({
    Title = "KimP Hub V1",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/KimP/refs/heads/main/KimPRoblox"))() 
    end
})    Mainbf:AddButton({
    Title = "KimP Hub V2",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/KimP/refs/heads/main/KimPRobloxV2"))() 
    end
})    Mainbf:AddButton({
    Title = "KimP Hub V3",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/KimP/refs/heads/main/KimPRobloxV3"))() 
    end
})     Mainbf:AddButton({
    Title = "Green Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaAnarchist/GreenZ-Hub/refs/heads/main/GreenZHub.lua"))()
    end
})    Mainbf:AddButton({
    Title = "Tsuo Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"))() 
    end
})    Mainbf:AddButton({
    Title = "Lion Hub",
    Description = "No Key",
    Callback = function()
        repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
getgenv().Team = "Pirates" -- Marines
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e0c7fcf6c077fc23475cf4ce4db58e42.lua"))()
    end
})    Mainbf:AddButton({
    Title = "QuanTum Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Trustmenotcondom/QTONYX/refs/heads/main/QuantumOnyx.lua"))()
    end
})    Mainbf:AddButton({
    Title = "Zenith Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Efe0626/ZenithHub/refs/heads/main/Loader"))()  
    end
})    Mainbf:AddButton({
    Title = "Xeter Hub v1",
    Description = "No Key",
    Callback = function()
        getgenv().Version = "V1"
loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/Loader/main/Xeter.lua"))()  
    end
})   Mainbf:AddButton({
    Title = "Xeter Hub v2",
    Description = "No Key",
    Callback = function()
        getgenv().Version = "V2"
loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/Loader/main/Xeter.lua"))()   
    end
})    Mainbf:AddButton({
    Title = "ThundarZ Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/ThundarZ/Welcome/refs/heads/main/Main/Loader/AllGame.lua'))()   
    end
})    Mainbf:AddButton({
    Title = "Rubu Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/RubuRoblox/refs/heads/main/RubuBF"))()   
    end
})    Mainbf:AddButton({
    Title = "Alchemy Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
    end
})    Mainbf:AddButton({
    Title = "Bapred Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/BapRed/main/BapRedHub"))()  
    end
})    Mainbf:AddButton({
    Title = "Astral Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Overgustx2/Main/refs/heads/main/BloxFruits_25.html"))()   
    end
})    Mainbf:AddButton({
    Title = "Omg Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()  
    end
})    Mainbf:AddButton({
    Title = "Volcano Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wpisstestfprg/Volcano/refs/heads/main/VolcanoLocal.lua", true))()  
    end
})    Mainbf:AddButton({
    Title = "Kncrypt Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/Kncrypt/refs/heads/main/sources/BloxFruit.lua"))()  
    end
})  Mainbf:AddButton({
    Title = "HoHo Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
    end
})    Mainbf:AddButton({
    Title = "BlueX Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua"))()      
    end
})    Mainbf:AddButton({
    Title = "Speed Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()    
    end
})    Mainbf:AddButton({
    Title = "Xeter Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/Loader/main/Xeter.lua"))()   
    end
})    Mainbf:AddButton({
    Title = "Ganteng",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/516a5669fc39b4945cd0609a08264505.lua"))()   
    end
})    Mainbf:AddButton({
    Title = "Cakka Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/UserDevEthical/Loadstring/main/CokkaHub.lua"))()   
    end
})
local Hopbf = tabs.Bloxfruit:AddSection("Hop Server")
Hopbf:AddButton({
    Title = "CutTay Hub Auto Pull Lever",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/a1498369f289af2671cca90085f23fb8.lua"))()  
    end
})    Hopbf:AddButton({
    Title = "Min Gamming Hop Boss",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/Min/refs/heads/main/MinHopBoss"))()
    end
})    Hopbf:AddButton({
    Title = "GreenZ Hub Kaitun Tyrant Of The Skies",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaAnarchist/GreenZ-Hub/refs/heads/main/KaitunTyrantOfTheSkies.lua"))()
    end
})    Hopbf:AddButton({
    Title = "GreenZ Hub Kaitun Rip Indra True Form",
    Description = "No Key",
    Callback = function()
        repeat wait() until game:IsLoaded() and game.Players.LocalPlayer 
loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaAnarchist/GreenZ-Hub/refs/heads/main/KaitunRipIndraTrueForm.lua"))()
    end
})        Hopbf:AddButton({
    Title = "Teddy Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TEDDYHUB-FREEMIUM"))()
    end
})    Hopbf:AddButton({
    Title = "Teddy Hub Hop Sever Rip indra,Dough king,…",
    Description = "No Key",
    Callback = function()
        repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TEDDYHUB-FREEMIUM"))()
    end
})    Hopbf:AddButton({
    Title = "Teddy Hub Auto Kill Tyrant Of The Skies",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/Auto-Tyrant-TEDDYHUB"))()
    end
})

local Kaitunbf = tabs.Bloxfruit:AddSection("Kaitun")

Kaitunbf:AddButton({
    Title = "Xero Hub",
    Description = "Need Key",
    Callback = function()
        -- Max level, godhuman, cdk, sgt
script_key = "" -- premium only, u can leave it blank if ur not
getgenv().Shutdown = false -- Turn on if u are farming bulk accounts
getgenv().Configs = {
    ["Team"] = "Marines",
    ["FPS Boost"] = {
        ["Enable"] = true,
        ["FPS Cap"] = 30,
    },
    ["Farm Boss Drops"] = {
        ["Enable"] = false,
        ["When x2 Exp Expired"] = false
    },
    ["Hop"] = { -- premium only
        ["Enable"] = true,
        ["Hop Find Tushita"] = true,
        ["Hop Find Valkyrie Helm"] = true,
        ["Hop Find Mirror Fractal"] = true,
        ["Hop Find Darkbeard"] = true, -- For skull guitar
        ["Hop Find Soul Reaper"] = true, -- For CDK
        ["Hop Find Mirage"] = true, -- For pull lever
        ["Find Fruit"] = true, -- Will find 1m+ fruit to unlock swan door to access third sea
    },
    ["Farm Mastery"] = {
        ["Enable"] = true,
        ["Farm Mastery Weapons"] = {"Sword", "Gun", "Blox Fruit"}, -- Blox Fruit, Gun (left -> right: High -> Low Priority)
        ["Swords To Farm"] = {"Cursed Dual Katana"},
        ["Guns To Farm"] = {"Skull Guitar"},
        ["Mastery Health (%)"] = 40 -- For Blox Fruit, Gun
    },
    ["Farm Config"] = {
        ["First Farm At Sky"] = true,
        ["Farm Bone Get x2 Exp"] = true
    },
    ["Trackstat"] = {
        ["Enable"] = false,
        ["Key"] = "", -- Get from xerohub.click
        ["Device"] = "test" -- u can put any name here
    },
    ["Auto Spawn rip_indra"] = true,
    ["Auto Spawn Dough King"] = true,
    ["Auto Pull Lever"] = true,
    ["Auto Collect Berry"] = true,
    ["Auto Evo Race"] = true,
    ["Awaken Fruit"] = true,
    ["Rainbow Haki"] = true,
    ["Hop Player Near"] = true,
    ["Skull Guitar"] = true,
    ["Cursed Dual Katana"] = true,
    ["Switch Melee"] = true,
    ["Eat Fruit"] = "", -- leave blank for none, put the fruit name like this example: Smoke Fruit, T-Rex Fruit, ...
    ["Snipe Fruit"] = "", -- leave blank for none, put the fruit name like this example: Smoke Fruit, T-Rex Fruit, ...
    ["Lock Fragment"] = 30000,
    ["Buy Stuffs"] = true -- buso, geppo, soru, ken haki, ...
}
repeat task.wait() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xero2409/XeroHub/refs/heads/main/kaitun.lua"))() end) until getgenv().Check_Execute
    end
})    Kaitunbf:AddButton({
    Title = "RoyX Hub",
    Description = "No Key",
    Callback = function()
        getgenv().ConfigsKaitun = {
	["Safe Mode"] = false, -- Will be pass all anti cheat (but slow farm)

	["Berry Collect"] = true,
	["Melee"] = {
		["Death Step"] = true,
		["Electric Claw"] = true,
		["Dragon Talon"] = true,
		["Sharkman Karate"] = true,
		["Superhuman"] = true,
		["God Human"] = true,
	},

	["Sword"] = {
		-- : World 1
		["Saber"] = true,
		["Pole"] = false,
		-- : World 2
		["Midnight Blade"] = true,
		["Shisui"] = true,
		["Saddi"] = true,
		["Wando"] = true,
		["Rengoku"] = true,
		["True Triple Katana"] = true,
		-- : World 3
		["Yama"] = true,
		["Tushita"] = true,
		["Canvander"] = true,
		["Buddy Sword"] = true,
		["Twin Hooks"] = true,
		["Hallow Scythe"] = true,
		["Cursed Dual Katana"] = true,
	},

	["Gun"] = {
		-- : World 2
		["Kabucha"] = true,
		-- : World 3
		["Venom Bow"] = true,
		["Skull Guitar"] = true,
	},

	["Mastery"] = {
		["Melee"] = true,
		["Sword"] = true,
		["Devil Fruits"] = true,

		["Configs"] = {
			["Selected All Sword"] = true,
			["Select Sword"] = {
				"Saber",
				"Cursed Dual Katana",
				"Shark Anchor"
			},
		}
	},

	["Race"] = {
		["v2"] = true,
		["v3"] = true,
		["Locked"] = {
			["Mink"] = true,
			["Human"] = true,
			["Skypiea"] = true,
			["Fishman"] = true,
		},
	},

	["Fruit"] = {
		["Main Fruit"] = {"Dough-Dough"},
		["Sec Fruit"] = {"Flame-Flame", "Ice-Ice", "Quake-Quake", "Light-Light", "Dark-Dark", "Spider-Spider", "Rumble-Rumble", "Magma-Magma", "Buddha-Buddha"},
		["Safe Fruit"] = {
			"Dough-Dough",
			"Dragon-Dragon"
		},
		["Not Open Door Fruit"] = {
		}
	},

	["Quest"] = {
		["Sea3Hop"] = true,
		
		["Rainbow Haki"] = true,
		["Pull Lever"] = true,
		["Musketeer Hat"] = true,
		["Dough Mirror"] = true,
		["Shark Anchor"] = {
			["Enable"] = true,
			["Level"] = 2100, -- Level Should More Than This Will Do
			["MaxMoney"] = 25_000_000,
			["MinMoney"] = 22_000_000,
		},
	},

	["Currency"] = {
		["Lock Fragment"] = 30_000,
	},

	["Performance"] = {
		["White Screen"] = false,
		["Booster FPS"] = false,
		["Lock FPS"] = 240,
		["AFK Timeout"] = 150,
		
		["Add/Accept Friends"] = true,
		["Auto Chat"] = false,
	},
}
loadstring(game:HttpGet("https://api.realaya.xyz/v1/files/l/73mkp0aqyfo4ypy8hvl0nz10lq49fey5.lua"))() 
    end
})    Kaitunbf:AddButton({
    Title = "Simple Hub",
    Description = "No Key",
    Callback = function()
        getgenv().simple_settings = {
    ["MASTERY"] = { -- Settings related to leveling up weapon or skill mastery
        ["ACTIVE"] = true, -- Enable or disable mastery leveling (true = enabled, false = disabled)
        ["METHOD"] = "Half", -- Method for gaining mastery, "Half"[350] or "Full"[600]
    },

    ["RAID"] = {
        ["MODE"] = "Legit", -- Legit / KillAura (Legit mode is Mob aura in raid)
    },

    ["OBJECTIVE"] = { -- Goals for farming and unlocking features
        ["GODHUMAN"] = true, -- Automatically unlock the "Godhuman" fighting style
        ["RACE-CONFIGURE"] = {
            ["RACE"] = {"Human", "Skypiea", "Fishman", "Mink"}, -- List -- "Human", "Skypiea", "Fishman", "Mink"
            ["RACE-LOCK"] = true, -- Automatically change the character race if not in the list
            ["RACE-V3"] = true, -- Automatically upgrade character race to V3 if possible Human, Mink, (Fishman, Ghoul, Cyborg) soon
        },
        ["FRAGMENT"] = 100000, -- Limit number of fragments to collect

        -- SWORD
        ["CANVANDER"] = true,
        ["BUDDY-SWORD"] = true,
        ["CURSED-DUAL-KATANA"] = true,
        ["SHARK-ANCHOR"] = true,

        --GUN
        ["ACIDUM-RIFLE"] = true,
        ["VENOM-BOW"] = true,
        ["SOUL-GUITAR"] = true,

        -- AURA
        ["COLOR-HAKI"] = {"Pure Red","Winter Sky","Snow White"}, -- Aura color to craft
    },

    ["FRUITPURCHASE"] = true, -- Automatically purchase fruits based on priority list
    ["PRIORITYFRUIT"] = { -- List of preferred fruits to purchase or eat in order of priority
        [1] = "Dragon-Dragon",
        [2] = "Dough-Dough",
        [3] = "Flame-Flame",
        [4] = "Rumble-Rumble",
        [5] = "Human-Human: Buddha",
        [6] = "Dark-Dark",
    },

    ["FPSCAP"] = 30, -- Limit the frame rate to optimize performance
    ["LOWTEXTURE"] = true -- Reduce graphic quality for better performance
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/simple-hubs/contents/refs/heads/main/bloxfruit-kaitan-main.lua"))()
    end
})    Kaitunbf:AddButton({
    Title = "Quartyz",
    Description = "Need Key",
    Callback = function()
        getgenv().Mode = "OneClick"
getgenv().Setting = {
    ["Team"] = "Pirates", -- Options "Pirates", "Marines"
    ["FucusOnLevel"] = true,
    ["Fruits"] = {  -- setting for fruits u want
        ["Primary"] = { -- if current fruit is not in this list, eat/buy
            "Dragon-Dragon",
            -- u can configs add mores/remove and must end with , (comma symbol)
        },
        ["Normal"] = { -- it just a normal fruit list
            "Flame-Flame",
            -- u can configs add mores/remove and must end with , (comma symbol)
        }
        -- run this for get all fruit name `local t={};for _,v in pairs(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetFruits"))do table.insert(t,v.Name)end;setclipboard(table.concat(t, "\n"))`
    },
    ["Lock Fruits"] = { -- don't use or eat fruits in this list
        "Yeti-Yeti",
        "T-Rex-T-Rex"
    },
    ["IdleCheck"] = 300, -- every (x) seconds if not moving rejoin
};

loadstring(game:HttpGet("https://raw.githubusercontent.com/xQuartyx/QuartyzScript/main/Loader.lua"))()
    end
})


local Autofruit = tabs.Bloxfruit:AddSection("Find Fruit")

Autofruit:AddButton({
    Title = "BlueX Hub",
    Description = "No Key",
    Callback = function()
        getgenv().Config = {
    ["Misc"] = {
        ["RandomFruits"] = true,
        ["RemoveNotify"] = true,
        ["BlackScreen"] = false,
    }
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/FindFruits.lua"))()
    end
})   Autofruit:AddButton({
    Title = "Turbo Lite",
    Description = "No Key",
    Callback = function()
        _G.Team_HaiTac = true
loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/refs/heads/main/TraiCay.lua"))()
    end
})   Autofruit:AddButton({
    Title = "Lion Hub",
    Description = "No Key",
    Callback = function()
        getgenv().Config = {
    Team = {
        SelectTeam = "Marines"
    },
    BuyFruit = {
        SelectFruit = {"Kitsune-Kitsune"},
        BuySelected = false,
        BuyRandom = true
    },
    Tween = {
        TweenFruit = true,
        SkipIfOwned = true,
        StoreFruit = true
    },
    Shop = {
        BuyZoroSword = false,
        BuyHakiColor = false
    },
    Misc = {
        SendWebhook = true,
        WebhookURL = "your webhook",
        DisableEffects = true
    }
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/d734d024f3000caddd23122da89a6c3e.lua"))()
    end
})   Autofruit:AddButton({
    Title = "Skull Hub",
    Description = "Need Key",
    Callback = function()
        getgenv().BloxFruits = {
    ["Team"] = "Marines", -- Pirates/Marines
    ["TweenSpeed"] = 350, -- Studs per second 380 no flag but kick
    ["Fruit"] = {
        ["FruitNotifier"] = false, -- Fruit notifier
        ["AutoRandom"] = true, -- Auto random/store fruit
        ["FruitSniper"] = {
            ["Enabled"] = false, -- Auto buy fruit in normal shop
            ["TargetFruits"] = {"Yeti-Yeti", "Dragon-Dragon", "Dough-Dough"},
        },
    },
    ["Farm"] = {
        ["Enabled"] = true, -- Farm chest & fruit
        ["FastMethod"] = false, -- Faster but more risky
        ["BlatantMethod"] = false, -- Instant tp no tween
        ["AutoHop"] = true, -- Auto hop after collect all
        ["ItemHop"] = true, -- God's Chalice/Fist of Darkness
    },
    ["Webhook"] = {
        ["Enabled"] = false,
        ["URL"] = "Your Webhook Url",
        ["UserId"] = "Id Discord",
    },
    ["BlackScreen"] = false,
    ["FpsBoost"] = true, -- Boost FPS
    ["AntiIdle"] = true, -- Anti AFK
}
loadstring(game:HttpGet('https://raw.githubusercontent.com/hungquan99/SkullHub/main/loader.lua'))()
    end
})












local Autobounty = tabs.Bloxfruit:AddSection("Auto Bounty")


Autobounty:AddButton({
    Title = "Lion Hub",
    Description = "No Key",
    Callback = function()
        repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
getgenv().Team = "Pirates"
getgenv().Config = {
    ["Safe Health"] = {50},
    ["Custom Y Run"] = {
        Enabled = true,
        ["Y Run"] = 5000
    },
    ["Hunt Method"] = {
        ["Use Move Predict"] = false,
        ["Hit and Run"] = false,
        ["Aimbot"] = true,
        ["ESP Player"] = true,
        ["Max Attack Time"] = 60
    },
    ["Shop"] = {
        ["Random Fruit"] = false,
        ["Store Fruit"] = true,
        ["Zoro Sword"] = false
    }, 
    ["Ui Theme"] = {
        ["Background"] = "139756291389843",
        ["Skip Button"] = "113079599736013",
        ["Reset Bounty Button"] = "118191900561814"
    },
    ["Setting"] = {
        ["World"] = nil,
        ["White Screen"] = false,
        ["Fast Delay"] = 0.5, 
        ["Tween Speed"] = 350,
        ["FPS BOOSTER"] = false,
        ["Url"] = "Your_Webhook_Url",
        ["Chat"] = {
            Enabled = false,
            Wait = 350,
            Massage = {"Lion Hub On Top", "Get Best Script g g / lionhub"}
        }
    },
    ["Skip"] = {
        ["Avoid V4"] = false
    },
    ["Spam All Skill On V4"] = {
        Enabled = true,
        ["Weapons"] = {"Melee", "Sword", "Gun", "Blox Fruit"}
    },
    Items = {
        Use = {"Melee", "Sword", "Gun", "Blox Fruit"},
        Melee = {
            Enable = true,
            Delay = 0.4,
            Skills = {
                Z = {Enable = true, HoldTime = 0.3},
                X = {Enable = true, HoldTime = 0.2},
                C = {Enable = true, HoldTime = 0.5}
            }
        },
        Sword = {
            Enable = true,
            Delay = 0.5,
            Skills = {
                Z = {Enable = true, HoldTime = 1},
                X = {Enable = true, HoldTime = 0}
            }
        },
Gun = {
            Enable = true,
            Delay = 0.3,
            Skills = {
                Z = {Enable = true, HoldTime = 0.1},
                X = {Enable = true, HoldTime = 0.1}
            }
        },
        ["Blox Fruit"] = {
            Enable = true,
            Delay = 0.4,
            Skills = {
                Z = {Enable = true, HoldTime = 0.1},
                X = {Enable = true, HoldTime = 0.1},
                C = {Enable = true, HoldTime = 0.15},
                V = {Enable = true, HoldTime = 0.2},
                F = {Enable = true, HoldTime = 0.1}
            }
        }
    }
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/10f7f97cebba24a87808c36ebd345a97.lua"))()
    end
})    Autobounty:AddButton({
    Title = "Vxeze Hub",
    Description = "No Key",
    Callback = function()
        getgenv().Config = {
    ["Team"] = "Pirates",
    ["Safe Health"] = {40, 50}, --- 60 - 70
    ["Skip"] = {
        ["Fruit"] = {
            ["Enabled"] = true, --- false
            ["Avoid Fruit"] = {
                "Portal-Portal",
                "Kitsune-Kitsune"
            }
        },
        ["Avoid V4"] = true --- false
    },
    ["Hunt Method"] = {
        ["Use Move Predict"] = true, --- false
        ["Hit and Run"] = true --- false
    },
    ["Spam All Skill On V4"] = {
        ["Enabled"] = true, --- false
        ["Weapons"] = {"Melee", "Gun", "Sword", "Blox Fruit"}
    },
    ["Chat"] = {
        ["Enabled"] = false, --- false
        ["Message"] = {"Vxeze Hub Auto Bounty"}
    },
    ["Custom Y Run"] = {
        ["Enabled"] = true, --- false
        ["Y Run"] = 5000 --- <5000
    },
    ["Misc"] = {
        ["Auto Teleport Sea 2"] = false,
        ["Auto Teleport Sea 3"] = true,
        ["Auto Store Fruit"] = true,
        ["Auto Random Fruit"] = true,
        ["White Screen"] = false, --- true
        ["Disabled Notify"] = false,
        ["Boots FPS"] = false,
        ["Auto Dash"] = true,
        ["Auto Rejoin"] = true,
        ["Click Delay"] = 0.01
    },
    ["Items"] = {
        ["Use"] = {"Melee", "Gun", "Sword"},
        ["Melee"] = {
            ["Enable"] = true,
            ["Skills"] = {
                ["Z"] = {["Enable"] = true, ["HoldTime"] = 1.5},
                ["X"] = {["Enable"] = true, ["HoldTime"] = 0.1},
                ["C"] = {["Enable"] = true, ["HoldTime"] = 0.1}
            }
        },
        ["Blox Fruit"] = {
            ["Enable"] = true,
            ["Skills"] = {
                ["Z"] = {["Enable"] = true, ["HoldTime"] = 0.1},
                ["X"] = {["Enable"] = true, ["HoldTime"] = 0.1},
                ["C"] = {["Enable"] = true, ["HoldTime"] = 0.1},
                ["V"] = {["Enable"] = false, ["HoldTime"] = 0.1},
                ["F"] = {["Enable"] = true, ["HoldTime"] = 0.1}
            }
        },
        ["Sword"] = {
            ["Enable"] = true,
            ["Skills"] = {
                ["Z"] = {["Enable"] = true, ["HoldTime"] = 0.1},
                ["X"] = {["Enable"] = true, ["HoldTime"] = 0.1}
            }
        },
        ["Gun"] = {
            ["Enable"] = true,
            ["Skills"] = {
                ["Z"] = {["Enable"] = true, ["HoldTime"] = 0.1},
                ["X"] = {["Enable"] = true, ["HoldTime"] = 0.1}
            }
        }
    }
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/Dex-Bear/Vxezehub/refs/heads/main/VxezeHubAutoBounty"))()
    end
})    Autobounty:AddButton({
    Title = "Hiru Hub",
    Description = "No Key",
    Callback = function()
        getgenv().Config = {
 ["Team"] = "Pirates",
 ["Safe Health"] = {40, 50},
 ["Skip"] = { 
 ["Fruit"] = {["Enabled"] = true,
 ["Avoid Fruit"] = {
 "Portal-Portal", 
 "Kitsune-Kitsune"
 }
 },
 ["Avoid V4"] = true
 },
 ["Hunt Method"] = {
 ["Use Move Predict"] = true,
 ["Hit and Run"] = true
 },
 ["Spam All Skill On V4"] = {
 ["Enabled"] = true,
 ["Weapons"] = {"Melee", "Gun", "Sword", "Blox Fruit"}
 },
 ["Chat"] = {
 ["Enabled"] = false,
 ["Message"] = {"Hiru Hub Bounty"}
 },
 ["Custom Y Run"] = {
 ["Enabled"] = false,
 ["Y Run"] = 100
 },
 ["Misc"] = {
 ["Auto Store Fruit"] = true,
 ["Auto Random Fruit"] = true,
 ["White Screen"] = false,
 ["Click Delay"] = 0.1,
 },
 ["Items"] = {["Use"] = {"Melee", "Gun", "Sword"},
 ["Melee"] = {
 ["Enable"] = true,
 ["Skills"] = {
 ["Z"] = {["Enable"] = true, ["HoldTime"] = 1.5},
 ["X"] = {["Enable"] = true, ["HoldTime"] = 0.1},
 ["C"] = {["Enable"] = true, ["HoldTime"] = 0.1}
 }
 },
 ["Blox Fruit"] = {
 ["Enable"] = false,
 ["Skills"] = {
 ["Z"] = {["Enable"] = true, ["HoldTime"] = 1.2},
 ["X"] = {["Enable"] = true, ["HoldTime"] = 0},
 ["C"] = {["Enable"] = true, ["HoldTime"] = 0},
 ["V"] = {["Enable"] = false, ["HoldTime"] = 0},
 ["F"] = {["Enable"] = false, ["HoldTime"] = 0}
 }
 },
 ["Sword"] = {
 ["Enable"] = true,
 ["Skills"] = {
 ["Z"] = {["Enable"] = true, ["HoldTime"] = 0.1},
 ["X"] = {["Enable"] = true, ["HoldTime"] = 0.1}
 } 
 },
 ["Gun"] = {
 ["Enable"] = true, 
 ["Skills"] = {
 ["Z"] = {["Enable"] = true, ["HoldTime"] = 0.1},
 ["X"] = {["Enable"] = true, ["HoldTime"] = 0.1}
 } 
 }
 }
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/NGUYENVUDUY1/Source/main/Bounty.lua"))()
    end
})













-------[            Grow a Garden            ]--------










    tabs.Growagarden:AddButton({
    Title = "Kenniel Script",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Kenniel123/Grow-a-garden/refs/heads/main/Grow%20A%20Garden"))()
    end
})    tabs.Growagarden:AddButton({
    Title = "Join Old Server",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/M-E-N-A-C-E/Menace-Hub/refs/heads/main/Old%20Server%20Finder%20Grow%20a%20Garden", true))()
    end
})    tabs.Growagarden:AddButton({
    Title = "Ameicaa",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tesghg/Grow-a-Garden/main/ameicaa_Grow_A_Garden.lua"))()
    end
})   tabs.Growagarden:AddButton({
    Title = "Beecon Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBossScript/BeeconHub/main/BeeconHub"))()
    end
})    tabs.Growagarden:AddButton({
    Title = "Speed Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})     tabs.Growagarden:AddButton({
    Title = "Native Hub",
    Description = "Link Get Key : https://ads.luarmor.net/get_key?for=Native_Linkvertise-OlHmNGrpKcxc",
    Callback = function()
        script_key="PASTE_KEY_HERE";
(loadstring or load)(game:HttpGet("https://getnative.cc/script/loader"))()
    end
})   tabs.Growagarden:AddButton({
    Title = "Solix Hub",
    Description = "I don't know",
    Callback = function()
        _G.AutoFarm = true
_G.PerformanceMode = "Fast" -- "LowEnd", "Normal", "Fast", "Ultra"
_G.TeleportCooldown = 0.1
-- Seed settings
_G.AutoRebuy = true
_G.SeedPrice = 4000
_G.AutoSellThreshold = 50
_G.AutoWatering = true
_G.AutoSprinklers = true
-- Gear shop
_G.GearShopAutoBuy = true
_G.GearShopItems = {"Basic Watering Can", "Basic Sprinkler", "Basic Shovel"}
_G.RenderDistance = 50
_G.UIUpdateInterval = 2
_G.OptimizeRendering = true
loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/solixloader/refs/heads/main/solix%20v2%20new%20loader.lua"))()
    end
})    tabs.Growagarden:AddButton({
    Title = "Black Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Skibidiking123/Fisch1/refs/heads/main/FischMain"))()
    end
}) tabs.Growagarden:AddButton({
    Title = "TBao Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/game/refs/heads/main/TbaoHubGrowGarden"))()
    end
})    tabs.Growagarden:AddButton({
    Title = "Photon Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NittarPP/PhotonScript/refs/heads/main/Loading/Loading.lua"))()
    end
})   tabs.Growagarden:AddButton({
    Title = "Vxeze Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dex-Bear/Vxezehub/refs/heads/main/VxezeHubMain"))()
    end
})    tabs.Growagarden:AddButton({
    Title = "Vxeze Hub Kaitun Grow A Garden",
    Description = "No Key",
    Callback = function()
        getgenv().VxezeHubConfig = {
    ["Auto Collect Plants"] = true,
    ["Auto Collect Moonlit Fruit"] = true,
    ["Auto Collect Blood Fruit"] = true,
    ["Loop Auto Sell"] = true,

    ["Auto Buy M+ Seeds"] = false,
    ["Auto Buy Selected Seeds"] = true,
    ["Select All Seeds"] = true,
    ["SelectedSeedsToBuy"] = {
        ["Apple"] = false, ["Bamboo"] = false, ["Beanstalk"] = false, ["Blueberry"] = false,
        ["Cacao"] = false, ["Cactus"] = false, ["Carrot"] = false, ["Coconut"] = false,
        ["Corn"] = false, ["Daffodil"] = false, ["Dragon Fruit"] = false, ["Grape"] = false,
        ["Mango"] = false, ["Mushroom"] = false, ["Orange"] = false, ["Pepper"] = false,
        ["Pumpkin"] = false, ["Strawberry"] = false, ["Tomato"] = false, ["Watermelon"] = false
    },

    ["Auto Buy Blood"] = tru,
    ["Select All Blood Items"] = true,
    ["SelectedBloodItemsToBuy"] = {
        ["Blood Banana"] = false, ["Blood Hedgehog"] = false, ["Blood Kiwi"] = false, ["Blood Owl"] = false,
        ["Moon Melon"] = false, ["Mysterious Crate"] = false, ["Night Egg"] = false,
        ["Night Seed Pack"] = false, ["Star Caller"] = false
    },

    ["Auto Buy Eggs"] = false,
    ["Eggs"] = {
        ["Common"] = true, ["Uncommon"] = true, ["Rare"] = true,
        ["Legendary"] = true, ["Mythical"] = true, ["Bug"] = true,
    },
    ["Auto Plant All Seeds"] = true,
    ["Select All Plantable Seeds"] = true,
    ["SelectedSeedsToPlant"] = {
        ["Apple"] = true, ["Bamboo"] = true, ["Beanstalk"] = true, ["Blueberry"] = true,
        ["Cacao"] = true, ["Cactus"] = true, ["Carrot"] = true, ["Coconut"] = true,
        ["Corn"] = true, ["Daffodil"] = true, ["Dragon Fruit"] = false, ["Grape"] = true,
        ["Mango"] = true, ["Mushroom"] = true, ["Orange"] = true, ["Pepper"] = true,
        ["Pumpkin"] = true, ["Strawberry"] = true, ["Tomato"] = true, ["Watermelon"] = true
    },

    ["Auto Submit Moonlit"] = false,
    ["Anti-AFK"] = true,
    ["Player NoClip"] = true,
    ["Camera NoClip"] = true,
    ["Continuous E Hold"] = true,
    ["Auto Max Zoom"] = true,
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Dex-Bear/Vxezehub/refs/heads/main/VxezeHubGrowAGardenKaitun.lua"))()
    end
})    tabs.Growagarden:AddButton({
    Title = "Tora IsMe",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/GrowaGarden"))()
    end
})    tabs.Growagarden:AddButton({
    Title = "Speed Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})    tabs.Growagarden:AddButton({
    Title = "NoLag Hub",
    Description = "No Key",
    Callback = function()
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local scripts = {
    [126884695634066] = "https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Garden/Garden-V1.lua",
    [81440632616906] = "https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/DigEarth/V1.lua",
}

local url = scripts[game.PlaceId]
if url then
    loadstring(game:HttpGetAsync(url))()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/untitled.lua"))()
end
    end
})    tabs.Growagarden:AddButton({
    Title = "Space Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/ago106/SpaceHub/refs/heads/main/Multi'))()
    end
})    tabs.Growagarden:AddButton({
    Title = "Ronix Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/8f14c1806369f8ae3db39eafc954d76d.lua"))()
    end
})    tabs.Growagarden:AddButton({
    Title = "Lunor Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet('https://lunor.dev/loader'))()
    end
})    tabs.Growagarden:AddButton({
    Title = "Bebo Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Bebo-Mods/BeboScripts/refs/heads/main/GrowAGarden.lua"))()
    end
})


















-------[            Blue Lock            ]--------















tabs.Bluelock:AddButton({
    Title = "Alchemy Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
    end
})    tabs.Bluelock:AddButton({
    Title = "TBao Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/game/refs/heads/main/TbaoHubBlueLockRivals"))()
    end
})     tabs.Bluelock:AddButton({
    Title = "Bill Dev",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/selciawashere/screepts/refs/heads/main/BLRTBDMOBILEKEYSYS",true))()
    end
})    tabs.Bluelock:AddButton({
    Title = "NS Hub",
    Description = "Need Key",
    Callback = function()
          
    end
})    tabs.Bluelock:AddButton({
    Title = "Lunor",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("loadstring(game:HttpGet('https://raw.githubusercontent.com/Just3itx/Lunor-Loadstrings/refs/heads/main/Loader'))()"))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Omg Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/UPD-Blue-Lock:-Rivals-OMG-Hub-29091"))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Arbix",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet(('https://pastefy.app/O3F7JYSF/raw'),true))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Tbao Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/game/refs/heads/main/TbaoHubBlueLockRivals"))()
    end
})   tabs.Bluelock:AddButton({
    Title = "Style Need Reo",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/D1M2PLua"))()
    end
})  tabs.Bluelock:AddButton({
    Title = "Inf Stamina",
    Description = "No Key",
    Callback = function()
        local args = {
            [1] = 0/0
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StaminaService"):WaitForChild("RE"):WaitForChild("DecreaseStamina"):FireServer(unpack(args))  
    end
})    tabs.Bluelock:AddButton({
    Title = "Auto Slide, Dribble",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Maybie/BlueLock/refs/heads/main/BLR.lua',true))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Sterling",
    Description = "I don't know",
    Callback = function()
        local GuiService = game:GetService("GuiService")
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    local player = Players.LocalPlayer
    local function onerrorMessageChanged(errorMessage)
        if errorMessage and errorMessage ~= "" then
            print("Error detected: " .. errorMessage)
            if player then
                wait()
                TeleportService:Teleport(game.PlaceId, player)
            end
        end
    end
    GuiService.ErrorMessageChanged:Connect(onerrorMessageChanged)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Zayn31214/name/refs/heads/main/SterlingNew"))()  
    end
})    tabs.Bluelock:AddButton({
    Title = "Over Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet('https://api.overhub.xyz/keys/script/overhub'))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Imp Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/Hub/refs/heads/main/ImpHub.lua"))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Ronix Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/c84ecefd7fa63a35d454d3ecefe3ee7e.lua"))()
    end
})






-------[            Brookhaven            ]--------





    tabs.Brookhaven:AddButton({
     Title = "Ice Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Waza80/scripts-new/main/IceHubBrookhaven.lua"))()
    end
})    tabs.Brookhaven:AddButton({
     Title = "SP Hub",
    Description = "No Key",
    Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/as6cd0/SP_Hub/refs/heads/main/Brookhaven"))() 
    end
})    tabs.Brookhaven:AddButton({
     Title = "Z4trox Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Jfdedit3/z4trox-hub-v1/main/z4trox%20hub'))()
    end
})









-------[            Forsaken            ]--------








    tabs.Forsaken:AddButton({
    Title = "ShitScripts",
    Description = "I don't know",
    Callback = function()
        if getgenv then
    getgenv().BloxtrapRPC = "true"
    getgenv().DebugNotifications = "false"
    getgenv().TrackMePlease = "true"
end
 
loadstring(game:HttpGet("https://raw.githubusercontent.com/ivannetta/ShitScripts/main/forsaken.lua"))()
    end
})    tabs.Forsaken:AddButton({
    Title = "Goa Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Nevcit/GOA_HUB/refs/heads/main/Forsaken"))()
    end
})    tabs.Forsaken:AddButton({
    Title = "Saryn Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Saiky988/Saryn-Hub/refs/heads/main/Saryn%Hub%Beta.lua'))()
    end
})    tabs.Forsaken:AddButton({
    Title = "RainV Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/OGWBZb1S/raw"))() 
    end
})










-------[            Blade Ball            ]--------







    tabs.Bladeball:AddButton({
    Title = "Yon Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/be9f75cf2b14e58f62e05e296ce0660b.lua"))() 
    end
})    tabs.Bladeball:AddButton({
    Title = "Allusive",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/318a5144aa7f73418565ac6aecc5bd94.lua"))() 
    end
})    tabs.Bladeball:AddButton({
    Title = "Lunax Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/mzkv/LUNAR/refs/heads/main/BladeBall", true))() 
    end
})    tabs.Bladeball:AddButton({
    Title = "Kalitor Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/redopy7/Blade-Ball/refs/heads/main/KalitorBeta.txt"))() 
    end
})    tabs.Bladeball:AddButton({
    Title = "Frostware",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/54b11727a99567356ad9ec3a8555b675.lua"))() 
    end
})   tabs.Bladeball:AddButton({
    Title = "Depth Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githu busercontent.com/funhaji/Blade-Ball/refs/heads/main/No-Lag.lua", true))()
    end
})tabs.Bladeball:AddButton({
    Title = "Beanz Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/pid4k/scripts/main/BeanzHub.lua"))()
    end
}) tabs.Bladeball:AddButton({
    Title = "Ronix Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/79ab2d3174641622d317f9e234797acb.lua"))()
    end
})   tabs.Bladeball:AddButton({
    Title = "Auto Parry",
    Description = "No Key",
    Callback = function()
        getgenv().visualizer = true
loadstring(game:HttpGet("https://raw.githubusercontent.com/1f0yt/community/main/RedCircleBlock"))() 
    end
})










-------[            Fisch            ]--------
















    tabs.Fisch:AddButton({
    Title = "Speed Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})    tabs.Fisch:AddButton({
    Title = "Than Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thantzy/thanhub/refs/heads/main/thanv1"))()
    end
})    tabs.Fisch:AddButton({
    Title = "HoHo Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
    end
})    tabs.Fisch:AddButton({
    Title = "Native Hub",
    Description = "Link Get Key : https://ads.luarmor.net/get_key?for=Native_Linkvertise-OlHmNGrpKcxc",
    Callback = function()
        script_key="PASTEKEYHERE";
(loadstring or load)(game:HttpGet("https://getnative.cc/script/loader"))()
    end
})    tabs.Fisch:AddButton({
    Title = "Deng Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DENGHUB2025/HUGHUB/main/WL", true))()
    end
})    tabs.Fisch:AddButton({
    Title = "Londne",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/londnee/code/refs/heads/main/Fisch.lua"))()
    end
})    tabs.Fisch:AddButton({
    Title = "Naoki Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://naokihub.vercel.app",true))()
    end
})    tabs.Fisch:AddButton({
    Title = "Kiciahook",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kiciahook/kiciahook/refs/heads/main/loader.lua"))()
    end
})   tabs.Fisch:AddButton({
    Title = "Solix Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
    end
})    tabs.Fisch:AddButton({
    Title = "Raito Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Efe0626/RaitoHub/refs/heads/main/Script"))()
    end
})    tabs.Fisch:AddButton({
    Title = "Ronix Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e4d72046eb884e9c01333d3e704fc2d7.lua"))()
    end
})    tabs.Fisch:AddButton({
    Title = "Krcrypt Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/Kncrypt/refs/heads/main/sources/Fisch.lua"))()
    end
})












-------[            Get Go            ]--------















tabs.Petgo:AddButton({
    Title = "NS Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/OhhMyGehlee/go/refs/heads/main/is"))()
    end
})    tabs.Petgo:AddButton({
    Title = "Zap Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet('https://zaphub.xyz/Exec'))()
    end
})    tabs.Petgo:AddButton({
    Title = "Speed Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})













-------[            Deed Rails            ]--------














   tabs.Deedrails:AddButton({
    Title = "MoonDiety Auto Win",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/m00ndiety/Auto-win-Keyless-/refs/heads/main/obf_Dead_Rails_Auto_Win_Farm_GUI.lua.txt'))()
    end
})   tabs.Deedrails:AddButton({
    Title = "MoonDiety Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/m00ndiety/DEAD-RAILS-MAIN-SCRIPT-V2/refs/heads/main/MoonDiety.txt'))() 
    end
})    tabs.Deedrails:AddButton({
    Title = "XuanVP Hub ( Fly )",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XUANVNPRO/XuanVPHUB/refs/heads/main/FlyGui.lua.txt"))()
    end
})   tabs.Deedrails:AddButton({
    Title = "XuanVP Hub ( Auto Fram Bond V1 )",
    Description = "No Key",
    Callback = function()
        _G.url = "linkwebhook"
loadstring(game:HttpGet("https://raw.githubusercontent.com/XUANVNPRO/Bondfarm/refs/heads/main/Bondv1"))()      
    end
})   tabs.Deedrails:AddButton({
    Title = "XuanVP Hub ( Auto Fram Bond V2)",
    Description = "No Key",
    Callback = function()
        _G.url = "linkwebhook"
loadstring(game:HttpGet("https://raw.githubusercontent.com/XUANVNPRO/Bondfarm/refs/heads/main/Bondv2"))()      
    end
})   tabs.Deedrails:AddButton({
    Title = "Nebula Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NebulaHubOfc/Public/refs/heads/main/Loader.lua"))()      
    end
})     tabs.Deedrails:AddButton({
    Title = "Rift Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://rifton.top/loader.lua"))()      
    end
})     tabs.Deedrails:AddButton({
    Title = "Akatsuki Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AkatsukiHub1/Rails/refs/heads/main/README.md"))()       
    end
})     tabs.Deedrails:AddButton({
    Title = "XuanVP Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XUANVNPRO/XuanVPHUB/refs/heads/main/XuanVPPHUB.lua.txt"))()       
    end
})     tabs.Deedrails:AddButton({
    Title = "Lunor Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet('https://lunor.dev/loader'))()       
    end
})      tabs.Deedrails:AddButton({
    Title = "Yon Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/be9f75cf2b14e58f62e05e296ce0660b.lua"))()       
    end
})     tabs.Deedrails:AddButton({
    Title = "Gojo",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LolnotaKid/SCRIPTSBYVEUX/refs/heads/main/LALALALALALAGOJOOO.lua.txt"))()      
    end
})    tabs.Deedrails:AddButton({
    Title = "I don't know the name (Fram Bond)",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/SevenIsYouScripts/Main/refs/heads/main/Auto%20Bonds%20Script'))()      
    end
})      tabs.Deedrails:AddButton({
    Title = "I don't know the name (Fram Bond)",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/invertedth/Autobonds/refs/heads/main/Autobondscirpt.lua"))()     
    end
})    tabs.Deedrails:AddButton({
    Title = "Kicihook V2",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kiciahook/kiciahook/refs/heads/main/loader.lua"))()  
    end
})       tabs.Deedrails:AddButton({
    Title = "HoHo Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Native Hub",
    Description = "Link Get Key : https://ads.luarmor.net/get_key?for=Native_Linkvertise-OlHmNGrpKcxc",
    Callback = function()
        script_key="PASTEKEYHERE";
(loadstring or load)(game:HttpGet("https://getnative.cc/script/loader"))()  
    end
})   tabs.Deedrails:AddButton({
    Title = "Than Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thantzy/thanhub/refs/heads/main/thanv1"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Nat Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ArdyBotzz/NatHub/refs/heads/master/NatHub.lua"))();  
    end
})    tabs.Deedrails:AddButton({
    Title = "Tp All Map By Jonas",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JonasThePogi/DeadRails/refs/heads/main/newloadstring"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Tbao Hub (Main)",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/refs/heads/main/TbaoHubDeadRails"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Tbao Hub (Tp Map)",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/game/refs/heads/main/TbaoHubDeadRailsTp"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Tbao Hub (Fram Bond)",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/game/refs/heads/main/TbaoHubDeadRailsFarm"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Tn Hub (Fram Bond)",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thiennrb7/Script/refs/heads/main/autobond"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Npc Lock",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/s542AG7U/raw"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Increase Hitbox + Aim lock",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/o4SV2jjx/raw"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "No Clip + Esp",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/DeadRails", true))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Auto Fram Bond",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8642/science/refs/heads/ok/dead%20rails"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Skull Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/hungquan99/SkullHub/main/loader.lua'))()
    end
})    tabs.Deedrails:AddButton({
    Title = "DHHz Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ducknovis/DHHz-hub/refs/heads/main/Dead-Rails.lua"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Deed Rails",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thiennrb7/Script/refs/heads/main/Bringall"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Speed Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Null Fire",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Solix Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Neox Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/NEOXHUBMAIN/refs/heads/main/loader", true))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Ronix Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/672a0ae340e8ce7e21a51e37c6bf0cc1.lua"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Spider Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SpiderScriptRB/Dead-Rails-SpiderXHub-Script/refs/heads/main/SpiderXHub%202.0.txt"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Auto Bond Fake",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Emplic/deathrails/refs/heads/main/bond"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Vehicle Fly",
    Description = "No Key",
    Callback = function()
        Loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Vehicle%20Fly%20Gui'))()
    end
})















-------[            Bubble Rubber Simulator           ]--------








   tabs.BubbleRubber:AddButton({
    Title = "Smoke Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/etqjuyreal/smoke/refs/heads/main/bgsi.lua"))()
    end
})
    tabs.BubbleRubber:AddButton({
    Title = "Beecon Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBossScript/BeeconHub/main/BeeconHub"))()
    end
})    
    tabs.BubbleRubber:AddButton({
    Title = "Speed Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
}) 
    tabs.BubbleRubber:AddButton({
    Title = "Tbi",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/1ecd78392f03d4393a38374136a8e5a8.lua"))()
    end
}) 
    tabs.BubbleRubber:AddButton({
    Title = "Strelizia Hub",
    Description = "Need Key",
    Callback = function()
        getgenv().UserPreference = {
    ['RiftPotions'] = {
        ['AuraEggPotions'] = {
            --['Infinity Elixir'] = true,
            --['Lucky Evolved'] = true,
            --['Speed Evolved'] = true,
        },
        ['TwentyFiveMultiPotions'] = {
            --['Lucky Evolved'] = true,
            --['Speed Evolved'] = true,
            --['Mythic Evolved'] = true
        }
    }
};
loadstring(game:HttpGet('https://raw.githubusercontent.com/0vma/Strelizia/refs/heads/main/Loader.lua', true))()
    end
})  tabs.BubbleRubber:AddButton({
    Title = "Nigel Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/eac841be8e94cbe9d477d0bde5c0a312.lua"))()
    end
})    tabs.BubbleRubber:AddButton({
    Title = "Moon X Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MateoDev2024/MoonX/main/Loader.lua"))()
    end
})     tabs.BubbleRubber:AddButton({
    Title = "Alchemy Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
    end
})     tabs.BubbleRubber:AddButton({
    Title = "Than Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thantzy/thanhub/refs/heads/main/thanv1"))()
    end
})    tabs.BubbleRubber:AddButton({
    Title = "Nousigi Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://nousigi.com/loader.lua"))()
    end
})    tabs.BubbleRubber:AddButton({
    Title = "NS Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/OhhMyGehlee/be/refs/heads/main/u"))()
    end
})    tabs.BubbleRubber:AddButton({
    Title = "Lunor Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet('https://lunor.dev/loader'))()
    end
})














-------[            Arise Crossover            ]--------














tabs.Arisecrossover:AddButton({
    Title = "Lunor Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet('https://lunor.dev/loader'))()
    end
})  tabs.Arisecrossover:AddButton({
    Title = "Omg Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
    end
})  tabs.Arisecrossover:AddButton({
    Title = "Nil Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/2c5f110f91165707959fc626b167e036.lua"))()
    end
})  tabs.Arisecrossover:AddButton({
    Title = "RoyX Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nomed-rin/Royx_Free/refs/heads/main/loader.lua"))()
    end
})  tabs.Arisecrossover:AddButton({
    Title = "Yon Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/be9f75cf2b14e58f62e05e296ce0660b.lua"))() 
    end
})   tabs.Arisecrossover:AddButton({
    Title = "Yuto Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/Binintrozza/yutv2e/main/Yutohub')))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Devry Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/defnotry/devry-hub/main/arise-crossover/main.lua"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Goomba Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JustLevel/goombahub/main/AriseCrossover.lua"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Arise Crossover By Perfectus",
    Description = "I Don't Know",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Arise-Crossover-Keyless-Script-33926"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Twvz",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ZhangJunZ84/twvz/refs/heads/main/arisecrossover.lua"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Almechy Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Elgato",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/meobeo8/elgato/a/Loader"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Skull Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/hungquan99/SkullHub/main/loader.lua'))() 
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Tora IsMe",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/AriseCrossover"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Omg Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/OhhMyGehlee/y/refs/heads/main/hj"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Sky Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SKOIXLL/SKYLOLAND/refs/heads/main/Load.lua"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Gentle Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GentleScriptHub/GentleHub/refs/heads/main/Games"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Speed Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})












-------[            Volleyball Legend            ]--------







tabs.Volleyball:AddButton({
    Title = "Yon Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/be9f75cf2b14e58f62e05e296ce0660b.lua"))()
    end
})    tabs.Volleyball:AddButton({
    Title = "Napoleon Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/raydjs/napoleonHub/refs/heads/main/src.lua"))() 
    end
})    tabs.Volleyball:AddButton({
    Title = "Sterling Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Zayn31214/name/refs/heads/main/SterlingNew"))() 
    end
})








-------[            Basketball            ]--------






    tabs.Basketball:AddButton({
    Title = "Rinns Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e1cfd93b113a79773d93251b61af1e2f.lua"))()
    end
})
    tabs.Basketball:AddButton({
    Title = "Alchemy Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
    end
})    tabs.Basketball:AddButton({
    Title = "RoyX Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nomed-rin/Royx_Free/refs/heads/main/loader.lua"))()
    end
})    tabs.Basketball:AddButton({
    Title = "Control Ball",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RedJDark/CONTROL-SCRIPTT/refs/heads/main/CONTROL"))()
    end
})








-------[            The Strongest Battlegrounds            ]--------










tabs.Tsb:AddButton({
    Title = "Spooks Spooky Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/ApparentlySpooks/spookshubTSB/refs/heads/main/SHTSB.txt'))()
    end
})    tabs.Tsb:AddButton({
    Title = "Rinns Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/SkibidiCen/MainMenu/main/Code'))()
    end
})    tabs.Tsb:AddButton({
    Title = "TSB Animations",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Mautiku/ehh/main/strong%20guest.lua.txt'))()
    end
})    tabs.Tsb:AddButton({
    Title = "VaultScript",
    Description = "Key : Th3Vault$criptsK3y",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Loolybooly/TheVaultScripts/refs/heads/main/FullScript"))() 
    end
})    tabs.Tsb:AddButton({
    Title = "Beecon Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBossScript/BeeconHub/main/BeeconHub"))() 
    end
})    tabs.Tsb:AddButton({
    Title = "Phantasm",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ATrainz/Phantasm/refs/heads/main/Phantasm.lua"))()
    end
})    tabs.Tsb:AddButton({
    Title = "Speed Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})     tabs.Tsb:AddButton({
    Title = "Trash Can",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/yes1nt/yes/refs/heads/main/Trashcan%20Man", true))()
    end
})











-------[            Murder Mystery 2           ]--------











    tabs.Mm2:AddButton({
    Title = "Kiciahook Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kiciahook/kiciahook/refs/heads/main/loader.lua"))()
    end
})      tabs.Mm2:AddButton({
    Title = "Solix Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
    end
})  tabs.Mm2:AddButton({
    Title = "Foggy Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FOGOTY/mm2-piano-reborn/refs/heads/main/scr"))()
    end
})    tabs.Mm2:AddButton({
    Title = "TBao Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubMurdervssheriff"))()
    end
})    tabs.Mm2:AddButton({
    Title = "Dash Script",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vax3478/Vax/refs/heads/main/dashscript-mm2hub"))()
    end
})    tabs.Mm2:AddButton({
    Title = "Eclicse",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet(("https://raw.githubusercontent.com/Ethanoj1/EclipseMM2/master/Script"),true))() 
    end
})    tabs.Mm2:AddButton({
    Title = "Script by Dayrox12",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dayrox12/main/refs/heads/main/mm2script.lua"))()
    end
})    tabs.Mm2:AddButton({
    Title = "XHub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Au0yX/Community/main/XhubMM2"))() 
    end
})









-------[            Rivals            ]--------









    tabs.Rivals:AddButton({
    Title = "Tbao Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubRivals"))()
    end
})    tabs.Rivals:AddButton({
    Title = "Duck Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/HexFG/duckhub/refs/heads/main/loader.lua'))()
    end
})  tabs.Rivals:AddButton({
    Title = "Ronix Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e945f55997c4240abc865c0bcc2136c5.lua"))()
    end
})    tabs.Rivals:AddButton({
    Title = "Soluna",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://soluna-script.vercel.app/main.lua",true))()
    end
})






-------[            Cộng Đồng Việt Nam            ]--------





    tabs.CongDongVietNam:AddButton({
    Title = "Radiant Hub Auto Grab",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/x2RunE/QuynhLaSo1/refs/heads/main/AutoGrabCDVN.lua"))()
    end
})     tabs.CongDongVietNam:AddButton({
    Title = "XZ Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet('https://z3rx.tech/script.lua'))()
    end
})






-------[            Anime Saga            ]--------




     tabs.AnimeSaga:AddButton({
    Title = "Tora IsMe",
    Description = "No Key",
    Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/AnimeSaga"))() 
    end
})     tabs.AnimeSaga:AddButton({
    Title = "Ns Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/OhhMyGehlee/ga/refs/heads/main/ga"))()
    end
})     tabs.AnimeSaga:AddButton({
    Title = "Aeonic Hub",
    Description = "Need Key",
    Callback = function()
        script_key = "" -- For Afk Farming
loadstring(game:HttpGet("https://raw.githubusercontent.com/mazino45/main/refs/heads/main/MainScript.lua"))()
    end
})     tabs.AnimeSaga:AddButton({
    Title = "Yuto Hub",
    Description = "Need Key",
    Callback = function()
        repeat wait() until game:IsLoaded()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/Binintrozza/yutv2e/main/Yutohub')))() 
    end
})     tabs.AnimeSaga:AddButton({
    Title = "Hyper Hab Script",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DookDekDEE/all-script-2/refs/heads/main/loader.lua"))()
    end
})     tabs.AnimeSaga:AddButton({
    Title = "EclipseX Hub",
    Description = "Need Key",
    Callback = function()
        script_key="PASTE_YOUR_KEY_HERE";
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/74c9ed77af04c6f2e365200b858bb14d.lua"))()
    end
})








-------[           Anime Rangers X             ]--------









    tabs.AnimeRangersX:AddButton({
    Title = "RoyX Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nomed-rin/Royx_Free/refs/heads/main/loader.lua"))()
    end
})    tabs.AnimeRangersX:AddButton({
    Title = "Tora IsMe",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/AnimeRangersX"))()
    end
})    tabs.AnimeRangersX:AddButton({
    Title = "Ns Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/OhhMyGehlee/yu/refs/heads/main/tu"))()
    end
})   tabs.AnimeRangersX:AddButton({
    Title = "Legend Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://scripts.city/LegendHub.lua"))()
    end
})  tabs.AnimeRangersX:AddButton({
    Title = "L Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YOies/KazounVN/refs/heads/main/ARX"))()
    end
})







-------[            Anime Vanguards            ]--------





    tabs.AnimeVanguards:AddButton({
    Title = "Bang Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/buang5516/buanghub/main/BUANGHUB.lua'))()
    end
})    tabs.AnimeVanguards:AddButton({
    Title = "Speed Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})    tabs.AnimeVanguards:AddButton({
    Title = "Solix Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
    end
})














-------[            Anime Last Stand            ]--------








    tabs.AnimeLastStand:AddButton({
    Title = "Vxrsa Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/4f5619867ab50ed14ce04ac9d95ec043.lua"))()
    end
})    tabs.AnimeLastStand:AddButton({
    Title = "Lmp Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/Hub/refs/heads/main/ImpHub.lua"))()
    end
})    tabs.AnimeLastStand:AddButton({
    Title = "Buang Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/buang5516/buanghub/main/animeLastStand.lua"))()
    end
})







-------[            Attack On Titan Revolution            ]--------











    tabs.AttackOnTitanRevolution:AddButton({
    Title = "Tekkit Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zerunquist/TekkitAotr/refs/heads/main/main"))()
    end
})    tabs.AttackOnTitanRevolution:AddButton({
    Title = "Shadow Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/levishifter/levishifter/refs/heads/main/ghoulre.lua"))()
    end
})








-------[            Door            ]--------








    tabs.Door:AddButton({
        Title = "Mspaint V4",
        Description = "Have Key,Copy Web And Join Discord Link To Getkey",
        Callback = function()
            setclipboard("https://mspaint.cc")
        end
})    tabs.Door:AddButton({
        Title = "Black King",
        Description = "No Key",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkDoorsKing/Doors/main/Main"))()
        end
})    tabs.Door:AddButton({
        Title = "Kolbol Hub",
        Description = "Need Key",  
        Callback = function()
            loadstring(game:HttpGet("https://pastefy.app/awczkDwJ/raw"))()
        end
    })   tabs.Door:AddButton({
        Title = "Kittycat Hub",
        Description = "No Key",  
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/CatEnddroid/Kitty-Cats-Doors-Beta/refs/heads/main/hub.lua"))()
        end
})    tabs.Door:AddButton({
        Title = "FFJ Hub",
        Description = "Need Key",  
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FFJ1/Roblox-Exploits/main/scripts/Loader.lua"))()
        end
})







-------[            King Legacy            ]--------









    tabs.KingLegacy:AddButton({
    Title = "ARC Hub",
    Description = "Need Key",
    Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ChopLoris/ArcHub/main/main.lua"))() 
    end
})    tabs.KingLegacy:AddButton({
    Title = "Zen Hub",
    Description = "Need Key",
    Callback = function()
        -- Zen Hub
loadstring(game:HttpGet("https://raw.githubusercontent.com/Zenhubtop/zen_hub_pr/main/zennewwwwui.lua", true))()
    end
})    tabs.KingLegacy:AddButton({
    Title = "Hyper Hab Script",
    Description = "No Key",
    Callback = function()
        repeat wait() until game:IsLoaded()
loadstring(game:HttpGet("https://raw.githubusercontent.com/DookDekDEE/Hyper/main/script.lua"))()
    end
})    tabs.KingLegacy:AddButton({
    Title = "Tsuo Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/king%20legacy"))()
    end
})






-------[            Bee Swarm Simulator            ]--------









    tabs.BeeSwarmSimulator:AddButton({
    Title = "Histy Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptpastebin/raw/main/Histy"))()
    end
})    tabs.BeeSwarmSimulator:AddButton({
    Title = "Blue Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptpastebin/raw/main/29"))()
    end
})    tabs.BeeSwarmSimulator:AddButton({
    Title = "Beecon Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBossScript/BeeconHub/main/BeeconHub"))()
    end
})    tabs.BeeSwarmSimulator:AddButton({
    Title = "Atlas Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Chris12089/atlasbss/main/script.lua"))()
    end
})








-------[            Evade            ]--------







    tabs.Evade:AddButton({
    Title = "Tbao Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubEvade"))()
    end
})    tabs.Evade:AddButton({
    Title = "Lmp Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/Hub/refs/heads/main/ImpHub.lua"))()
    end
})    tabs.Evade:AddButton({
    Title = "Draconic Hub",
    Description = "I don't know",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Unknownproooolucky/Draconic-Hub-X/refs/heads/main/Files/Games/Evade/Overhaul.lua'))()
    end
})    tabs.Evade:AddButton({
    Title = "Turbo Lite",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/refs/heads/main/Evade.lua"))()
    end
})











-------[            Gym League            ]--------









    tabs.GymLeague:AddButton({
    Title = "Speed Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Script-Games/main/Gym%20League.lua"))()
    end
})   tabs.GymLeague:AddButton({
    Title = "Demonic Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Prosexy/Demonic-HUB-V2/main/DemonicHub_V2.lua", true))()
    end
})   tabs.GymLeague:AddButton({
    Title = "Nurk Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AbdouGG/Gym-Leauge/main/V1"))()
    end
})









-------[            Meme Sea            ]--------








    tabs.MemeSea:AddButton({
    Title = "InfynityX Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://gitlab.com/Lmy77/menu/-/raw/main/infinityx"))()
    end
})    tabs.MemeSea:AddButton({
    Title = "Omg Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
    end
})    tabs.MemeSea:AddButton({
    Title = "Yoto V3 Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/Binintrozza/yutv2e/main/Yutohub')))()
    end
})    tabs.MemeSea:AddButton({
    Title = "Shiny Hub",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/ZaqueHub/ShinyHub-MMSea/main/MEME%20SEA%20PROTECT.txt'))()
    end
})






-------[            Misc            ]--------








local Supportscript = tabs.Misc:AddSection("Support Script")

Supportscript:AddButton({
    Title = "Fly",
    Description = "Helps you fly",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDom/refs/heads/main/Fly.lua"))()
    end
})    Supportscript:AddButton({
    Title = "Test Unc",
    Description = "Check Unc",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDom/refs/heads/main/TestUnc.lua"))()
    end
})    Supportscript:AddButton({
        Title = "Aimbot",
        Description = "Make By spdmteam.com/ArceusX Aim",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/refs/heads/main/Arceus%20Aimbot.lua"))()
        end
    })



local ScriptDev = tabs.Misc:AddSection("Developer Script")


    ScriptDev:AddButton({
    Title = "Dark Dex",
    Description = "Show Game File",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
    end
})    ScriptDev:AddButton({
    Title = "Infinite Yield",
    Description = "Command",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})   ScriptDev:AddButton({
        Title = "Simple Spy",
        Description = "Help you create own script or other",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()
        end
    })



local Fixlag = tabs.Misc:AddSection("Fix Lag")

Fixlag:AddButton({
    Title = "Turbo Lite",
    Description = "No Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/main/FixLag.lua"))()
    end
})    Fixlag:AddButton({
    Title = "Fix Lag 50%",
    Description = "Delete some things",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDom/refs/heads/main/FixLag.lua"))()
    end
})    Fixlag:AddButton({
    Title = "Fix Lag 100%",
    Description = "Delete everything",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDom/refs/heads/main/FixLag100%25.lua"))()
    end
})






local Screen = tabs.Setting:AddSection("Screen")

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local Buoi = false
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

Screen:AddToggle("BuoiToggle", {
    Title = "Blurry Screen",
    Default = false,
    Callback = function(state)
        Buoi = state
    end
})

-- Liên tục áp dụng hiệu ứng
spawn(function()
    while task.wait() do
        if Buoi then
            blur.Size = 30
        else
            blur.Size = 0
        end
    end
end)
local Buoi = false

Screen:AddToggle("BuoiToggle", {
    Title = "White Screen", -- Tên hiển thị trong UI
    Default = false,
    Callback = function(state)
        Buoi = state
    end
})

-- Chạy ẩn để liên tục kiểm tra trạng thái
spawn(function()
    while task.wait() do
        game:GetService("RunService"):Set3dRenderingEnabled(not Buoi)
    end
end)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local Buoi = false

-- Tạo ScreenGui + Frame đen nếu chưa có
local gui = Instance.new("ScreenGui")
gui.Name = "BuoiOverlay"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = PlayerGui

local blackOverlay = Instance.new("Frame")
blackOverlay.Size = UDim2.new(1, 0, 1, 0)  -- Lấp đầy toàn bộ màn hình
blackOverlay.BackgroundColor3 = Color3.new(0, 0, 0)  -- Màu đen
blackOverlay.BackgroundTransparency = 0  -- Không trong suốt, đen hoàn toàn
blackOverlay.Visible = false  -- Mặc định là không hiển thị
blackOverlay.Parent = gui

-- Toggle
Screen:AddToggle("BuoiToggle", {
    Title = "Black Screen",
    Default = false,
    Callback = function(state)
        Buoi = state
        blackOverlay.Visible = state  -- Hiển thị hoặc ẩn màn hình đen
    end
})

local Game = tabs.Setting:AddSection("Game")

-- Biến URL script chính
local ScriptURL = "https://raw.githubusercontent.com/TDDuym500/NomDom/refs/heads/main/NomDomHub.lua"
local AutoLoadEnabled = false

-- Thêm Toggle vào UI
Game:AddToggle("Enable Auto Load Script", {
    Title = "Auto Load Script",
    Default = false,
    Callback = function(state)
        AutoLoadEnabled = state
        if AutoLoadEnabled then
            -- Nếu bật toggle thì tải và chạy script
            pcall(function()
                local response = game:HttpGet(ScriptURL)
                if response then
                    loadstring(response)()
                else
                    warn("Không thể tải script từ URL.")
                end
            end)

            -- Đảm bảo script tiếp tục chạy khi teleport server/game
            local queue = queue_on_teleport or (syn and syn.queue_on_teleport)
            if queue then
                queue(("loadstring(game:HttpGet('%s'))()"):format(ScriptURL))
            end
        end
    end
})





-- Lấy đối tượng LocalPlayer và TeleportService
local LocalPlayer = game.Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")

-- Biến trạng thái cho toggle
local AutoRejoinEnabled = false  -- Mặc định là tắt

-- Hàm tự động teleport khi bị kick hoặc mất kết nối
local function autoRejoin()
    -- Lắng nghe sự kiện teleport
    LocalPlayer.OnTeleport:Connect(function(status)
        if AutoRejoinEnabled then  -- Nếu tính năng tự động rejoin bật
            if status == Enum.TeleportState.Failed then
                -- Sau khi thất bại, teleport lại vào game
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            end
        end
    end)

    -- Kết nối sự kiện OnKick để tự động teleport người chơi khi bị kick
    LocalPlayer.OnKick:Connect(function(reason)
        if AutoRejoinEnabled then  -- Nếu tính năng tự động rejoin bật
            -- Sau khi bị kick, teleport lại vào game
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end
    end)
end

-- Thêm toggle vào UI
Game:AddToggle("Enable Auto Rejoin", {
    Title = "Auto Rejoin",  -- Tiêu đề của toggle
    Default = false,  -- Mặc định là tắt
    Callback = function(state)
        AutoRejoinEnabled = state  -- Cập nhật trạng thái của toggle (true/false)
    end
})



local Anti = tabs.Setting:AddSection("Anti")

-- Thêm toggle vào UI
Anti:AddToggle("Antiband", {
    Title = "Anti Band",  -- Tiêu đề của toggle
    Default = true,  -- Mặc định là bật
    Callback = function(state)
        -- Có thể thêm mã tùy chỉnh khi bật/tắt tính năng Anti Band ở đây
    end
})

-- Anti AFK
local isAntiAFKEnabled = false
Anti:AddToggle("AntiAFK", {  -- Đổi tên để tránh trùng với các toggle khác
    Title = "Anti AFK",  -- Tiêu đề của toggle
    Default = false,  -- Mặc định là tắt
    Callback = function(state)
        isAntiAFKEnabled = state

        if state then
            -- Nếu toggle bật, bắt đầu mô phỏng click chuột
            local VirtualUser = game:GetService("VirtualUser")

            -- Mô phỏng click chuột mỗi phút
            spawn(function()
                while isAntiAFKEnabled do
                    wait(60) -- Chờ 1 phút
                    VirtualUser:CaptureController()

                    -- Mô phỏng click chuột phải
                    VirtualUser:ClickButton2(Vector2.new(0, 0))

                    -- Mô phỏng click chuột trái nhanh
                    VirtualUser:ClickButton1(Vector2.new(0, 0))
                end
            end)
        end
    end
})









local TweenService = game:GetService("TweenService")

local gui = Instance.new("ScreenGui")
gui.Name = "ToggleUIFluent"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = game:GetService("CoreGui")

local button = Instance.new("ImageButton")
button.Size = UDim2.new(0, 50, 0, 50)
button.Position = UDim2.new(0.120833337 - 0.1, 0, 0.0952890813 + 0.01, 0)
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.BorderSizePixel = 0
button.Image = "http://www.roblox.com/asset/?id=106181852399090"

button.Draggable = true
button.Parent = gui

-- Bo góc
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = button

-- Particle hiệu ứng
local particle = Instance.new("ParticleEmitter")
particle.Parent = button
particle.LightEmission = 1
particle.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 0) })
particle.Lifetime = NumberRange.new(0.5, 1)
particle.Rate = 0
particle.Speed = NumberRange.new(5, 10)
particle.SpreadAngle = Vector2.new(360, 360)
particle.Color = ColorSequence.new(Color3.fromRGB(255, 85, 255), Color3.fromRGB(85, 255, 255))

-- Animation hover (tăng kích thước khi di chuột vào nút)
local hoverTween = TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), { Size = UDim2.new(0, 55, 0, 55) })
local unhoverTween = TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), { Size = UDim2.new(0, 50, 0, 50) })

-- Khi hover vào nút (hover effect)
button.MouseEnter:Connect(function()
    hoverTween:Play()
end)

-- Khi rời chuột ra khỏi nút (unhover effect)
button.MouseLeave:Connect(function()
    unhoverTween:Play()
end)

-- Khi bấm nút
button.MouseButton1Down:Connect(function()
    -- Particle effect khi bấm
    particle.Rate = 100

    -- Reset particle sau 1s
    task.delay(1, function()
        particle.Rate = 0
    end)

    -- Gửi phím End để bật/tắt UI
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.End, false, game)
end)





-- Thông báo chào người chơi
Fluent:Notify({
    Title = "Welcome, " .. game.Players.LocalPlayer.Name,
    Content = "Use script fun",
    Duration = 5
})





wait(1)



loadstring(game:HttpGet("https://raw.githubusercontent.com/NomDomHub/NomDomHub/refs/heads/main/WedbookScript.lua"))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/NomDomHub/NomDomHub/refs/heads/main/NotifyBloxFruit.lua"))()


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Danh sách user được phép chạy script
local allowedUsers = {
    ["Boptrithuc"] = true,
    ["boptrithuc01"] = true,
    ["acctesthacktuviet"] = true,
    ["noxeldp"] = true,
}

-- Kiểm tra nếu tên người chơi không có trong danh sách thì dừng script
if not allowedUsers[LocalPlayer.Name] then
    return -- Không làm gì nếu người chơi không được phép
end

-- Hàm áp dụng Headless + Korblox
local function ApplyMods(character)
    task.spawn(function()
        pcall(function()
            -- Đợi các bộ phận tồn tại
            local head = character:WaitForChild("Head", 5)
            if head then
                head.Transparency = 1
                local face = head:FindFirstChild("face")
                if face then face:Destroy() end
            end

            local upperLeg = character:WaitForChild("RightUpperLeg", 5)
            local lowerLeg = character:WaitForChild("RightLowerLeg", 5)
            local foot = character:WaitForChild("RightFoot", 5)

            if upperLeg then
                upperLeg.MeshId = "rbxassetid://9598310133"
                upperLeg.TextureID = "rbxassetid://902843398"
            end
            if lowerLeg then
                lowerLeg.Transparency = 1
            end
            if foot then
                foot.Transparency = 1
            end
        end)
    end)
end

-- Nếu nhân vật đã tồn tại, áp dụng ngay
if LocalPlayer.Character then
    ApplyMods(LocalPlayer.Character)
end

-- Lắng nghe khi nhân vật hồi sinh
LocalPlayer.CharacterAdded:Connect(ApplyMods)





