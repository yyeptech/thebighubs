local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local currentkey = "ABC-Y2R-9D2-84D-99R-13E-SPL"
local Window = Library.CreateLib("EraSploit Loader", "DarkTheme")

local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Key System")
Section:NewTextBox("Key", "Enter the key", function(txt)
	getgenv().invitecode = txt
end)

local status = Section:NewLabel("Waiting...")
Section:NewButton("Load", "Activate", function()
    if getgenv().invitecode == "erasploitisgood" then
        status:UpdateLabel("Loading...")
        if game.placeId == 4924922222 then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/yyeptech/thebighubs/refs/heads/main/brohaven.luau"))()
        elseif game.placeId == 1537690962 then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/yyeptech/thebighubs/refs/heads/main/bss.luau"))()
        else
            game.Players.LocalPlayer:Kick("Invalid Game.")
        end
    elseif getgenv().invitecode == currentkey then
        status:UpdateLabel("Loading...")
        if game.placeId == 4924922222 then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/yyeptech/thebighubs/refs/heads/main/brohaven.luau"))()
        elseif game.placeId == 1537690962 then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/yyeptech/thebighubs/refs/heads/main/bssbeta.luau"))()
        end
         
    else
        status:UpdateLabel("Invalid!")
    end
end)
local freekey = Section:NewLabel("You can get a free key in our Discord")
local freekey1 = Section:NewLabel("discord.gg/XAqn48p6Jm")
