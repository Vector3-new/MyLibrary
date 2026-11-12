local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vector3-new/MyLibrary/refs/heads/main/Library.Lua"))()

-- 1. Create Main Window (accepts a string)
local MainWindow = Library:CreateWindow("Example")

-- 2. Notifications
Library:Notify({
    Title = "Welcome",
    Content = "Library has been successfully loaded!",
    Icon = "lucide-bell-ring", -- Uses Lucide icons from your Icons.Lua
    Time = 5,
    -- Sound = "1234567890", -- Optional Roblox Sound ID
    -- SoundVolume = 1
})

-- 3. Standalone Draggable Elements (HUD)
local DraggableLabel = Library:CreateDraggableLabel("Status: Active",UDim2.fromOffset(20, 100))
-- DraggableLabel:SetText("Status: Idle")
-- DraggableLabel:SetVisible(true)
-- DraggableLabel:Destroy()

local DraggableButton = Library:CreateDraggableButton("Toggle UI",function() MainWindow:ToggleVisible() end,UDim2.fromOffset(20,140))
-- DraggableButton:SetVisible(true)
-- DraggableButton:Destroy()

-- 4. Tabs
local MainTab = MainWindow:AddTab("Main","lucide-home")
local VisualsTab = MainWindow:AddTab("Visuals","lucide-eye")
local SettingsTab = MainWindow:AddTab("Settings","lucide-settings")

-- 5. Content Boxes (Sides: "Left" or "Right")
local LeftBox = MainTab:AddContentBox("General Controls","Left","lucide-sliders")
local RightBox = MainTab:AddContentBox("Interactive Elements","Right","lucide-box")

-- 6. Elements inside Left ContentBox

-- Label
local MyLabel = LeftBox:AddLabel("This is a standard text label. It wraps automatically.")
-- MyLabel:SetText("Updated label text!")
-- MyLabel:SetVisible(true)
-- MyLabel:Destroy()

-- Divider
local MyDivider = LeftBox:AddDivider()
-- MyDivider:SetVisible(true)
-- MyDivider:Destroy()

-- Image (accepts 1st argument: Image ID, 2nd argument: Height)
local MyImage = LeftBox:AddImage("rbxassetid://10822217003",120)
-- MyImage:SetImage("rbxassetid://1234567890")
-- MyImage:SetVisible(true)
-- MyImage:Destroy()

-- Button
local MyButton = LeftBox:AddButton({
    Text = "Trigger Notification",
    Callback = function()
        Library:Notify({
            Title = "Button Clicked",
            Content = "You pressed the example button!",
            Icon = "lucide-check",
            Time = 3
        })
    end
})
-- MyButton:SetText("New Button Text")
-- MyButton:SetDisabled(false)
-- MyButton:SetVisible(true)
-- MyButton:Destroy()

-- Toggle
local MyToggle = LeftBox:AddToggle({
    Text = "Enable Feature",
    Index = "ExampleToggle", -- Required if you want SaveManager to save this element
    Default = false,
    Callback = function(Value)
        print("Toggle state changed to:",Value)
    end
})
-- MyToggle:SetText("Updated Toggle")
-- MyToggle:SetValue(true)
-- MyToggle:SetDisabled(false)
-- MyToggle:SetVisible(true)
-- MyToggle:Destroy()

-- 7. Elements inside Right ContentBox

-- Slider
local MySlider = RightBox:AddSlider({
    Text = "WalkSpeed",
    Index = "WalkSpeedSlider",
    Min = 16,
    Max = 250,
    Default = 16,
    RoundTo = 0, -- Number of decimal places (0 for integers, 1 for 0.1, etc.)
    Suffix = "studs/s",
    Callback = function(Value)
        print("Slider value:",Value)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})
-- MySlider:SetText("Speed")
-- MySlider:SetValue(50)
-- MySlider:SetDisabled(false)
-- MySlider:SetVisible(true)
-- MySlider:Destroy()

-- Text Input
local MyInput = RightBox:AddInput({
    Text = "Custom Message",
    Index = "CustomMessageInput",
    Default = "",
    Placeholder = "Type something here...",
    ClearTextOnFocus = false,
    Finished = true, -- true = triggers callback only when Enter/unfocused; false = triggers on every keystroke
    Callback = function(Value)
        print("Input text:",Value)
    end
})
-- MyInput:SetText("New Input Title")
-- MyInput:SetValue("Hello!")
-- MyInput:SetDisabled(false)
-- MyInput:SetVisible(true)
-- MyInput:Destroy()

-- KeyPicker (Keybind)
local MyKeybind = RightBox:AddKeyPicker({
    Text = "Toggle UI Keybind",
    Index = "ToggleUIKeybind",
    Default = "RightShift", -- Backspace clears the bind to "None"
    Callback = function()
        MainWindow:ToggleVisible()
    end
})
-- MyKeybind:SetText("Menu Key")
-- MyKeybind:SetValue("Insert")
-- MyKeybind:SetDisabled(false)
-- MyKeybind:SetVisible(true)
-- MyKeybind:Destroy()

-- Single-Selection Dropdown
local SingleDropdown = RightBox:AddDropdown({
    Text = "Select Mode",
    Index = "ModeDropdown",
    Values = {"Legit","Rage","Semi-Rage","Visuals Only"},
    Default = "Legit",
    MultiSelection = false,
    CanDeselect = true,
    Callback = function(Value)
        print("Selected mode:",Value)
    end
})
-- SingleDropdown:SetText("New Dropdown Title")
-- SingleDropdown:SetValue("Rage")
-- SingleDropdown:ReplaceValues({"Option 1", "Option 2"})
-- print(SingleDropdown:GetActiveValues())
-- SingleDropdown:SetDisabled(false)
-- SingleDropdown:SetVisible(true)
-- SingleDropdown:Destroy()

-- Multi-Selection Dropdown
local MultiDropdown = RightBox:AddDropdown({
    Text = "Target Parts",
    Index = "TargetPartsDropdown",
    Values = {"Head","Torso","Left Arm","Right Arm","Legs"},
    Default = {"Head", "Torso"},
    MultiSelection = true,
    CanDeselect = false, -- Prevents deselecting the last remaining item
    Callback = function(SelectedTable)
        print("Active targets:",table.concat(SelectedTable, ", "))
    end
})

-- 8. Element Visibility & State Control Example (Visuals Tab)
local ControlBox = VisualsTab:AddContentBox("Dynamic Controls","Left","lucide-wrench")
local SecretLabel = ControlBox:AddLabel("Secret Feature Unlocked!")
SecretLabel:SetVisible(false)

ControlBox:AddToggle({
    Text = "Show Secret Label",
    Default = false,
    Callback = function(State)
        SecretLabel:SetVisible(State)
    end
})

-- 9. Save Manager Setup (Settings Tab)
SetupSaveManager({
    Tab = SettingsTab,
    Name = "Config Manager",
    MainFolderName = "MyScriptConfigs",
    Autoload = true,
    -- Optional filtering:
    -- FilterIndexMode = "Exclude", -- "Exclude" or "Selected"
    -- FilterIndex = {"ToggleUIKeybind"}
})
