-- =========================================================
-- THE KING T SHOP HUB — Clean Loader (No Key · No API)
-- =========================================================
-- >>> วางสคริปต์ของคุณใน runScript() ด้านล่าง <<<
-- =========================================================

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local CoreGui          = game:GetService("CoreGui")

local GUI_NAME = "TheKingTShopHubLoader_v3"
local LOADER_VERSION = "clean-1"

-- ========================================================
-- >>> PUT YOUR SCRIPT HERE <<<
-- ========================================================
local function runScript()
    -- ตัวอย่างที่ 1: ดึงจาก URL
    -- loadstring(game:HttpGet("https://your-host.com/script.lua"))()

    -- ตัวอย่างที่ 2: วางโค้ดตรงนี้เลย
    -- print("Hello from The King T Shop Hub!")

    -- ตัวอย่างที่ 3: ใช้ไฟล์ในเครื่อง
    -- loadstring(readfile("MyScript.lua"))()

    warn("[Loader] runScript() is empty. Paste your code inside the function.")
end
-- ========================================================

-- ---------- Theme ----------
local Theme = {
    CardBg          = Color3.fromRGB(15, 15, 18),
    CardBorder      = Color3.fromRGB(34, 38, 48),
    PillBg          = Color3.fromRGB(22, 24, 30),
    PillBorder      = Color3.fromRGB(38, 42, 54),
    IconBoxBg       = Color3.fromRGB(24, 26, 34),
    PrimaryBtnBg    = Color3.fromRGB(242, 242, 245),
    PrimaryBtnHover = Color3.fromRGB(218, 218, 226),
    PrimaryBtnText  = Color3.fromRGB(15, 15, 18),
    SecondaryBtnBg  = Color3.fromRGB(20, 22, 28),
    SecondaryBtnBorder = Color3.fromRGB(36, 40, 52),
    SecondaryBtnHover  = Color3.fromRGB(28, 30, 38),
    TextWhite       = Color3.fromRGB(245, 245, 247),
    TextMuted       = Color3.fromRGB(148, 163, 184),
    TextSubtle      = Color3.fromRGB(105, 115, 130),
    Cyan            = Color3.fromRGB(34, 211, 238),
    Gold            = Color3.fromRGB(245, 158, 11),
    Error           = Color3.fromRGB(239, 68, 68),
    CheckGreen      = Color3.fromRGB(132, 204, 22),
}

-- ---------- Helpers ----------
local function resolveParentGui()
    local ok, hui = pcall(function()
        if type(gethui) == "function" then return gethui() end
    end)
    if ok and hui then return hui end

    local ok2, core = pcall(function() return CoreGui end)
    if ok2 and core then return core end

    local lp = Players.LocalPlayer
    if lp then
        return lp:WaitForChild("PlayerGui")
    end
    return nil
end

local function protectGuiInstance(gui)
    pcall(function()
        if type(syn) == "table" and type(syn.protect_gui) == "function" then
            syn.protect_gui(gui)
        end
    end)
end

-- ---------- Build GUI ----------
local parentContainer = resolveParentGui()
if not parentContainer then
    warn("[Loader] No valid parent GUI found.")
    return
end

local existing = parentContainer:FindFirstChild(GUI_NAME)
if existing then existing:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = GUI_NAME
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
protectGuiInstance(ScreenGui)
ScreenGui.Parent = parentContainer

-- ---------- Toast ----------
local ToastContainer = Instance.new("Frame")
ToastContainer.Name = "ToastContainer"
ToastContainer.Size = UDim2.new(0, 360, 0, 140)
ToastContainer.Position = UDim2.new(0.5, -180, 0, 24)
ToastContainer.BackgroundTransparency = 1
ToastContainer.ZIndex = 100
ToastContainer.Parent = ScreenGui

local ToastLayout = Instance.new("UIListLayout")
ToastLayout.SortOrder = Enum.SortOrder.LayoutOrder
ToastLayout.Padding = UDim.new(0, 6)
ToastLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ToastLayout.VerticalAlignment = Enum.VerticalAlignment.Top
ToastLayout.Parent = ToastContainer

