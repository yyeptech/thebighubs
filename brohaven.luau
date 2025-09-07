local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()
local Window = MacLib:Window({
	Title = "Execsense Injected",
	Subtitle = "Brookhaven v1.6",
	Size = UDim2.fromOffset(890, 570),
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
	Main = tabGroups.TabGroup1:Tab({ Name = "Players"}),
	Main2 = tabGroups.TabGroup1:Tab({ Name = "Tools"}),
	Main3 = tabGroups.TabGroup1:Tab({ Name = "Local Player"}),
	Main4 = tabGroups.TabGroup1:Tab({ Name = "Information"}),
}
local sections = {
	MainSection5 = tabs.Main:Section({ Side = "Left" }),
	MainSection1 = tabs.Main:Section({ Side = "Left" }),
	MainSectionTp = tabs.Main:Section({ Side = "Right" }),
	MainSection2 = tabs.Main2:Section({ Side = "Left" }),
	MainSection3 = tabs.Main3:Section({ Side = "Left" }),
	MainSection4 = tabs.Main3:Section({ Side = "Left" }),
	MainSection7 = tabs.Main3:Section({ Side = "Left" }),
	MainSection8 = tabs.Main4:Section({ Side = "Left" }),
}

sections.MainSection1:Header({
	Name = "Auto Kill"
})
sections.MainSectionTp:Header({
	Name = "Other"
})
sections.MainSection3:Header({
	Name = "Player"
})
sections.MainSection7:Header({
	Name = "Other"
})
sections.MainSection4:Header({
	Name = "Houses"
})
local plr = game.Players.LocalPlayer
local plr3 = nil
local plr2 = nil


sections.MainSection1:Input({
	Name = "Player's name",
	Placeholder = "Name",
	AcceptedCharacters = "All",
	Callback = function(input)
		plr3 = input
	end,
}, "Input")
local prevcframeofseat = nil
sections.MainSection5:Button({
	Name = "Get Couch",
	Callback = function()
	    prevcframeofseat = workspace.WorkspaceCom["003_CouchGiveTool"]:WaitForChild("Seat1").CFrame
        workspace.WorkspaceCom:WaitForChild("003_CouchGiveTool"):WaitForChild("Seat1").CFrame = plr.Character.PrimaryPart.CFrame
        workspace.WorkspaceCom:WaitForChild("003_CouchGiveTool"):WaitForChild("Seat1").CanCollide = false
        while task.wait() do
            if plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated then
                plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                plr.Character.PrimaryPart.CFrame = plr.Character.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
                task.wait(0.25)
                workspace.WorkspaceCom["003_CouchGiveTool"]:WaitForChild("Seat1").CFrame = prevcframeofseat
                workspace.WorkspaceCom:WaitForChild("003_CouchGiveTool"):WaitForChild("Seat1").CanCollide = true
                break
            end
        end
	end,
})
sections.MainSection1:Button({
	Name = "Kill Player(Required Couch)",
	Callback = function()
        plr2 = game.Players[plr3]
        local name = game.Players.LocalPlayer.Name
        if workspace[name]:FindFirstChild("Couch") then
            workspace[name].Couch.Parent = plr.Backpack
        end
        if plr.Backpack:FindFirstChild("Couch") then
            plr.Backpack.Couch.Parent = workspace[name]
            local prevpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            task.wait(0.05)
            while task.wait() do
                plr.Character.HumanoidRootPart.CFrame = plr2.Character.PrimaryPart.CFrame + Vector3.new(0, -3.5, 0)
                if plr2.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated then
                    task.wait(0.08)
                    plr.Character.HumanoidRootPart.CFrame = CFrame.new(100000, 25, 0)
                    task.wait(0.80)
                    workspace[name].Couch.Parent = plr.Backpack
                    task.wait(0.3)
                    plr.Character.HumanoidRootPart.CFrame = prevpos
                    break
                end
            end
        end
	end,
})
local plrtp = nil
sections.MainSectionTp:Input({
	Name = "Player's name",
	Placeholder = "Name",
	AcceptedCharacters = "All",
	Callback = function(input)
		plrtp = input
	end,
}, "Input")
sections.MainSectionTp:Button({
	Name = "Tp to player",
	Callback = function()
        plr.Character.PrimaryPart.CFrame = game.Players[plrtp].Character.PrimaryPart.CFrame
	end,
})
sections.MainSection2:Button({
	Name = "Equip All Tools [PENDING FIX]",
	Callback = function()
        print("Pending Fix")
	end,
})

sections.MainSection3:Slider({
	Name = "WalkSpeed",
	Default = 20,
	Minimum = 0,
	Maximum = 500,
	DisplayMethod = "Speed",
	Precision = 0,
	Callback = function(Value)
	    plr.Character.Humanoid.WalkSpeed = Value
	end
}, "Slider")
sections.MainSection3:Slider({
	Name = "Jump Boost",
	Default = 20,
	Minimum = 0,
	Maximum = 500,
	DisplayMethod = "Boost",
	Precision = 0,
	Callback = function(Value)
	    plr.Character.Humanoid.JumpPower = Value
	end
}, "Slider")

sections.MainSection4:Button({
	Name = "Anti Ban",
	Callback = function()
        for _, i in pairs(workspace:GetDescendants()) do
		    if i.Name == "BannedBlock" or "PropBlocker13" and i:FindFirstChild("PropBlocker13") then
		        i:Destroy()
		    end
		end
	end,
})
sections.MainSection4:Button({
	Name = "Remove all doors",
	Callback = function()
        for _, i in pairs(workspace:GetDescendants()) do
            if i.Name == "Door" or i.Name == "FakeDoor" or i.Name == "Doors" or i.Name == "Frame" or i.Name == "DoorRight" then
                i:Destroy()
            end
        end
	end,
})
sections.MainSectionTp:Button({
	Name = "Move player to you(Required Couch)",
	Callback = function()
        local name = game.Players.LocalPlayer.Name
        if workspace[name]:FindFirstChild("Couch") then
            workspace[name].Couch.Parent = plr.Backpack
        end
        if plr.Backpack:FindFirstChild("Couch") then
            plr.Backpack.Couch.Parent = workspace[name]
            local prevpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            task.wait(0.05)
            while task.wait() do
                plr.Character.HumanoidRootPart.CFrame = game.Players[plrtp].Character.PrimaryPart.CFrame + Vector3.new(0, -3.5, 0)
                if game.Players[plrtp].Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated then
                    task.wait(0.08)
                    plr.Character.HumanoidRootPart.CFrame = prevpos
                    task.wait(0.5)
                    workspace[name].Couch.Parent = plr.Backpack
                    break
                end
            end
            
        end
	end,
})
local prevtotp = nil
sections.MainSection7:Toggle({
	Name = "Anti Seat",
	Default = false,
	Callback = function(value)
        getgenv().antisit = value
        while antisit and task.wait() do
            prevtotp = plr.Character.PrimaryPart.CFrame
            if plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated then
                plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                plr.Character.PrimaryPart.CFrame = prevtotp
            end
        end
	end,
}, "Toggle")
sections.MainSection8:Label({
	Text = "Key used: ".. tostring(getgenv().invitecode)
})
sections.MainSection8:Label({
	Text = "Our Discord: discord.gg/XAqn48p6Jm"
})
