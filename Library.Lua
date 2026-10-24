while not game:IsLoaded() do task.wait() end
local Icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vector3-new/MyLibrary/refs/heads/main/Icons.Lua"))()
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local P = game:GetService("Players")
local LocalPlayer = P.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local JustALibrary = {
    Tabs = {},
    Elements = {},
    Connections = {}
}
local BlacklistedKeys = {
	"Unknown",
    "W",
    "A",
    "S",
    "D",
    "Up",
    "Left",
    "Down",
    "Right",
    "Slash"
}
local JustALibraryGUI = CoreGui:FindFirstChild("JustALibrary")
if JustALibraryGUI then JustALibraryGUI:Destroy() end
JustALibraryGUI = Instance.new("ScreenGui",CoreGui)
JustALibraryGUI.Name = "JustALibrary"

local LibraryBlur = Lighting:FindFirstChild("LibraryBlur")
if LibraryBlur then LibraryBlur:Destroy() end
LibraryBlur = Instance.new("BlurEffect",Lighting)
LibraryBlur.Name = "LibraryBlur"
LibraryBlur.Size = 0
TweenService:Create(LibraryBlur,TweenInfo.new(0.25,Enum.EasingStyle.Linear),{Size = 12}):Play()

local function New(GivenTable)
    local Object
    if (GivenTable.ClassName or "Frame") == "Frame" and GivenTable.ScrollingConfig then
        Object = Instance.new("ScrollingFrame",GivenTable.Parent)
        Object.ScrollBarThickness = 0
        Object.CanvasSize = UDim2.new(0,0,0,0)
        Object.ScrollingDirection = Enum.ScrollingDirection[GivenTable.ScrollingConfig.ScrollingDirection] or Enum.ScrollingDirection.Y
        Object.AutomaticCanvasSize = Enum.AutomaticSize[GivenTable.ScrollingConfig.ScrollingDirection] or Enum.AutomaticSize.Y
    else
        Object = Instance.new(GivenTable.ClassName or "Frame",GivenTable.Parent)
    end
    Object.Name = GivenTable.Name or Object.ClassName
    Object.Visible = GivenTable.Visible
    Object.BackgroundColor3 = GivenTable.BackgroundColor3 or Color3.fromRGB(0,0,0)
    Object.BackgroundTransparency = GivenTable.BackgroundTransparency or 1
    Object.AnchorPoint = GivenTable.AnchorPoint or Vector2.new(0,0)
    Object.Size = GivenTable.Size or UDim2.new(0,0,0,0)
    Object.AutomaticSize = GivenTable.AutomaticSize or Enum.AutomaticSize.None
    Object.Position = GivenTable.Position or UDim2.new(0,0,0,0)
    Object.LayoutOrder = GivenTable.LayoutOrder or 0
    Object.ZIndex = GivenTable.ZIndex or 0
    if GivenTable.ClassName == "TextLabel" or GivenTable.ClassName == "TextButton" or GivenTable.ClassName == "TextBox" then
        Object.Text = GivenTable.Text or (GivenTable.ClassName == "TextLabel" and "Text" or GivenTable.ClassName == "TextBox" and "" or "Button")
        Object.TextColor3 = GivenTable.TextColor3 or Color3.fromRGB(255,255,255)
        Object.TextSize = GivenTable.TextSize or 8
        Object.TextWrapped = GivenTable.TextWrapped or false
        Object.TextTruncate = GivenTable.TextTruncate or Enum.TextTruncate.AtEnd
        Object.TextScaled = GivenTable.TextScaled or false
        Object.TextTransparency = GivenTable.TextTransparency or 0
        Object.TextXAlignment = GivenTable.TextXAlignment or Enum.TextXAlignment.Center
        Object.TextYAlignment = GivenTable.TextYAlignment or Enum.TextYAlignment.Center
    end
    if GivenTable.ClassName == "TextBox" then
        Object.PlaceholderText = GivenTable.PlaceholderText or ""
        Object.ClearTextOnFocus = GivenTable.ClearTextOnFocus or false
        Object.TextEditable = GivenTable.TextEditable or true
    end
    if GivenTable.ClassName == "ImageLabel" or GivenTable.ClassName == "ImageButton" then
        Object.Image = GivenTable.Image or ""
        Object.ImageColor3 = GivenTable.ImageColor3 or Color3.fromRGB(255,255,255)
        Object.ImageTransparency = GivenTable.ImageTransparency or 0
    end
    if GivenTable.CornerRadius then
        local UICorner = Instance.new("UICorner",Object)
        UICorner.CornerRadius = UDim.new(0,GivenTable.CornerRadius)
    end
    if GivenTable.Padding then
        local UIPadding = Instance.new("UIPadding",Object)
        UIPadding.PaddingBottom = UDim.new(0,GivenTable.Padding)
    end
    if GivenTable.ListLayoutConfig then
        local UIListLayout = Instance.new("UIListLayout",Object)
        UIListLayout.Padding = GivenTable.ListLayoutConfig.Padding or UDim.new(0,0)
        UIListLayout.FillDirection = GivenTable.ListLayoutConfig.FillDirection or Enum.FillDirection.Vertical
        UIListLayout.SortOrder = GivenTable.ListLayoutConfig.SortOrder or Enum.SortOrder.LayoutOrder
        UIListLayout.HorizontalAlignment = GivenTable.ListLayoutConfig.HorizontalAlignment or Enum.HorizontalAlignment.Left
        UIListLayout.VerticalAlignment = GivenTable.ListLayoutConfig.VerticalAlignment or Enum.VerticalAlignment.Top
    end
    return Object
end

local function RemoveConnections(Element)
    if not JustALibrary.Connections[Element] then return end
    for _,Connection in JustALibrary.Connections[Element] do Connection:Disconnect() end
    JustALibrary.Connections[Element] = nil
end

local function MakeDraggable(GivenFrame)
    RemoveConnections(GivenFrame)
    local ConnectionsTable = {}
    JustALibrary.Connections[GivenFrame] = ConnectionsTable
    local IsDragging,CursorPosition,FramePosition,Offset = false
    table.insert(ConnectionsTable,GivenFrame.InputBegan:Connect(function(Input,GameProcessed)
        if not GameProcessed and GivenFrame.Visible and (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
            CursorPosition = Input.Position
            FramePosition = GivenFrame.AbsolutePosition
            IsDragging = true
        end
    end))
     table.insert(ConnectionsTable,UserInputService.InputChanged:Connect(function(Input)
        if IsDragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
            Offset = Input.Position-CursorPosition
            TweenService:Create(GivenFrame,TweenInfo.new(0.05),{Position = UDim2.fromOffset(FramePosition.X+Offset.X,FramePosition.Y+Offset.Y)}):Play()
        end
    end))
    table.insert(ConnectionsTable,UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then IsDragging = false end
    end))
end

local ModalElement = New({
    ClassName = "TextButton",
    Parent = JustALibraryGUI,
    Name = "ModalElement",
    BackgroundTransparency = 1,
    ZIndex = -999,
    Text = "",
    Visible = true
})
ModalElement.Modal = true

local Cursor = New({
    ClassName = "Frame",
    Parent = JustALibraryGUI,
    Name = "Cursor",
    BackgroundColor3 = Color3.fromRGB(255,255,255),
    BackgroundTransparency = 0,
    Position = UDim2.fromOffset(Mouse.X,Mouse.Y),
    Size = UDim2.fromOffset(5,5),
    ZIndex = 999,
    CornerRadius = 8,
    Visible = true
})
local CursorStroke = Instance.new("UIStroke",Cursor)
CursorStroke.Color = Color3.fromRGB(0,0,0)
CursorStroke.Thickness = 1
Mouse.Move:Connect(function() Cursor.Position = UDim2.fromOffset(Mouse.X,Mouse.Y) end)

