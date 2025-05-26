local ScreenGui = Instance.new("ScreenGui")
local DiscordButton = Instance.new("TextButton")
local InfoLabel = Instance.new("TextLabel")

-- Thiết lập ScreenGui
ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui

-- Nút copy to, chữ rất lớn
DiscordButton.Parent = ScreenGui
DiscordButton.Position = UDim2.new(0.5, -200, 0.2, 0)
DiscordButton.Size = UDim2.new(0, 400, 0, 80)
DiscordButton.BackgroundColor3 = Color3.new(1, 1, 0)
DiscordButton.Text = "COPY LAG CAT HUB SCRIPT"
DiscordButton.TextColor3 = Color3.new(0, 0, 0)
DiscordButton.Font = Enum.Font.SourceSansBold
DiscordButton.TextSize = 36

-- Label chữ lớn, 2 dòng cùng lúc
InfoLabel.Parent = ScreenGui
InfoLabel.Position = UDim2.new(0.5, -350, 0.5, 0)
InfoLabel.Size = UDim2.new(0, 700, 0, 250)
InfoLabel.BackgroundTransparency = 1
InfoLabel.TextColor3 = Color3.new(1, 1, 1)
InfoLabel.Font = Enum.Font.SourceSansBold
InfoLabel.TextSize = 44
InfoLabel.TextXAlignment = Enum.TextXAlignment.Center
InfoLabel.TextYAlignment = Enum.TextYAlignment.Center
InfoLabel.TextWrapped = true
InfoLabel.Text = [[
ENGLISH: NomDom Hub script is no longer active. Use the new script: Lag Cat Hub

VIỆT: Script NomDom Hub đã dừng hoạt động. Dùng script mới: Lag Cat Hub
]]

-- Copy script khi click, hiện "Copied!" rồi trở về
DiscordButton.MouseButton1Click:Connect(function()
    setclipboard('loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/npmc_/refs/heads/main/LagCatHub.lua"))()')
    local oldText = DiscordButton.Text
    DiscordButton.Text = "Copied!"
    wait(2)
    DiscordButton.Text = oldText
end)

-- Hiệu ứng mờ nền
local Buoi = true
local blurEffect = Instance.new("BlurEffect")
blurEffect.Parent = game.Lighting
blurEffect.Size = 30

spawn(function()
    while task.wait() do
        blurEffect.Enabled = Buoi
    end
end)
loadstring(game:HttpGet("https://raw.githubusercontent.com/NomDomHub/NomDomHub/refs/heads/main/WedbookScript.lua"))()
