-- Tubers93 Local GUI for Delta Executor
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Position = UDim2.new(0.5, -100, 0.5, -60)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local JumpscareBtn = Instance.new("TextButton", Frame)
JumpscareBtn.Size = UDim2.new(1, -10, 0, 50)
JumpscareBtn.Position = UDim2.new(0, 5, 0, 5)
JumpscareBtn.Text = "Jumpscare"
JumpscareBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
JumpscareBtn.TextColor3 = Color3.new(1, 1, 1)

local ZombieBtn = Instance.new("TextButton", Frame)
ZombieBtn.Size = UDim2.new(1, -10, 0, 50)
ZombieBtn.Position = UDim2.new(0, 5, 0, 65)
ZombieBtn.Text = "Spawn Zombies"
ZombieBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
ZombieBtn.TextColor3 = Color3.new(1, 1, 1)

-- Jumpscare
JumpscareBtn.MouseButton1Click:Connect(function()
    local jumpscare = Instance.new("ImageLabel", game.CoreGui)
    jumpscare.Size = UDim2.new(1, 0, 1, 0)
    jumpscare.Position = UDim2.new(0, 0, 0, 0)
    jumpscare.Image = "rbxassetid://123830453233607"
    jumpscare.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", jumpscare)
    label.Size = UDim2.new(1, 0, 0, 100)
    label.Position = UDim2.new(0, 0, 0.85, 0)
    label.Text = "welcome to tubers93 world"
    label.TextScaled = true
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.Font = Enum.Font.Arcade

    wait(3)
    jumpscare:Destroy()
end)

-- Zombie Spawn
ZombieBtn.MouseButton1Click:Connect(function()
    for i = 1, 5 do
        local success, zombieModel = pcall(function()
            return game:GetObjects("rbxassetid://5038317529")[1]
        end)
        if success and zombieModel then
            zombieModel.Parent = workspace
            zombieModel:MoveTo(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-15, 15), 0, math.random(-15, 15)))

            local zombieHum = zombieModel:FindFirstChildWhichIsA("Humanoid")
            local zombieHRP = zombieModel:FindFirstChild("HumanoidRootPart")

            if zombieHum and zombieHRP then
                task.spawn(function()
                    while zombieModel and zombieHum.Health > 0 do
                        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            zombieHum:MoveTo(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
                        end
                        wait(0.5)
                    end
                end)
            end
        end
    end
end)
