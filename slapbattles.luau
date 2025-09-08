
local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()
local Window = MacLib:Window({
	Title = "Execsense Injected",
	Subtitle = "Slap Battles V2 [THE FIRST STEP]",
	Size = UDim2.fromOffset(890, 625),
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
	Gloves = tabGroups.TabGroup1:Tab({ Name = "Gloves" }),
	Ability = tabGroups.TabGroup1:Tab({ Name = "Abilities" }),
    Info = tabGroups.TabGroup1:Tab({ Name = "Information" }),
}
local sections = {
	MainSection1 = tabs.Main:Section({ Side = "Left" }),
    MainSection2 = tabs.Main:Section({ Side = "Right" }),
	MainSection4 = tabs.Slapples:Section({ Side = "Left" }),
    MainSection5 = tabs.Main:Section({ Side = "Left" }),
    MainSection8 = tabs.Info:Section({ Side = "Left" }),
	MainSection9 = tabs.Gloves:Section({ Side = "Left" }),
	MainSection10 = tabs.Ability:Section({ Side = "Left" }),
	MainSection11 = tabs.Ability:Section({ Side = "Left" }),
}
sections.MainSection1:Header({
	Name = "Aura V1.5"
})
sections.MainSection2:Header({
	Name = "Local Player"
})
sections.MainSection5:Header({
	Name = "Changers"
})
sections.MainSection9:Header({
	Name = "Get Any Glove Exploit"
})
sections.MainSection10:Header({
	Name = "Admin"
})
sections.MainSection11:Header({
	Name = "Brick"
})

local plr = game.Players.LocalPlayer
local cd = 0.7
sections.MainSection1:Slider({
	Name = "Cooldown",
	Default = 85,
	Minimum = 5,
	Maximum = 120,
	DisplayMethod = "Cooldown",
	Precision = 0,
	Callback = function(Value)
        cd = Value / 100
	end
}, "Slider")
local Rad = 20
sections.MainSection1:Slider({
	Name = "Radius",
	Default = 20,
	Minimum = 15,
	Maximum = 60,
	DisplayMethod = "Radius",
	Precision = 0,
	Callback = function(Value)
        Rad = Value
	end
}, "Slider")
local root1 = nil
local root2 = nil
sections.MainSection2:Button({
	Name = "GodMode Exploit (On default glove doesnt work)",
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

local target = nil
local path = nil
sections.MainSection1:Toggle({
	Name = "Enabled (Only Default, Dual and some gloves)",
	Default = false,
	Callback = function(value)
        getgenv().aura = value
		while getgenv().aura do
            plr = game.Players.LocalPlayer
            for _, i in pairs(game.Workspace:GetChildren()) do
                for _, is in pairs(game.Players:GetPlayers()) do
                    if i.Name == is.Name then
                        if (game.Workspace[i.Name].Torso.Position - game.Workspace[plr.Name].Torso.Position).Magnitude < Rad and i.isInArena then 
                            print()
                            game:GetService("ReplicatedStorage"):FindFirstChild("b"):FireServer(game.Workspace[i.Name]["Torso"])
                            game:GetService("ReplicatedStorage"):FindFirstChild("GeneralHit"):FireServer(game.Workspace[i.Name]["Torso"])
                            task.wait(cd)
                        end
                    end
                end
            end
        end
	end,
}, "Toggle")
local turning = 0
sections.MainSection1:Toggle({
	Name = "Auto Slaps V1 (Dual Glove)",
	Default = false,
	Callback = function(value)
        getgenv().aslap = value
		while getgenv().aslap and task.wait() do
            plr = game.Players.LocalPlayer
            for _, i in pairs(game.Workspace:GetChildren()) do
                if game.Players:FindFirstChild(i.Name) then
                    if getgenv().aslap and turning == 0 then
                        workspace[plr.Name].HumanoidRootPart.CFrame = CFrame.new(workspace[i.Name].HumanoidRootPart.Position)
                        task.wait(plr:GetNetworkPing() + 0.2)
                        game:GetService("ReplicatedStorage"):FindFirstChild("GeneralHit"):FireServer(game.Workspace[i.Name]["Torso"])
                        task.wait(plr:GetNetworkPing() + 0.2)
                        CFrame.new(0, 150, 100)
                    end
                end
            end
            if plr.Character.Humanoid.Health == 0 and turning == 0 then
                turning = 1
            elseif plr.Character.Humanoid.Health == 100 and turning == 0 then
                turning = 0
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
local glove = nil
sections.MainSection10:Toggle({
	Name = "Auto Use Anvil",
	Default = false,
	Callback = function(value)
        getgenv().anvil = value
		while task.wait(0.05) and getgenv().anvil do
            game:GetService("ReplicatedStorage"):WaitForChild("AdminAbility"):FireServer("Anvil")
        end
	end,
}, "Toggle")
sections.MainSection10:Toggle({
	Name = "Auto Use Invisibility",
	Default = false,
	Callback = function(value)
        getgenv().invis = value
		while task.wait(0.05) and getgenv().invis do
            game:GetService("ReplicatedStorage"):WaitForChild("AdminAbility"):FireServer("Invisibility")
        end
	end,
}, "Toggle")
sections.MainSection10:Toggle({
	Name = "Auto Use Fling",
	Default = false,
	Callback = function(value)
        getgenv().fling = value
		while task.wait(0.05) and getgenv().fling do
            game:GetService("ReplicatedStorage"):WaitForChild("AdminAbility"):FireServer("Fling")
        end
	end,
}, "Toggle")
sections.MainSection11:Toggle({
	Name = "Fast Bricks(requires equipped brick glove)",
	Default = false,
	Callback = function(value)
        getgenv().fbr = value
		while task.wait() and getgenv().fbr do
            game:GetService("ReplicatedStorage"):WaitForChild("lbrick"):FireServer()
        end
	end,
}, "Toggle")
sections.MainSection9:Input({
	Name = "Glove",
	Placeholder = "Write name",
	AcceptedCharacters = "All",
	Callback = function(input)
		glove = input
	end,
}, "Input")
sections.MainSection9:Button({
	Name = "Equip Glove",
	Callback = function()
		for _, i in pairs(game.ReplicatedStorage:GetDescendants()) do
			if i:IsA("RemoteEvent") and string.match(i.Name, "{")then
				i:FireServer(glove)
			end
		end
	end,
})
if tostring(getgenv().invitecode) ~= "nil" then
    sections.MainSection8:Label({
        Text = "Key used: ".. tostring(getgenv().invitecode)
    })
    sections.MainSection8:Label({
        Text = "Build: Early Access"
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
	Text = "Total functional: 9 functions"
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