local function showToast(titleText, messageText, accentColor)
    local color = accentColor or Theme.CheckGreen
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 0)
    frame.BackgroundColor3 = Theme.CardBg
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.ZIndex = 101
    frame.Parent = ToastContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Color = color
    stroke.Transparency = 0.35
    stroke.Parent = frame

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.Position = UDim2.new(0, 12, 0, 12)
    dot.BackgroundColor3 = color
    dot.BorderSizePixel = 0
    dot.ZIndex = 102
    dot.Parent = frame

    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -34, 0, 16)
    titleLbl.Position = UDim2.new(0, 26, 0, 8)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.Text = titleText
    titleLbl.TextColor3 = Theme.TextWhite
    titleLbl.TextSize = 12
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 102
    titleLbl.Parent = frame

    local msgLbl = Instance.new("TextLabel")
    msgLbl.Size = UDim2.new(1, -34, 0, 16)
    msgLbl.Position = UDim2.new(0, 26, 0, 24)
    msgLbl.BackgroundTransparency = 1
    msgLbl.Font = Enum.Font.GothamMedium
    msgLbl.Text = messageText
    msgLbl.TextColor3 = Theme.TextMuted
    msgLbl.TextSize = 11
    msgLbl.TextXAlignment = Enum.TextXAlignment.Left
    msgLbl.ZIndex = 102
    msgLbl.Parent = frame

    TweenService:Create(
        frame,
        TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        { Size = UDim2.new(1, 0, 0, 48) }
    ):Play()

    task.delay(3.0, function()
        if frame and frame.Parent then
            local out = TweenService:Create(
                frame,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                { Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1 }
            )
            out:Play()
            out.Completed:Connect(function()
                if frame then frame:Destroy() end
            end)
        end
    end)
end

-- ---------- Splash ----------
local SplashAnchor = Instance.new("Frame")
SplashAnchor.Name = "SplashAnchor"
SplashAnchor.Size = UDim2.new(0, 340, 0, 200)
SplashAnchor.Position = UDim2.new(0.5, -170, 0.5, -100)
SplashAnchor.BackgroundColor3 = Theme.CardBg
SplashAnchor.BorderSizePixel = 0
SplashAnchor.ClipsDescendants = true
SplashAnchor.ZIndex = 10
SplashAnchor.Parent = ScreenGui

local SplashCorner = Instance.new("UICorner")
SplashCorner.CornerRadius = UDim.new(0, 14)
SplashCorner.Parent = SplashAnchor

local SplashStroke = Instance.new("UIStroke")
SplashStroke.Thickness = 1.2
SplashStroke.Color = Theme.CardBorder
SplashStroke.Parent = SplashAnchor

local SplashGlyph = Instance.new("TextLabel")
SplashGlyph.Size = UDim2.new(1, 0, 0, 60)
SplashGlyph.Position = UDim2.new(0, 0, 0, 30)
SplashGlyph.BackgroundTransparency = 1
SplashGlyph.Font = Enum.Font.GothamBold
SplashGlyph.Text = "👑"
SplashGlyph.TextSize = 46
SplashGlyph.ZIndex = 11
SplashGlyph.Parent = SplashAnchor

local SplashTitle = Instance.new("TextLabel")
SplashTitle.Size = UDim2.new(1, 0, 0, 22)
SplashTitle.Position = UDim2.fromOffset(0, 104)
SplashTitle.BackgroundTransparency = 1
SplashTitle.Font = Enum.Font.GothamBold
SplashTitle.Text = "THE KING T SHOP HUB"
SplashTitle.TextSize = 14
SplashTitle.TextColor3 = Theme.TextWhite
SplashTitle.ZIndex = 11
SplashTitle.Parent = SplashAnchor

local SplashStatus = Instance.new("TextLabel")
SplashStatus.Size = UDim2.new(1, -32, 0, 20)
SplashStatus.Position = UDim2.fromOffset(16, 132)
SplashStatus.BackgroundTransparency = 1
SplashStatus.Font = Enum.Font.GothamMedium
SplashStatus.Text = "กำลังเริ่มระบบ..."
SplashStatus.TextSize = 12
SplashStatus.TextColor3 = Theme.TextMuted
SplashStatus.ZIndex = 11
SplashStatus.Parent = SplashAnchor