local NotificationsHolder = New({
    ClassName = "Frame",
    Parent = JustALibraryGUI,
    Name = "NotificationsHolder",
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(1,1),
    Position = UDim2.new(1,-10,1,-10),
    Size = UDim2.new(0,300,1,0),
    ListLayoutConfig = {
        Padding = UDim.new(0,5),
        VerticalAlignment = Enum.VerticalAlignment.Bottom
    },
    Visible = true
})

function JustALibrary:Notify(GivenTable)
    local NotificationFakeFrame = New({
        ClassName = "Frame",
        Name = "NotificationFakeFrame",
        BackgroundTransparency = 1,
        Size = UDim2.new(1,0,0,0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = 999,
        Visible = true
    })
    local NotificationFrame = New({
        ClassName = "Frame",
        Parent = NotificationFakeFrame,
        Name = "NotificationFrame",
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 0.4,
        Position = UDim2.fromScale(1.1,0),
        Size = UDim2.new(1,0,0,0),
        AutomaticSize = Enum.AutomaticSize.Y,
        CornerRadius = 8,
        Padding = 5,
        ListLayoutConfig = {SortOrder = Enum.SortOrder.LayoutOrder,HorizontalAlignment = Enum.HorizontalAlignment.Center},
        Visible = true
    })
    local NotificationTitle = New({
        ClassName = "TextLabel",
        Parent = NotificationFrame,
        Name = "NotificationTitle",
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(280,25),
        LayoutOrder = #(NotificationFrame:GetChildren()),
        TextColor3 = Color3.fromRGB(255,255,255),
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = GivenTable.Title or "Notification",
        Visible = true
    })
    local NotificationContent = New({
        ClassName = "TextLabel",
        Parent = NotificationFrame,
        Name = "NotificationContent",
        BackgroundTransparency = 1,
        LayoutOrder = #(NotificationFrame:GetChildren()),
        Size = UDim2.fromOffset(280,0),
        AutomaticSize = Enum.AutomaticSize.Y,
        TextColor3 = Color3.fromRGB(200,200,200),
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = GivenTable.Content or "Hello World!",
        Padding = 3,
        Visible = true
    })
    local NotificationTimeFrame = New({
        ClassName = "Frame",
        Parent = NotificationFrame,
        Name = "NotificationTime",
        BackgroundColor3 = Color3.fromRGB(255,255,255),
        BackgroundTransparency = 0,
        LayoutOrder = #(NotificationFrame:GetChildren()),
        Size = UDim2.new(0,0,0,3),
        CornerRadius = 8,
        Visible = true
    })
    if GivenTable.Sound then
        local NotificationSound = Instance.new("Sound",NotificationFrame)
        NotificationSound.SoundId = "rbxassetid://"..GivenTable.Sound
        NotificationSound.Volume = GivenTable.SoundVolume or 1
        NotificationSound:Play()
    end
    NotificationFakeFrame.Parent = NotificationsHolder
    task.spawn(function()
        TweenService:Create(NotificationFrame,TweenInfo.new(0.75,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position = UDim2.fromScale(0,0)}):Play()
        TweenService:Create(NotificationTimeFrame,TweenInfo.new(GivenTable.Time or 3,Enum.EasingStyle.Linear),{Size = UDim2.new(0,280,0,3)}):Play()
        task.wait(GivenTable.Time or 3)
        TweenService:Create(NotificationFrame,TweenInfo.new(0.75,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position = UDim2.fromScale(1.1,0)}):Play()
        task.wait(0.75)
        NotificationFakeFrame:Destroy()
    end)
end

function JustALibrary:CreateDraggableLabel(GivenText)
    local DraggableLabelHolder = {}
    local DraggableLabelFrame = New({
        ClassName = "Frame",
        Name = "DraggableLabel",
        Parent = JustALibraryGUI,
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 0.4,
        Size = UDim2.fromOffset(30,30),
        AutomaticSize = Enum.AutomaticSize.X,
        CornerRadius = 8,
        Visible = true
    })
    local DraggableLabelText = New({
        ClassName = "TextLabel",
        Parent = DraggableLabelFrame,
        Name = "DraggableLabelText",
        BackgroundTransparency = 1,
        Size = UDim2.new(1,0,0,30),
        AutomaticSize = Enum.AutomaticSize.X,
        TextColor3 = Color3.fromRGB(255,255,255),
        TextScaled = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = GivenText or "Hello World!",
        Visible = true
    })
    local TextPadding = Instance.new("UIPadding",DraggableLabelText)
    TextPadding.PaddingTop = UDim.new(0,5)
    TextPadding.PaddingBottom = UDim.new(0,5)
    TextPadding.PaddingLeft = UDim.new(0,5)
    TextPadding.PaddingRight = UDim.new(0,5)
    MakeDraggable(DraggableLabelFrame)
    return DraggableLabelHolder
end

function JustALibrary:CreateWindow(GivenTable)
    local Window = {}
    local WindowSize = GivenTable.Size or UDim2.fromOffset(650,550)

    local WindowFrame = New({
        ClassName = "Frame",
        Parent = JustALibraryGUI,
        Name = "WindowFrame",
        Size = WindowSize,
        Position = UDim2.new(0.5,-WindowSize.X.Offset/2,0.5,-WindowSize.Y.Offset/2),
        BackgroundTransparency = 1,
        Active = true,
        Visible = true
    })
    MakeDraggable(WindowFrame)

    local WindowTitle = New({
        ClassName = "Frame",
        Parent = WindowFrame,
        Name = "WindowTitle",
        Size = UDim2.new(0.2,0,0,50),
        Position = UDim2.new(0,0,0,-60),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 0.6,
        CornerRadius = 8,
        Visible = true
    })
    local WindowTitleText = New({
        ClassName = "TextLabel",
        Parent = WindowTitle,
        Name = "WindowTitleText",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(0.9,0.9),
        Position = UDim2.fromScale(0.05,0.05),
        TextScaled = true,
        TextColor3 = Color3.fromRGB(255,255,255),
        Text = GivenTable.Title or "Window",
        Visible = true
    })
    local WindowTitleButton = New({
        ClassName = "TextButton",
        Parent = WindowTitle,
        Name = "WindowTitleButton",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1,1),
        Text = "",
        Visible = true
    })

    local TabsDivider = New({
        ClassName = "Frame",
        Parent = WindowFrame,
        Name = "TabsDivider",
        Position = UDim2.new(0.21,0,0,-60),
        Size = UDim2.new(0.01,0,0,50),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 0.6,
        CornerRadius = 8,
        Visible = true
    })
    local TabsFrame = New({
        ClassName = "Frame",
        Parent = WindowFrame,
        Name = "TabsFrame",
        BackgroundTransparency = 1,
        Position = UDim2.new(0.23,0,0,-60),
        Size = UDim2.new(0.54,0,0,50),
        ScrollingConfig = {
            ScrollingDirection = "X"
        },
        ListLayoutConfig = {
            Padding = UDim.new(0,10),
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder
        },
        Visible = true
    })
    local SecondTabsDivider = New({
        ClassName = "Frame",
        Parent = WindowFrame,
        Name = "SecondTabsDivider",
        Position = UDim2.new(0.78,0,0,-60),
        Size = UDim2.new(0.01,0,0,50),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 0.6,
        CornerRadius = 8,
        Visible = true
    })

    local NotificationsFrame = New({
        ClassName = "Frame",
        Parent = WindowFrame,
        Name = "NotificationsFrame",
        Size = UDim2.new(0.2,0,0,50),
        Position = UDim2.new(0.8,0,0,-60),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 0.6,
        CornerRadius = 8,
        Visible = true
    })
    local NotificationsFrameText = New({
        ClassName = "TextLabel",
        Parent = NotificationsFrame,
        Name = "NotificationsFrameText",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(0.9,0.9),
        Position = UDim2.fromScale(0.05,0.05),
        TextScaled = true,
        TextColor3 = Color3.fromRGB(255,255,255),
        Text = "Notifications",
        Visible = true
    })
    local NotificationsFrameButton = New({
        ClassName = "TextButton",
        Parent = NotificationsFrame,
        Name = "NotificationsFrameButton",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1,1),
        Text = "",
        Visible = true
    })
    local NotificationsContentFrame = New({
        ClassName = "Frame",
        Parent = WindowFrame,
        Name = "NotificationsContentFrame",
        Size = UDim2.fromOffset(200,WindowFrame.Size.Y.Offset-50),
        Position = UDim2.fromOffset(WindowFrame.Size.X.Offset+10,0),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 0.6,
        CornerRadius = 8,
        Visible = false,
        ScrollingConfig = {
            ScrollingDirection = "Y"
        },
        ListLayoutConfig = {
            Padding = UDim.new(0,5),
            SortOrder = Enum.SortOrder.LayoutOrder
        }
    })
    local NotificationsClearAllButton = New({
        ClassName = "TextButton",
        Parent = WindowFrame,
        Name = "NotificationsClearAllButton",
        BackgroundTransparency = 0.6,
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        Size = UDim2.fromOffset(200,40),
        Position = UDim2.fromOffset(WindowFrame.Size.X.Offset+10,WindowFrame.Size.Y.Offset-40),
        TextScaled = true,
        TextColor3 = Color3.fromRGB(255,255,255),
        Text = "Clear All",
        CornerRadius = 8,
        Visible = false
    })

    function Window:ToggleVisible()
        WindowFrame.Visible = not WindowFrame.Visible
        ModalElement.Visible = WindowFrame.Visible
        Cursor.Visible = WindowFrame.Visible
        if WindowFrame.Visible then
            TweenService:Create(LibraryBlur,TweenInfo.new(0.1,Enum.EasingStyle.Linear),{Size = 12}):Play()
        else
            TweenService:Create(LibraryBlur,TweenInfo.new(0.25,Enum.EasingStyle.Linear),{Size = 0}):Play()
        end
    end
    WindowTitleButton.MouseButton1Click:Connect(function()
        Window:ToggleVisible()
    end)

    NotificationsFrameButton.MouseButton1Click:Connect(function()
        if NotificationsContentFrame.Visible then
            NotificationsContentFrame.Visible = false NotificationsClearAllButton.Visible = false
            TweenService:Create(NotificationsFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
        else
            NotificationsContentFrame.Visible = true NotificationsClearAllButton.Visible = true
            TweenService:Create(NotificationsFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(125,125,125)}):Play()
        end
    end)

    NotificationsClearAllButton.MouseButton1Click:Connect(function()
        for _,Notifications in NotificationsContentFrame:GetChildren() do
            if Notifications:IsA("Frame") then
                TweenService:Create(Notifications.NotificationFrame,TweenInfo.new(0.3,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position = UDim2.fromScale(1.5,0)}):Play()
                task.spawn(function() task.wait(0.6) Notifications:Destroy() end) task.wait(0.05)
            end
        end
    end)

    NotificationsHolder.ChildAdded:Connect(function(Notification)
        local NewNotification = Notification:Clone()
        if NewNotification.NotificationFrame:FindFirstChild("Sound") then NewNotification.NotificationFrame.Sound:Destroy() end
        if NewNotification.NotificationFrame:FindFirstChild("NotificationTime") then NewNotification.NotificationFrame.NotificationTime:Destroy() end
        if NewNotification.NotificationFrame:FindFirstChild("UIPadding") then NewNotification.NotificationFrame.UIPadding:Destroy() end
        NewNotification.Parent = NotificationsContentFrame
        NewNotification.LayoutOrder = #(NotificationsContentFrame:GetChildren())
        NewNotification.NotificationFrame.Position = UDim2.fromScale(-1.1,0)
        for _,Labels in NewNotification.NotificationFrame:GetChildren() do if Labels:IsA("TextLabel") then Labels.Size = UDim2.fromOffset(180,25) end end
        NewNotification.NotificationFrame.Size = UDim2.fromScale(1,1)
        NewNotification.Size = UDim2.new(1,0,0,NewNotification.NotificationFrame.AbsoluteSize.Y)
        TweenService:Create(NewNotification.NotificationFrame,TweenInfo.new(0.75,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position = UDim2.fromScale(0,0)}):Play()
    end)

    function Window:AddTab(GivenTable)
        local Tab = {}

        local TabFrame = New({
            ClassName = "Frame",
            Parent = TabsFrame,
            Name = GivenTable.Name or "Tab",
            BackgroundColor3 = Color3.fromRGB(0,0,0),
            BackgroundTransparency = 0.6,
            Size = UDim2.fromOffset(150,50),
            LayoutOrder = #(TabsFrame:GetChildren()),
            CornerRadius = 8,
            Visible = true
        })
        local TabLabel = New({
            ClassName = "TextLabel",
            Parent = TabFrame,
            Name = "TabLabel",
            BackgroundTransparency = 1,
            TextColor3 = Color3.fromRGB(255,255,255),
            TextScaled = true,
            Text = GivenTable.Name or "Tab",
            Size = GivenTable.Icon and UDim2.fromOffset(90,25) or UDim2.fromOffset(130,25),
            Position = GivenTable.Icon and UDim2.fromOffset(45,12) or UDim2.fromOffset(10,12),
            Visible = true
        })
        if GivenTable.Icon then
            local TabIcon = New({
                ClassName = "ImageLabel",
                Parent = TabFrame,
                BackgroundTransparency = 1,
                Position = UDim2.fromOffset(10,10),
                Size = UDim2.fromOffset(30,30),
                Image = Icons.assets[GivenTable.Icon],
                Visible = true
            })
        end

        local TabContentFrame = New({
            ClassName = "Frame",
            Parent = WindowFrame,
            Name = GivenTable.Name or "Tab",
            BackgroundTransparency = 0.6,
            BackgroundColor3 = Color3.fromRGB(0,0,0),
            Size = UDim2.fromScale(1,1),
            CornerRadius = 8,
            Visible = false
        })
        local TabContentScrollingFrame = New({
            ClassName = "Frame",
            Parent = TabContentFrame,
            Name = "TabContentScrollingFrame",
            Size = UDim2.fromScale(0.47,0.95),
            Position = UDim2.fromScale(0.025,0.025),
            BackgroundTransparency = 1,
            ScrollingConfig = {
                ScrollingDirection = "Y"
            },
            ListLayoutConfig = {
                Padding = UDim.new(0,8),
                SortOrder = Enum.SortOrder.LayoutOrder
            },
            Visible = true
        })
        local SecondTabContentScrollingFrame = New({
            ClassName = "Frame",
            Parent = TabContentFrame,
            Name = "SecondTabContentScrollingFrame",
            Size = UDim2.fromScale(0.47,0.95),
            Position = UDim2.fromScale(0.505,0.025),
            BackgroundTransparency = 1,
            ScrollingConfig = {
                ScrollingDirection = "Y"
            },
            ListLayoutConfig = {
                Padding = UDim.new(0,8),
                SortOrder = Enum.SortOrder.LayoutOrder
            },
            Visible = true
        })

        local TabButton = New({
            ClassName = "TextButton",
            Parent = TabFrame,
            Name = "TabButton",
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1,1),
            Text = "",
            Visible = true
        })
        TabButton.MouseButton1Click:Connect(function()
            for _,TabFrames in TabsFrame:GetChildren() do
                if TabFrames:IsA("Frame") then
                    if TabFrames == TabFrame then
                        WindowFrame[TabFrames.Name].Visible = true
                        TweenService:Create(TabFrames,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(125,125,125)}):Play()
                    else
                        WindowFrame[TabFrames.Name].Visible = false
                        TweenService:Create(TabFrames,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
                    end
                end
            end
        end)

        function Tab:AddContentBox(GivenTable)
            local ContentBox = {HiddenElements = {}}
            local GivenParent = GivenTable.Side == "Right" and SecondTabContentScrollingFrame or TabContentScrollingFrame

            local ContentBoxFrame = New({
                ClassName = "Frame",
                Parent = GivenParent,
                Name = GivenTable.Name,
                Size = UDim2.new(1,0,0,30),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = Color3.fromRGB(0,0,0),
                BackgroundTransparency = 0.6,
                CornerRadius = 8,
                Padding = 8,
                LayoutOrder = #(GivenParent:GetChildren()),
                ListLayoutConfig = {
                    Padding = UDim.new(0,8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                },
                Visible = true
            })
            local ContentBoxTitleFrame = New({
                ClassName = "Frame",
                Parent = ContentBoxFrame,
                Name = "ContentBoxTitleFrame",
                Size = UDim2.new(1,0,0,30),
                BackgroundColor3 = Color3.fromRGB(0,0,0),
                BackgroundTransparency = 0.6,
                CornerRadius = 8,
                Visible = true
            })
            local ContentBoxTitle = New({
                ClassName = "TextLabel",
                Parent = ContentBoxTitleFrame,
                Name = "ContentBoxTitle",
                BackgroundTransparency = 1,
                Size = UDim2.new(0.75,0,0,30),
                Position = UDim2.fromScale(0.03,0),
                TextWrapped = true,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextColor3 = Color3.fromRGB(255,255,255),
                Text = GivenTable.Name or "ContentBox",
                Visible = true
            })
            local ContentBoxPopOut = New({
                ClassName = "ImageButton",
                Parent = ContentBoxTitleFrame,
                Name = "ContentBoxPopOut",
                BackgroundTransparency = 1,
                AnchorPoint = Vector2.new(1,0),
                Size = UDim2.fromOffset(20,20),
                Position = UDim2.new(0.875,0,0,5),
                Image = Icons.assets["lucide-external-link"],
                Visible = true
            })
            local ContentBoxMinimize = New({
                ClassName = "ImageButton",
                Parent = ContentBoxTitleFrame,
                Name = "ContentBoxMinimize",
                BackgroundTransparency = 1,
                AnchorPoint = Vector2.new(1,0),
                Size = UDim2.fromOffset(20,20),
                Position = UDim2.new(0.975,0,0,5),
                Image = Icons.assets["lucide-chevron-down"],
                Visible = true
            })

            local IsMinimized = false
            ContentBoxMinimize.MouseButton1Click:Connect(function()
                IsMinimized = not IsMinimized
                for _,Element in ContentBoxFrame:GetChildren() do
                    if Element:IsA("Frame") and Element.Name ~= "ContentBoxTitleFrame" and not ContentBox.HiddenElements[Element] then
                        Element.Visible = not IsMinimized
                        if not IsMinimized then
                            TweenService:Create(ContentBoxMinimize,TweenInfo.new(0.2),{Rotation = 0}):Play()
                            ContentBoxFrame.UIPadding.PaddingBottom = UDim.new(0,8)
                        else
                            TweenService:Create(ContentBoxMinimize,TweenInfo.new(0.2),{Rotation = 180}):Play()
                            ContentBoxFrame.UIPadding.PaddingBottom = UDim.new(0,0)
                        end
                    end
                end
            end)

            ContentBoxPopOut.MouseButton1Click:Connect(function()
                if ContentBoxFrame.Parent ~= GivenParent then
                    RemoveConnections(ContentBoxFrame)
                    ContentBoxFrame.Parent = GivenParent
                    ContentBoxFrame.Size = UDim2.new(1,0,0,30)
                    ContentBoxPopOut.Rotation = 0
                else
                    MakeDraggable(ContentBoxFrame)
                    ContentBoxFrame.Parent = JustALibraryGUI
                    ContentBoxFrame.Size = UDim2.fromOffset(275,30)
                    ContentBoxPopOut.Rotation = 180
                end
            end)

            function ContentBox:AddLabel(Text)
                local LabelHolder = {}

                local LabelFrame = New({
                    ClassName = "Frame",
                    Parent = ContentBoxFrame,
                    Name = "LabelFrame",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1,0,0,0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = #(ContentBoxFrame:GetChildren()),
                    Visible = true
                })
                local LabelText = New({
                    ClassName = "TextLabel",
                    Parent = LabelFrame,
                    Name = "LabelText",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0.9,0,0,0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Position = UDim2.fromScale(0.05,0),
                    TextWrapped = true,
                    TextColor3 = Color3.fromRGB(255,255,255),
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Text = Text or "Label",
                    Visible = true
                })

                function LabelHolder:SetText(Text)
                    LabelText.Text = Text or "Label"
                end

                function LabelHolder:SetVisible(Boolean)
                    if Boolean then ContentBox.HiddenElements[LabelFrame] = nil else ContentBox.HiddenElements[LabelFrame] = true end
                    LabelFrame.Visible = Boolean and not IsMinimized
                end

                function LabelHolder:Destroy()
                    LabelFrame:Destroy()
                end

                return LabelHolder
            end

            function ContentBox:AddDivider()
                local DividerHolder = {}

                local DividerFrame = New({
                    ClassName = "Frame",
                    Parent = ContentBoxFrame,
                    Name = "DividerFrame",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1,0,0,5),
                    LayoutOrder = #(ContentBoxFrame:GetChildren()),
                    Visible = true
                })
                local Divider = New({
                    ClassName = "Frame",
                    Parent = DividerFrame,
                    Name = "Divider",
                    BackgroundTransparency = 0.6,
                    BackgroundColor3 = Color3.fromRGB(0,0,0),
                    Size = UDim2.new(0.9,0,0,5),
                    Position = UDim2.fromScale(0.05,0),
                    CornerRadius = 8,
                    Visible = true
                })

                function DividerHolder:SetVisible(Boolean)
                    if Boolean then ContentBox.HiddenElements[DividerFrame] = nil else ContentBox.HiddenElements[DividerFrame] = true end
                    DividerFrame.Visible = Boolean and not IsMinimized
                end

                function DividerHolder:Destroy()
                    DividerFrame:Destroy()
                end

                return DividerHolder
            end

            function ContentBox:AddImage(GivenTable)
                local ImageHolder = {}

                local ImageFrame = New({
                    ClassName = "Frame",
                    Parent = ContentBoxFrame,
                    Name = "ImageFrame",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1,0,0,GivenTable.ImageHeight or 230),
                    LayoutOrder = #(ContentBoxFrame:GetChildren()),
                    Visible = true
                })
                local ImageLabel = New({
                    ClassName = "ImageLabel",
                    Parent = ImageFrame,
                    Name = "ImageLabel",
                    BackgroundTransparency = 0.6,
                    BackgroundColor3 = Color3.fromRGB(0,0,0),
                    Size = UDim2.fromScale(0.9,1),
                    Position = UDim2.fromScale(0.05,0),
                    Image = GivenTable.Image,
                    CornerRadius = 8,
                    Visible = true
                })

                function ImageHolder:SetVisible(Boolean)
                    if Boolean then ContentBox.HiddenElements[ImageFrame] = nil else ContentBox.HiddenElements[ImageFrame] = true end
                    ImageFrame.Visible = Boolean and not IsMinimized
                end

                function ImageHolder:Destroy()
                    ImageLabel:Destroy()
                end

                return ImageHolder
            end

            function ContentBox:AddButton(GivenTable)
                local ButtonHolder = {}

                local ButtonFrame = New({
                    ClassName = "Frame",
                    Parent = ContentBoxFrame,
                    Name = "ButtonFrame",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1,0,0,25),
                    LayoutOrder = #(ContentBoxFrame:GetChildren()),
                    Visible = true
                })
                local Button = New({
                    ClassName = "TextButton",
                    Parent = ButtonFrame,
                    Name = "Button",
                    BackgroundTransparency = 0.6,
                    BackgroundColor3 = Color3.fromRGB(0,0,0),
                    Size = UDim2.new(0.9,0,0,25),
                    Position = UDim2.fromScale(0.05,0),
                    TextScaled = true,
                    TextColor3 = Color3.fromRGB(255,255,255),
                    Text = GivenTable.Text or "Label",
                    CornerRadius = 8,
                    Visible = true
                })
                Button.MouseButton1Click:Connect(GivenTable.Callback)

                function ButtonHolder:SetText(Text)
                    Button.Text = Text or "Button"
                end

                function ButtonHolder:SetDisabled(Boolean)
                    if Boolean then
                        Button.Interactable = false
                        TweenService:Create(Button,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(125,125,125)}):Play()
                    else
                        Button.Interactable = true
                        TweenService:Create(Button,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                    end
                end

                function ButtonHolder:SetVisible(Boolean)
                    if Boolean then ContentBox.HiddenElements[ButtonFrame] = nil else ContentBox.HiddenElements[ButtonFrame] = true end
                    ButtonFrame.Visible = Boolean and not IsMinimized
                end

                function ButtonHolder:Destroy()
                    ButtonFrame:Destroy()
                end

                return ButtonHolder
            end

            function ContentBox:AddToggle(GivenTable)
                local ToggleHolder = {Value = false}

                local ToggleFrame = New({
                    ClassName = "Frame",
                    Parent = ContentBoxFrame,
                    Name = "ToggleFrame",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1,0,0,25),
                    LayoutOrder = #(ContentBoxFrame:GetChildren()),
                    Visible = true
                })
                local ToggleText = New({
                    ClassName = "TextLabel",
                    Parent = ToggleFrame,
                    Name = "ToggleText",
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(0.7,1),
                    Position = UDim2.fromScale(0.05,0),
                    TextColor3 = Color3.fromRGB(255,255,255),
                    TextScaled = true,
                    Text = GivenTable.Text or "Toggle",
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Visible = true
                })
                local ToggleButtonFrame = New({
                    ClassName = "Frame",
                    Parent = ToggleFrame,
                    Name = "ToggleButtonFrame",
                    BackgroundTransparency = 0.6,
                    BackgroundColor3 = Color3.fromRGB(0,0,0),
                    AnchorPoint = Vector2.new(1,0),
                    Size = UDim2.new(0,50,0,25),
                    Position = UDim2.fromScale(0.95,0),
                    CornerRadius = 20,
                    Visible = true
                })
                local SecondToggleButtonFrame = New({
                    ClassName = "Frame",
                    Parent = ToggleButtonFrame,
                    Name = "SecondToggleButtonFrame",
                    BackgroundTransparency = 0,
                    BackgroundColor3 = Color3.fromRGB(255,255,255),
                    Size = UDim2.fromScale(0.5,1),
                    Position = UDim2.fromScale(0,0),
                    CornerRadius = 20,
                    Visible = true
                })

                local IsToggled = false
                if GivenTable.Default then
                    IsToggled = true
                    ToggleButtonFrame.BackgroundColor3 = Color3.fromRGB(125,125,125)
                    SecondToggleButtonFrame.Position = UDim2.fromScale(0.5,0)
                end
                ToggleHolder.Value = IsToggled

                local ToggleButton = New({
                    ClassName = "TextButton",
                    Parent = ToggleButtonFrame,
                    Name = "ToggleButton",
                    BackgroundTransparency = 1,
                    Text = "",
                    Size = UDim2.fromScale(1,1),
                    Visible = true
                })
                ToggleButton.MouseButton1Click:Connect(function()
                    IsToggled = not IsToggled
                    ToggleHolder.Value = IsToggled
                    if IsToggled then
                        TweenService:Create(ToggleButtonFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(125,125,125)}):Play()
                        TweenService:Create(SecondToggleButtonFrame,TweenInfo.new(0.25),{Position = UDim2.fromScale(0.5,0)}):Play()
                    else
                        TweenService:Create(ToggleButtonFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
                        TweenService:Create(SecondToggleButtonFrame,TweenInfo.new(0.25),{Position = UDim2.fromScale(0,0)}):Play()
                    end
                    GivenTable.Callback(IsToggled)
                end)

                function ToggleHolder:SetText(Text)
                    ToggleText.Text = Text or "Toggle"
                end

                function ToggleHolder:SetValue(Boolean)
                    IsToggled = Boolean
                    if IsToggled then
                        TweenService:Create(ToggleButtonFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(125,125,125)}):Play()
                        TweenService:Create(SecondToggleButtonFrame,TweenInfo.new(0.25),{Position = UDim2.fromScale(0.5,0)}):Play()
                    else
                        TweenService:Create(ToggleButtonFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
                        TweenService:Create(SecondToggleButtonFrame,TweenInfo.new(0.25),{Position = UDim2.fromScale(0,0)}):Play()
                    end
                    GivenTable.Callback(IsToggled)
                end

                function ToggleHolder:SetDisabled(Boolean)
                    if Boolean then
                        ToggleButton.Interactable = false
                        TweenService:Create(ToggleText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(125,125,125)}):Play()
                        TweenService:Create(SecondToggleButtonFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(125,125,125)}):Play()
                    else
                        ToggleButton.Interactable = true
                        TweenService:Create(ToggleText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                        TweenService:Create(SecondToggleButtonFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
                    end
                end

                function ToggleHolder:SetVisible(Boolean)
                    if Boolean then ContentBox.HiddenElements[ToggleFrame] = nil else ContentBox.HiddenElements[ToggleFrame] = true end
                    ToggleFrame.Visible = Boolean and not IsMinimized
                end

                function ToggleHolder:Destroy()
                    ToggleFrame:Destroy()
                end

                JustALibrary.Elements[GivenTable.Index or "Toggle"] = ToggleHolder

                return ToggleHolder
            end

            function ContentBox:AddDropdown(GivenTable)
                local DropdownHolder = {}

                local DropdownFrame = New({
                    ClassName = "Frame",
                    Parent = ContentBoxFrame,
                    Name = "DropdownFrame",
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(1,0,0,25),
                    LayoutOrder = #(ContentBoxFrame:GetChildren()),
                    Visible = true
                })
                local DropdownText = New({
                    ClassName = "TextLabel",
                    Parent = DropdownFrame,
                    Name = "DropdownText",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0.75,0,0,25),
                    Position = UDim2.fromScale(0.075,0),
                    TextColor3 = Color3.fromRGB(255,255,255),
                    TextScaled = true,
                    Text = GivenTable.Text or "Dropdown",
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 2,
                    Visible = true
                })
                local DropdownButton = New({
                    ClassName = "TextButton",
                    Parent = DropdownFrame,
                    Name = "DropdownButton",
                    BackgroundTransparency = 0.6,
                    BackgroundColor3 = Color3.fromRGB(0,0,0),
                    Size = UDim2.new(0.9,0,0,25),
                    Position = UDim2.fromScale(0.05,0),
                    Text = "",
                    TextTransparency = 1,
                    CornerRadius = 8,
                    Visible = true
                })
                local DropdownIcon = New({
                    ClassName = "ImageLabel",
                    Parent = DropdownButton,
                    Name = "DropdownIcon",
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(1,0),
                    Size = UDim2.new(0,25,0,25),
                    Position = UDim2.fromScale(0.99,0),
                    Image = Icons.assets["lucide-chevron-down"],
                    Visible = true
                })
                local DropdownValuesFrame = New({
                    ClassName = "Frame",
                    Parent = DropdownFrame,
                    Name = "DropdownValuesFrame",
                    BackgroundTransparency = 0.6,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(0.9,0,0,0),
                    Position = UDim2.new(0.05,0,0,30),
                    CornerRadius = 8,
                    ListLayoutConfig = {
                        Padding = UDim.new(0,5),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center
                    },
                    Visible = false
                })
                local DropdownValuesPadding = Instance.new("UIPadding",DropdownValuesFrame)
                DropdownValuesPadding.PaddingTop = UDim.new(0,5)
                DropdownValuesPadding.PaddingBottom = UDim.new(0,5)
                DropdownValuesPadding.PaddingLeft = UDim.new(0,8)
                DropdownValuesPadding.PaddingRight = UDim.new(0,5)

                local SelectedValue = "" if GivenTable.MultiSelection then SelectedValue = {} end
                DropdownHolder.Value = SelectedValue
                local function CreateValue(GivenName,Selected)
                    local ValueFrame = New({
                        ClassName = "Frame",
                        Parent = DropdownValuesFrame,
                        Name = GivenName,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1,0,0,25),
                        LayoutOrder = #(DropdownValuesFrame:GetChildren()),
                        Visible = true
                    })
                    local ValueText = New({
                        ClassName = "TextLabel",
                        Parent = ValueFrame,
                        Name = "ValueText",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0.85,0,0,25),
                        TextColor3 = Selected and Color3.fromRGB(255,255,255) or Color3.fromRGB(75,75,75),
                        TextScaled = true,
                        Text = GivenName,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Visible = true
                    })
                    local ValueButton = New({
                        ClassName = "TextButton",
                        Parent = ValueFrame,
                        Name = "ValueButton",
                        BackgroundTransparency = 0.6,
                        BackgroundColor3 = Color3.fromRGB(100,100,100),
                        AnchorPoint = Vector2.new(1,0),
                        Size = UDim2.fromOffset(25,25),
                        Position = UDim2.fromScale(0.99,0),
                        Text = "",
                        CornerRadius = 20,
                        Visible = true
                    })
                    local ValueIcon = New({
                        ClassName = "ImageLabel",
                        Parent = ValueButton,
                        Name = "ValueIcon",
                        BackgroundTransparency = 1,
                        ImageTransparency = Selected and 0 or 1,
                        AnchorPoint = Vector2.new(0.5,0.5),
                        Size = UDim2.new(0,20,0,20),
                        Position = UDim2.fromScale(0.5,0.5),
                        Image = Icons.assets["lucide-check"],
                        Visible = true
                    })
                    if Selected then if GivenTable.MultiSelection then table.insert(SelectedValue,GivenName) else SelectedValue = GivenName end DropdownHolder.Value = SelectedValue end 
                    return ValueFrame
                end

                for _,Value in GivenTable.Values or {} do
                    local ValueName if typeof(Value) == "string" then ValueName = Value elseif typeof(Value) == "Instance" then ValueName = Value.Name end
                    local ValueFrame = CreateValue(ValueName,GivenTable.Default == Value or typeof(GivenTable.Default) == "table" and GivenTable.MultiSelection and table.find(GivenTable.Default,Value))
                    ValueFrame.ValueButton.MouseButton1Click:Connect(function()
                        for _,Button in DropdownValuesFrame:GetChildren() do
                            if Button:IsA("Frame") then 
                                if not GivenTable.MultiSelection then
                                    if Button.Name == ValueName then
                                        if SelectedValue ~= Button.Name then
                                            SelectedValue = Button.Name
                                            DropdownHolder.Value = SelectedValue
                                            TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                                            TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 0}):Play()
                                            GivenTable.Callback(SelectedValue)
                                        elseif SelectedValue == Button.Name and GivenTable.CanDeselect then
                                            SelectedValue = nil
                                            DropdownHolder.Value = SelectedValue
                                            TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(75,75,75)}):Play()
                                            TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 1}):Play()
                                            GivenTable.Callback(SelectedValue)
                                        end
                                    else
                                        TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(75,75,75)}):Play()
                                        TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 1}):Play()
                                    end
                                elseif GivenTable.MultiSelection then
                                    if Button.Name == ValueName then
                                        if not table.find(SelectedValue,Button.Name) then
                                            table.insert(SelectedValue,Button.Name)
                                            TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                                            TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 0}):Play()
                                            GivenTable.Callback(SelectedValue)
                                        elseif (table.find(SelectedValue,Button.Name) and #SelectedValue>1) or (table.find(SelectedValue,Button.Name) and GivenTable.CanDeselect) then
                                            local Index = table.find(SelectedValue,Button.Name)
                                            if Index then table.remove(SelectedValue,Index) end
                                            TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(75,75,75)}):Play()
                                            TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 1}):Play()
                                            GivenTable.Callback(SelectedValue)
                                        end
                                    elseif not table.find(SelectedValue,Button.Name) then
                                        TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(75,75,75)}):Play()
                                        TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 1}):Play()
                                    end
                                end
                            end
                        end
                    end)
                end

                DropdownButton.MouseButton1Click:Connect(function()
                    if DropdownValuesFrame.Visible then
                        DropdownValuesFrame.Visible = false
                        TweenService:Create(DropdownIcon,TweenInfo.new(0.25),{Rotation = 0}):Play()
                    else
                        DropdownValuesFrame.Visible = true
                        TweenService:Create(DropdownIcon,TweenInfo.new(0.25),{Rotation = 180}):Play()
                    end
                end)

                function DropdownHolder:SetText(Text)
                    DropdownText.Text = Text or "Dropdown"
                end

                function DropdownHolder:SetValue(Value)
                    if Value and typeof(Value) == "table" and GivenTable.MultiSelection then table.clear(SelectedValue)
                        for _,Values in Value do
                            local ValueName if typeof(Values) == "string" then ValueName = Values elseif typeof(Values) == "Instance" then ValueName = Values.Name end
                            for _,Button in DropdownValuesFrame:GetChildren() do
                                if Button:IsA("Frame") then
                                    if Button.Name == ValueName then
                                        table.insert(SelectedValue,Button.Name)
                                        TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                                        TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 0}):Play()
                                    elseif not table.find(SelectedValue,Button.Name) then
                                        TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(75,75,75)}):Play()
                                        TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 1}):Play()
                                    end
                                end
                            end
                        end
                        GivenTable.Callback(SelectedValue)
                    elseif not GivenTable.MultiSelection then
                        local ValueName if typeof(Value) == "string" then ValueName = Value elseif typeof(Value) == "Instance" then ValueName = Value.Name end
                        for _,Button in DropdownValuesFrame:GetChildren() do
                            if Button:IsA("Frame") then
                                if Button.Name == ValueName then
                                    SelectedValue = Button.Name
                                    DropdownHolder.Value = SelectedValue
                                    TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                                    TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 0}):Play()
                                else
                                    TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(75,75,75)}):Play()
                                    TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 1}):Play()
                                end
                            end
                        end
                        GivenTable.Callback(Value)
                    end
                end

                function DropdownHolder:ReplaceValues(NewValues)
                    if GivenTable.MultiSelection then
                        table.clear(SelectedValue)
                        GivenTable.Callback(SelectedValue)
                    else
                        SelectedValue = nil
                        GivenTable.Callback(SelectedValue)
                    end
                    for _,Button in DropdownValuesFrame:GetChildren() do
                        if Button:IsA("Frame") then Button:Destroy() end
                    end
                    for _,Value in NewValues do
                        local ValueName if typeof(Value) == "string" then ValueName = Value elseif typeof(Value) == "Instance" then ValueName = Value.Name end
                        local ValueFrame = CreateValue(ValueName,GivenTable.Default == Value)
                        ValueFrame.ValueButton.MouseButton1Click:Connect(function()
                            for _,Button in DropdownValuesFrame:GetChildren() do
                                if Button:IsA("Frame") then 
                                    if not GivenTable.MultiSelection then
                                        if Button.Name == ValueName then
                                            if SelectedValue ~= Button.Name then
                                                SelectedValue = Button.Name
                                                DropdownHolder.Value = SelectedValue
                                                TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                                                TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 0}):Play()
                                                GivenTable.Callback(SelectedValue)
                                            elseif SelectedValue == Button.Name and GivenTable.CanDeselect then
                                                SelectedValue = nil
                                                DropdownHolder.Value = SelectedValue
                                                TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(75,75,75)}):Play()
                                                TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 1}):Play()
                                                GivenTable.Callback(SelectedValue)
                                            end
                                        else
                                            TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(75,75,75)}):Play()
                                            TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 1}):Play()
                                        end
                                    elseif GivenTable.MultiSelection then
                                        if Button.Name == ValueName then
                                            if not table.find(SelectedValue,Button.Name) then
                                                table.insert(SelectedValue,Button.Name)
                                                TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                                                TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 0}):Play()
                                                GivenTable.Callback(SelectedValue)
                                            elseif (table.find(SelectedValue,Button.Name) and #SelectedValue > 1) or (table.find(SelectedValue,Button.Name) and GivenTable.CanDeselect) then
                                                local Index = table.find(SelectedValue,Button.Name)
                                                if Index then table.remove(SelectedValue,Index) end
                                                TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(75,75,75)}):Play()
                                                TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 1}):Play()
                                                GivenTable.Callback(SelectedValue)
                                            end
                                        elseif not table.find(SelectedValue,Button.Name) then
                                            TweenService:Create(Button.ValueText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(75,75,75)}):Play()
                                            TweenService:Create(Button.ValueButton.ValueIcon,TweenInfo.new(0.25),{ImageTransparency = 1}):Play()
                                        end
                                    end
                                end
                            end
                        end)
                    end
                end

                function DropdownHolder:GetActiveValues()
                    return SelectedValue
                end

                function DropdownHolder:SetDisabled(Boolean)
                    DropdownValuesFrame.Visible = false
                    if Boolean then
                        DropdownButton.Interactable = false
                        TweenService:Create(DropdownIcon,TweenInfo.new(0.25),{Rotation = 0}):Play()
                        TweenService:Create(DropdownIcon,TweenInfo.new(0.25),{ImageColor3 = Color3.fromRGB(125,125,125)}):Play()
                        TweenService:Create(DropdownText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(125,125,125)}):Play()
                    else
                        DropdownButton.Interactable = true
                        TweenService:Create(DropdownIcon,TweenInfo.new(0.25),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
                        TweenService:Create(DropdownText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(225,225,225)}):Play()
                    end
                    
                end

                function DropdownHolder:SetVisible(Boolean)
                    TweenService:Create(DropdownIcon,TweenInfo.new(0.25),{Rotation = 0}):Play()
                    if Boolean then ContentBox.HiddenElements[DropdownFrame] = nil else ContentBox.HiddenElements[DropdownFrame] = true end
                    DropdownFrame.Visible = Boolean and not IsMinimized
                end

                function DropdownHolder:Destroy()
                    DropdownFrame:Destroy()
                end

                JustALibrary.Elements[GivenTable.Index or "Dropdown"] = DropdownHolder

                return DropdownHolder
            end

            function ContentBox:AddInput(GivenTable)
                local InputHolder = {Value = GivenTable.Default or ""}

                local InputFakeFrame = New({
                    ClassName = "Frame",
                    Parent = ContentBoxFrame,
                    Name = "InputFakeFrame",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1,0,0,50),
                    LayoutOrder = #(ContentBoxFrame:GetChildren()),
                    Visible = true
                })
                local InputName = New({
                    ClassName = "TextLabel",
                    Parent = InputFakeFrame,
                    Name = "InputName",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0.9,0,0,25),
                    Position = UDim2.new(0.05,0,0,0),
                    TextColor3 = Color3.fromRGB(255,255,255),
                    TextScaled = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Text = GivenTable.Text,
                    Visible = true
                })
                local InputFrame = New({
                    ClassName = "Frame",
                    Parent = InputFakeFrame,
                    Name = "InputFrame",
                    BackgroundTransparency = 0.6,
                    BackgroundColor3 = Color3.fromRGB(0,0,0),
                    Size = UDim2.new(0.9,0,0,25),
                    Position = UDim2.new(0.05,0,0,25),
                    CornerRadius = 8,
                    Visible = true
                })
                local Input = New({
                    ClassName = "TextBox",
                    Parent = InputFrame,
                    Name = "Input",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0.9,0,0,25),
                    Position = UDim2.new(0.05,0,0,0),
                    TextColor3 = Color3.fromRGB(255,255,255),
                    TextWrapped = true,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    PlaceholderText = GivenTable.Placeholder or "",
                    ClearTextOnFocus = GivenTable.ClearTextOnFocus or false,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Text = GivenTable.Default or "",
                    Visible = true
                })

                local WaitingForFinish = false
                Input:GetPropertyChangedSignal("Text"):Connect(function()
                    if not GivenTable.Finished then
                        InputHolder.Value = Input.Text
                        GivenTable.Callback(Input.Text)
                    elseif GivenTable.Finished and not WaitingForFinish then
                        WaitingForFinish = true
                        while Input.CursorPosition ~= -1 do task.wait() end
                        InputHolder.Value = Input.Text
                        GivenTable.Callback(Input.Text)
                        WaitingForFinish = false
                    end
                end)

				function InputHolder:SetText(Text)
                    InputName.Text = Text or "Input"
                end

                function InputHolder:SetValue(NewValue)
                    Input.Text = NewValue
                    GivenTable.Callback(Input.Text)
                end

                function InputHolder:SetDisabled(Boolean)
                    if Boolean then
                        Input.Interactable = false
                        TweenService:Create(InputName,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(125,125,125)}):Play()
                        TweenService:Create(Input,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(125,125,125)}):Play()
                    else
                        Input.Interactable = true
                        TweenService:Create(InputName,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                        TweenService:Create(Input,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                    end
                end

                function InputHolder:SetVisible(Boolean)
                    if Boolean then ContentBox.HiddenElements[InputFakeFrame] = nil else ContentBox.HiddenElements[InputFakeFrame] = true end
                    InputFakeFrame.Visible = Boolean and not IsMinimized
                end

                function InputHolder:Destroy()
                    InputFakeFrame:Destroy()
                end

                JustALibrary.Elements[GivenTable.Index or "Input"] = InputHolder

                return InputHolder
            end

            function ContentBox:AddKeyPicker(GivenTable)
                local KeybindHolder = {Value = "None"}

                local KeybindFakeFrame = New({
                    ClassName = "Frame",
                    Parent = ContentBoxFrame,
                    Name = "KeybindFakeFrame",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1,0,0,25),
                    LayoutOrder = #(ContentBoxFrame:GetChildren()),
                    Visible = true
                })
                local KeybindName = New({
                    ClassName = "TextLabel",
                    Parent = KeybindFakeFrame,
                    Name = "KeybindName",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0.7,0,1,0),
                    Position = UDim2.new(0.05,0,0,0),
                    TextColor3 = Color3.fromRGB(255,255,255),
                    TextScaled = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Text = GivenTable.Text or "Keybind",
                    Visible = true
                })
                local KeybindFrame = New({
                    ClassName = "Frame",
                    Parent = KeybindFakeFrame,
                    Name = "KeybindFrame",
                    BackgroundTransparency = 0.6,
                    BackgroundColor3 = Color3.fromRGB(0,0,0),
                    Size = UDim2.new(0.2,0,1,0),
                    Position = UDim2.new(0.75,0,0,0),
                    CornerRadius = 8,
                    Visible = true
                })
                local KeybindButton = New({
                    ClassName = "TextButton",
                    Parent = KeybindFrame,
                    Name = "KeybindButton",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1,0,1,0),
                    TextColor3 = Color3.fromRGB(255,255,255),
                    TextScaled = true,
                    Text = (not GivenTable.Default or table.find(BlacklistedKeys,GivenTable.Default)) and "None" or GivenTable.Default,
                    Visible = true
                })

                local Trigger,IsDisabled,WaitForKey = GivenTable.Default or "None",false
                KeybindHolder.Value = Trigger
                UserInputService.InputBegan:Connect(function(Key,GameProcessed)
                    if GameProcessed or IsDisabled or WaitForKey or Key.KeyCode.Name ~= Trigger then return end GivenTable.Callback()
                end)

                KeybindButton.MouseButton1Click:Connect(function()
                    KeybindButton.Text = "..."
                    WaitForKey = UserInputService.InputBegan:Connect(function(Key,GameProcessed)
                        if not GameProcessed and Key.UserInputType == Enum.UserInputType.Keyboard and not table.find(BlacklistedKeys,Key.KeyCode.Name) then
                            Trigger = Key.KeyCode.Name
                            if Trigger == "Backspace" or Trigger == "Escape" then Trigger = "None" end
                            KeybindHolder.Value = Trigger KeybindButton.Text = Trigger
                            task.wait() WaitForKey:Disconnect() WaitForKey = nil
                        end
                    end)
                end)

				function KeybindHolder:SetText(Text)
                    KeybindName.Text = Text or "Keybind"
                end

                function KeybindHolder:SetValue(Key)
                    if WaitForKey then WaitForKey:Disconnect() end WaitForKey = true
                    if not table.find(BlacklistedKeys,Key) then
                        Trigger = Key
                        if Trigger == "Backspace" or Trigger == "Escape" then Trigger = "None" end
                        KeybindHolder.Value = Trigger KeybindButton.Text = Trigger
                    end task.wait() WaitForKey = nil
                end

                function KeybindHolder:SetDisabled(Boolean)
                    if Boolean then
                        KeybindButton.Interactable = false
                        IsDisabled = true
                        TweenService:Create(KeybindName,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(125,125,125)}):Play()
                        TweenService:Create(KeybindButton,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(125,125,125)}):Play()
                    else
                        KeybindButton.Interactable = true
                        IsDisabled = false
                        TweenService:Create(KeybindName,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                        TweenService:Create(KeybindButton,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                    end
                end

                function KeybindHolder:SetVisible(Boolean)
                    if Boolean then ContentBox.HiddenElements[KeybindFakeFrame] = nil else ContentBox.HiddenElements[KeybindFakeFrame] = true end
                    KeybindFakeFrame.Visible = Boolean and not IsMinimized
                end

                function KeybindHolder:Destroy()
                    KeybindFakeFrame:Destroy()
                end

                JustALibrary.Elements[GivenTable.Index or "Keybind"] = KeybindHolder

                return KeybindHolder
            end

            function ContentBox:AddSlider(GivenTable)

            end

            return ContentBox
        end

        table.insert(JustALibrary.Tabs,Tab)

        return Tab
    end

    return Window
end

function SetupSaveManager(GivenTable)
    if not isfolder or not makefolder or not isfile or not listfiles or not readfile or not writefile or not delfile then return end
    local SaveManager,ConfigName,ImportMode,ImportJSONCode,SelectedConfig,ConfigsDropdown = {},"Config",false
    if not GivenTable.Tab or not table.find(JustALibrary.Tabs,GivenTable.Tab) or not GivenTable.MainFolderName then return end
    local MainFolder = isfolder(GivenTable.MainFolderName)
    if not MainFolder then makefolder(GivenTable.MainFolderName) end
    if GivenTable.Autoload and isfile(GivenTable.MainFolderName.."/Autoload.lib") then
        local AutoloadConfigName = loadfile(GivenTable.MainFolderName.."/Autoload.lib")()
        if AutoloadConfigName then
            local FilesPath = listfiles(GivenTable.MainFolderName)
            for _,Path in FilesPath do
                if string.match(Path,"([^/\\]+)$") == AutoloadConfigName then
                    local ConfigData = HttpService:JSONDecode(readfile(GivenTable.MainFolderName.."/"..AutoloadConfigName))
                    for Index,Elements in JustALibrary.Elements do
                        if ConfigData[Index] and ConfigData[Index].Name == Index then task.spawn(function() Elements:SetValue(ConfigData[Index].Value) end) end
                    end
                    JustALibrary:Notify({
                        Title = "Save manager",
                        Content = "Loaded config: "..AutoloadConfigName,
                        Sound = 107396133526484
                    }) break
                end
            end
        end
    end
    local function RefreshList()
        local FilesPath,FilesList = listfiles(GivenTable.MainFolderName),{}
        for _,Path in FilesPath do
            if string.match(Path,"([^/\\]+)$") ~= "Autoload.lib" then print(_,Path,string.match(Path,"([^/\\]+)$")) table.insert(FilesList,string.match(Path,"([^/\\]+)$")) end
        end ConfigsDropdown:ReplaceValues(FilesList)
    end
    local SaveManagerContentBox = GivenTable.Tab:AddContentBox({Name = "Save manager",Side = "Right"})
    SaveManagerContentBox:AddInput({
        Text = "Config name",
        Index = "SaveManagerConfigName",
        Placeholder = "Config name here...",
        Finished = true,
        Callback = function(Value) ConfigName = Value end
    })
    SaveManagerContentBox:AddButton({
        Text = "Create config",
        Callback = function()
            if ImportMode and ImportJSONCode then
                writefile(GivenTable.MainFolderName.."/"..ConfigName..".lib",ImportJSONCode)
            else
                local Config = {}
                for Index,Elements in JustALibrary.Elements do
                    if Index ~= "SaveManagerConfigName" and Index ~= "SaveManagerConfigsList" and Index ~= "SaveManagerImportMode" and Index ~= "SaveManagerJSONCode" then
                        if GivenTable.FilterIndexMode and GivenTable.FilterIndex then
                            if GivenTable.FilterIndexMode == "Exclude" and not table.find(GivenTable.FilterIndex,Index) then
                                Config[Index] = {Name = Index,Value = Elements.Value}
                            elseif GivenTable.FilterIndexMode == "Selected" and table.find(GivenTable.FilterIndex,Index) then
                                Config[Index] = {Name = Index,Value = Elements.Value}
                            end
                        else
                            Config[Index] = {Name = Index,Value = Elements.Value}
                        end
                    end
                end writefile(GivenTable.MainFolderName.."/"..ConfigName..".lib",HttpService:JSONEncode(Config))
            end RefreshList()
        end
    })
    SaveManagerContentBox:AddToggle({
        Text = "Import",
        Index = "SaveManagerImportMode",
        Callback = function(Value)
            ImportMode = Value
            JustALibrary.Elements["SaveManagerJSONCode"]:SetVisible(ImportMode)
        end
    })
    SaveManagerContentBox:AddInput({
        Text = "JSON Code",
        Index = "SaveManagerJSONCode",
        Placeholder = "JSON here...",
        Finished = true,
        Callback = function(Value) ImportJSONCode = Value end
    })
    JustALibrary.Elements["SaveManagerJSONCode"]:SetVisible(false)
    SaveManagerContentBox:AddDivider()
    ConfigsDropdown = SaveManagerContentBox:AddDropdown({
        Text = "Configs list",
        Index = "SaveManagerConfigsList",
        MaxVisibleValues = "Auto",
        Callback = function(Value) SelectedConfig = tostring(Value) end
    })
    SaveManagerContentBox:AddButton({
        Text = "Force refresh list",
        Callback = RefreshList
    })
    SaveManagerContentBox:AddDivider()
    SaveManagerContentBox:AddButton({
        Text = "Load config",
        Callback = function()
            if not isfile(GivenTable.MainFolderName.."/"..SelectedConfig) then return end
            local ConfigData = HttpService:JSONDecode(readfile(GivenTable.MainFolderName.."/"..SelectedConfig))
            for Index,Elements in JustALibrary.Elements do
                if ConfigData[Index] and ConfigData[Index].Name == Index then
                    Elements:SetValue(ConfigData[Index].Value)
                end
            end
            JustALibrary:Notify({
                Title = "Save manager",
                Content = "Loaded config: "..SelectedConfig,
                Sound = 107396133526484
            })
        end
    })
    SaveManagerContentBox:AddButton({
        Text = "Set as autoload",
        Callback = function()
            if not SelectedConfig then return end writefile(GivenTable.MainFolderName.."/Autoload.lib","return '"..SelectedConfig.."'")
        end
    })
    SaveManagerContentBox:AddButton({
        Text = "Export (Copy JSON)",
        Callback = function()
            if not SelectedConfig or not setclipboard then return end setclipboard(readfile(GivenTable.MainFolderName.."/"..SelectedConfig))
        end
    })
    SaveManagerContentBox:AddButton({
        Text = "Delete config",
        Callback = function()
            if not SelectedConfig then return end delfile(GivenTable.MainFolderName.."/"..SelectedConfig) RefreshList()
        end
    })
    SaveManagerContentBox:AddDivider()
    SaveManagerContentBox:AddButton({
        Text = "Reset autoload",
        Callback = function() if isfile(GivenTable.MainFolderName.."/Autoload.lib") then delfile(GivenTable.MainFolderName.."/Autoload.lib") end end
    }) RefreshList()
end return JustALibrary
