local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()
local Window = MacLib:Window({
	Title = "EraSploit",
	Subtitle = "Slap Battles[KILL STREAK ONLY] V1.4",
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
	Slapples = tabGroups.TabGroup1:Tab({ Name = "Slapples" }),
    Info = tabGroups.TabGroup1:Tab({ Name = "Information" }),
}
local sections = {
	MainSection1 = tabs.Main:Section({ Side = "Left" }),
    MainSection2 = tabs.Main:Section({ Side = "Right" }),
	MainSection4 = tabs.Slapples:Section({ Side = "Left" }),
    MainSection5 = tabs.Main:Section({ Side = "Left" }),
    MainSection8 = tabs.Info:Section({ Side = "Left" }),
}
sections.MainSection1:Header({
	Name = "Aura"
})
sections.MainSection2:Header({
	Name = "Local Player"
})
sections.MainSection5:Header({
	Name = "Changers"
})

local plr = game.Players.LocalPlayer
local cd = 0.4
sections.MainSection1:Slider({
	Name = "Cooldown",
	Default = 85,
	Minimum = 5,
	Maximum = 100,
	DisplayMethod = "Cooldown",
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
            while task.wait(0.001) do
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
		while getgenv().aura do
            plr = game.Players.LocalPlayer
            for _, i in pairs(game.Workspace:GetChildren()) do
                for _, is in pairs(game.Players:GetPlayers()) do
                    if i.Name == is.Name then
                        if (game.Workspace[i.Name].Torso.Position - game.Workspace[plr.Name].Torso.Position).Magnitude < 20.2 and i.isInArena then 
                            print()
                            game:GetService("ReplicatedStorage"):FindFirstChild("KSHit"):FireServer(game.Workspace[i.Name]["Right Arm"])
                            task.wait(cd)
                        end
                    end
                end
            end
        end
	end,
}, "Toggle")
local extendauraprev = nil
sections.MainSection1:Toggle({
	Name = "Extended Aura(use if radius > 20)[BETA]",
	Default = false,
	Callback = function(value)
        getgenv().exaura = value
		while getgenv().exaura do
            plr = game.Players.LocalPlayer
            for _, i in pairs(game.Workspace:GetChildren()) do
                for _, is in pairs(game.Players:GetPlayers()) do
                    if i.Name == is.Name then
                        if (game.Workspace[i.Name].Torso.Position - game.Workspace[plr.Name].Torso.Position).Magnitude < Rad and i.isInArena and not i.Humanoid.PlatformStand then 
							extendauraprev = plr.Character.PrimaryPart.CFrame
							plr.Character.PrimaryPart.CFrame = CFrame.new(game.Workspace[i.Name].Torso.Position)
							task.wait(plr:GetNetworkPing() + 0.015)
							print(plr:GetNetworkPing())
                            game:GetService("ReplicatedStorage"):FindFirstChild("KSHit"):FireServer(game.Workspace[i.Name]["Right Arm"])
							plr.Character.PrimaryPart.CFrame = extendauraprev
                            task.wait(cd)
                        end
                    end
                end
            end
        end
	end,
}, "Toggle")
local prevpos = nil
local ragtoggle = true
sections.MainSection2:Toggle({
	Name = "Anti Ragdoll",
	Default = false,
	Callback = function(value)
        getgenv().aragdoll = value
		while task.wait() and getgenv().aragdoll do
            plr = game.Players.LocalPlayer
            if ragtoggle then     
                prevpos = plr.Character.PrimaryPart.CFrame
            end
            if workspace[plr.Name].Humanoid.PlatformStand then
                ragtoggle = false
                plr.Character.PrimaryPart.Anchored = true
                task.wait(0.8)
                plr.Character.PrimaryPart.Anchored = false
                ragtoggle = true
            end
        end
	end,
}, "Toggle")
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
		while task.wait() and getgenv().aslapples do
            for _, i in pairs(workspace.Arena.island5.Slapples:GetChildren()) do
				i.Glove.CFrame = plr.Character.PrimaryPart.CFrame
			end
        end
	end,
}, "Toggle")
local speed = 20
sections.MainSection5:Slider({
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
sections.MainSection5:Slider({
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
sections.MainSection5:Toggle({
	Name = "Toggle Changer",
	Default = false,
	Callback = function(value)
        getgenv().changer = value
		while task.wait() and getgenv().changer do
            plr = game.Players.LocalPlayer
            plr.Character.Humanoid.JumpPower = jump
            plr.Character.Humanoid.WalkSpeed = speed
        end
	end,
}, "Toggle")
if tostring(getgenv().invitecode) ~= "nil" then
    sections.MainSection8:Label({
        Text = "Key used: ".. tostring(getgenv().invitecode)
    })
    sections.MainSection8:Label({
        Text = "Build: Premium"
    })
else 
    sections.MainSection8:Label({
        Text = "Build: Source/Dev"
    })
end
sections.MainSection8:Label({
	Text = "Our Discord: discord.gg/XAqn48p6Jm"
})
sections.MainSection8:Label({
	Text = "Developed by yyep"
})
sections.MainSection8:Label({
	Text = "Total functional: 7 functions"
})
if getexecutorname() ~= nil then
    sections.MainSection8:Label({
        Text = "Executor used: "..tostring(getexecutorname())
    })
else
    sections.MainSection8:Label({
        Text = "Executor used: not defined"
    })
end