local SplashBarBg = Instance.new("Frame")
SplashBarBg.Size = UDim2.new(1, -64, 0, 4)
SplashBarBg.Position = UDim2.new(0, 32, 0, 168)
SplashBarBg.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
SplashBarBg.BorderSizePixel = 0
SplashBarBg.ZIndex = 11
SplashBarBg.Parent = SplashAnchor

local SBCorner = Instance.new("UICorner")
SBCorner.CornerRadius = UDim.new(1, 0)
SBCorner.Parent = SplashBarBg

local SplashBarFill = Instance.new("Frame")
SplashBarFill.Size = UDim2.new(0.35, 0, 1, 0)
SplashBarFill.BackgroundColor3 = Theme.Cyan
SplashBarFill.BorderSizePixel = 0
SplashBarFill.ZIndex = 12
SplashBarFill.Parent = SplashBarBg

local SFBCorner = Instance.new("UICorner")
SFBCorner.CornerRadius = UDim.new(1, 0)
SFBCorner.Parent = SplashBarFill

-- ---------- Main Card ----------
local MainAnchor = Instance.new("Frame")
MainAnchor.Name = "MainAnchor"
MainAnchor.Size = UDim2.new(0, 430, 0, 314)
MainAnchor.Position = UDim2.new(0.5, -215, 0.5, -157)
MainAnchor.BackgroundTransparency = 1
MainAnchor.Visible = false
MainAnchor.Parent = ScreenGui

local MainCard = Instance.new("Frame")
MainCard.Name = "MainCard"
MainCard.Size = UDim2.new(1, 0, 1, 0)
MainCard.BackgroundColor3 = Theme.CardBg
MainCard.BackgroundTransparency = 0.02
MainCard.ClipsDescendants = true
MainCard.ZIndex = 2
MainCard.Parent = MainAnchor

local CardCorner = Instance.new("UICorner")
CardCorner.CornerRadius = UDim.new(0, 14)
CardCorner.Parent = MainCard

local CardStroke = Instance.new("UIStroke")
CardStroke.Thickness = 1
CardStroke.Color = Theme.CardBorder
CardStroke.Parent = MainCard

-- Top drag bar
local TopDragBar = Instance.new("Frame")
TopDragBar.Name = "TopDragBar"
TopDragBar.Size = UDim2.new(1, 0, 0, 58)
TopDragBar.BackgroundTransparency = 1
TopDragBar.ZIndex = 3
TopDragBar.Parent = MainCard

local BrandIconBox = Instance.new("Frame")
BrandIconBox.Size = UDim2.new(0, 38, 0, 38)
BrandIconBox.Position = UDim2.new(0, 20, 0, 10)
BrandIconBox.BackgroundColor3 = Theme.IconBoxBg
BrandIconBox.ZIndex = 4
BrandIconBox.Parent = TopDragBar

local BICorner = Instance.new("UICorner")
BICorner.CornerRadius = UDim.new(1, 0)
BICorner.Parent = BrandIconBox

local BIStroke = Instance.new("UIStroke")
BIStroke.Thickness = 1.2
BIStroke.Color = Theme.CardBorder
BIStroke.Parent = BrandIconBox

local BrandGlyph = Instance.new("TextLabel")
BrandGlyph.Size = UDim2.fromScale(1, 1)
BrandGlyph.BackgroundTransparency = 1
BrandGlyph.Font = Enum.Font.GothamBold
BrandGlyph.Text = "👑"
BrandGlyph.TextSize = 18
BrandGlyph.ZIndex = 5
BrandGlyph.Parent = BrandIconBox

