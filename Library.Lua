while not game:IsLoaded() do task.wait() end

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local P = game:GetService("Players")
local LocalPlayer = P.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CoreGui = game:GetService("CoreGui")

local Icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vector3-new/MyLibrary/refs/heads/main/Icons.Lua"))()

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
    "Slash",
    "Backspace",
    "Escape"
}

local JustAnLibrary = {}

local JustAnLibraryGUI = CoreGui:FindFirstChild("JustAnLibrary")
if JustAnLibraryGUI then JustAnLibraryGUI:Destroy() end
JustAnLibraryGUI = Instance.new("ScreenGui",CoreGui)
JustAnLibraryGUI.Name = "JustAnLibrary"

local NotificationsHolder = Instance.new("Frame",JustAnLibraryGUI)
NotificationsHolder.BackgroundTransparency = 1
NotificationsHolder.AnchorPoint = Vector2.new(1,1)
NotificationsHolder.Position = UDim2.new(1,-10,1,-10)
NotificationsHolder.Size = UDim2.new(0,300,1,0)
local NotificationsHolderList = Instance.new("UIListLayout",NotificationsHolder)
NotificationsHolderList.Padding = UDim.new(0,5)
NotificationsHolderList.VerticalAlignment = Enum.VerticalAlignment.Bottom

    --[[
        :Notify({
            Title = "Notification",
            Content = "Hello World!",
            Sound = nil,
            SoundVolume = 0.5,
            Time = 3
        })
    ]]

function JustAnLibrary:Notify(GivenTable)
    local NotificationFakeFrame = Instance.new("Frame",NotificationsHolder)
    NotificationFakeFrame.BackgroundTransparency = 1
    NotificationFakeFrame.Size = UDim2.new(1,0,0,100)
    local NotificationFrame = Instance.new("Frame",NotificationFakeFrame)
    NotificationFrame.BackgroundTransparency = 0.6
    NotificationFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    NotificationFrame.Position = UDim2.fromScale(1.1,0)
    NotificationFrame.Size = UDim2.new(1,0,0,0)
    NotificationFrame.AutomaticSize = Enum.AutomaticSize.Y
    local NotificationTitle = Instance.new("TextLabel",NotificationFrame)
    NotificationTitle.BackgroundTransparency = 1
    NotificationTitle.Position = UDim2.fromOffset(10,0)
    NotificationTitle.Size = UDim2.fromOffset(280,25)
    NotificationTitle.TextColor3 = Color3.fromRGB(255,255,255)
    NotificationTitle.TextScaled = true
    NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotificationTitle.Text = GivenTable.Title or "Notification"
    local NotificationContent = Instance.new("TextLabel",NotificationFrame)
    NotificationContent.BackgroundTransparency = 1
    NotificationContent.Position = UDim2.fromOffset(10,25)
    NotificationContent.Size = UDim2.fromOffset(280,0)
    NotificationContent.AutomaticSize = Enum.AutomaticSize.Y
    NotificationContent.TextColor3 = Color3.fromRGB(200,200,200)
    NotificationContent.TextWrap = true
    NotificationContent.TextXAlignment = Enum.TextXAlignment.Left
    NotificationContent.Text = GivenTable.Content or "Hello World!"
    local NotificationCorner = Instance.new("UICorner",NotificationFrame)
    if GivenTable.Sound then
        local NotificationSound = Instance.new("Sound",NotificationFrame)
        NotificationSound.SoundId = "rbxassetid://"..GivenTable.Sound
        if GivenTable.SoundVolume then NotificationSound.SoundVolume = GivenTable.SoundVolume end
        NotificationSound:Play()
    end
    NotificationFrame.Size = UDim2.new(1,0,0,NotificationFrame.AbsoluteSize.Y+3)
    NotificationFakeFrame.Size = NotificationFrame.Size
    TweenService:Create(NotificationFrame,TweenInfo.new(0.75,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position = UDim2.fromScale(0,0)}):Play()
    task.wait(GivenTable.Time or 3)
    TweenService:Create(NotificationFrame,TweenInfo.new(0.75,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position = UDim2.fromScale(1.1,0)}):Play()
    task.wait(0.75);NotificationFakeFrame:Destroy()
end

