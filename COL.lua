-- Táº£i Junkie SDK
local function _d(_t)
    local _o = table.create(#_t)
    for _i = 1, #_t do
        _o[_i] = string.char(_t[_i])
    end
    return table.concat(_o)
end
local Junkie = loadstring(game:HttpGet(_d({104,116,116,112,115,58,47,47,106,110,107,105,101,46,99,111,109,47,115,100,107,47,108,105,98,114,97,114,121,46,108,117,97})))()

-- Cáº¥u hÃ¬nh Dashboard cá»§a báº¡n
Junkie.service = "18034" 
Junkie.provider = "7653" 
Junkie.identifier = "1056706" 

-- Táº¡o UI
local PlayersService = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local localPlayer = PlayersService.LocalPlayer
local CREDIT_USER_ID = 9930783751
local CARD_W = 320
local CARD_H = 280
local CARD_GAP = 24
local playerGui = localPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JunkieLoaderUI"
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local bg = Instance.new("Frame", screenGui)
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(10,14,24)
bg.BorderSizePixel = 0

-- Cyan glitch-fall digits background effect
local fxLayer = Instance.new("Frame", bg)
fxLayer.Size = UDim2.new(1,0,1,0)
fxLayer.BackgroundTransparency = 1
fxLayer.ZIndex = 0

local FX_COUNT = 120
local fxDigits = {}
local fxState = {}
local fxConn = nil
local fxSpeedMul = 1
local fxTerminating = false

local function respawnDigit(lbl, fromTop)
    local s = math.random(9, 13)
    lbl.Text = tostring(math.random(0,9))
    lbl.Font = Enum.Font.Code
    lbl.TextSize = s
    lbl.TextColor3 = Color3.fromRGB(0, math.random(200,255), 255)
    lbl.TextTransparency = math.random(15,55) / 100
    lbl.TextStrokeTransparency = 0.82
    lbl.TextStrokeColor3 = Color3.fromRGB(0,255,255)
    lbl.Size = UDim2.new(0, s + 8, 0, s + 8)
    lbl.Position = UDim2.fromScale(
        math.random() * 1.2 - 0.1,
        fromTop and (-0.15 - math.random() * 0.9) or math.random()
    )
    fxState[lbl] = {
        vx = (math.random() - 0.5) * 0.06,
        vy = 0.11 + math.random() * 0.22,
        glitch = 0
    }
end

for _ = 1, FX_COUNT do
    local d = Instance.new("TextLabel")
    d.BackgroundTransparency = 1
    d.TextXAlignment = Enum.TextXAlignment.Center
    d.TextYAlignment = Enum.TextYAlignment.Center
    d.ZIndex = 0
    d.Parent = fxLayer
    table.insert(fxDigits, d)
    respawnDigit(d, false)
end

fxConn = RunService.RenderStepped:Connect(function(dt)
    for _, lbl in ipairs(fxDigits) do
        local st = fxState[lbl]
        if st then
            local x = lbl.Position.X.Scale + st.vx * dt * fxSpeedMul
            local y = lbl.Position.Y.Scale + st.vy * dt * fxSpeedMul
            st.glitch = st.glitch - dt
            if st.glitch <= 0 and not fxTerminating then
                lbl.Text = tostring(math.random(0,9))
                lbl.Rotation = math.random(-8, 8)
                lbl.TextTransparency = math.random(20,65) / 100
                st.glitch = 0.04 + math.random() * 0.14
            end
            if math.random() < 0.02 then
                st.vx = math.clamp(st.vx + (math.random() - 0.5) * 0.02, -0.07, 0.07)
            end
            if y > 1.12 or x < -0.16 or x > 1.16 then
                respawnDigit(lbl, true)
            else
                lbl.Position = UDim2.fromScale(x, y)
            end
        end
    end
end)

local function playTween(obj, duration, goal)
    local tw = TweenService:Create(
        obj,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        goal
    )
    tw:Play()
    return tw
end

local function fadeTree(root, duration)
    local all = {root}
    for _, d in ipairs(root:GetDescendants()) do
        table.insert(all, d)
    end
    for _, obj in ipairs(all) do
        if obj:IsA("Frame") then
            playTween(obj, duration, {BackgroundTransparency = 1})
        elseif obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            local goal = {TextTransparency = 1, TextStrokeTransparency = 1}
            pcall(function() goal.BackgroundTransparency = 1 end)
            playTween(obj, duration, goal)
        elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
            playTween(obj, duration, {ImageTransparency = 1, BackgroundTransparency = 1})
        elseif obj:IsA("UIStroke") then
            playTween(obj, duration, {Transparency = 1})
        end
    end
end

local card = Instance.new("Frame", bg)
card.Size = UDim2.new(0,CARD_W,0,CARD_H)
card.Position = UDim2.new(0.5,-(CARD_W + CARD_GAP/2),0.5,-CARD_H/2)
card.BackgroundColor3 = Color3.fromRGB(18,24,38)
card.BorderSizePixel = 0
Instance.new("UICorner", card).CornerRadius = UDim.new(0,14)
local cardStroke = Instance.new("UIStroke", card)
cardStroke.Color = Color3.fromRGB(56,92,148)
cardStroke.Thickness = 1.8

local creditCard = Instance.new("Frame", bg)
creditCard.Size = UDim2.new(0,CARD_W,0,CARD_H)
creditCard.Position = UDim2.new(0.5,CARD_GAP/2,0.5,-CARD_H/2)
creditCard.BackgroundColor3 = Color3.fromRGB(18,24,38)
creditCard.BorderSizePixel = 0
Instance.new("UICorner", creditCard).CornerRadius = UDim.new(0,14)
local creditStroke = Instance.new("UIStroke", creditCard)
creditStroke.Color = Color3.fromRGB(56,92,148)
creditStroke.Thickness = 1.8

local creditTitle = Instance.new("TextLabel", creditCard)
creditTitle.Size = UDim2.new(1,0,0,48)
creditTitle.Position = UDim2.new(0,0,0,12)
creditTitle.BackgroundTransparency = 1
creditTitle.Text = "CuongOutLook Credit"
creditTitle.Font = Enum.Font.GothamBold
creditTitle.TextSize = 21
creditTitle.TextColor3 = Color3.fromRGB(238,244,255)
creditTitle.TextXAlignment = Enum.TextXAlignment.Center

local creditSub = Instance.new("TextLabel", creditCard)
creditSub.Size = UDim2.new(1,0,0,18)
creditSub.Position = UDim2.new(0,0,0,46)
creditSub.BackgroundTransparency = 1
creditSub.Text = "Official Profile"
creditSub.Font = Enum.Font.Gotham
creditSub.TextSize = 12
creditSub.TextColor3 = Color3.fromRGB(132,148,178)
creditSub.TextXAlignment = Enum.TextXAlignment.Center

local avatarHolder = Instance.new("Frame", creditCard)
avatarHolder.Size = UDim2.new(0,98,0,98)
avatarHolder.Position = UDim2.new(0.5,-49,0,76)
avatarHolder.BackgroundColor3 = Color3.fromRGB(13,18,30)
avatarHolder.BorderSizePixel = 0
Instance.new("UICorner", avatarHolder).CornerRadius = UDim.new(1,0)
local avatarStroke = Instance.new("UIStroke", avatarHolder)
avatarStroke.Color = Color3.fromRGB(56,92,148)
avatarStroke.Thickness = 1.2

local avatar = Instance.new("ImageLabel", avatarHolder)
avatar.Size = UDim2.new(1,-10,1,-10)
avatar.Position = UDim2.new(0,5,0,5)
avatar.BackgroundTransparency = 1
avatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
avatar.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", avatar).CornerRadius = UDim.new(1,0)
pcall(function()
    local thumb = PlayersService:GetUserThumbnailAsync(CREDIT_USER_ID, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    if thumb and thumb ~= "" then
        avatar.Image = thumb
    end
end)

local creditUser = Instance.new("TextLabel", creditCard)
creditUser.Size = UDim2.new(1,-28,0,22)
creditUser.Position = UDim2.new(0,14,0,188)
creditUser.BackgroundTransparency = 1
creditUser.Text = "RobloxUser: CuongOutLook"
creditUser.Font = Enum.Font.GothamBold
creditUser.TextSize = 14
creditUser.TextColor3 = Color3.fromRGB(238,244,255)
creditUser.TextXAlignment = Enum.TextXAlignment.Center

local creditFacebook = Instance.new("TextLabel", creditCard)
creditFacebook.Size = UDim2.new(1,-28,0,22)
creditFacebook.Position = UDim2.new(0,14,0,216)
creditFacebook.BackgroundTransparency = 1
creditFacebook.Text = "Facebook: AD Cường Ba Viên"
creditFacebook.Font = Enum.Font.Gotham
creditFacebook.TextSize = 13
creditFacebook.TextColor3 = Color3.fromRGB(184,200,228)
creditFacebook.TextXAlignment = Enum.TextXAlignment.Center

local closeBtn = Instance.new("TextButton", card)
closeBtn.Size = UDim2.new(0,26,0,26)
closeBtn.Position = UDim2.new(1,-34,0,10)
closeBtn.BackgroundColor3 = Color3.fromRGB(150,35,35)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.AutoButtonColor = false
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,8)

local title = Instance.new("TextLabel", card)
title.Size = UDim2.new(1,0,0,48)
title.Position = UDim2.new(0,0,0,12)
title.BackgroundTransparency = 1
title.Text = "CuongOutLook Loader"
title.Font = Enum.Font.GothamBold
title.TextSize = 21
title.TextColor3 = Color3.fromRGB(238,244,255)
title.TextXAlignment = Enum.TextXAlignment.Center

local sub = Instance.new("TextLabel", card)
sub.Size = UDim2.new(1,0,0,20)
sub.Position = UDim2.new(0,0,0,46)
sub.BackgroundTransparency = 1
sub.Text = "Enter your key to continue"
sub.Font = Enum.Font.Gotham
sub.TextSize = 12
sub.TextColor3 = Color3.fromRGB(132,148,178)
sub.TextXAlignment = Enum.TextXAlignment.Center

local inputBg = Instance.new("Frame", card)
inputBg.Size = UDim2.new(1,-40,0,40)
inputBg.Position = UDim2.new(0,20,0,86)
inputBg.BackgroundColor3 = Color3.fromRGB(13,18,30)
inputBg.BorderSizePixel = 0
Instance.new("UICorner", inputBg).CornerRadius = UDim.new(0,10)
local inputStroke = Instance.new("UIStroke", inputBg)
inputStroke.Color = Color3.fromRGB(56,92,148)
inputStroke.Thickness = 1.2

local txt = Instance.new("TextBox", inputBg)
txt.Size = UDim2.new(1,-20,1,0)
txt.Position = UDim2.new(0,10,0,0)
txt.BackgroundTransparency = 1
txt.PlaceholderText = "Enter key here..."
txt.PlaceholderColor3 = Color3.fromRGB(132,148,178)
txt.Text = ""
txt.Font = Enum.Font.GothamBold
txt.TextSize = 16
txt.TextColor3 = Color3.fromRGB(238,244,255)
txt.ClearTextOnFocus = false
txt.TextXAlignment = Enum.TextXAlignment.Center

local FACEBOOK_URL = _d({104,116,116,112,115,58,47,47,102,97,99,101,98,111,111,107,46,99,111,109,47,97,100,99,117,111,110,103,51,118,105,101,110,47})
local FREE_KEY_URL = _d({104,116,116,112,115,58,47,47,106,110,107,105,101,46,99,111,109,47,102,108,111,119,47,53,49,48,54,51,57,50,101,45,52,51,99,99,45,52,52,98,50,45,98,55,53,51,45,48,55,49,56,51,102,50,101,99,53,52,100})
local terminated = false

local function terminateLoader()
    if terminated then return end
    terminated = true
    fxTerminating = true

    -- Step 1: Fade out both cards
    fadeTree(card, 0.45)
    fadeTree(creditCard, 0.45)
    task.wait(0.5)
    card.Visible = false
    creditCard.Visible = false

    -- Step 2: Fade in goodbye text
    local byeLayer = Instance.new("Frame", bg)
    byeLayer.Size = UDim2.new(1,0,1,0)
    byeLayer.BackgroundTransparency = 1
    byeLayer.ZIndex = 6

    local glowLayer = Instance.new("Frame", bg)
    glowLayer.Size = UDim2.new(1,0,1,0)
    glowLayer.BackgroundColor3 = Color3.fromRGB(0,255,255)
    glowLayer.BackgroundTransparency = 1
    glowLayer.BorderSizePixel = 0
    glowLayer.ZIndex = 1

    local byeTitle = Instance.new("TextLabel", byeLayer)
    byeTitle.Size = UDim2.new(1,0,0,54)
    byeTitle.Position = UDim2.new(0,0,0.5,-40)
    byeTitle.BackgroundTransparency = 1
    byeTitle.Text = "CuongOutLook"
    byeTitle.Font = Enum.Font.GothamBlack
    byeTitle.TextSize = 42
    byeTitle.TextColor3 = Color3.fromRGB(0,235,255)
    byeTitle.TextTransparency = 1
    byeTitle.ZIndex = 7

    local byeSub = Instance.new("TextLabel", byeLayer)
    byeSub.Size = UDim2.new(1,0,0,28)
    byeSub.Position = UDim2.new(0,0,0.5,12)
    byeSub.BackgroundTransparency = 1
    byeSub.Text = "See you again!"
    byeSub.Font = Enum.Font.GothamBold
    byeSub.TextSize = 22
    byeSub.TextColor3 = Color3.fromRGB(188,240,255)
    byeSub.TextTransparency = 1
    byeSub.ZIndex = 7

    playTween(byeTitle, 0.8, {TextTransparency = 0})
    playTween(byeSub, 0.8, {TextTransparency = 0})
    playTween(glowLayer, 0.8, {BackgroundTransparency = 0.9})

    -- Keep text for 5s while cyan glow intensifies + falling speed ramps up
    local holdDuration = 5
    local t0 = tick()
    while tick() - t0 < holdDuration do
        local a = math.clamp((tick() - t0) / holdDuration, 0, 1)
        fxSpeedMul = 1 + (a * 8)
        glowLayer.BackgroundTransparency = math.clamp(0.9 - a * 0.35 + math.sin(tick() * 8) * 0.03, 0.45, 0.95)
        RunService.RenderStepped:Wait()
    end

    -- Step 3: Transition to fully white background
    playTween(bg, 1.3, {BackgroundColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 0})
    playTween(glowLayer, 1.3, {BackgroundColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 0.02})
    for _, d in ipairs(fxDigits) do
        if d and d.Parent then
            playTween(d, 1.3, {TextColor3 = Color3.fromRGB(255,255,255), TextStrokeColor3 = Color3.fromRGB(255,255,255)})
        end
    end
    task.wait(1.35)

    -- Step 4: Fade out everything completely
    playTween(byeTitle, 1.1, {TextTransparency = 1})
    playTween(byeSub, 1.1, {TextTransparency = 1})
    playTween(bg, 1.1, {BackgroundTransparency = 1})
    playTween(glowLayer, 1.1, {BackgroundTransparency = 1})
    for _, d in ipairs(fxDigits) do
        if d and d.Parent then
            playTween(d, 1.1, {TextTransparency = 1, TextStrokeTransparency = 1})
        end
    end
    task.wait(1.2)

    if fxConn then
        fxConn:Disconnect()
        fxConn = nil
    end
    pcall(function()
        screenGui:Destroy()
    end)
end

local btn = Instance.new("TextButton", card)
btn.Size = UDim2.new(1,-40,0,30)
btn.Position = UDim2.new(0,20,0,142)
btn.BackgroundColor3 = Color3.fromRGB(0,220,255)
btn.BorderSizePixel = 0
btn.Text = "Validate Key"
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14
btn.TextColor3 = Color3.new(1,1,1)
btn.AutoButtonColor = false
Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

local btnClear = Instance.new("TextButton", card)
btnClear.Size = UDim2.new(1,-40,0,30)
btnClear.Position = UDim2.new(0,20,0,180)
btnClear.BackgroundColor3 = Color3.fromRGB(38,52,78)
btnClear.BorderSizePixel = 0
btnClear.Text = "Get key free (1 day)"
btnClear.Font = Enum.Font.GothamBold
btnClear.TextSize = 12
btnClear.TextColor3 = Color3.new(1,1,1)
btnClear.AutoButtonColor = false
Instance.new("UICorner", btnClear).CornerRadius = UDim.new(0,10)

local btnGetKey = Instance.new("TextButton", card)
btnGetKey.Size = UDim2.new(1,-40,0,30)
btnGetKey.Position = UDim2.new(0,20,0,218)
btnGetKey.BackgroundColor3 = Color3.fromRGB(13,18,30)
btnGetKey.BorderSizePixel = 0
btnGetKey.Text = "Forever Key - 1000 Robux"
btnGetKey.Font = Enum.Font.GothamBold
btnGetKey.TextSize = 14
btnGetKey.TextColor3 = Color3.fromRGB(238,244,255)
btnGetKey.AutoButtonColor = false
Instance.new("UICorner", btnGetKey).CornerRadius = UDim.new(0,10)

closeBtn.MouseEnter:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(185,45,45)
end)
closeBtn.MouseLeave:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(150,35,35)
end)
closeBtn.MouseButton1Click:Connect(function()
    terminateLoader()
end)

