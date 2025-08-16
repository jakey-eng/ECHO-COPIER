-- Executor-friendly LocalScript for Studio

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0,200,0,50)
Frame.Position = UDim2.new(0.4,0,0.1,0)
Frame.BackgroundColor3 = Color3.fromRGB(50,50,50)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(1,0,1,0)
Toggle.Text = "Echo: ON"
Toggle.TextColor3 = Color3.fromRGB(255,255,255)
Toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
Toggle.Parent = Frame

local echoEnabled = true
Toggle.MouseButton1Click:Connect(function()
	echoEnabled = not echoEnabled
	if echoEnabled then
		Toggle.Text = "Echo: ON"
		Toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
	else
		Toggle.Text = "Echo: OFF"
		Toggle.BackgroundColor3 = Color3.fromRGB(170,0,0)
	end
end)

-- Wait for default text channel
local channel
repeat
	channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
	wait(0.1)
until channel

-- Listen for messages from other players
channel.MessageReceived:Connect(function(msg)
	if not echoEnabled then return end
	if msg.TextSource and msg.TextSource.UserId ~= LocalPlayer.UserId then
		channel:SendAsync(msg.Text) -- send it as you
	end
end)
