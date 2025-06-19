----sài đi do chat gbt lm đấy



local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- Tạo hiệu ứng mờ nền
local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 30
blurEffect.Enabled = true
blurEffect.Parent = Lighting

-- Làm mờ dần hiệu ứng blur khi kết thúc
local function smoothRemoveBlur()
	for i = 30, 0, -1 do
		blurEffect.Size = i
		task.wait(0.008)
	end
	blurEffect:Destroy()
end

-- Tạo GUI
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "NomDomIntro"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Khung container để canh giữa
local container = Instance.new("Frame")
container.BackgroundTransparency = 1
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.Position = UDim2.new(0.5, 0, 0.5, 0)
container.Size = UDim2.new(0, 600, 0, 100)
container.Parent = gui

-- Chữ cần hiển thị
local text = "NomDom"
local letterLabels = {}
local spacing = 90
local totalWidth = (#text - 1) * spacing

-- Tạo từng TextLabel cho từng chữ
for i = 1, #text do
	local char = text:sub(i, i)
	local label = Instance.new("TextLabel")
	label.Text = char
	label.Font = Enum.Font.GothamBlack
	label.TextSize = 100
	label.TextColor3 = Color3.fromRGB(255, 255, 255) -- màu trắng
	label.BackgroundTransparency = 1
	label.TextTransparency = 1
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.Size = UDim2.new(0, 100, 0, 100)

	local offsetX = (i - 1) * spacing - totalWidth / 2
	label.Position = UDim2.new(0.5, offsetX, 1.5, 0)
	label.Parent = container

	table.insert(letterLabels, label)

	-- Bay lên và rõ dần
	task.delay((i - 1) * 0.1, function()
		local tween = TweenService:Create(label, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.5, offsetX, 0.5, 0),
			TextTransparency = 0
		})
		tween:Play()
	end)
end

-- Sau vài giây, từng chữ từ phải sang trái rơi xuống và mờ dần
task.delay(#text * 0.1 + 2, function()
	for i = #letterLabels, 1, -1 do
		local label = letterLabels[i]
		task.delay((#letterLabels - i) * 0.1, function()
			local tween = TweenService:Create(label, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
				Position = label.Position + UDim2.new(0, 0, 0.5, 0),
				TextTransparency = 1
			})
			tween:Play()
		end)
	end

	-- Xóa GUI và hiệu ứng blur
	task.delay(1.2 + #letterLabels * 0.1, function()
		gui:Destroy()
		smoothRemoveBlur()
	end)
end)