function JustAnLibrary:CreateWindow(GivenTable)
    local WindowFrame = Instance.new("Frame",JustAnLibraryGUI)
    WindowFrame.Name = GivenTable.Title or "Window"
    WindowFrame.Size = GivenTable.Size or UDim2.fromOffset(650,550)
    WindowFrame.Position = UDim2.new(0.5,-WindowFrame.Size.X.Offset/2,0.5,-WindowFrame.Size.Y.Offset/2)
    WindowFrame.BackgroundTransparency = 1
    local WindowCorner = Instance.new("UICorner",WindowFrame)

    local WindowTabsDividerFrame = Instance.new("Frame",WindowFrame)
    WindowTabsDividerFrame.Name = "TabsDivider"
    WindowTabsDividerFrame.Position = UDim2.new(0.26,0,0,-60)
    WindowTabsDividerFrame.Size = UDim2.new(0.01,0,0,50)
    WindowTabsDividerFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    WindowTabsDividerFrame.BackgroundTransparency = 0.6
    local WindowTitleCorner = Instance.new("UICorner",WindowTabsDividerFrame)

    local SecondWindowTabsDividerFrame = WindowTabsDividerFrame:Clone()
    SecondWindowTabsDividerFrame.Parent = WindowFrame
    SecondWindowTabsDividerFrame.Name = "SecondTabsDivider"
    SecondWindowTabsDividerFrame.Position = UDim2.new(0.89,0,0,-60)

    local WindowTabsFrame = Instance.new("ScrollingFrame",WindowFrame)
    WindowTabsFrame.Name = "TabsFrame"
    WindowTabsFrame.BackgroundTransparency = 1
    WindowTabsFrame.Position = UDim2.new(0.28,0,0,-60)
    WindowTabsFrame.Size = UDim2.new(0.6,0,0,50)
    WindowTabsFrame.ScrollBarThickness = 0
    WindowTabsFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
    WindowTabsFrame.ScrollingDirection = Enum.ScrollingDirection.X
    local WindowTabsListLayout = Instance.new("UIListLayout",WindowTabsFrame)
    WindowTabsListLayout.Padding = UDim.new(0,10)
    WindowTabsListLayout.FillDirection = Enum.FillDirection.Horizontal
    WindowTabsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    local WindowTitleFrame = Instance.new("Frame",WindowFrame)
    WindowTitleFrame.Name = "Title"
    WindowTitleFrame.Size = UDim2.new(0.25,0,0,50)
    WindowTitleFrame.Position = UDim2.new(0,0,0,-60)
    WindowTitleFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    WindowTitleFrame.BackgroundTransparency = 0.6
    local WindowTitleCorner = Instance.new("UICorner",WindowTitleFrame)

    local WindowTitleLabel = Instance.new("TextLabel",WindowTitleFrame)
    WindowTitleLabel.BackgroundTransparency = 1
    WindowTitleLabel.Size = UDim2.fromScale(1,1)
    WindowTitleLabel.TextScaled = true
    WindowTitleLabel.TextColor3 = Color3.fromRGB(255,255,255)
    WindowTitleLabel.Text = GivenTable.Title or "Window"

    local WindowTitleButton = Instance.new("TextButton",WindowTitleFrame)
    WindowTitleButton.BackgroundTransparency = 1
    WindowTitleButton.TextTransparency = 1
    WindowTitleButton.Size = UDim2.fromScale(1,1)
    WindowTitleButton.MouseButton1Click:Connect(function()
        for _,TabFrames in WindowTabsFrame:GetChildren() do
            if TabFrames:IsA("Frame") then
                WindowFrame[TabFrames.Name].Visible = false
                TweenService:Create(TabFrames,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
            end
        end
        TweenService:Create(WindowTitleFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(125,125,125)}):Play()
        task.wait(0.3)
        TweenService:Create(WindowTitleFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
    end)

    local WindowNotificationsFrame = WindowTitleFrame:Clone()
    WindowNotificationsFrame.TextLabel.Text = "Notifications"
    WindowNotificationsFrame.TextLabel.Size = UDim2.fromScale(0.9,0.9)
    WindowNotificationsFrame.TextLabel.Position = UDim2.fromScale(0.05,0.05)
    WindowNotificationsFrame.Parent = WindowFrame
    WindowNotificationsFrame.Name = "Notifications"
    WindowNotificationsFrame.Size = UDim2.new(0.09,0,0,50)
    WindowNotificationsFrame.Position = UDim2.new(0.91,0,0,-60)

    local WindowNotificationsContentFrame = Instance.new("ScrollingFrame",WindowFrame)
    WindowNotificationsContentFrame.Name = "NotificationsFrame"
    WindowNotificationsContentFrame.Size = UDim2.fromOffset(200,WindowFrame.Size.Y.Offset-50)
    WindowNotificationsContentFrame.Position = UDim2.fromOffset(WindowFrame.Size.X.Offset+10,0)
    WindowNotificationsContentFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    WindowNotificationsContentFrame.BackgroundTransparency = 0.6
    WindowNotificationsContentFrame.ScrollBarThickness = 0
    WindowNotificationsContentFrame.CanvasSize = UDim2.fromScale(0,0)
    WindowNotificationsContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    WindowNotificationsContentFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    WindowNotificationsContentFrame.Visible = false
    local WindowNotificationsContentCorner = Instance.new("UICorner",WindowNotificationsContentFrame)
    local WindowNotificationsContentListLayout = Instance.new("UIListLayout",WindowNotificationsContentFrame)
    WindowNotificationsContentListLayout.Padding = UDim.new(0,5)
    WindowNotificationsContentListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    NotificationsHolder.ChildAdded:Connect(function(Notification)
        NewNotification = Notification:Clone()
        if NewNotification.Frame:FindFirstChild("Sound") then NewNotification.Frame.Sound:Destroy() end
        NewNotification.Parent = WindowNotificationsContentFrame
        NewNotification.LayoutOrder = #(WindowNotificationsContentFrame:GetChildren())
        NewNotification.Frame.Position = UDim2.fromScale(-1.1,0)
        for _,Labels in NewNotification.Frame:GetChildren() do if Labels:IsA("TextLabel") then Labels.Size = UDim2.fromOffset(180,25) end end
        TweenService:Create(NewNotification.Frame,TweenInfo.new(0.75,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position = UDim2.fromScale(0,0)}):Play()
    end)

    local WindowNotificationsClearAllButton = Instance.new("TextButton",WindowFrame)
    WindowNotificationsClearAllButton.BackgroundTransparency = 0.6
    WindowNotificationsClearAllButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
    WindowNotificationsClearAllButton.Visible = false
    WindowNotificationsClearAllButton.Size = UDim2.fromOffset(200,40)
    WindowNotificationsClearAllButton.Position = UDim2.fromOffset(WindowFrame.Size.X.Offset+10,WindowFrame.Size.Y.Offset-40)
    WindowNotificationsClearAllButton.TextScaled = true
    WindowNotificationsClearAllButton.TextColor3 = Color3.fromRGB(255,255,255)
    WindowNotificationsClearAllButton.Text = "Clear All"
    local WindowNotificationsClearAllCorner = Instance.new("UICorner",WindowNotificationsClearAllButton)

    local NotifyMenuVisible = false

    WindowNotificationsFrame.TextButton.MouseButton1Click:Connect(function()
        if NotifyMenuVisible then
            NotifyMenuVisible = false
            WindowNotificationsContentFrame.Visible = false
            WindowNotificationsClearAllButton.Visible = false
            TweenService:Create(WindowNotificationsFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
        else
            NotifyMenuVisible = true
            WindowNotificationsContentFrame.Visible = true
            WindowNotificationsClearAllButton.Visible = true
            TweenService:Create(WindowNotificationsFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(125,125,125)}):Play()
        end
    end)

    WindowNotificationsClearAllButton.MouseButton1Click:Connect(function()
        for _,Notifications in WindowNotificationsContentFrame:GetChildren() do
            if Notifications:IsA("Frame") then
                TweenService:Create(Notifications.Frame,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position = UDim2.fromScale(1.5,0)}):Play()
                task.spawn(function() task.wait(0.75);Notifications:Destroy() end);task.wait(0.05)
            end
        end
    end)

    local Window = {}

    function Window:AddTab(GivenTable)

        local TabContent = {}

        local TabFrame = Instance.new("Frame",WindowTabsFrame)
        TabFrame.Name = GivenTable.Name or "Tab"
        TabFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
        TabFrame.BackgroundTransparency = 0.6
        TabFrame.Size = UDim2.fromOffset(150,50)
        TabFrame.LayoutOrder = #(WindowTabsFrame:GetChildren())

        local TabLabel = Instance.new("TextLabel",TabFrame)
        TabLabel.BackgroundTransparency = 1
        TabLabel.TextColor3 = Color3.fromRGB(255,255,255)
        TabLabel.TextScaled = true
        TabLabel.Text = GivenTable.Name or "Tab"
        if GivenTable.Icon then
            TabLabel.Size = UDim2.fromOffset(90,25)
            TabLabel.Position = UDim2.fromOffset(45,12)
            local TabIcon = Instance.new("ImageLabel",TabFrame)
            TabIcon.BackgroundTransparency = 1
            TabIcon.Position = UDim2.fromOffset(10,10)
            TabIcon.Size = UDim2.fromOffset(30,30)
            TabIcon.Image = GivenTable.Icon
        else
            TabLabel.Size = UDim2.fromOffset(130,25)
            TabLabel.Position = UDim2.fromOffset(10,12)
        end

        local TabCorner = Instance.new("UICorner",TabFrame)
        local TabContentFrame = Instance.new("Frame",WindowFrame)
        TabContentFrame.Name = GivenTable.Name or "Tab"
        TabContentFrame.BackgroundTransparency = 0.6
        TabContentFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
        TabContentFrame.Size = UDim2.fromScale(1,1)
        TabContentFrame.Visible = false
        local TabContentCorner = Instance.new("UICorner",TabContentFrame)

        local TabButton = Instance.new("TextButton",TabFrame)
        TabButton.BackgroundTransparency = 1
        TabButton.TextTransparency = 1
        TabButton.Size = UDim2.fromScale(1,1)
        TabButton.MouseButton1Click:Connect(function()
            for _,TabFrames in WindowTabsFrame:GetChildren() do
                if TabFrames:IsA("Frame") and TabFrames == TabButton.Parent then
                    WindowFrame[TabFrames.Name].Visible = true
                    TweenService:Create(TabFrames,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(125,125,125)}):Play()
                elseif TabFrames:IsA("Frame") then
                    WindowFrame[TabFrames.Name].Visible = false
                    TweenService:Create(TabFrames,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
                end
            end
        end)

        local TabContentScrollingFrame = Instance.new("ScrollingFrame",TabContentFrame)
        TabContentScrollingFrame.Name = "LeftScrollingFrame"
        TabContentScrollingFrame.Size = UDim2.fromScale(0.47,0.95)
        TabContentScrollingFrame.Position = UDim2.fromScale(0.025,0.025)
        TabContentScrollingFrame.BackgroundTransparency = 1
        TabContentScrollingFrame.ScrollBarThickness = 0
        TabContentScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
        TabContentScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabContentScrollingFrame.CanvasSize = UDim2.fromScale(0,0)
        local TabContentScrollingLayout = Instance.new("UIListLayout",TabContentScrollingFrame)
        TabContentScrollingLayout.Padding = UDim.new(0,8)
        TabContentScrollingLayout.SortOrder = Enum.SortOrder.LayoutOrder
        local SecondTabContentScrollingFrame = TabContentScrollingFrame:Clone()
        SecondTabContentScrollingFrame.Parent = TabContentFrame
        SecondTabContentScrollingFrame.Name = "RightScrollingFrame"
        SecondTabContentScrollingFrame.Size = UDim2.fromScale(0.47,0.95)
        SecondTabContentScrollingFrame.Position = UDim2.fromScale(0.505,0.025)

        function TabContent:AddContentBox(GivenTable)

            local ContentBox = {}

            local ContentBoxFrame = Instance.new("Frame")
            ContentBoxFrame.Name = GivenTable.Name
            ContentBoxFrame.Size = UDim2.new(1,0,0,50)
            ContentBoxFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
            ContentBoxFrame.BackgroundTransparency = 0.6
            if GivenTable.Side == "Right" then
                ContentBoxFrame.Parent = SecondTabContentScrollingFrame
            elseif GivenTable.Side == "Left" then
                ContentBoxFrame.Parent = TabContentScrollingFrame
            end
            ContentBoxFrame.LayoutOrder = #(ContentBoxFrame.Parent:GetChildren())
            local ContentBoxCorner = Instance.new("UICorner",ContentBoxFrame)
            local ContentBoxLayout = Instance.new("UIListLayout",ContentBoxFrame)
            ContentBoxLayout.Padding = UDim.new(0,8)
            ContentBoxLayout.SortOrder = Enum.SortOrder.LayoutOrder

            local ContentBoxTitle = Instance.new("TextLabel",ContentBoxFrame)
            ContentBoxTitle.BackgroundColor3 = Color3.fromRGB(0,0,0)
            ContentBoxTitle.BackgroundTransparency = 0.6
            ContentBoxTitle.Size = UDim2.new(1,0,0,25)
            ContentBoxTitle.TextScaled = true
            ContentBoxTitle.TextColor3 = Color3.fromRGB(255,255,255)
            ContentBoxTitle.Text = GivenTable.Name or "ContentBox"
            ContentBoxTitle.LayoutOrder = -1
            local ContentBoxTitleCorner = Instance.new("UICorner",ContentBoxTitle)

            function ContentBox:Resize()
                local TotalSize = 0
                for _, Elements in ContentBoxFrame:GetChildren() do
                    if (Elements:IsA("Frame") or Elements:IsA("TextLabel")) and Elements.Visible then TotalSize += Elements.Size.Y.Offset + 8 end
                end
                ContentBoxFrame.Size = UDim2.new(1,0,0,TotalSize)
            end

            function ContentBox:AddLabel(Text)
                local LabelHolder = {}

                local LabelFrame = Instance.new("Frame",ContentBoxFrame)
                LabelFrame.BackgroundTransparency = 1
                LabelFrame.Size = UDim2.new(1,0,0,25)
                LabelFrame.LayoutOrder = #(ContentBoxFrame:GetChildren())

                local Label = Instance.new("TextLabel",LabelFrame)
                Label.BackgroundTransparency = 1
                Label.Size = UDim2.new(0.9,0,0,25)
                Label.Position = UDim2.fromScale(0.05,0)
                Label.TextScaled = true
                Label.RichText = true
                Label.TextColor3 = Color3.fromRGB(255,255,255)
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Text = Text or "Label"

                ContentBox:Resize()

                function LabelHolder:SetText(Text)
                    Label.Text = Text or "Label"
                end

                function LabelHolder:SetVisible(Boolean)
                    LabelFrame.Visible = Boolean
                    ContentBox:Resize()
                end

                function LabelHolder:Destroy()
                    LabelFrame:Destroy()
                    ContentBox:Resize()
                end

                return LabelHolder

            end

            function ContentBox:AddDivider()
                local DividerHolder = {}

                local DividerFrame = Instance.new("Frame",ContentBoxFrame)
                DividerFrame.BackgroundTransparency = 1
                DividerFrame.Size = UDim2.new(1,0,0,5)
                DividerFrame.LayoutOrder = #(ContentBoxFrame:GetChildren())

                local Divider = Instance.new("Frame",DividerFrame)
                Divider.BackgroundTransparency = 0.6
                Divider.BackgroundColor3 = Color3.fromRGB(0,0,0)
                Divider.Size = UDim2.new(0.9,0,0,5)
                Divider.Position = UDim2.fromScale(0.05,0)

                local DividerCorner = Instance.new("UICorner",Divider)

                ContentBox:Resize()

                function DividerHolder:SetVisible(Boolean)
                    DividerFrame.Visible = Boolean
                    ContentBox:Resize()
                end

                function DividerHolder:Destroy()
                    DividerFrame:Destroy()
                    ContentBox:Resize()
                end

                return DividerHolder

            end

            function ContentBox:AddImage(GivenTable)
                local ImageHolder = {}

                local ImageFrame = Instance.new("Frame",ContentBoxFrame)
                ImageFrame.BackgroundTransparency = 1
                ImageFrame.Size = UDim2.new(1,0,0,GivenTable.ImageHeight or 230)
                ImageFrame.LayoutOrder = #(ContentBoxFrame:GetChildren())

                local ImageLabel = Instance.new("ImageLabel",ImageFrame)
                ImageLabel.BackgroundTransparency = 0.6
                ImageLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
                ImageLabel.Size = UDim2.fromScale(0.9,1)
                ImageLabel.Position = UDim2.fromScale(0.05,0)
                ImageLabel.Image = GivenTable.Image
                local ImageLabelCorner = Instance.new("UICorner",ImageLabel)

                ContentBox:Resize()

                function ImageHolder:SetVisible(Boolean)
                    ImageLabel.Visible = Boolean
                    ContentBox:Resize()
                end

                function ImageHolder:Destroy()
                    ImageLabel:Destroy()
                    ContentBox:Resize()
                end

                return ImageHolder

            end

            --[[
                :AddButton({
                    Text = "Button",
                    Callback = function() end
                })
            ]]

            function ContentBox:AddButton(GivenTable)
                local ButtonHolder = {}

                local ButtonFrame = Instance.new("Frame",ContentBoxFrame)
                ButtonFrame.BackgroundTransparency = 1
                ButtonFrame.Size = UDim2.new(1,0,0,25)
                ButtonFrame.LayoutOrder = #(ContentBoxFrame:GetChildren())

                local Button = Instance.new("TextButton",ButtonFrame)
                Button.BackgroundTransparency = 0.6
                Button.BackgroundColor3 = Color3.fromRGB(0,0,0)
                Button.Size = UDim2.new(0.9,0,0,25)
                Button.Position = UDim2.fromScale(0.05,0)
                Button.TextScaled = true
                Button.TextColor3 = Color3.fromRGB(255,255,255)
                Button.Text = GivenTable.Text or "Label"

                local ButtonCorner = Instance.new("UICorner",Button)

                Button.MouseButton1Click:Connect(GivenTable.Callback)

                ContentBox:Resize()

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
                    ButtonFrame.Visible = Boolean
                    ContentBox:Resize()
                end

                function ButtonHolder:Destroy()
                    ButtonFrame:Destroy()
                    ContentBox:Resize()
                end

                return ButtonHolder

            end

            --[[
                :AddToggle({
                    Text = "Toggle",
                    Default = false,
                    Callback = function() end
                })
            ]]

            function ContentBox:AddToggle(GivenTable)
                local ToggleHolder = {}

                local ToggleFrame = Instance.new("Frame",ContentBoxFrame)
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.Size = UDim2.new(1,0,0,25)
                ToggleFrame.LayoutOrder = #(ContentBoxFrame:GetChildren())

                local ToggleText = Instance.new("TextLabel",ToggleFrame)
                ToggleText.BackgroundTransparency = 1
                ToggleText.Size = UDim2.fromScale(0.7,1)
                ToggleText.Position = UDim2.fromScale(0.05,0)
                ToggleText.TextColor3 = Color3.fromRGB(255,255,255)
                ToggleText.TextScaled = true
                ToggleText.Text = GivenTable.Text or "Toggle"
                ToggleText.TextXAlignment = Enum.TextXAlignment.Left

                local ToggleButtonFrame = Instance.new("Frame",ToggleFrame)
                ToggleButtonFrame.BackgroundTransparency = 0.6
                ToggleButtonFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
                ToggleButtonFrame.Size = UDim2.new(0.2,0,0,25)
                ToggleButtonFrame.Position = UDim2.fromScale(0.75,0)
                local ToggleButtonFrameCorner = Instance.new("UICorner",ToggleButtonFrame)

                local SecondToggleButtonFrame = ToggleButtonFrame:Clone()
                SecondToggleButtonFrame.Parent = ToggleButtonFrame
                SecondToggleButtonFrame.Size = UDim2.fromScale(0.5,1)
                SecondToggleButtonFrame.Position = UDim2.fromScale(0,0)
                SecondToggleButtonFrame.BackgroundTransparency = 0
                SecondToggleButtonFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)

                local IsToggled = false
                if GivenTable.Default then
                    IsToggled = true
                    SecondToggleButtonFrame.Position = UDim2.fromScale(0.5,0)
                end

                local ToggleButton = Instance.new("TextButton",ToggleButtonFrame)
                ToggleButton.BackgroundTransparency = 1
                ToggleButton.TextTransparency = 1
                ToggleButton.Size = UDim2.fromScale(1,1)

                ToggleButton.MouseButton1Click:Connect(function()
                    IsToggled = not IsToggled
                    GivenTable.Callback(IsToggled)
                    if IsToggled then
                        TweenService:Create(ToggleButtonFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(125,125,125)}):Play()
                        TweenService:Create(SecondToggleButtonFrame,TweenInfo.new(0.25),{Position = UDim2.fromScale(0.5,0)}):Play()
                    else
                        TweenService:Create(ToggleButtonFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
                        TweenService:Create(SecondToggleButtonFrame,TweenInfo.new(0.25),{Position = UDim2.fromScale(0,0)}):Play()
                    end
                end)

                ContentBox:Resize()

                function ToggleHolder:SetText(Text)
                    ToggleText.Text = Text or "Toggle"
                end

                function ToggleHolder:SetValue(Boolean)
                    IsToggled = Boolean
                    GivenTable.Callback(IsToggled)
                    if IsToggled then
                        TweenService:Create(ToggleButtonFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(125,125,125)}):Play()
                        TweenService:Create(SecondToggleButtonFrame,TweenInfo.new(0.25),{Position = UDim2.fromScale(0.5,0)}):Play()
                    else
                        TweenService:Create(ToggleButtonFrame,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
                        TweenService:Create(SecondToggleButtonFrame,TweenInfo.new(0.25),{Position = UDim2.fromScale(0,0)}):Play()
                    end
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
                    ToggleFrame.Visible = Boolean
                    ContentBox:Resize()
                end

                function ToggleHolder:Destroy()
                    ToggleFrame:Destroy()
                    ContentBox:Resize()
                end

                return ToggleHolder

            end

            --[[
                :AddDropdown({
                    Text = "Dropdown",
                    Values = {},
                    Default = nil,
                    MaxVisibleValues = 2,
                    MultiSelection = true, --returns table
                    Callback = function() end
                })
            ]]

            function ContentBox:AddDropdown(GivenTable)
                local DropdownHolder = {}

                local DropdownFrame = Instance.new("Frame",ContentBoxFrame)
                DropdownFrame.BackgroundTransparency = 1
                DropdownFrame.Size = UDim2.new(1,0,0,25)
                DropdownFrame.LayoutOrder = #(ContentBoxFrame:GetChildren())

                local DropdownText = Instance.new("TextLabel",DropdownFrame)
                DropdownText.BackgroundTransparency = 1
                DropdownText.Size = UDim2.fromScale(0.9,1)
                DropdownText.Position = UDim2.fromScale(0.075,0)
                DropdownText.TextColor3 = Color3.fromRGB(255,255,255)
                DropdownText.TextScaled = true
                DropdownText.Text = GivenTable.Text or "Dropdown"
                DropdownText.TextXAlignment = Enum.TextXAlignment.Left
                DropdownText.ZIndex = 2

                local DropdownButton = Instance.new("TextButton",DropdownFrame)
                DropdownButton.BackgroundTransparency = 0.6
                DropdownButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
                DropdownButton.Size = UDim2.new(0.9,0,0,25)
                DropdownButton.Position = UDim2.fromScale(0.05,0)
                DropdownButton.TextTransparency = 1
                local DropdownButtonCorner = Instance.new("UICorner",DropdownButton)

                local DropdownIcon = Instance.new("ImageLabel",DropdownButton)
                DropdownIcon.BackgroundTransparency = 1
                DropdownIcon.Size = UDim2.new(0.1,0,0,25)
                DropdownIcon.Position = UDim2.fromScale(0.89,0)
                DropdownIcon.Image = Icons.assets["lucide-chevron-down"]

                local DropdownValuesFrame = Instance.new("ScrollingFrame",DropdownFrame)
                DropdownValuesFrame.Size = UDim2.new(0.9,0,0,(GivenTable.MaxVisibleValues or 2)*25+(GivenTable.MaxVisibleValues or 2)*3)
                DropdownValuesFrame.Position = UDim2.fromScale(0.05,1.15)
                DropdownValuesFrame.BackgroundTransparency = 1
                DropdownValuesFrame.ScrollBarThickness = 0
                DropdownValuesFrame.ScrollingDirection = Enum.ScrollingDirection.Y
                DropdownValuesFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
                DropdownValuesFrame.CanvasSize = UDim2.fromScale(0,0)
                DropdownValuesFrame.Visible = false
                local DropdownValuesCorner = Instance.new("UICorner",DropdownValuesFrame)
                local DropdownValuesListLayout = Instance.new("UIListLayout",DropdownValuesFrame)
                DropdownValuesListLayout.Padding = UDim.new(0,3)
                DropdownValuesListLayout.SortOrder = Enum.SortOrder.LayoutOrder

                local FakeDropdownFrame = Instance.new("Frame",ContentBoxFrame)
                FakeDropdownFrame.BackgroundTransparency = 1
                FakeDropdownFrame.Size = UDim2.new(1,0,0,(GivenTable.MaxVisibleValues or 2)*25+(GivenTable.MaxVisibleValues or 2)*3)
                FakeDropdownFrame.LayoutOrder = DropdownFrame.LayoutOrder+1
                FakeDropdownFrame.Visible = false

                local SelectedValue
                if GivenTable.MultiSelection then SelectedValue = {} end

                for _,Value in GivenTable.Values do
                    local ValueType
                    if typeof(Value) == "string" then ValueType = Value else ValueType = Value.Name end
                    local ValueFrame = Instance.new("Frame",DropdownValuesFrame)
                    ValueFrame.BackgroundTransparency = 0.6
                    ValueFrame.Size = UDim2.new(1,0,0,25)
                    ValueFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
                    ValueFrame.Name = ValueType
                    local ValueFrameCorner = Instance.new("UICorner",ValueFrame)
                    local ValueButton = Instance.new("TextButton",ValueFrame)
                    ValueButton.BackgroundTransparency = 1
                    ValueButton.Size = UDim2.fromScale(1,1)
                    ValueButton.Text = ValueType
                    ValueButton.TextColor3 = Color3.fromRGB(255,255,255)
                    ValueButton.TextScaled = true
                    ValueButton.MouseButton1Click:Connect(function()
                        for _,Buttons in DropdownValuesFrame:GetChildren() do
                            if Buttons:IsA("Frame") then
                                if not GivenTable.MultiSelection then
                                    if Buttons.Name == ValueType and SelectedValue ~= Buttons then
                                        SelectedValue = Buttons
                                        GivenTable.Callback(Value)
                                        TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
                                    elseif Buttons.Name == ValueType and SelectedValue == Buttons then
                                        SelectedValue = nil
                                        GivenTable.Callback(SelectedValue)
                                        TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
                                    else
                                        TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
                                    end
                                elseif GivenTable.MultiSelection then
                                    if Buttons.Name == ValueType and not table.find(SelectedValue,Buttons) then
                                        table.insert(SelectedValue,Buttons)
                                        GivenTable.Callback(SelectedValue)
                                        TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
                                    elseif Buttons.Name == ValueType and table.find(SelectedValue,Buttons) then
                                        for Index,Item in SelectedValue do
                                            if Item == Buttons then table.remove(SelectedValue,Index) end
                                        end
                                        GivenTable.Callback(SelectedValue)
                                        TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
                                    elseif not table.find(SelectedValue,Buttons) then
                                        TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
                                    end
                                end
                            end
                        end
                    end)
                end

                DropdownButton.MouseButton1Click:Connect(function()
                    if DropdownValuesFrame.Visible then
                        DropdownValuesFrame.Visible = false
                        FakeDropdownFrame.Visible = false
                        ContentBox:Resize()
                        TweenService:Create(DropdownIcon,TweenInfo.new(0.25),{Rotation = 0}):Play()
                    else
                        DropdownValuesFrame.Visible = true
                        FakeDropdownFrame.Visible = true
                        ContentBox:Resize()
                        TweenService:Create(DropdownIcon,TweenInfo.new(0.25),{Rotation = 180}):Play()
                    end
                end)

                ContentBox:Resize()

                function DropdownHolder:SetText(Text)
                    DropdownText.Text = Text or "Dropdown"
                end

                function DropdownHolder:SetValue(Value)
                    if typeof(Value) == "table" and GivenTable.MultiSelection then
                        table.clear(SelectedValue)
                        for _,Values in Value do
                            local ValueType
                            if typeof(Values) == "string" then ValueType = Values else ValueType = Values.Name end
                            for _,Buttons in DropdownValuesFrame:GetChildren() do
                                if Buttons:IsA("Frame") then
                                    if Buttons.Name == ValueType then
                                        table.insert(SelectedValue,Buttons)
                                        GivenTable.Callback(SelectedValue)
                                        TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
                                    elseif not table.find(SelectedValue,Buttons) then
                                        TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
                                    end
                                end
                            end
                        end
                    elseif not GivenTable.MultiSelection then
                        local ValueType
                        if typeof(Value) == "string" then ValueType = Value else ValueType = Value.Name end
                        for _,Buttons in DropdownValuesFrame:GetChildren() do
                            if Buttons:IsA("Frame") then
                                if Buttons.Name == ValueType then
                                    SelectedValue = Buttons
                                    GivenTable.Callback(Value)
                                    TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
                                else
                                    TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
                                end
                            end
                        end
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
                    for _,Buttons in DropdownValuesFrame:GetChildren() do
                        if Buttons:IsA("Frame") then Buttons:Destroy() end
                    end
                    for _,Value in NewValues do
                        local ValueType
                        if typeof(Value) == "string" then ValueType = Value else ValueType = Value.Name end
                        local ValueFrame = Instance.new("Frame",DropdownValuesFrame)
                        ValueFrame.BackgroundTransparency = 0.6
                        ValueFrame.Size = UDim2.new(1,0,0,25)
                        ValueFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
                        ValueFrame.Name = ValueType
                        local ValueFrameCorner = Instance.new("UICorner",ValueFrame)
                        local ValueButton = Instance.new("TextButton",ValueFrame)
                        ValueButton.BackgroundTransparency = 1
                        ValueButton.Size = UDim2.fromScale(1,1)
                        ValueButton.Text = ValueType
                        ValueButton.TextColor3 = Color3.fromRGB(255,255,255)
                        ValueButton.TextScaled = true
                        ValueButton.MouseButton1Click:Connect(function()
                            for _,Buttons in DropdownValuesFrame:GetChildren() do
                                if Buttons:IsA("Frame") then
                                    if not GivenTable.MultiSelection then
                                        if Buttons.Name == ValueType and SelectedValue ~= Buttons then
                                            SelectedValue = Buttons
                                            GivenTable.Callback(SelectedValue)
                                            TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
                                        elseif Buttons.Name == ValueType and SelectedValue == Buttons then
                                            SelectedValue = nil
                                            GivenTable.Callback(SelectedValue)
                                            TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
                                        else
                                            TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
                                        end
                                    elseif GivenTable.MultiSelection then
                                        if Buttons.Name == ValueType and not table.find(SelectedValue,Buttons) then
                                            table.insert(SelectedValue,Buttons)
                                            GivenTable.Callback(SelectedValue)
                                            TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
                                        elseif Buttons.Name == ValueType and table.find(SelectedValue,Buttons) then
                                            for Index,Item in SelectedValue do
                                                if Item == Buttons then table.remove(SelectedValue,Index) end
                                            end
                                            GivenTable.Callback(SelectedValue)
                                            TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
                                        elseif not table.find(SelectedValue,Buttons) then
                                            TweenService:Create(Buttons,TweenInfo.new(0.25),{BackgroundColor3 = Color3.fromRGB(0,0,0)}):Play()
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
                    FakeDropdownFrame.Visible = false
                    if Boolean then
                        DropdownButton.Interactable = true
                        TweenService:Create(DropdownIcon,TweenInfo.new(0.25),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
                        TweenService:Create(DropdownText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(225,225,225)}):Play()
                    else
                        DropdownButton.Interactable = false
                        TweenService:Create(DropdownIcon,TweenInfo.new(0.25),{Rotation = 0}):Play()
                        TweenService:Create(DropdownIcon,TweenInfo.new(0.25),{ImageColor3 = Color3.fromRGB(125,125,125)}):Play()
                        TweenService:Create(DropdownText,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(125,125,125)}):Play()
                    end
                    ContentBox:Resize()
                end

                function DropdownHolder:SetVisible(Boolean)
                    DropdownFrame.Visible = Boolean
                    DropdownValuesFrame.Visible = false
                    FakeDropdownFrame.Visible = false
                    TweenService:Create(DropdownIcon,TweenInfo.new(0.25),{Rotation = 0}):Play()
                    ContentBox:Resize()
                end

                function DropdownHolder:Destroy()
                    DropdownFrame:Destroy()
                    FakeDropdownFrame:Destroy()
                    ContentBox:Resize()
                end

                return DropdownHolder

            end

            --[[
                :AddInput({
                    Text = "Input",
                    Default = nil,
                    Placeholder = nil,
                    ClearTextOnFocus = false,
                    Finished = false,
                    Callback = function() end
                })
            ]]

            function ContentBox:AddInput(GivenTable)
                local InputHolder = {}

                local InputFakeFrame = Instance.new("Frame",ContentBoxFrame)
                InputFakeFrame.BackgroundTransparency = 1
                InputFakeFrame.Size = UDim2.new(1,0,0,50)
                InputFakeFrame.LayoutOrder = #(ContentBoxFrame:GetChildren())

                local InputName = Instance.new("TextLabel",InputFakeFrame)
                InputName.BackgroundTransparency = 1
                InputName.Size = UDim2.new(0.9,0,0,25)
                InputName.Position = UDim2.new(0.05,0,0,0)
                InputName.TextColor3 = Color3.fromRGB(255,255,255)
                InputName.TextScaled = true
                InputName.TextXAlignment = Enum.TextXAlignment.Left
                InputName.Text = GivenTable.Text

                local InputFrame = Instance.new("Frame",InputFakeFrame)
                InputFrame.BackgroundTransparency = 0.6
                InputFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
                InputFrame.Size = UDim2.new(0.9,0,0,25)
                InputFrame.Position = UDim2.new(0.05,0,0,25)
                local InputFrameCorner = Instance.new("UICorner",InputFrame)

                local Input = Instance.new("TextBox",InputFrame)
                Input.BackgroundTransparency = 1
                Input.Size = UDim2.new(0.9,0,0,25)
                Input.Position = UDim2.new(0.05,0,0,0)
                Input.ClearTextOnFocus = GivenTable.ClearTextOnFocus or false
                Input.TextColor3 = Color3.fromRGB(255,255,255)
                Input.TextWrap = true
                Input.TextTruncate = Enum.TextTruncate.AtEnd
                Input.PlaceholderText = GivenTable.Placeholder or ""
                Input.TextXAlignment = Enum.TextXAlignment.Left
                Input.Text = GivenTable.Default or ""

                local WaitingForFinish = false

                Input:GetPropertyChangedSignal("Text"):Connect(function()
                    if not GivenTable.Finished then
                        GivenTable.Callback(Input.Text)
                    elseif GivenTable.Finished and not WaitingForFinish then
                        WaitingForFinish = true
                        while Input.CursorPosition ~= -1 do task.wait() end
                        GivenTable.Callback(Input.Text)
                        WaitingForFinish = false
                    end
                end)

                ContentBox:Resize()

                function InputHolder:SetValue(NewValue)
                    Input.Text = NewValue
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
                    ContentBox:Resize()
                end

                function InputHolder:SetVisible(Boolean)
                    InputFakeFrame.Visible = Boolean
                    ContentBox:Resize()
                end

                function InputHolder:Destroy()
                    InputFakeFrame:Destroy()
                    ContentBox:Resize()
                end

                return InputHolder

            end

            --[[
                :AddKeyPicker({
                    Text = "Keybind",
                    Default = "None",
                    Callback = function() end
                })
            ]]

            function ContentBox:AddKeyPicker(GivenTable)
                local KeybindHolder = {}

                local KeybindFakeFrame = Instance.new("Frame",ContentBoxFrame)
                KeybindFakeFrame.BackgroundTransparency = 1
                KeybindFakeFrame.Size = UDim2.new(1,0,0,25)
                KeybindFakeFrame.LayoutOrder = #(ContentBoxFrame:GetChildren())

                local KeybindName = Instance.new("TextLabel",KeybindFakeFrame)
                KeybindName.BackgroundTransparency = 1
                KeybindName.Size = UDim2.new(0.7,0,1,0)
                KeybindName.Position = UDim2.new(0.05,0,0,0)
                KeybindName.TextColor3 = Color3.fromRGB(255,255,255)
                KeybindName.TextScaled = true
                KeybindName.TextXAlignment = Enum.TextXAlignment.Left
                KeybindName.Text = GivenTable.Text or "Keybind"

                local KeybindFrame = Instance.new("Frame",KeybindFakeFrame)
                KeybindFrame.BackgroundTransparency = 0.6
                KeybindFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
                KeybindFrame.Size = UDim2.new(0.2,0,1,0)
                KeybindFrame.Position = UDim2.new(0.75,0,0,0)
                local KeybindFrameCorner = Instance.new("UICorner",KeybindFrame)

                local KeybindButton = Instance.new("TextButton",KeybindFrame)
                KeybindButton.BackgroundTransparency = 1
                KeybindButton.Size = UDim2.new(1,0,1,0)
                KeybindButton.TextColor3 = Color3.fromRGB(255,255,255)
                KeybindButton.TextScaled = true
                if not GivenTable.Default or table.find(BlacklistedKeys,GivenTable.Default) then 
                    KeybindButton.Text = "None"
                else
                    KeybindButton.Text = GivenTable.Default
                end

                local Trigger = GivenTable.Default or "None"
                local WaitForKey

                UserInputService.InputBegan:Connect(function(Key,GameProcessed)
                    if GameProcessed then return end
                    if Key.KeyCode.Name == Trigger and not WaitForKey then GivenTable.Callback() end
                end)

                KeybindButton.MouseButton1Click:Connect(function()
                    Trigger = nil
                    KeybindButton.Text = "..."
                    WaitForKey = UserInputService.InputBegan:Connect(function(Key,GameProcessed)
                        if GameProcessed then return end
                        if not table.find(BlacklistedKeys,Key.KeyCode.Name) then
                            Trigger = Key.KeyCode.Name
                            KeybindButton.Text = Trigger
                            task.wait()
                            WaitForKey:Disconnect();WaitForKey = nil
                        end
                    end)
                end)

                ContentBox:Resize()

                return KeybindHolder
            end

            return ContentBox

        end

        return TabContent

    end

    return Window

end

return JustAnLibrary
