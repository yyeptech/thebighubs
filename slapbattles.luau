local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()
local Window = MacLib:Window({
	Title = "EraSploit",
	Subtitle = "Slap Battles V1",
	Size = UDim2.fromOffset(850, 625),
	DragStyle = 1,
	DisabledWindowControls = {},
	ShowUserInfo = true,
	Keybind = Enum.KeyCode.RightControl,
	AcrylicBlur = true,
})
local tabGroups = {
	TabGroup1 = Window:TabGroup()
}
local tabs = {
	Main = tabGroups.TabGroup1:Tab({ Name = "Fight Helpers" }),
}
local sections = {
	MainSection1 = tabs.Main:Section({ Side = "Left" }),
    MainSection2 = tabs.Main:Section({ Side = "Left" }),
}
sections.MainSection1:Header({
	Name = "Aura"
})
sections.MainSection2:Header({
	Name = "Local Player"
})


local plr = game.Players.LocalPlayer
local cd = 0.4
sections.MainSection1:Slider({
	Name = "Cooldown",
	Default = 85,
	Minimum = 25,
	Maximum = 120,
	DisplayMethod = "Radius",
	Precision = 0,
	Callback = function(Value)
        cd = Value / 100
	end
}, "Slider")
local root1 = nil
local root2 = nil
sections.MainSection2:Button({
	Name = "GodMode Exploit",
	Callback = function()
		if plr.Character.Humanoid.Health > 0 then
            workspace[plr.Name].Humanoid.Health = 0
            while task.wait(0.01) do
                print("wrok")
                if workspace[plr.Name]:WaitForChild("Humanoid").Health == 100 then
                    task.wait(0.25)
                    plr.Character.PrimaryPart.CFrame = CFrame.new(workspace.Arena["main island"].Grass.Position)
                    break
                end
            end
        end
	end,
})
sections.MainSection1:Toggle({
	Name = "Enabled",
	Default = false,
	Callback = function(value)
        getgenv().aura = value
		while task.wait() and aura do
            plr = game.Players.LocalPlayer
            for _, i in pairs(game.Workspace:GetChildren()) do
                for _, is in pairs(game.Players:GetPlayers()) do
                    if i.Name == is.Name then
                        if (game.Workspace[i.Name].Torso.Position - game.Workspace[plr.Name].Torso.Position).Magnitude < 20 then 
                            print()
                            game:GetService("ReplicatedStorage"):FindFirstChild("b"):FireServer(game.Workspace[i.Name]["Right Arm"])
                            task.wait(cd)
                        end
                    end
                end
            end
        end
	end,
}, "Toggle")
local speed = 20
sections.MainSection2:Button({
	Name = "Anti Void",
	Default = false,
	Callback = function()
		local anvoid = Instance.new("Part")
		local barpos = workspace.DEATHBARRIER.Position
		anvoid.Transparency = 0.7
		anvoid.Parent = workspace
		anvoid.Anchored = true
		anvoid.Size = Vector3.new(1000000, 10, 1000000)
		anvoid.Position = Vector3.new(barpos.X, -15, barpos.Z)
	end,
}, "Toggle")
sections.MainSection4:Toggle({
	Name = "Auto Collect Slapples",
	Default = false,
	Callback = function(value)
        getgenv().aslapples = value
		while task.wait() and aslapples do
            for _, i in pairs(workspace.Arena.island5.Slapples:GetChildren()) do
				i.Glove.CFrame = plr.Character.PrimaryPart.CFrame
			end
        end
	end,
}, "Toggle")
sections.MainSection2:Slider({
	Name = "Walk Speed",
	Default = 20,
	Minimum = 1,
	Maximum = 200,
	DisplayMethod = "Speed",
	Precision = 0,
	Callback = function(Value)
        speed = Value
	end
}, "Slider")
local jump = 50
sections.MainSection2:Slider({
	Name = "Jump Boost",
	Default = 20,
	Minimum = 1,
	Maximum = 250,
	DisplayMethod = "Jump",
	Precision = 0,
	Callback = function(Value)
        jump = Value
	end
}, "Slider")
while task.wait() do
    plr.Character.Humanoid.WalkSpeed = speed
    plr.Character.Humanoid.JumpPower = jump
end
