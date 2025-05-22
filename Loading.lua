local RunService = game:GetService("RunService")

-- Hiệu ứng mờ
local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 30
blurEffect.Enabled = false
blurEffect.Parent = game.Lighting

-- GUI chính
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ScriptByDuyGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Font & Màu dùng chung
local sharedFont = Enum.Font.Gotham
local sharedColor = Color3.fromRGB(200, 200, 200)
local sharedStrokeTransparency = 0.7

-- "Script By Duy"
local mainText = Instance.new("TextLabel")
mainText.Parent = gui
mainText.Size = UDim2.new(1, 0, 1, 0)
mainText.Position = UDim2.new(0, 0, 0, 0)
mainText.BackgroundTransparency = 1
mainText.Text = "Update : 31"
mainText.TextColor3 = sharedColor
mainText.TextStrokeTransparency = sharedStrokeTransparency
mainText.Font = sharedFont
mainText.TextScaled = true
mainText.TextTransparency = 1

-- "Loading Script..."
local loadingText = Instance.new("TextLabel")
loadingText.Parent = gui
loadingText.Size = UDim2.new(1, 0, 0.1, 0)
loadingText.Position = UDim2.new(0, 0, 0.65, 0)
loadingText.BackgroundTransparency = 1
loadingText.Text = "Loading Script... 0%"
loadingText.TextColor3 = sharedColor
loadingText.TextStrokeTransparency = sharedStrokeTransparency
loadingText.Font = sharedFont
loadingText.TextScaled = true
loadingText.TextTransparency = 1

-- "Done!"
local doneText = Instance.new("TextLabel")
doneText.Parent = gui
doneText.Size = loadingText.Size
doneText.Position = loadingText.Position
doneText.BackgroundTransparency = 1
doneText.Text = "Done"
doneText.TextColor3 = sharedColor
doneText.TextStrokeTransparency = sharedStrokeTransparency
doneText.Font = sharedFont
doneText.TextScaled = true
doneText.TextTransparency = 1

-- Thanh loading nền
local loadingBg = Instance.new("Frame", gui)
loadingBg.Size = UDim2.new(0.6, 0, 0.04, 0)
loadingBg.Position = UDim2.new(0.2, 0, 0.75, 0)
loadingBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
loadingBg.BorderSizePixel = 0
Instance.new("UICorner", loadingBg).CornerRadius = UDim.new(0, 20)

-- Thanh loading tiến độ màu trắng
local loadingBar = Instance.new("Frame", loadingBg)
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.Position = UDim2.new(0, 0, 0, 0)
loadingBar.BackgroundColor3 = Color3.new(1, 1, 1) -- màu trắng
loadingBar.BorderSizePixel = 0
Instance.new("UICorner", loadingBar).CornerRadius = UDim.new(0, 20)

-- Bật hiệu ứng mờ
blurEffect.Enabled = true

-- Hàm fade in text bằng RenderStepped
local function fadeInText(label)
	for alpha = 1, 0, -0.05 do
		label.TextTransparency = alpha
		RunService.RenderStepped:Wait()
	end
	label.TextTransparency = 0
end

-- Hàm fade out text bằng RenderStepped
local function fadeOutText(label)
	for alpha = 0, 1, 0.05 do
		label.TextTransparency = alpha
		RunService.RenderStepped:Wait()
	end
	label.TextTransparency = 1
end

-- Fade in chữ mainText và loadingText
fadeInText(mainText)
fadeInText(loadingText)

-- Loading + cập nhật % đơn giản
for i = 0, 100, 2 do
	loadingBar.Size = UDim2.new(i / 100, 0, 1, 0)
	loadingText.Text = "Loading Script... " .. i .. "%"
	RunService.RenderStepped:Wait()
end

-- Ẩn loadingText dần
fadeOutText(loadingText)

-- Hiện chữ "Done!" dần
fadeInText(doneText)

-- Đợi 1.5 giây
task.wait(1.5)

-- Fade out toàn bộ (mainText, doneText, loadingBar, loadingBg)
for alpha = 0, 1, 0.05 do
	mainText.TextTransparency = alpha
	doneText.TextTransparency = alpha
	loadingBar.BackgroundTransparency = alpha
	loadingBg.BackgroundTransparency = alpha
	RunService.RenderStepped:Wait()
end

-- Tắt hiệu ứng mờ mượt
for blur = 30, 0, -1 do
	blurEffect.Size = blur
	task.wait(0.008)
end

-- Xóa GUI và hiệu ứng
task.wait(0.3)
gui:Destroy()
blurEffect:Destroy()
