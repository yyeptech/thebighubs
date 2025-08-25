local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()

local Window = MacLib:Window({
	Title = "ERXWare DLC",
	Subtitle = "Bee Swarm Simulator V4",
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
    Exploits = tabGroups.TabGroup1:Tab({ Name = "Exploits / Useful" }),
    Other = tabGroups.TabGroup1:Tab({ Name = "Other" }),
    Teleports = tabGroups.TabGroup1:Tab({ Name = "Teleports" }),
    Information = tabGroups.TabGroup1:Tab({ Name = "Information" }),
	Tutor = tabGroups.TabGroup1:Tab({ Name = "Tutorial" }),
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
	MainSection9 = tabs.Tutor:Section({ Side = "Left" }),
    MainSection10 = tabs.Other:Section({ Side = "Left" }),
    MainSection11 = tabs.Teleports:Section({ Side = "Right" }),
    MainSection12 = tabs.Main:Section({ Side = "Left" }),
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
sections.MainSection9:Header({
	Name = "Tutorial on Functions"
})
sections.MainSection10:Header({
	Name = "Collecting"
})
sections.MainSection11:Header({
	Name = "Shops"
})
sections.MainSection12:Header({
	Name = "Auto Buy with Tickets"
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
	Name = "Mode",
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
local convtype = nil
local Dropdown = sections.MainSection6:Dropdown({
	Name = "Mode",
	Multi = false,
	Required = true,
	Options = {"Hive", "Micro-Converter"},
	Default = "Hive",
	Callback = function(Value)
		convtype = Value
	end,
}, "Dropdown")
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
            if convtype == "Hive" and plr.CoreStats.Pollen.Value == plr.CoreStats.Capacity.Value or plr.CoreStats.Pollen.Value > plr.CoreStats.Capacity.Value then
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

            elseif plr.CoreStats.Pollen.Value == plr.CoreStats.Capacity.Value or plr.CoreStats.Pollen.Value > plr.CoreStats.Capacity.Value and convtype == "Micro-Converter" then
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerActivesCommand"):FireServer({ Name = "Micro-Converter" })
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
local amovturn = true
sections.MainSection5:Toggle({
	Name = "Auto Movement",
	Default = false,
	Callback = function(value)
	    getgenv().afarm = value
        while getgenv().afarm and task.wait(0.08) do
            for _, targetobj in pairs(workspace.Collectibles:GetChildren()) do
                if (plr.Character.PrimaryPart.Position - targetobj.Position).Magnitude < 60 and targetobj.Transparency < 0.5 and movtype == "Legit" and turnmov and amovturn then
                    amovturn = false
					passivetoggle = false
                    plr.Character.Humanoid:MoveTo(targetobj.Position)
                    plr.Character.Humanoid.MoveToFinished:Connect(function()
                        passivetoggle = true
						amovturn = true
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
local antitp = true
sections.MainSection4:Toggle({
	Name = "Anti Spawn [Bypasser]",
	Default = false,
	Callback = function(value)
	    getgenv().atp = value
	    while getgenv().atp and task.wait() and antitp do
            if (workspace:FindFirstChildOfClass("SpawnLocation").Position - plr.Character.PrimaryPart.Position).Magnitude < 5 then
                antitp = false
                task.wait()
                antitp = true
                task.wait()
                plr.Character.PrimaryPart.CFrame = prevatp
            end
            prevatp = plr.Character.PrimaryPart.CFrame
        end
    end,
}, "Toggle")

sections.MainSection3:Slider({
	Name = "Walk Speed",
	Default = 15,
	Minimum = 1,
	Maximum = 250,
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
	Maximum = 250,
	DisplayMethod = "Speed",
	Precision = 0,
	Callback = function(Value)
        plr.Character.Humanoid.JumpPower = tonumber(Value)
	end
}, "Slider")

local MagicPrev = nil
sections.MainSection4:Toggle({
	Name = "Magic Body [PC Only]",
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
	Name = "Mode",
	Multi = false,
	Required = true,
	Options = {"All Mobs", "Crab(works until the first coconut attack)"},
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
            elseif targtype == "Crab(works until the first coconut attack)" then
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
local curshop = nil
local Dropdown = sections.MainSection11:Dropdown({
	Name = "Current Shop",
	Multi = false,
	Required = true,
	Options = {0,"0(2)", 10, "10(2)", 25, 35, "Red", "Blue", "Yellow", "Star Amulet", "Moon Amulet"},
	Default = 0,
	Callback = function(Value)
		curshop = Value
	end,
}, "Dropdown")
local b1 = CFrame.new(59, 2, 293)
local b2 = CFrame.new(-233, 15, 372)
local bred = CFrame.new(-287, 18, 214)
local bblue = CFrame.new(250, 2, 96)
local byellow = CFrame.new(-368, 79, -72)
local b6 = CFrame.new(164, 66, -137)
local bspec = CFrame.new(461, 135, -316)
local b8 = CFrame.new(-18, 174, -177)
local b9 = CFrame.new(-499, 49, 409)
local b10 = CFrame.new(121, 63, 285)
local bmoon = CFrame.new(22, 85, -54)
sections.MainSection11:Button({
	Name = "Teleport",
	Callback = function()
        if curshop == 0 then
            plr.Character.PrimaryPart.CFrame = b1
        elseif curshop == "0(2)" then
            plr.Character.PrimaryPart.CFrame = b2
        elseif curshop == "Red" then
            plr.Character.PrimaryPart.CFrame = bred
        elseif curshop == "Blue" then
            plr.Character.PrimaryPart.CFrame = bblue
        elseif curshop == "Yellow" then
            plr.Character.PrimaryPart.CFrame = byellow
        elseif curshop == 10 then
            plr.Character.PrimaryPart.CFrame = b6
        elseif curshop == "10(2)" then
            plr.Character.PrimaryPart.CFrame = bspec 
        elseif curshop == 25 then
            plr.Character.PrimaryPart.CFrame = b8
        elseif curshop == "Star Amulet" then
            plr.Character.PrimaryPart.CFrame = b10
        elseif curshop == 35 then
            plr.Character.PrimaryPart.CFrame = b9
        elseif curshop == "Moon Amulet" then
            plr.Character.PrimaryPart.CFrame = bmoon
        end
	end,
})
local path = nil
sections.MainSection10:Toggle({
	Name = "Collect all Stickers",
	Default = false,
	Callback = function(value)
	    getgenv().acollectstic = value
        while acollectstic and task.wait(0.1) do 
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("HiddenStickerEvent"):FireServer(1)
        end
    end,
}, "Toggle")
sections.MainSection12:Toggle({
	Name = "Auto Buy Gumdrops",
	Default = false,
	Callback = function(value)
	    getgenv().abuygum = value
	    while getgenv().abuygum and task.wait() do
	        local args = {
                "Purchase",
                {
                    Type = "Gumdrops",
                    Category = "Eggs",
                    Amount = 3
                }
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ItemPackageEvent"):InvokeServer(unpack(args))

	    end
	end,
}, "Toggle")
sections.MainSection12:Toggle({
	Name = "Auto Buy Stingers",
	Default = false,
	Callback = function(value)
	    getgenv().abuysting = value
	    while getgenv().abuysting and task.wait() do
	        local args = {
                "Purchase",
                {
                    Type = "Stinger",
                    Category = "Eggs",
                    Amount = 1
                }
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ItemPackageEvent"):InvokeServer(unpack(args))

	    end
	end,
}, "Toggle")
if tostring(getgenv().invitecode) ~= "nil" then
    sections.MainSection8:Label({
        Text = "Key used: ".. tostring(getgenv().invitecode)
    })
else 
    sections.MainSection8:Label({
        Text = "Source/Dev Build"
    })
end
sections.MainSection8:Label({
	Text = "Our Discord: discord.gg/XAqn48p6Jm"
})
sections.MainSection8:Label({
	Text = "Developed by yyep"
})
sections.MainSection8:Label({
	Text = "Total functional: 16 functions"
})
sections.MainSection9:Label({
	Text = "Activate the Passive Movement at the Center Field ONLY(otherwise, the script may exit the field)"
})
sections.MainSection9:Label({
	Text = "To move in Magic Body you need to click on mouse"
})
sections.MainSection9:Label({
	Text = "Anti Spawn allows you to stay in locked locations"
})
sections.MainSection9:Label({
	Text = "Emergency Movement activates when script stopped(when player not on the field)"
})
