local JustALibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vector3-new/MyLibrary/refs/heads/main/Library.Lua"))()

local MainWindow = JustALibrary:CreateWindow({
    Title = "Example",
    Size = UDim2.fromOffset(550,450) -- or UDim2.fromOffset(650,550)
})

local Main = MainWindow:AddTab({Name = "Home"})
local Settings = MainWindow:AddTab({Name = "Settings",Icon = "lucide-cog"})

--[[
    :AddContentBox({
        Name = "LocalPlayer",
        Side = "Left"
    })
]]

local LocalPlayerBox = Main:AddContentBox({Name = "LocalPlayer",Side = "Left"})
local Contentbox1 = Main:AddContentBox({Name = "Contentbox 1",Side = "Right"})
local Contentbox2 = Main:AddContentBox({Name = "Contentbox 2",Side = "Right"})

--[[
    :AddImage({
        Image = nil,
        ImageHeight = 230
    })

    :SetVisible(Boolean)
    :Destroy()
]]

local Iamge = LocalPlayerBox:AddImage({Image = game.Players:GetUserThumbnailAsync(game.Players.LocalPlayer.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size420x420)})

--[[
    :SetText(Text)
    :SetVisible(Boolean)
    :Destroy()
]]

local Label = LocalPlayerBox:AddLabel(game.Players.LocalPlayer.DisplayName.." ["..game.Players.LocalPlayer.Name.."]")

--[[
    :SetVisible(Boolean)
    :Destroy()
]]

local Divider = LocalPlayerBox:AddDivider()

--[[
    :AddButton({
        Text = "Button",
        Callback = function() end
    })

    :SetText(Text)
    :SetDisabled(Boolean)
    :SetVisible(Boolean)
    :Destroy()
]]

local Button = LocalPlayerBox:AddButton({
    Text = "Print",
    Callback = function()

        --[[
            :Notify({
                Title = "Notification",
                Content = "Hello World!",
                Sound = nil,
                SoundVolume = 0.5,
                Time = 3
            })
        ]]

        JustALibrary:Notify({
            Content = game.Players.LocalPlayer.DisplayName.." ["..game.Players.LocalPlayer.Name.."]".."\nHello World!",
            Sound = 107396133526484,
            Time = 3
        })
    end
})

--[[
    :AddToggle({
        Text = "Toggle",
        Index = "Toggle",
        Default = false,
        Callback = function() end
    })

    :SetText(Text)
    :SetValue(Boolean)
    :SetDisabled(Boolean)
    :SetVisible(Boolean)
    :Destroy()
]]

Contentbox1:AddToggle({
    Text = "Toggle",
    Index = "Togl",
    Callback = function(Value) print(Value) end
})

--[[
    :AddDropdown({
        Text = "Dropdown",
        Index = "Dropdown",
        Values = {},
        Default = nil,
        MaxVisibleValues = "Auto", or number > 0
        MultiSelection = true, returns table
        Callback = function() end
    })

    :SetText(Text)
    :SetValue(string or table)
    :ReplaceValues(Table)
    :GetActiveValues()
    :SetDisabled(Boolean)
    :SetVisible(Boolean)
    :Destroy()
]]

Contentbox1:AddDropdown({
    Text = "Single Dropdown",
    Index = "Drop1",
    Values = {"wan","tu","tri"},
    Default = "wan",
    MaxVisibleValues = "Auto",
    MultiSelection = false,
    Callback = function(Value) print(Value) end
})

Contentbox1:AddDropdown({
    Text = "Multi Dropdown",
    Index = "Drop2",
    Values = {"for","fiv","ix"},
    Default = "fiv",
    MaxVisibleValues = 2,
    MultiSelection = true,
    Callback = function(Value) for Index,Item in Value do print(Index,Item) end end
})

--[[
    :AddInput({
        Text = "Input",
        Index = "Input",
        Default = nil,
        Placeholder = nil,
        ClearTextOnFocus = false,
        Finished = false,
        Callback = function() end
    })

    :SetText(Text)
    :SetValue(Text)
    :SetDisabled(Boolean)
    :SetVisible(Boolean)
    :Destroy()
]]

Contentbox1:AddInput({
    Text = "Input",
    Index = "MyInput",
    Default = "Nothing",
    Placeholder = "Type something",
    Finished = true,
    Callback = function(Value) print(Value) end
})

--[[
    :AddKeyPicker({
        Text = "Keybind",
        Index = "Keybind",
        Default = "None",
        Callback = function() end
    })

    :SetText(Text)
    :SetValue(Key(string))
    :SetDisabled(Boolean)
    :SetVisible(Boolean)
    :Destroy()
]]

Contentbox2:AddKeyPicker({
    Text = "Toggle Window",
    Index = "ToggleWindowKeybind",
    Default = "T",
    Callback = function()
        MainWindow:ToggleVisible()
    end
})

--[[
    :SetupSaveManager({
        Tab = nil,
        MainFolderName = nil,
        SubFolderName = nil,
        Autoload = false,
        FilterIndexMode = "Exclude", or "Selected"
        FilterIndex = {}
    })
]]

SetupSaveManager({
    Tab = Settings,
    MainFolderName = "TestFolder",
    SubFolderName = "Configs",
    Autoload = true,
    FilterIndexMode = "Exclude",
    FilterIndex = {"Togl"}
})