local HubBrandTitle = Instance.new("TextLabel")
HubBrandTitle.Size = UDim2.new(0, 240, 0, 20)
HubBrandTitle.Position = UDim2.new(0, 68, 0, 11)
HubBrandTitle.BackgroundTransparency = 1
HubBrandTitle.Font = Enum.Font.GothamBold
HubBrandTitle.Text = "THE KING T SHOP"
HubBrandTitle.TextColor3 = Theme.TextWhite
HubBrandTitle.TextSize = 15
HubBrandTitle.TextXAlignment = Enum.TextXAlignment.Left
HubBrandTitle.ZIndex = 4
HubBrandTitle.Parent = TopDragBar

local HubBrandSubtitle = Instance.new("TextLabel")
HubBrandSubtitle.Size = UDim2.new(0, 240, 0, 16)
HubBrandSubtitle.Position = UDim2.new(0, 68, 0, 31)
HubBrandSubtitle.BackgroundTransparency = 1
HubBrandSubtitle.Font = Enum.Font.GothamMedium
HubBrandSubtitle.Text = "Free Edition · v" .. LOADER_VERSION
HubBrandSubtitle.TextColor3 = Theme.TextMuted
HubBrandSubtitle.TextSize = 11
HubBrandSubtitle.TextXAlignment = Enum.TextXAlignment.Left
HubBrandSubtitle.ZIndex = 4
HubBrandSubtitle.Parent = TopDragBar

local WindowBtnHolder = Instance.new("Frame")
WindowBtnHolder.Size = UDim2.new(0, 56, 0, 26)
WindowBtnHolder.Position = UDim2.new(1, -76, 0, 16)
WindowBtnHolder.BackgroundTransparency = 1
WindowBtnHolder.ZIndex = 5
WindowBtnHolder.Parent = TopDragBar

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 24, 0, 24)
MinBtn.Position = UDim2.new(0, 0, 0, 0)
MinBtn.BackgroundColor3 = Theme.IconBoxBg
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Text = "-"
MinBtn.TextColor3 = Theme.TextMuted
MinBtn.TextSize = 14
MinBtn.AutoButtonColor = false
MinBtn.ZIndex = 6
MinBtn.Parent = WindowBtnHolder

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(0, 30, 0, 0)
CloseBtn.BackgroundColor3 = Theme.IconBoxBg
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Theme.TextMuted
CloseBtn.TextSize = 13
CloseBtn.AutoButtonColor = false
CloseBtn.ZIndex = 6
CloseBtn.Parent = WindowBtnHolder

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.18), {
        BackgroundColor3 = Color3.fromRGB(225, 29, 72),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.18), {
        BackgroundColor3 = Theme.IconBoxBg,
        TextColor3 = Theme.TextMuted
    }):Play()
end)

-- ---------- Content ----------
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, 0, 1, -58)
ContentContainer.Position = UDim2.new(0, 0, 0, 58)
ContentContainer.BackgroundTransparency = 1
ContentContainer.ZIndex = 3
ContentContainer.Parent = MainCard

local StatusLine = Instance.new("Frame")
StatusLine.Size = UDim2.new(1, -40, 0, 26)
StatusLine.Position = UDim2.new(0, 20, 0, 6)
StatusLine.BackgroundTransparency = 1
StatusLine.ZIndex = 4
StatusLine.Parent = ContentContainer

local ServerPill = Instance.new("Frame")
ServerPill.Size = UDim2.new(0.5, -4, 1, 0)
ServerPill.BackgroundColor3 = Theme.PillBg
ServerPill.BorderSizePixel = 0
ServerPill.ZIndex = 5
ServerPill.Parent = StatusLine

local SPCorner = Instance.new("UICorner")
SPCorner.CornerRadius = UDim.new(0, 6)
SPCorner.Parent = ServerPill

local SPStroke = Instance.new("UIStroke")
SPStroke.Thickness = 1
SPStroke.Color = Theme.PillBorder
SPStroke.Parent = ServerPill

local ServerDot = Instance.new("Frame")
ServerDot.Size = UDim2.new(0, 6, 0, 6)
ServerDot.Position = UDim2.new(0, 10, 0.5, -3)
ServerDot.BackgroundColor3 = Theme.CheckGreen
ServerDot.BorderSizePixel = 0
ServerDot.ZIndex = 6
ServerDot.Parent = ServerPill

