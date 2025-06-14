-- Server Script: Tubers93 Jumpscare + Zombies (for Server Executors or ServerScriptService)
local JumpscareImageId = "rbxassetid://123830453233607"
local ZombieAssetId = "rbxassetid://5038317529"

-- Function: Show jumpscare to all players
function showJumpscare()
	for _, player in ipairs(game.Players:GetPlayers()) do
		if player:FindFirstChild("PlayerGui") then
			local jumpscareGui = Instance.new("ScreenGui")
			jumpscareGui.Name = "JumpscareGUI"
			jumpscareGui.ResetOnSpawn = false
			jumpscareGui.Parent = player.PlayerGui

			local img = Instance.new("ImageLabel", jumpscareGui)
			img.Size = UDim2.new(1, 0, 1, 0)
			img.Position = UDim2.new(0, 0, 0, 0)
			img.Image = JumpscareImageId
			img.BackgroundTransparency = 1

			local msg = Instance.new("TextLabel", jumpscareGui)
			msg.Size = UDim2.new(1, 0, 0, 100)
			msg.Position = UDim2.new(0, 0, 0.8, 0)
			msg.BackgroundTransparency = 1
			msg.TextScaled = true
			msg.TextColor3 = Color3.new(1, 0, 0)
			msg.Font = Enum.Font.Arcade
			msg.Text = "welcome to tubers93 world"
		end
	end

	wait(3)

	-- Remove the GUI
	for _, player in ipairs(game.Players:GetPlayers()) do
		local gui = player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("JumpscareGUI")
		if gui then gui:Destroy() end
	end
end

-- Function: Spawn zombies and chase all players
function spawnZombies()
	for i = 1, 10 do
		local zombie = game:GetService("InsertService"):LoadAsset(5038317529)
		local model = zombie:FindFirstChildOfClass("Model")
		if model then
			model.Parent = workspace
			model:MoveTo(Vector3.new(math.random(-50, 50), 10, math.random(-50, 50)))

			local hum = model:FindFirstChildOfClass("Humanoid")
			local root = model:FindFirstChild("HumanoidRootPart")
			if hum and root then
				spawn(function()
					while model and model.Parent and hum.Health > 0 do
						wait(1)
						local closestPlayer = nil
						local closestDist = math.huge

						for _, player in ipairs(game.Players:GetPlayers()) do
							if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
								local dist = (player.Character.HumanoidRootPart.Position - root.Position).Magnitude
								if dist < closestDist then
									closestDist = dist
									closestPlayer = player
								end
							end
						end

						if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("HumanoidRootPart") then
							hum:MoveTo(closestPlayer.Character.HumanoidRootPart.Position)
						end
					end
				end)
			end
		end
	end
end

-- Chat Commands for testing
game.Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		if msg == "!jumpscare" then
			showJumpscare()
		elseif msg == "!zombies" then
			spawnZombies()
		end
	end)
end)
