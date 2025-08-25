local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()

local Window = MacLib:Window({
	Title = "ERXWare DLC",
	Subtitle = "Bee Swarm Simulator V2.7",
	Size = UDim2.fromOffset(860, 570),
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
	Main = tabGroups.TabGroup1:Tab({ Name = "Automatic" }),
    Exploits = tabGroups.TabGroup1:Tab({ Name = "Exploits" }),
    Other = tabGroups.TabGroup1:Tab({ Name = "Other" }),
    Teleports = tabGroups.TabGroup1:Tab({ Name = "Teleports" }),
    Information = tabGroups.TabGroup1:Tab({ Name = "Information" }),
}
local sections = {
	MainSection1 = tabs.Main:Section({ Side = "Left" }),
	MainSection2 = tabs.Other:Section({ Side = "Left" }),
	MainSection3 = tabs.Other:Section({ Side = "Right" }),
	MainSection4 = tabs.Exploits:Section({ Side = "Left" }),
	MainSection5 = tabs.Main:Section({ Side = "Right" }),
	MainSection6 = tabs.Main:Section({ Side = "Left" }),
    MainSection7 = tabs.Teleports:Section({ Side = "Left" }),
    MainSection8 = tabs.Information:Section({ Side = "Left" }),
}
sections.MainSection1:Header({
	Name = "Farming"
})
sections.MainSection2:Header({
	Name = "Antis"
})
sections.MainSection3:Header({
	Name = "Local Player"
})
sections.MainSection5:Header({
	Name = "Movement"
})
sections.MainSection6:Header({
	Name = "Convert"
})
sections.MainSection7:Header({
	Name = "Locations"
})
local plr = game.Players.LocalPlayer
local adig = nil
local afarm = nil

sections.MainSection1:Toggle({
	Name = "Auto Dig",
	Default = false,
	Callback = function(value)
	    getgenv().adig = value
	    while getgenv().adig and task.wait(0.001) do
	        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ToolCollect"):FireServer()
	    end
	end,
}, "Toggle")
local prevpos = nil
local prevstat = nil
local targetobj = nil
local path = nil
local movtype = nil
local Dropdown = sections.MainSection5:Dropdown({
	Name = "Type",
	Multi = false,
	Required = true,
	Options = {"Legit", "Fast"},
	Default = "Legit",
	Callback = function(Value)
		movtype = Value
	end,
}, "Dropdown")
local turnmov = true
local localhive = nil
local turning = 0
local turn = 0
for _, i in pairs(workspace.Honeycombs:GetDescendants()) do
    if i.Name == "Owner" and tostring(i.Value) == plr.Name then
        localhive = i.Parent.Name
    end
end
sections.MainSection6:Toggle({
	Name = "Auto Convert",
	Default = false,
	Callback = function(value)
	    getgenv().aconv = value
	    turn = 1
	    prevpos = plr.Character.PrimaryPart.CFrame
	    plr.CoreStats.Pollen.Value = plr.CoreStats.Pollen.Value + 0.00001
	    for _, i in pairs(workspace.Honeycombs:GetDescendants()) do
            if i.Name == "Owner" and tostring(i.Value) == plr.Name then
                localhive = i.Parent.Name
            end
        end
        while getgenv().aconv and task.wait() do
            if plr.CoreStats.Pollen.Value == plr.CoreStats.Capacity.Value or plr.CoreStats.Pollen.Value > plr.CoreStats.Capacity.Value then
                if turn == 1 then
                    for i = 0, 10 do
                        plr.Character.PrimaryPart.CFrame = CFrame.new(workspace.Honeycombs[localhive].patharrow:WaitForChild("Base").Position) + Vector3.new(0, 0.4, 0)
                    end
                    if (workspace.Honeycombs[localhive].patharrow:WaitForChild("Base").Position - plr.Character.PrimaryPart.Position).Magnitude < 3 then
                        task.wait(0.39)
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerHiveCommand"):FireServer("ToggleHoneyMaking")
                        turnmov = false
                        turning = 1
                        turn = 0
                    end
	            end
	        
	        end
	        if plr.CoreStats.Pollen.Value == 0 then
	            task.wait(8.32)
                plr.Character.PrimaryPart.CFrame = prevpos
                turn = 0
                turnmov = true
                turn = 1
                turning = 0
	        end
	    end
	end,
}, "Toggle")
local passivetoggle = true
sections.MainSection5:Toggle({
	Name = "Auto Movement",
	Default = false,
	Callback = function(value)
	    getgenv().afarm = value
        while getgenv().afarm and task.wait(0.08) do
            for _, targetobj in pairs(workspace.Collectibles:GetChildren()) do
                if (plr.Character.PrimaryPart.Position - targetobj.Position).Magnitude < 60 and targetobj.Transparency < 0.5 and movtype == "Legit" and turnmov then
                    passivetoggle = false
                    plr.Character.Humanoid:MoveTo(targetobj.Position)
                    plr.Character.Humanoid.MoveToFinished:Connect(function()
                        passivetoggle = true
                    end)
                elseif (plr.Character.PrimaryPart.Position - targetobj.Position).Magnitude < 60 and targetobj.Transparency < 0.5 and movtype == "Fast" and turnmov then
                    plr.Character.PrimaryPart.CFrame = CFrame.new(targetobj.Position) + Vector3.new(0, -2, 0)
                end
            end
	    end
	end,
}, "Toggle")
local randompos = nil
local center = nil
sections.MainSection5:Toggle({
	Name = "Passive Movement",
	Default = false,
	Callback = function(value) 
        center = plr.Character.PrimaryPart.Position
        getgenv().passiv = value
        print(passiv)
        while task.wait(0.15) and passiv do
            randompos = Vector3.new(plr.Character.PrimaryPart.Position.X + math.random(-35, 35), plr.Character.PrimaryPart.Position.Y, plr.Character.PrimaryPart.Position.Z + math.random(-35, 35))
            if (randompos - center).Magnitude < 35 and movtype == "Legit" and passivetoggle then
                plr.Character.Humanoid:MoveTo(randompos)
            elseif (randompos - center).Magnitude < 35 and movtype == "Fast" and passivetoggle then
                plr.Character.PrimaryPart.CFrame = CFrame.new(randompos)
            end
        end
	end,
}, "Toggle")
local emov = 0
local curspeed = 0
plr.Character.Humanoid.Running:Connect(function(walkspd)
    curspeed = walkspd
end)
sections.MainSection5:Toggle({
	Name = "Emergency Movement",
	Default = false,
	Callback = function(value)
	    getgenv().emove = value
        while emove and task.wait() do
            if curspeed ~= 0 then
                emov = 0
            elseif curspeed == 0 and emove then
                for emov = 1, 550 do
                    task.wait(0.01)
                    print(emov)
                    if emov == 550 and curspeed == 0 and turning == 0 then
                        for i = 0, 5 do
                            plr.Character.PrimaryPart.CFrame = CFrame.new(workspace.Honeycombs[localhive].patharrow:WaitForChild("Base").Position) + Vector3.new(0, 2, 0)
                        end
                        task.wait(0.5)
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerHiveCommand"):FireServer("ToggleHoneyMaking")
                        turning = 1
                    elseif curspeed ~= 0 then
                        emov = 0
                        turning = 0
                        break
                    end
                end
            end
        end
    end,
}, "Toggle")
sections.MainSection2:Button({
	Name = "Remove all Barriers",
	Default = false,
	Callback = function()
	    for _, i in pairs(workspace.Gates:GetDescendants()) do
	        if i.Name == "Door" then
	            i:Destroy()
	        end
	    end
	end,
}, "Button")
local prevatp = nil
sections.MainSection2:Toggle({
	Name = "Anti Teleport to Spawn",
	Default = false,
	Callback = function(value)
	    getgenv().atp = value
        prevatp = plr.Character.PrimaryPart.CFrame
	    if getgenv().atp then
            workspace:FindFirstChildOfClass("SpawnLocation").Touched:Connect(function(who)
                if who.Parent.Name == plr.Name then
                    plr.Character.PrimaryPart.CFrame = prevatp
                    task.wait()
                    prevatp = plr.Character.PrimaryPart.CFrame
                end
            end)
        end
	end,
}, "Toggle")

sections.MainSection3:Slider({
	Name = "Walk Speed",
	Default = 15,
	Minimum = 1,
	Maximum = 150,
	DisplayMethod = "Speed",
	Precision = 0,
	Callback = function(Value)
		plr.Character.Humanoid.WalkSpeed = tonumber(Value)
	end
}, "Slider")
sections.MainSection3:Slider({
	Name = "Jump Boost",
	Default = 15,
	Minimum = 1,
	Maximum = 150,
	DisplayMethod = "Speed",
	Precision = 0,
	Callback = function(Value)
        plr.Character.Humanoid.JumpPower = tonumber(Value)
	end
}, "Slider")

local MagicPrev = nil
sections.MainSection4:Toggle({
	Name = "Magic Body",
	Default = false,
	Callback = function(value)
	    getgenv().magic = value
        if magic then    
            MagicPrev = plr.Character.PrimaryPart.CFrame
			plr.Character.PrimaryPart.CFrame = CFrame.new(0, 1000, 0)
            task.wait()
            plr.Character.PrimaryPart.Anchored = true
            task.wait()
            plr.Character.PrimaryPart.CFrame = MagicPrev
            local mouse = game.Players.LocalPlayer:GetMouse()
            local input = game:GetService("UserInputService")
            mouse.Button1Down:Connect(function()
                if magic then    
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position)
                    plr.Character.PrimaryPart.Anchored = true
                end
            end)
            input.InputBegan:Connect(function(key)
                if key.KeyCode == Enum.KeyCode.E and magic then
                    plr.Character.PrimaryPart.Anchored = false
                end
            end)
        else
            plr.Character.PrimaryPart.Anchored = false
        end
	end,
}, "Toggle")
local targtype = nil
local pos1targ = CFrame.new(-303, 71, 442)
local pos2targ = CFrame.new(-224, 71, 443)
local Dropdown = sections.MainSection4:Dropdown({
	Name = "Type",
	Multi = false,
	Required = true,
	Options = {"All Mobs", "Crab [IN DEV]"},
	Default = "All Mobs",
	Callback = function(Value)
		targtype = Value
	end,
}, "Dropdown")
local AntiPrev = nil
sections.MainSection4:Toggle({
	Name = "Anti Mob Target",
	Default = false,
	Callback = function(value)
	    getgenv().antitarg = value
        while antitarg and task.wait() do 
            if targtype == "All Mobs" then
                AntiPrev = plr.Character.PrimaryPart.CFrame
                plr.Character.PrimaryPart.CFrame = CFrame.new(0, 500, 0)
                task.wait()
                plr.Character.PrimaryPart.Anchored = true
                task.wait()
                plr.Character.PrimaryPart.CFrame = AntiPrev
                task.wait()
                plr.Character.PrimaryPart.Anchored = false
                task.wait(0.003)
            elseif targtype == "Crab(until the first coconut attack)" then
                plr.Character.PrimaryPart.CFrame = pos1targ
                task.wait()
                plr.Character.PrimaryPart.Anchored = true
                task.wait()
                plr.Character.PrimaryPart.CFrame = pos2targ
                task.wait()
                plr.Character.PrimaryPart.Anchored = false
                task.wait()
            end
        end
    end,
}, "Toggle")
local bee5 = CFrame.new(-2, 21, 69)
local bee10 = CFrame.new(230, 69, -60)
local bee15 = CFrame.new(-239, 69, -59)
local bee20 = CFrame.new(48, 34, 438)
local bee25 = CFrame.new(100, 173, -87)
local bee35 = CFrame.new(-373, 51, 386)
local currentloc = nil
local Dropdown = sections.MainSection7:Dropdown({
	Name = "Location",
	Multi = false,
	Required = true,
	Options = {5, 10, 15, 20, 25, 35},
	Default = 5,
	Callback = function(Value)
		currentloc = Value
	end,
}, "Dropdown")
sections.MainSection7:Button({
	Name = "Teleport",
	Callback = function()
        if currentloc == 5 then
            plr.Character.PrimaryPart.CFrame = bee5
        elseif currentloc == 10 then
            plr.Character.PrimaryPart.CFrame = bee10
        elseif currentloc == 15 then
            plr.Character.PrimaryPart.CFrame = bee15
        elseif currentloc == 20 then
            plr.Character.PrimaryPart.CFrame = bee20
        elseif currentloc == 25 then
            plr.Character.PrimaryPart.CFrame = bee25
        elseif currentloc == 35 then
            plr.Character.PrimaryPart.CFrame = bee35
        end
	end,
})
if tostring(getgenv().invitecode) ~= "nil" then
    sections.MainSection8:Label({
        Text = "Key used: ".. tostring(getgenv().invitecode)
    })
else 
    sections.MainSection8:Label({
        Text = "Dev Build"
    })
end
sections.MainSection8:Label({
	Text = "Our Discord: discord.gg/XAqn48p6Jm"
})
sections.MainSection8:Label({
	Text = "Developed by yyep"
})
sections.MainSection8:Label({
	Text = "Total functional: 12 functions"
})