local SDCorner = Instance.new("UICorner")
SDCorner.CornerRadius = UDim.new(1, 0)
SDCorner.Parent = ServerDot

local ServerText = Instance.new("TextLabel")
ServerText.Size = UDim2.new(1, -24, 1, 0)
ServerText.Position = UDim2.new(0, 22, 0, 0)
ServerText.BackgroundTransparency = 1
ServerText.Font = Enum.Font.GothamMedium
ServerText.Text = "พร้อมใช้งาน"
ServerText.TextColor3 = Theme.CheckGreen
ServerText.TextSize = 11
ServerText.TextXAlignment = Enum.TextXAlignment.Left
ServerText.ZIndex = 6
ServerText.Parent = ServerPill

local VersionPill = Instance.new("Frame")
VersionPill.Size = UDim2.new(0.5, -4, 1, 0)
VersionPill.Position = UDim2.new(0.5, 4, 0, 0)
VersionPill.BackgroundColor3 = Theme.PillBg
VersionPill.BorderSizePixel = 0
VersionPill.ZIndex = 5
VersionPill.Parent = StatusLine

local VPCorner = Instance.new("UICorner")
VPCorner.CornerRadius = UDim.new(0, 6)
VPCorner.Parent = VersionPill

local VPStroke = Instance.new("UIStroke")
VPStroke.Thickness = 1
VPStroke.Color = Theme.PillBorder
VPStroke.Parent = VersionPill

local VersionText = Instance.new("TextLabel")
VersionText.Size = UDim2.new(1, -16, 1, 0)
VersionText.Position = UDim2.new(0, 8, 0, 0)
VersionText.BackgroundTransparency = 1
VersionText.Font = Enum.Font.GothamMedium
VersionText.Text = "Loader v" .. LOADER_VERSION
VersionText.TextColor3 = Theme.TextMuted
VersionText.TextSize = 11
VersionText.ZIndex = 6
VersionText.Parent = VersionPill

-- Status / output display
local OutputBox = Instance.new("Frame")
OutputBox.Size = UDim2.new(1, -40, 0, 100)
OutputBox.Position = UDim2.new(0, 20, 0, 44)
OutputBox.BackgroundColor3 = Color3.fromRGB(11, 11, 14)
OutputBox.BorderSizePixel = 0
OutputBox.ZIndex = 4
OutputBox.Parent = ContentContainer

local OBCorner = Instance.new("UICorner")
OBCorner.CornerRadius = UDim.new(0, 8)
OBCorner.Parent = OutputBox

local OBStroke = Instance.new("UIStroke")
OBStroke.Thickness = 1.2
OBStroke.Color = Theme.CardBorder
OBStroke.Transparency = 0.2
OBStroke.Parent = OutputBox

local OutputLabel = Instance.new("TextLabel")
OutputLabel.Size = UDim2.new(1, -24, 1, -24)
OutputLabel.Position = UDim2.new(0, 12, 0, 12)
OutputLabel.BackgroundTransparency = 1
OutputLabel.Font = Enum.Font.Code
OutputLabel.Text = "> Ready.\n> Press START to run your script."
OutputLabel.TextColor3 = Theme.TextMuted
OutputLabel.TextSize = 11
OutputLabel.TextXAlignment = Enum.TextXAlignment.Left
OutputLabel.TextYAlignment = Enum.TextYAlignment.Top
OutputLabel.TextWrapped = true
OutputLabel.ZIndex = 5
OutputLabel.Parent = OutputBox

-- Start button
local StartBtn = Instance.new("TextButton")
StartBtn.Size = UDim2.new(1, -40, 0, 44)
StartBtn.Position = UDim2.new(0, 20, 0, 156)
StartBtn.BackgroundColor3 = Theme.PrimaryBtnBg
StartBtn.Font = Enum.Font.GothamBold
StartBtn.Text = "START SCRIPT"
StartBtn.TextColor3 = Theme.PrimaryBtnText
StartBtn.TextSize = 14
StartBtn.AutoButtonColor = false
StartBtn.ZIndex = 5
StartBtn.Parent = ContentContainer