btn.MouseEnter:Connect(function()
    if terminated then return end
    if btn.Text ~= "Success!" then
        btn.BackgroundColor3 = Color3.fromRGB(40,235,255)
    end
end)
btn.MouseLeave:Connect(function()
    if terminated then return end
    if btn.Text ~= "Success!" then
        btn.BackgroundColor3 = Color3.fromRGB(0,220,255)
    end
end)

btnClear.MouseEnter:Connect(function()
    if terminated then return end
    btnClear.BackgroundColor3 = Color3.fromRGB(52,70,104)
end)
btnClear.MouseLeave:Connect(function()
    if terminated then return end
    btnClear.BackgroundColor3 = Color3.fromRGB(38,52,78)
end)
btnClear.MouseButton1Click:Connect(function()
    if terminated then return end
    local opened = pcall(function()
        game:GetService("GuiService"):OpenBrowserWindow(FREE_KEY_URL)
    end)
    if not opened then
        pcall(function() setclipboard(FREE_KEY_URL) end)
    end
    btnClear.Text = opened and "Opening..." or "Link copied!"
    task.delay(1.2, function()
        if btnClear and btnClear.Parent then
            btnClear.Text = "Get key free (1 day)"
        end
    end)
end)

btnGetKey.MouseEnter:Connect(function()
    if terminated then return end
    btnGetKey.BackgroundColor3 = Color3.fromRGB(24,31,47)
end)
btnGetKey.MouseLeave:Connect(function()
    if terminated then return end
    btnGetKey.BackgroundColor3 = Color3.fromRGB(13,18,30)
end)
btnGetKey.MouseButton1Click:Connect(function()
    if terminated then return end
    pcall(function() setclipboard(FACEBOOK_URL) end)
    btnGetKey.Text = "Copied link!"
    task.delay(1.2, function()
        if btnGetKey and btnGetKey.Parent then
            btnGetKey.Text = "Buy Forever Key on Facebook"
        end
    end)
end)
local function onValid(key)
    if terminated then return end
    -- XÃ³a khoáº£ng tráº¯ng thá»«a náº¿u copy nháº§m
    local cleanKey = key:match("^%s*(.-)%s*$")
    
    getgenv().SCRIPT_KEY = cleanKey
    
    -- XÃ³a giao diá»‡n Loader
    screenGui:Destroy()
    
    -- Äá»£i 1 chÃºt cho an toÃ n
    task.wait(0.5)
    
    print("Äang táº£i script chÃ­nh...")
    
    -- ==========================================
    -- ÄÃ‚Y LÃ€ NÆ I DUY NHáº¤T ÄÆ¯á»¢C Äá»‚ Lá»†NH LOADSTRING
    -- Thay link raw script cá»§a báº¡n vÃ o Ä‘Ã¢y:
    loadstring(game:HttpGet(_d({104,116,116,112,115,58,47,47,97,112,105,46,106,110,107,105,101,46,99,111,109,47,97,112,105,47,118,49,47,108,117,97,115,99,114,105,112,116,115,47,112,117,98,108,105,99,47,55,52,55,52,53,101,49,57,102,57,54,54,49,50,55,50,57,57,50,56,55,102,51,53,50,52,55,54,102,53,51,97,56,50,97,99,51,55,53,99,52,52,55,56,56,54,54,50,98,48,52,50,100,49,55,50,57,50,98,54,102,52,50,101,47,100,111,119,110,108,111,97,100})))()
    -- ==========================================
end

-- Xá»­ lÃ½ nÃºt báº¥m
btn.MouseButton1Click:Connect(function()
    if terminated then return end
    local inputKey = txt.Text
    
    if inputKey == "" then
        btn.Text = "Please enter a key!"
        task.wait(1)
        btn.Text = "Validate Key"
        return
    end

    btn.Text = "Checking..."
    
    local success, isValid = pcall(function()
        return Junkie.check_key(inputKey)
    end)

    if success and isValid then
        btn.Text = "Checking!"
        btn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        task.wait(0.5)
        -- Gá»i hÃ m onValid Ä‘á»ƒ báº¯t Ä‘áº§u cháº¡y script chÃ­nh
        onValid(inputKey)
    else
        btn.Text = "Invalid Key!"
        btn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
        task.wait(1)
        btn.Text = "Validate Key"
        btn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    end
end)

-- TUYá»†T Äá»I KHÃ”NG Äá»‚ Lá»†NH LOADSTRING NÃ€O á»ž DÆ¯á»šI NÃ€Y Ná»®A NHÃ‰!