local SBCornerBtn = Instance.new("UICorner")
SBCornerBtn.CornerRadius = UDim.new(0, 8)
SBCornerBtn.Parent = StartBtn

-- Info footer
local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, -40, 0, 20)
Footer.Position = UDim2.new(0, 20, 0, 208)
Footer.BackgroundTransparency = 1
Footer.Font = Enum.Font.GothamMedium
Footer.Text = "No key required · No external requests"
Footer.TextColor3 = Theme.TextSubtle
Footer.TextSize = 10
Footer.TextXAlignment = Enum.TextXAlignment.Center
Footer.ZIndex = 4
Footer.Parent = ContentContainer

-- ---------- States ----------
local isMinimized = false
local isRunning = false

local function log(text, color)
    OutputLabel.Text = "> " .. text
    OutputLabel.TextColor3 = color or Theme.TextMuted
end

-- ---------- Button hover ----------
StartBtn.MouseEnter:Connect(function()
    if isRunning then return end
    TweenService:Create(StartBtn, TweenInfo.new(0.15), { BackgroundColor3 = Theme.PrimaryBtnHover }):Play()
end)
StartBtn.MouseLeave:Connect(function()
    if isRunning then return end
    TweenService:Create(StartBtn, TweenInfo.new(0.15), { BackgroundColor3 = Theme.PrimaryBtnBg }):Play()
end)

-- ---------- Start handler ----------
StartBtn.MouseButton1Click:Connect(function()
    if isRunning then return end
    isRunning = true
    StartBtn.Text = "RUNNING..."
    StartBtn.BackgroundColor3 = Theme.CheckGreen
    StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    log("Executing script...", Theme.Cyan)

    task.spawn(function()
        local ok, err = pcall(runScript)
        if ok then
            log("Script executed successfully.", Theme.CheckGreen)
            showToast("Success", "Script started.", Theme.CheckGreen)
        else
            log("Error: " .. tostring(err), Theme.Error)
            showToast("Error", tostring(err), Theme.Error)
        end
        StartBtn.Text = "START SCRIPT"
        StartBtn.BackgroundColor3 = Theme.PrimaryBtnBg
        StartBtn.TextColor3 = Theme.PrimaryBtnText
        isRunning = false
    end)
end)

-- ---------- Min / Close ----------
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        ContentContainer.Visible = false
        TweenService:Create(MainAnchor, TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 430, 0, 58)
        }):Play()
    else
        TweenService:Create(MainAnchor, TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 430, 0, 314)
        }):Play()
        task.delay(0.1, function()
            if not isMinimized then ContentContainer.Visible = true end
        end)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainAnchor, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    task.delay(0.21, function()
        if ScreenGui then ScreenGui:Destroy() end
    end)
end)

-- ---------- Dragging ----------
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

TopDragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainAnchor.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopDragBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging and dragStart and startPos then
        local delta = input.Position - dragStart
        TweenService:Create(MainAnchor, TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        }):Play()
    end
end)

-- ---------- Splash transition ----------
local function transitionSplashToMain()
    TweenService:Create(SplashAnchor, TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.fromOffset(0, 0),
        BackgroundTransparency = 1
    }):Play()
    task.wait(0.28)
    SplashAnchor.Visible = false
    MainAnchor.Visible = true
    MainAnchor.Size = UDim2.new(0, 430, 0, 0)
    TweenService:Create(MainAnchor, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 430, 0, 314)
    }):Play()
end

-- ---------- Boot ----------
task.spawn(function()
    TweenService:Create(SplashBarFill, TweenInfo.new(0.6), { Size = UDim2.new(0.75, 0, 1, 0) }):Play()
    task.wait(0.5)
    SplashStatus.Text = "พร้อมแล้ว"
    SplashStatus.TextColor3 = Theme.CheckGreen
    TweenService:Create(SplashBarFill, TweenInfo.new(0.3), {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Theme.CheckGreen
    }):Play()
    task.wait(0.35)
    transitionSplashToMain()
end)
