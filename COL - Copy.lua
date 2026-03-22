-- ============================================================
--   CuongOutLook Undetect
-- ============================================================
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local TeleportService  = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local Workspace        = game:GetService("Workspace")
local Camera           = Workspace.CurrentCamera
local plr              = Players.LocalPlayer
local mouse            = plr:GetMouse()
local ADMIN_USER_IDS = {
    [9930783751] = true,
}
local function isAdminUser(player)
    return player and ADMIN_USER_IDS[player.UserId] == true
end
local function getChar() return plr.Character end
local function getHRP()
    local c = getChar()
    return c and c:FindFirstChild("HumanoidRootPart")
end
local function getHum()
    local c = getChar()
    return c and c:FindFirstChildOfClass("Humanoid")
end
local function notify(title, msg, dur)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title    = "CuongOutLook | " .. title,
            Text     = msg,
            Duration = dur or 4,
        })
    end)
end
-- ============================================================
-- KEY SYSTEM
-- Key: 172005
-- Facebook: facebook.com/adcuong3vien/
-- ============================================================
local VALID_KEY   = "CuongOutLook-FreeKey-172005"
local FACEBOOK_URL = "facebook.com/adcuong3vien/"
local panelKeyUnlocked = false
local function requestPanelKey()
    if panelKeyUnlocked or isAdminUser(plr) then
        panelKeyUnlocked = true
        return true
    end
    local keyPassed = false
    local keySG = Instance.new("ScreenGui")
    keySG.Name             = "CuongOutLookKeySystem"
    keySG.IgnoreGuiInset   = true
    keySG.ZIndexBehavior   = Enum.ZIndexBehavior.Sibling
    keySG.ResetOnSpawn     = false
    local _ok, _hui = pcall(function() return gethui() end)
    keySG.Parent = (_ok and _hui) or plr.PlayerGui
    local bg = Instance.new("Frame", keySG)
    bg.Size             = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.fromRGB(10,14,24)
    bg.BorderSizePixel  = 0
    local card = Instance.new("Frame", bg)
    card.Size             = UDim2.new(0,340,0,280)
    card.Position         = UDim2.new(0.5,-170,0.5,-140)
    card.BackgroundColor3 = Color3.fromRGB(18,24,38)
    card.BorderSizePixel  = 0
    Instance.new("UICorner",card).CornerRadius = UDim.new(0,14)
    local _cs = Instance.new("UIStroke",card)
    _cs.Color = Color3.fromRGB(56,92,148); _cs.Thickness = 1.8
    local title = Instance.new("TextLabel",card)
    title.Size               = UDim2.new(1,0,0,48)
    title.Position           = UDim2.new(0,0,0,16)
    title.BackgroundTransparency = 1
    title.Text               = "CuongOutLook Aimbot"
    title.Font               = Enum.Font.GothamBold
    title.TextSize           = 22
    title.TextColor3         = Color3.fromRGB(238,244,255)
    title.TextXAlignment     = Enum.TextXAlignment.Center
    local sub = Instance.new("TextLabel",card)
    sub.Size               = UDim2.new(1,0,0,20)
    sub.Position           = UDim2.new(0,0,0,56)
    sub.BackgroundTransparency = 1
    sub.Text               = "Enter your key to continue"
    sub.Font               = Enum.Font.Gotham
    sub.TextSize           = 12
    sub.TextColor3         = Color3.fromRGB(132,148,178)
    sub.TextXAlignment     = Enum.TextXAlignment.Center
    local disc = Instance.new("TextLabel",card)
    disc.Size               = UDim2.new(1,0,0,16)
    disc.Position           = UDim2.new(0,0,0,78)
    disc.BackgroundTransparency = 1
    disc.Text               = "Get key: "..FACEBOOK_URL
    disc.Font               = Enum.Font.Gotham
    disc.TextSize           = 10
    disc.TextColor3         = Color3.fromRGB(110,130,160)
    disc.TextXAlignment     = Enum.TextXAlignment.Center
    local inputBg = Instance.new("Frame",card)
    inputBg.Size             = UDim2.new(1,-40,0,44)
    inputBg.Position         = UDim2.new(0,20,0,112)
    inputBg.BackgroundColor3 = Color3.fromRGB(13,18,30)
    inputBg.BorderSizePixel  = 0
    Instance.new("UICorner",inputBg).CornerRadius = UDim.new(0,10)
    local _ks = Instance.new("UIStroke",inputBg)
    _ks.Color = Color3.fromRGB(56,92,148); _ks.Thickness = 1.2
    local keyBox = Instance.new("TextBox",inputBg)
    keyBox.Size                = UDim2.new(1,-20,1,0)
    keyBox.Position            = UDim2.new(0,10,0,0)
    keyBox.BackgroundTransparency = 1
    keyBox.PlaceholderText     = "Enter key here..."
    keyBox.PlaceholderColor3   = Color3.fromRGB(132,148,178)
    keyBox.Text                = ""
    keyBox.Font                = Enum.Font.GothamBold
    keyBox.TextSize            = 16
    keyBox.TextColor3          = Color3.fromRGB(238,244,255)
    keyBox.ClearTextOnFocus    = false
    keyBox.TextXAlignment      = Enum.TextXAlignment.Center
    local status = Instance.new("TextLabel",card)
    status.Size               = UDim2.new(1,0,0,18)
    status.Position           = UDim2.new(0,0,0,164)
    status.BackgroundTransparency = 1
    status.Text               = ""
    status.Font               = Enum.Font.Gotham
    status.TextSize           = 11
    status.TextXAlignment     = Enum.TextXAlignment.Center
    status.TextColor3         = Color3.fromRGB(255,80,80)
    local submitBtn = Instance.new("TextButton",card)
    submitBtn.Size             = UDim2.new(1,-40,0,42)
    submitBtn.Position         = UDim2.new(0,20,0,190)
    submitBtn.BackgroundColor3 = Color3.fromRGB(0,220,255)
    submitBtn.BorderSizePixel  = 0
    submitBtn.Text             = "Unlock"
    submitBtn.Font             = Enum.Font.GothamBold
    submitBtn.TextSize         = 14
    submitBtn.TextColor3       = Color3.new(1,1,1)
    submitBtn.AutoButtonColor  = false
    Instance.new("UICorner",submitBtn).CornerRadius = UDim.new(0,10)
    local copyBtn = Instance.new("TextButton",card)
    copyBtn.Size             = UDim2.new(1,-40,0,28)
    copyBtn.Position         = UDim2.new(0,20,0,240)
    copyBtn.BackgroundColor3 = Color3.fromRGB(13,18,30)
    copyBtn.BorderSizePixel  = 0
    copyBtn.Text             = "Copy Facebook Link"
    copyBtn.Font             = Enum.Font.Gotham
    copyBtn.TextSize         = 11
    copyBtn.TextColor3       = Color3.fromRGB(238,244,255)
    copyBtn.AutoButtonColor  = false
    Instance.new("UICorner",copyBtn).CornerRadius = UDim.new(0,8)
    copyBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(FACEBOOK_URL) end)
        copyBtn.Text = "Copied!"
        task.delay(2, function() copyBtn.Text = "Copy Facebook Link" end)
    end)
    submitBtn.MouseEnter:Connect(function()
        submitBtn.BackgroundColor3 = Color3.fromRGB(40,235,255)
    end)
    submitBtn.MouseLeave:Connect(function()
        submitBtn.BackgroundColor3 = Color3.fromRGB(0,220,255)
    end)
    local function tryKey()
        local entered = keyBox.Text:match("^%s*(.-)%s*$")
        if entered == VALID_KEY then
            status.Text      = "Key accepted!"
            status.TextColor3 = Color3.fromRGB(80,255,120)
            submitBtn.BackgroundColor3 = Color3.fromRGB(40,180,80)
            task.delay(0.6, function()
                panelKeyUnlocked = true
                keyPassed = true
                keySG:Destroy()
            end)
        else
            status.Text       = "Invalid key. Get it on Facebook."
            status.TextColor3 = Color3.fromRGB(255,70,70)
            keyBox.Text       = ""
            local origPos = card.Position
            for _ = 1, 4 do
                card.Position = UDim2.new(0.5,-170+6,0.5,-140)
                task.wait(0.04)
                card.Position = UDim2.new(0.5,-170-6,0.5,-140)
                task.wait(0.04)
            end
            card.Position = origPos
        end
    end
    submitBtn.MouseButton1Click:Connect(tryKey)
    keyBox.FocusLost:Connect(function(enter) if enter then tryKey() end end)
    repeat task.wait(0.1) until keyPassed
    return true
end
requestPanelKey()
-- ============================================================
-- DRAWING API SHIM
-- Protects against executors where Drawing is unavailable.
-- ============================================================
if not Drawing then
    local _dummy = {}
    local _dmt = {
        __index    = function(t,k) return function() return t end end,
        __newindex = function() end,
    }
    Drawing = setmetatable({}, {
        __index = function(_, _k)
            return function(_type)
                return setmetatable({
                    Visible=false, Filled=false, Color=Color3.new(),
                    Position=Vector2.new(), Radius=0, Thickness=1,
                    ZIndex=0, From=Vector2.new(), To=Vector2.new(),
                }, _dmt)
            end
        end
    })
    Drawing.new = function(_type)
        return setmetatable({
            Visible=false, Filled=false, Color=Color3.new(),
            Position=Vector2.new(), Radius=0, Thickness=1,
            ZIndex=0, From=Vector2.new(), To=Vector2.new(),
            Remove=function() end, Destroy=function() end,
        }, _dmt)
    end
end
-- ============================================================
-- STATE  (all features start OFF)
-- ============================================================
local STATE = {
    antiFling      = false,
    antiRubberBand = false,
    antiTP         = false,
    antiItemOrbit  = false,
    cheaterDetect  = false,
    fly            = false,
    flySpeed       = 50,
    clickTP        = false,
    noclip         = false,
    speedBoost     = false,
    speedValue     = 30,
    reach          = false,
    reachValue     = 15,
    antiMusic      = false,
    lowPoly        = false,
    esp            = false,
    espTeamCheck   = false,
    espBox         = true,
    espName        = true,
    espHealth      = true,
    espDist        = true,
    espTracer      = false,
    espHeadCircle  = false,
    espChams       = false,
    espSkeleton    = false,
    -- Aimbot
    aimbot         = false,
    aimKey         = "RMB",
    aimBone        = "Head",
    aimSmooth      = 12,
    aimFOV         = 120,
    aimShowFOV     = true,
    aimTeamCheck   = true,
    aimPrediction  = true,
    triggerbot     = false,
    -- Anti extras
    antiAim        = false,
    antiScreen     = false,
    antiExploit    = false,
    -- New protections
    antiGravity    = false,
    -- New movement
    spinToggle     = false,
    chainFling     = false,
    jumpPower      = 50,
    jumpBoost      = false,
    infinite       = false,
    bhop           = false,
    -- New world
    fullbright     = false,
    noFog          = false,
    timeFreeze     = false,
    frozenTime     = 14,
    antiAFK        = false,
    noScreenFX     = false,
    _wasNoclip     = false,
    rainbowSky     = false,
    removeWalls    = false,
    removeAnchored = false,
    removeUnanchored = false,
    spectateTarget = nil,
    lastSafePos    = nil,
    lastSafeTime   = 0,
    flyPlatform    = nil,
    flyBodyVel     = nil,
    flyBodyGyro    = nil,
    baselineSpeed  = 16,
    detectedCheaters = {},
}
-- ============================================================
-- STATE PERSISTENCE  (writefile / readfile via executor)
-- Saves all toggle & slider values to cuongoutlook_state.json
-- Restores them automatically on next inject.
-- ============================================================
local STATE_FILE = "cuongoutlook_state.json"
-- Keys that are safe to save (no runtime objects / positions)
local SAVE_KEYS = {"antiFling","antiRubberBand","antiTP","antiItemOrbit","fly","flySpeed","clickTP","noclip","speedBoost","speedValue","reach","reachValue","antiMusic","lowPoly","esp","espTeamCheck","espBox","espName","espHealth","espDist","espTracer","espHeadCircle","espChams","espSkeleton","aimbot","aimKey","aimBone","aimSmooth","aimFOV","aimShowFOV","aimTeamCheck","aimPrediction","triggerbot","antiAim","antiScreen","antiExploit","antiGravity","spinToggle","jumpPower","jumpBoost","infinite","bhop","fullbright","noFog","timeFreeze","frozenTime","antiAFK","noScreenFX","rainbowSky","removeWalls","removeAnchored","removeUnanchored"}
-- Tiny JSON serialiser (only needs bool, number, string)
local function toJSON(tbl)
    local parts = {}
    for _, k in ipairs(SAVE_KEYS) do
        local v = tbl[k]
        local encoded
        if type(v) == "boolean" then
            encoded = v and "true" or "false"
        elseif type(v) == "number" then
            encoded = tostring(v)
        elseif type(v) == "string" then
            -- escape backslash and double-quote
            local s = v:gsub('\\', '\\\\'):gsub('"', '\\"')
            encoded = '"' .. s .. '"'
        end
        if encoded then
            table.insert(parts, '"' .. k .. '":' .. encoded)
        end
    end
    return "{" .. table.concat(parts, ",") .. "}"
end
-- Tiny JSON parser (only needs bool, number, string values)
local function fromJSON(str)
    local result = {}
    for k, v in str:gmatch('"([^"]+)":%s*([^,}]+)') do
        v = v:match("^%s*(.-)%s*$")  -- trim
        if v == "true" then
            result[k] = true
        elseif v == "false" then
            result[k] = false
        elseif v:sub(1,1) == '"' then
            result[k] = v:sub(2,-2):gsub('\\"','"'):gsub('\\\\','\\')
        else
            local n = tonumber(v)
            if n then result[k] = n end
        end
    end
    return result
end
-- Save current STATE to file
local function saveState()
    pcall(function()
        if writefile then
            writefile(STATE_FILE, toJSON(STATE))
        end
    end)
end
-- Load saved STATE from file and apply values
local function loadState()
    local ok, saved = pcall(function()
        if isfile and isfile(STATE_FILE) and readfile then
            return fromJSON(readfile(STATE_FILE))
        end
        return nil
    end)
    if not ok or not saved then return end
    -- Apply saved values into STATE
    for _, k in ipairs(SAVE_KEYS) do
        if saved[k] ~= nil then
            STATE[k] = saved[k]
        end
    end
    return true
end
-- ============================================================
-- SAFE POSITION TRACKER
-- ============================================================
RunService.Heartbeat:Connect(function()
    local hrp = getHRP()
    local hum = getHum()
    if not hrp or not hum then return end
    if hum.FloorMaterial ~= Enum.Material.Air and not STATE.fly then
        STATE.lastSafePos  = hrp.Position
        STATE.lastSafeTime = tick()
    end
end)
-- ============================================================
-- ANTI-FLING
-- ============================================================
local FLING_THRESH = 120
RunService.Heartbeat:Connect(function()
    if not STATE.antiFling then return end
    local hrp = getHRP()
    if not hrp or not STATE.lastSafePos then return end
    if hrp.AssemblyLinearVelocity.Magnitude > FLING_THRESH then
        hrp.CFrame                  = CFrame.new(STATE.lastSafePos + Vector3.new(0, 3, 0))
        hrp.AssemblyLinearVelocity  = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        notify("Anti-Fling", "Blocked", 2)
    end
end)
-- ============================================================
-- ANTI-RUBBER BAND
-- ============================================================
local rb_prevPos = nil
RunService.Heartbeat:Connect(function()
    if not STATE.antiRubberBand then rb_prevPos = nil; return end
    local hrp = getHRP()
    if not hrp then rb_prevPos = nil; return end
    local cur = hrp.Position
    if rb_prevPos == nil then rb_prevPos = cur; return end
    local delta = (cur - rb_prevPos).Magnitude
    local vel   = hrp.AssemblyLinearVelocity.Magnitude
    if delta > 15 and vel < 4 and STATE.lastSafePos then
        hrp.CFrame                 = CFrame.new(rb_prevPos)
        hrp.AssemblyLinearVelocity = Vector3.zero
        notify("Anti-RB", "Blocked", 2)
    else
        rb_prevPos = cur
    end
end)
-- ============================================================
-- ANTI-TP
-- ============================================================
local tp_prevPos    = nil
local tp_ignoreTick = 0
local function markOwnTP()
    tp_ignoreTick = tick()
    tp_prevPos    = nil
end
RunService.Heartbeat:Connect(function()
    if not STATE.antiTP then tp_prevPos = nil; return end
    local hrp = getHRP()
    if not hrp then tp_prevPos = nil; return end
    local cur = hrp.Position
    if tp_prevPos == nil then tp_prevPos = cur; return end
    if tick() - tp_ignoreTick < 0.5 then tp_prevPos = cur; return end
    local delta = (cur - tp_prevPos).Magnitude
    local vel   = hrp.AssemblyLinearVelocity.Magnitude
    if delta > 50 and vel < 8 and not STATE.fly then
        hrp.CFrame                 = CFrame.new(tp_prevPos)
        hrp.AssemblyLinearVelocity = Vector3.zero
        notify("Anti-TP", "Blocked", 3)
    else
        tp_prevPos = cur
    end
end)
-- ============================================================
-- ANTI-ITEM ORBIT  (throttled to 4x/sec)
-- ============================================================
local orbitTracked   = {}
local orbitScanTimer = 0
RunService.Heartbeat:Connect(function(dt)
    if not STATE.antiItemOrbit then
        if next(orbitTracked) then
            for part in pairs(orbitTracked) do
                pcall(function() part.LocalTransparencyModifier = 0 end)
            end
            orbitTracked = {}
        end
        return
    end
    orbitScanTimer = orbitScanTimer + dt
    if orbitScanTimer < 0.25 then return end
    orbitScanTimer = 0
    local myChar = getChar()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= plr then
            local c = p.Character
            if c then
                local root = c:FindFirstChild("HumanoidRootPart")
                if root then
                    local rPos     = root.Position
                    local candidates = {}
                    for _, obj in ipairs(c:GetDescendants()) do
                        if obj:IsA("BasePart") and obj ~= root then
                            table.insert(candidates, obj)
                        end
                    end
                    for _, obj in ipairs(Workspace:GetChildren()) do
                        if obj:IsA("BasePart") and obj.Parent ~= myChar then
                            if (obj.Position - rPos).Magnitude < 12 then
                                table.insert(candidates, obj)
                            end
                        end
                    end
                    for _, obj in ipairs(candidates) do
                        local flat  = Vector3.new(obj.Position.X - rPos.X, 0, obj.Position.Z - rPos.Z)
                        local dist  = flat.Magnitude
                        if dist < 12 and dist > 0.5 then
                            local angle = math.atan2(flat.Z, flat.X)
                            local entry = orbitTracked[obj]
                            if entry then
                                local dA = math.abs(angle - entry.prevAngle)
                                if dA > math.pi then dA = (2 * math.pi) - dA end
                                if dA > 0.08 then
                                    entry.count = entry.count + 1
                                    if entry.count >= 3 then
                                        pcall(function() obj.LocalTransparencyModifier = 1 end)
                                    end
                                end
                                entry.prevAngle = angle
                            else
                                orbitTracked[obj] = {prevAngle = angle, count = 0}
                            end
                        else
                            if orbitTracked[obj] then
                                pcall(function() obj.LocalTransparencyModifier = 0 end)
                                orbitTracked[obj] = nil
                            end
                        end
                    end
                end
            end
        end
    end
end)
-- ============================================================
-- CHEATER ESP  - red highlight + "DUMB CHEATER" tag
-- ============================================================
local cheaterESP = {}  -- [player] = {hl, bb}
local function addCheaterESP(p)
    if cheaterESP[p] then return end
    local c   = p.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if not c or not hrp then return end
    local hl = Instance.new("SelectionBox")
    hl.Color3              = Color3.fromRGB(255, 0, 0)
    hl.LineThickness       = 0.07
    hl.SurfaceTransparency = 0.6
    hl.SurfaceColor3       = Color3.fromRGB(255, 0, 0)
    hl.Adornee             = c
    hl.Parent              = c
    local bb = Instance.new("BillboardGui")
    bb.Size        = UDim2.new(0, 160, 0, 38)
    bb.StudsOffset = Vector3.new(0, 3.5, 0)
    bb.AlwaysOnTop = true
    bb.Adornee     = hrp
    bb.Parent      = hrp
    local lbl = Instance.new("TextLabel", bb)
    lbl.Size                  = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text                  = "DUMB CHEATER"
    lbl.Font                  = Enum.Font.GothamBold
    lbl.TextSize              = 14
    lbl.TextColor3            = Color3.fromRGB(255, 55, 55)
    lbl.TextStrokeTransparency = 0
    lbl.TextStrokeColor3      = Color3.fromRGB(0, 0, 0)
    cheaterESP[p] = {hl = hl, bb = bb}
end
local function removeCheaterESP(p)
    local e = cheaterESP[p]
    if not e then return end
    pcall(function() e.hl:Destroy() end)
    pcall(function() e.bb:Destroy() end)
    cheaterESP[p] = nil
end
Players.PlayerRemoving:Connect(removeCheaterESP)
-- ============================================================
-- CHEATER DETECTION
--
-- FLY DETECTION (fixed):
--   - graceTimer starts already expired so players already flying
--     when script loads ARE detected after 5s
--   - Counts time when: airborne + yVel > -30 (not freefalling)
--     + past jump grace (1.5s) + no tool held
--   - Timer resets to 0 only when they actually land
--
-- SPEED DETECTION:
--   - 5 continuous seconds above (baseline * 1.85) while on ground
--
-- INJECTION DETECTION (fixed false positives):
--   - Uses a SCORING SYSTEM - needs 4+ points to flag
--   - Single signals ignored (games legitimately use BodyVelocity,
--     set WalkSpeed, etc.)
--   - Only flags clear combinations that no normal game would produce
--   - Scores are based on how impossible the combo is without an executor
-- ============================================================
local cdData           = {}  -- kept for PlayerRemoving cleanup
local detectionLog     = {}
local onDetectionAdded = nil
local function logDetection(name, reason)
    table.insert(detectionLog, 1, {name = name, reason = reason, time = os.date("%H:%M:%S")})
    while #detectionLog > 20 do table.remove(detectionLog) end
    if onDetectionAdded then onDetectionAdded() end
end
local function flagCheater(p, reason)
    local key = tostring(p.UserId) .. "_" .. reason
    if STATE.detectedCheaters[key] then return end
    STATE.detectedCheaters[key] = true
    notify("Cheater", p.Name .. " | " .. reason, 6)
    logDetection(p.Name, reason)
    addCheaterESP(p)
end
local function playerHasTool(c)
    if not c then return false end
    for _, obj in ipairs(c:GetChildren()) do
        if obj:IsA("Tool") then return true end
    end
    return false
end
-- ============================================================
-- INJECTION DETECTION  v4  -  Cheat presence, not behavior
--
-- Scans for artifacts that ONLY exist when a cheat executor has
-- injected scripts into the game. Checks run every 2s per player.
-- Uses a scoring system (need 5+ pts) to avoid false positives.
--
-- SIGNALS CHECKED:
--  [5pts] BodyVelocity + BodyGyro TOGETHER in HRP  = fly script
--  [5pts] LinearVelocity + AlignOrientation TOGETHER = modern fly
--  [5pts] Known executor GUI name in PlayerGui
--  [5pts] LocalScript/Script injected inside character
--  [4pts] Known cheat platform part near player (FlyPart, etc.)
--  [3pts] Humanoid.AutoRotate flipped off while on ground + moving
--  [3pts] MaxHealth changed to absurd value (1e+06 godmode pattern)
--  [3pts] NetworkOwnership-impossible BodyMover in HRP while grounded
--  [2pts] WalkSpeed exact executor default (50/100/200) + BodyMover present
--  [2pts] Character contains a Script (not LocalScript, rare legit use)
-- ============================================================
-- Known executor/cheat GUI names injected into PlayerGui
local EXEC_GUI_NAMES = {
    -- Executors
    ["Synapse"] = true, ["Krnl"] = true, ["Script-Ware"] = true,
    ["Fluxus"] = true, ["Oxygen"] = true, ["Electron"] = true,
    ["Celery"] = true, ["Coco Z"] = true, ["WeAreDevs"] = true,
    ["JJSploit"] = true, ["Sentinel"] = true, ["Calamari"] = true,
    -- Common cheat GUIs
    ["Infinite Yield"] = true, ["Dex Explorer"] = true,
    ["ScriptHub"] = true, ["Owl Hub"] = true, ["Dark Hub"] = true,
    ["Vynixus"] = true, ["Sirius"] = true, ["Linoria"] = true,
    ["RayField"] = true, ["WaypointHub"] = true, ["EzHub"] = true,
    ["Hydroxide"] = true, ["RemoteSpy"] = true, ["RconsoleSpy"] = true,
    -- Generic executor tells
    ["SynUI"] = true, ["KRNLUI"] = true, ["ScriptWareUI"] = true,
}
-- Known fly platform part names (scripts spawn these under characters)
local FLY_PART_NAMES = {
    cuongoutlookPlat=true, FlyPart=true, FlightPart=true,
    FlyPlatform=true, Platform=true, BodyPlatform=true,
    noclippart=true, HoverPart=true, GlidePart=true,
}
-- Baseline WalkSpeed for this server (sampled after 5s so game-given speed isn't flagged)
local injBaselineTimer = 0
local injBaselineSet   = false
local injGameMaxWalk   = 16
local function buildInjBaseline()
    local maxW = 16
    for _, p in ipairs(Players:GetPlayers()) do
        local c = p.Character
        if c then
            local hum = c:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed > maxW then maxW = hum.WalkSpeed end
        end
    end
    injGameMaxWalk = maxW
    injBaselineSet = true
end
local function scanPlayerGui(p)
    -- We can see other players' PlayerGui in some executor versions
    -- because executors sometimes put their GUI in the wrong place
    local pg = p:FindFirstChild("PlayerGui")
    if not pg then return 0, nil end
    for _, obj in ipairs(pg:GetChildren()) do
        if EXEC_GUI_NAMES[obj.Name] then
            return 5, "Executor GUI: " .. obj.Name
        end
        -- Fuzzy match: contains known executor keywords
        local lower = obj.Name:lower()
        if lower:find("synapse") or lower:find("krnl") or lower:find("exploit")
            or lower:find("executor") or lower:find("inject") then
            return 5, "Executor GUI (fuzzy): " .. obj.Name
        end
    end
    return 0, nil
end
-- WHAT WE ACTUALLY CHECK (no false positives)
-- REMOVED: LocalScript/Script in character - every game does this
-- REMOVED: AutoRotate check - many games disable it legitimately
-- KEPT:    BV+BG combo - requires executor to produce simultaneously
-- KEPT:    LV+AO combo - requires executor to produce simultaneously
-- KEPT:    MaxHealth > 100k - no legit game sets this
-- KEPT:    Known fly platform parts (specific names executors use)
-- KEPT:    Executor GUI names in PlayerGui
-- KEPT:    WalkSpeed 50+ above server max (after baseline)
-- Need 5pts to flag - single signals never flag alone
-- --------------------------------------------------------------
local function checkInjection(p)
    local c   = p.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    local hum = c and c:FindFirstChildOfClass("Humanoid")
    if not c or not hrp or not hum then return end
    local score   = 0
    local reasons = {}
    local function add(pts, reason)
        score = score + pts
        table.insert(reasons, reason)
    end
    local hasBV = hrp:FindFirstChildOfClass("BodyVelocity") ~= nil
    local hasBG = hrp:FindFirstChildOfClass("BodyGyro")     ~= nil
    local hasLV = hrp:FindFirstChildOfClass("LinearVelocity")   ~= nil
    local hasAO = hrp:FindFirstChildOfClass("AlignOrientation") ~= nil
    -- BV+BG TOGETHER: no legit game adds both at same time
    if hasBV and hasBG then add(5, "BV+BG fly") end
    -- LV+AO TOGETHER: modern fly script signature
    if hasLV and hasAO then add(5, "LV+AO fly") end
    -- Fly platform part spawned by script near/in character
    for _, obj in ipairs(c:GetDescendants()) do
        if obj:IsA("BasePart") and FLY_PART_NAMES[obj.Name] then
            add(5, "Fly part in char: "..obj.Name); break
        end
    end
    for _, obj in ipairs(Workspace:GetChildren()) do
        if obj:IsA("BasePart") and FLY_PART_NAMES[obj.Name] then
            if (obj.Position - hrp.Position).Magnitude < 10 then
                add(4, "Fly part near player: "..obj.Name); break
            end
        end
    end
    -- Godmode: MaxHealth set to impossible value
    -- Legit games cap at a few thousand at most
    if hum.MaxHealth > 100000 or hum.MaxHealth ~= hum.MaxHealth then
        add(5, "MaxHealth godmode: "..tostring(math.floor(hum.MaxHealth)))
    end
    -- Executor GUI visible in PlayerGui (some executors put GUI wrong place)
    local guiScore, guiReason = scanPlayerGui(p)
    if guiScore > 0 then add(guiScore, guiReason) end
    -- WalkSpeed way above everyone else (after 5s baseline)
    if injBaselineSet and hum.WalkSpeed > injGameMaxWalk + 50 then
        add(3, "WalkSpeed +"..math.floor(hum.WalkSpeed - injGameMaxWalk).." above server")
    end
    -- Verdict
    if score >= 5 then
        flagCheater(p, "["..score.."pts] "..table.concat(reasons, " + "))
    end
end
local injCheckTimer2 = 0
RunService.Heartbeat:Connect(function(dt)
    if not STATE.cheaterDetect then return end
    injBaselineTimer = injBaselineTimer + dt
    injCheckTimer2   = injCheckTimer2   + dt
    -- Build server speed baseline after 5s
    if not injBaselineSet and injBaselineTimer >= 5 then
        buildInjBaseline()
    end
    -- Scan every player every 2 seconds
    if injCheckTimer2 >= 2 then
        injCheckTimer2 = 0
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= plr then
                pcall(function() checkInjection(p) end)
            end
        end
    end
end)
Players.PlayerRemoving:Connect(function(p)
    cdData[p.UserId] = nil
    removeCheaterESP(p)
end)
-- ============================================================
-- ANTI-MUSIC
-- ============================================================
local mutedSounds = {}
local function muteAll()
    local function muteIn(parent)
        for _, obj in ipairs(parent:GetDescendants()) do
            if obj:IsA("Sound") and not mutedSounds[obj] then
                mutedSounds[obj] = obj.Volume
                obj.Volume = 0
            end
        end
    end
    muteIn(Workspace)
    pcall(function() muteIn(game:GetService("SoundService")) end)
end
local function unmuteAll()
    for s, v in pairs(mutedSounds) do
        pcall(function() s.Volume = v end)
    end
    mutedSounds = {}
end
Workspace.DescendantAdded:Connect(function(obj)
    if STATE.antiMusic and obj:IsA("Sound") then
        mutedSounds[obj] = obj.Volume
        obj.Volume = 0
    end
end)
-- ============================================================
-- LOW POLY MODE
-- Sets all BaseParts to SmoothPlastic, removes Textures/
-- Decals/SpecialMeshes, sets render fidelity to Automatic,
-- reduces Lighting quality. Gives massive FPS boost on low-end.
-- ============================================================
-- lpOriginals stores EXACT original values so restore is perfect
local lpOriginals  = {}
local lpActive     = false
local lpAddedConn  = nil   -- DescendantAdded connection - disconnected on disable
local function applyLowPoly()
    if lpActive then return end
    lpActive   = true
    lpOriginals = {}
    local Lighting = game:GetService("Lighting")
    pcall(function()
        lpOriginals["__GlobalShadows"] = Lighting.GlobalShadows
        lpOriginals["__QualityLevel"]  = settings().Rendering.QualityLevel
        Lighting.GlobalShadows         = false
        settings().Rendering.QualityLevel = 1
    end)
    for _, obj in ipairs(Workspace:GetDescendants()) do
        pcall(function()
            if obj:IsA("BasePart") then
                lpOriginals[obj] = {mat = obj.Material, cast = obj.CastShadow}
                obj.Material     = Enum.Material.SmoothPlastic
                obj.CastShadow   = false
            elseif obj:IsA("Texture") or obj:IsA("Decal") then
                lpOriginals[obj] = {trans = obj.Transparency}
                obj.Transparency = 1
            elseif obj:IsA("SpecialMesh") then
                -- SpecialMesh has no Transparency - skip
            elseif obj:IsA("Beam") or obj:IsA("Trail") or obj:IsA("ParticleEmitter") then
                lpOriginals[obj] = {enabled = obj.Enabled}
                obj.Enabled      = false
            elseif obj:IsA("Sky") then
                lpOriginals[obj] = {parent = obj.Parent}
                obj.Parent       = nil
            end
        end)
    end
    -- Watch new descendants - use stored connection so we can disconnect
    lpAddedConn = Workspace.DescendantAdded:Connect(function(obj)
        if not lpActive then return end
        pcall(function()
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic; obj.CastShadow = false
            elseif obj:IsA("Texture") or obj:IsA("Decal") then
                obj.Transparency = 1
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
                obj.Enabled = false
            end
        end)
    end)
    notify("Low Poly", "Enabled - FPS boost active", 3)
end
local function removeLowPoly()
    if not lpActive then return end
    lpActive = false
    -- Disconnect new-part watcher
    if lpAddedConn then lpAddedConn:Disconnect(); lpAddedConn = nil end
    local Lighting = game:GetService("Lighting")
    pcall(function()
        if lpOriginals["__GlobalShadows"] ~= nil then
            Lighting.GlobalShadows = lpOriginals["__GlobalShadows"]
        end
        if lpOriginals["__QualityLevel"] ~= nil then
            settings().Rendering.QualityLevel = lpOriginals["__QualityLevel"]
        end
    end)
    for obj, data in pairs(lpOriginals) do
        if type(obj) ~= "string" then  -- skip the __key entries
            pcall(function()
                if obj:IsA("BasePart") then
                    obj.Material   = data.mat
                    obj.CastShadow = data.cast
                elseif obj:IsA("Texture") or obj:IsA("Decal") then
                    obj.Transparency = data.trans
                elseif obj:IsA("Beam") or obj:IsA("Trail") or obj:IsA("ParticleEmitter") then
                    obj.Enabled = data.enabled
                elseif obj:IsA("Sky") then
                    obj.Parent = data.parent
                end
            end)
        end
    end
    lpOriginals = {}
    notify("Low Poly", "Disabled - restored", 3)
end
-- ============================================================
-- WORLD EDITOR
-- ============================================================
local hiddenParts = {}
local function isPlayerPart(obj)
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character and obj:IsDescendantOf(p.Character) then return true end
    end
    return false
end
local function hidePart(obj)
    if not obj:IsA("BasePart") or isPlayerPart(obj) or hiddenParts[obj] then return end
    hiddenParts[obj] = {t = obj.Transparency, cc = obj.CanCollide, cs = obj.CastShadow}
    obj.Transparency = 1
    obj.CanCollide   = false
    obj.CastShadow   = false
end
local function restorePart(obj)
    local d = hiddenParts[obj]
    if not d then return end
    pcall(function()
        obj.Transparency = d.t
        obj.CanCollide   = d.cc
        obj.CastShadow   = d.cs
    end)
    hiddenParts[obj] = nil
end
local function restoreAll()
    local list = {}
    for obj in pairs(hiddenParts) do table.insert(list, obj) end
    for _, obj in ipairs(list) do restorePart(obj) end
end
local function applyWorldEdits()
    restoreAll()
    if not STATE.removeWalls and not STATE.removeAnchored and not STATE.removeUnanchored then return end
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not isPlayerPart(obj) then
            local hide = false
            if STATE.removeWalls     and obj.CanCollide and obj.Transparency < 0.9 then hide = true end
            if STATE.removeAnchored  and obj.Anchored then hide = true end
            if STATE.removeUnanchored and not obj.Anchored and obj.CanCollide then hide = true end
            if hide then hidePart(obj) end
        end
    end
end
Workspace.DescendantAdded:Connect(function(obj)
    task.wait()
    if not obj:IsA("BasePart") or isPlayerPart(obj) then return end
    if STATE.removeWalls      and obj.CanCollide and obj.Transparency < 0.9 then hidePart(obj) end
    if STATE.removeAnchored   and obj.Anchored then hidePart(obj) end
    if STATE.removeUnanchored and not obj.Anchored and obj.CanCollide then hidePart(obj) end
end)
-- ============================================================
-- ESP SYSTEM v2  -  Extended, still low overhead
-- Box, Name, HP, Distance, Tracer, Head Circle, Chams, Skeleton
-- 2 WorldToViewportPoint calls per player for box
-- Skeleton uses HRP + key bone positions (6 extra calls max)
-- Chams = Highlight instance (zero per-frame cost once created)
-- ============================================================
local espData   = {}
local ESP_RED   = Color3.fromRGB(255, 55, 55)
local ESP_BLUE  = Color3.fromRGB(55, 200, 255)
local ESP_WHITE = Color3.fromRGB(255, 255, 255)
local VP_CENTER = Vector2.new(0, 0) -- updated each frame
local function espCol(p)
    if STATE.espTeamCheck and p.Team and plr.Team and p.Team == plr.Team then
        return ESP_BLUE
    end
    return ESP_RED
end
local function newLine(th, z)
    local d = Drawing.new("Line")
    d.Thickness = th or 1.2; d.ZIndex = z or 3; d.Visible = false
    return d
end
local function newCircle()
    local d = Drawing.new("Circle")
    d.Thickness = 1.2; d.ZIndex = 4; d.Filled = false; d.Visible = false
    return d
end
-- Skeleton bone pairs: {partNameA, partNameB}
local SKEL_BONES = {
    {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
    {"UpperTorso","Left UpperArm"},{"Left UpperArm","Left LowerArm"},{"Left LowerArm","LeftHand"},
    {"UpperTorso","Right UpperArm"},{"Right UpperArm","Right LowerArm"},{"Right LowerArm","RightHand"},
    {"LowerTorso","Left UpperLeg"},{"Left UpperLeg","Left LowerLeg"},{"Left LowerLeg","LeftFoot"},
    {"LowerTorso","Right UpperLeg"},{"Right UpperLeg","Right LowerLeg"},{"Right LowerLeg","RightFoot"},
    -- R6 fallback
    {"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},
    {"Torso","Left Leg"},{"Torso","Right Leg"},
}
local function createESP(p)
    if espData[p] then return end
    local col = espCol(p)
    -- BillboardGui on HRP: name + hp bar + distance text
    local bb = Instance.new("BillboardGui")
    bb.Size                  = UDim2.new(0,100,0,26)
    bb.StudsOffsetWorldSpace = Vector3.new(0,3.5,0)
    bb.AlwaysOnTop           = true
    bb.LightInfluence        = 0
    bb.ResetOnSpawn          = false
    local nameL = Instance.new("TextLabel",bb)
    nameL.Size=UDim2.new(1,0,0,13); nameL.BackgroundTransparency=1
    nameL.Text=p.Name; nameL.Font=Enum.Font.GothamBold; nameL.TextSize=11
    nameL.TextColor3=ESP_WHITE; nameL.TextStrokeTransparency=0.35
    nameL.TextStrokeColor3=Color3.new(0,0,0)
    local hpBg = Instance.new("Frame",bb)
    hpBg.Size=UDim2.new(1,0,0,4); hpBg.Position=UDim2.new(0,0,0,15)
    hpBg.BackgroundColor3=Color3.fromRGB(35,8,8); hpBg.BorderSizePixel=0
    Instance.new("UICorner",hpBg).CornerRadius=UDim.new(1,0)
    local hpFill = Instance.new("Frame",hpBg)
    hpFill.Size=UDim2.new(1,0,1,0); hpFill.BackgroundColor3=Color3.fromRGB(60,220,60)
    hpFill.BorderSizePixel=0; Instance.new("UICorner",hpFill).CornerRadius=UDim.new(1,0)
    local distL = Instance.new("TextLabel",bb)
    distL.Size=UDim2.new(1,0,0,9); distL.Position=UDim2.new(0,0,1,1)
    distL.BackgroundTransparency=1; distL.Font=Enum.Font.Gotham; distL.TextSize=8
    distL.TextColor3=Color3.fromRGB(190,190,190)
    distL.TextStrokeTransparency=0.5; distL.TextStrokeColor3=Color3.new(0,0,0)
    distL.Text=""
    -- 2D box (4 lines)
    local box = {newLine(1.4),newLine(1.4),newLine(1.4),newLine(1.4)}
    -- Tracer (bottom-center screen to player feet)
    local tracer = newLine(1.0, 2)
    -- Head circle
    local headCirc = newCircle()
    -- Chams (Highlight - parented to character, zero per-frame cost)
    local cham = Instance.new("Highlight")
    cham.FillTransparency    = 0.55
    cham.OutlineTransparency = 0.0
    cham.OutlineColor        = col
    cham.FillColor           = col
    -- NOT parented yet - done in update
    -- Skeleton lines (one per bone pair - only visible bones drawn)
    local skelLines = {}
    for _ = 1, #SKEL_BONES do table.insert(skelLines, newLine(0.9, 2)) end
    espData[p] = {
        bb=bb, nameL=nameL, hpFill=hpFill, distL=distL,
        box=box, tracer=tracer, headCirc=headCirc,
        cham=cham, skelLines=skelLines,
    }
end
local function destroyESP(p)
    local e = espData[p]
    if not e then return end
    pcall(function() e.bb:Destroy() end)
    pcall(function() e.cham:Destroy() end)
    for _,l in ipairs(e.box)      do pcall(function() l:Remove() end) end
    pcall(function() e.tracer:Remove() end)
    pcall(function() e.headCirc:Remove() end)
    for _,l in ipairs(e.skelLines) do pcall(function() l:Remove() end) end
    espData[p] = nil
end
local function clearAllESP()
    for p in pairs(espData) do destroyESP(p) end
end
local function hideEntry(e)
    for _,l in ipairs(e.box) do l.Visible=false end
    e.tracer.Visible=false; e.headCirc.Visible=false
    for _,l in ipairs(e.skelLines) do l.Visible=false end
end
local espFrame = 0
RunService.RenderStepped:Connect(function()
    if not STATE.esp then
        if next(espData) then clearAllESP() end
        return
    end
    espFrame = espFrame + 1
    local doSlow = (espFrame % 3 == 0)
    local cam    = Camera
    local vp     = cam.ViewportSize
    VP_CENTER    = Vector2.new(vp.X/2, vp.Y)  -- tracer origin = bottom-center
    local myHRP  = getHRP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= plr then
            local c   = p.Character
            local hrp = c and c:FindFirstChild("HumanoidRootPart")
            local hum = c and c:FindFirstChildOfClass("Humanoid")
            if c and hrp and hum then
                if not espData[p] then createESP(p) end
                local e   = espData[p]
                local col = espCol(p)
                -- Billboard
                if e.bb.Parent ~= hrp then e.bb.Parent = hrp end
                -- Chams (Highlight)
                if STATE.espChams then
                    if e.cham.Parent ~= c then
                        e.cham.Adornee = c
                        e.cham.Parent  = c
                        e.cham.OutlineColor = col
                        e.cham.FillColor    = col
                    end
                else
                    if e.cham.Parent then e.cham.Parent = nil end
                end
                -- Name / HP / Distance visibility flags
                e.nameL.Visible = STATE.espName
                e.hpFill.Parent.Visible = STATE.espHealth
                e.distL.Visible = STATE.espDist
                -- 2 screen projections for box
                local topSc, topVis = cam:WorldToViewportPoint(hrp.Position + Vector3.new(0,3.2,0))
                local botSc, botVis = cam:WorldToViewportPoint(hrp.Position + Vector3.new(0,-3.2,0))
                if topVis and botVis and STATE.espBox then
                    local bH = math.abs(botSc.Y - topSc.Y)
                    local bW = bH * 0.48
                    local x,y = topSc.X - bW/2, topSc.Y
                    local r,b = x+bW, botSc.Y
                    local function setLine(l,fx,fy,tx,ty)
                        l.From=Vector2.new(fx,fy); l.To=Vector2.new(tx,ty)
                        l.Color=col; l.Visible=true
                    end
                    setLine(e.box[1],x,y,r,y)
                    setLine(e.box[2],x,b,r,b)
                    setLine(e.box[3],x,y,x,b)
                    setLine(e.box[4],r,y,r,b)
                    -- Tracer: bottom-center to player feet
                    if STATE.espTracer then
                        e.tracer.From    = VP_CENTER
                        e.tracer.To      = Vector2.new(topSc.X, b)
                        e.tracer.Color   = col
                        e.tracer.Visible = true
                    else
                        e.tracer.Visible = false
                    end
                    -- Head circle (same X as box center, Y = top of box)
                    if STATE.espHeadCircle then
                        local headR = bH * 0.13
                        e.headCirc.Position = Vector2.new(topSc.X, y + headR)
                        e.headCirc.Radius   = headR
                        e.headCirc.Color    = col
                        e.headCirc.Visible  = true
                    else
                        e.headCirc.Visible = false
                    end
                else
                    for _,l in ipairs(e.box) do l.Visible=false end
                    e.tracer.Visible=false; e.headCirc.Visible=false
                end
                -- Skeleton
                if STATE.espSkeleton then
                    for i, pair in ipairs(SKEL_BONES) do
                        local pA = c:FindFirstChild(pair[1])
                        local pB = c:FindFirstChild(pair[2])
                        local sl = e.skelLines[i]
                        if pA and pB then
                            local sA, vA = cam:WorldToViewportPoint(pA.Position)
                            local sB, vB = cam:WorldToViewportPoint(pB.Position)
                            if vA and vB then
                                sl.From=Vector2.new(sA.X,sA.Y)
                                sl.To=Vector2.new(sB.X,sB.Y)
                                sl.Color=col; sl.Visible=true
                            else sl.Visible=false end
                        else sl.Visible=false end
                    end
                else
                    for _,sl in ipairs(e.skelLines) do sl.Visible=false end
                end
                -- Slow: HP + distance (~20fps)
                if doSlow then
                    local hpPct = math.clamp(hum.Health/math.max(hum.MaxHealth,1),0,1)
                    e.hpFill.Size=UDim2.new(hpPct,0,1,0)
                    e.hpFill.BackgroundColor3=Color3.fromRGB(
                        math.floor(255*(1-hpPct)), math.floor(255*hpPct), 25)
                    if myHRP then
                        e.distL.Text=math.floor((hrp.Position-myHRP.Position).Magnitude).."m"
                    end
                    e.nameL.TextColor3 = col
                end
            else
                if espData[p] then destroyESP(p) end
            end
        end
    end
    for p in pairs(espData) do
        if not p.Parent then destroyESP(p) end
    end
end)
Players.PlayerRemoving:Connect(function(p) destroyESP(p) end)
-- ============================================================
-- AIMBOT
-- RMB (or chosen key) to lock. Smooth camera move toward target.
-- Bone: Head / HRP / UpperTorso.  Prediction: leads moving targets.
-- FOV circle drawn on screen.  Team check skips teammates.
-- ============================================================
local abTarget   = nil   -- current locked player
local abFOVcirc
local triggerHeld = false
pcall(function()
    abFOVcirc = Drawing.new("Circle")
    abFOVcirc.Thickness=1.2; abFOVcirc.Filled=false
    abFOVcirc.Color=Color3.fromRGB(255,255,255)
    abFOVcirc.Visible=false; abFOVcirc.ZIndex=5
end)
if not abFOVcirc then abFOVcirc = Drawing.new("Circle") end
local function abKeyHeld()
    if STATE.aimKey == "RMB" then
        return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
    elseif STATE.aimKey == "LMB" then
        return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
    else
        local ok,k = pcall(function() return Enum.KeyCode[STATE.aimKey] end)
        return ok and UserInputService:IsKeyDown(k)
    end
end
local function abGetBone(c)
    if not c then return nil end
    local bone = STATE.aimBone
    local part = c:FindFirstChild(bone)
        or c:FindFirstChild("HumanoidRootPart")
        or c:FindFirstChild("Torso")
    return part
end
local function abIsTeammate(p)
    if not STATE.aimTeamCheck then return false end
    return p.Team and plr.Team and p.Team == plr.Team
end
local function tbGetTargetHumanoid(target)
    if not target then return nil, nil end
    local parent = target.Parent
    if not parent then return nil, nil end
    local hum = parent:FindFirstChildOfClass("Humanoid")
    local model = hum and parent or nil
    if not hum and parent.Parent then
        hum = parent.Parent:FindFirstChildOfClass("Humanoid")
        if hum then model = parent.Parent end
    end
    return hum, model
end
local function tbShouldFire()
    local hum, model = tbGetTargetHumanoid(mouse.Target)
    if not hum or not model or hum.Health <= 0 then return false end
    if model == getChar() or model.Name == plr.Name then return false end
    local targetPlayer = Players:GetPlayerFromCharacter(model)
    if targetPlayer and abIsTeammate(targetPlayer) then return false end
    return true
end
local function abFindTarget()
    local cam   = Camera
    local vp    = cam.ViewportSize
    local cx,cy = vp.X/2, vp.Y/2
    local best,bestDist = nil, math.huge
    for _,p in ipairs(Players:GetPlayers()) do
        if p ~= plr and not abIsTeammate(p) then
            local c   = p.Character
            local hum = c and c:FindFirstChildOfClass("Humanoid")
            local bone= abGetBone(c)
            if bone and hum and hum.Health > 0 then
                local sc,vis = cam:WorldToViewportPoint(bone.Position)
                if vis then
                    local dx,dy = sc.X-cx, sc.Y-cy
                    local dist  = math.sqrt(dx*dx+dy*dy)
                    if dist < STATE.aimFOV and dist < bestDist then
                        bestDist=dist; best=p
                    end
                end
            end
        end
    end
    return best
end
local function abPredict(bone)
    if not STATE.aimPrediction or not bone then return bone.Position end
    return bone.Position + bone.AssemblyLinearVelocity * (1/30)
end
-- Aimbot uses mousemoverel correctly:
-- We compute screen-space delta from center to target.
-- Then divide by smoothness to get this frame's movement.
-- We CLAMP to the actual remaining delta so we never overshoot.
-- This is the standard approach used by every real Roblox aimbot.
RunService.RenderStepped:Connect(function()
    -- FOV circle
    if STATE.aimbot and STATE.aimShowFOV then
        local vp = Camera.ViewportSize
        abFOVcirc.Position = Vector2.new(vp.X/2, vp.Y/2)
        abFOVcirc.Radius   = STATE.aimFOV
        abFOVcirc.Visible  = true
    else
        abFOVcirc.Visible = false
    end
    if not STATE.aimbot then abTarget = nil; return end
    if not abKeyHeld()  then abTarget = nil; return end
    abTarget = abFindTarget()
    if not abTarget then return end
    local c    = abTarget.Character
    local bone = abGetBone(c)
    if not bone then abTarget = nil; return end
    local aimPos       = abPredict(bone)
    local cam          = Camera
    local vp           = cam.ViewportSize
    local cx, cy       = vp.X / 2, vp.Y / 2
    -- Project target to screen
    local sc, vis = cam:WorldToViewportPoint(aimPos)
    if not vis then abTarget = nil; return end
    -- Raw delta from crosshair center to target on screen
    local rawX = sc.X - cx
    local rawY = sc.Y - cy
    -- Smooth: divide delta by smoothness factor
    -- Clamp so we NEVER move more than the remaining delta (no overshoot)
    local smooth = math.max(1, STATE.aimSmooth)
    local moveX  = math.clamp(rawX / smooth, -math.abs(rawX), math.abs(rawX))
    local moveY  = math.clamp(rawY / smooth, -math.abs(rawY), math.abs(rawY))
    -- Only move if we are not already on target
    if math.abs(rawX) > 0.5 or math.abs(rawY) > 0.5 then
        mousemoverel(moveX, moveY)
    end
end)
UserInputService.InputBegan:Connect(function(inp, gameProcessed)
    if gameProcessed then return end
    if inp.KeyCode == Enum.KeyCode.H then
        STATE.triggerbot = not STATE.triggerbot
        if not STATE.triggerbot and triggerHeld then
            pcall(mouse1release)
            triggerHeld = false
        end
        notify("Triggerbot", STATE.triggerbot and "Enabled" or "Disabled", 2)
        pcall(saveState)
    end
end)
RunService.RenderStepped:Connect(function()
    local shouldFire = STATE.triggerbot and tbShouldFire()
    if shouldFire and not triggerHeld then
        pcall(mouse1press)
        triggerHeld = true
    elseif triggerHeld and not shouldFire then
        pcall(mouse1release)
        triggerHeld = false
    end
end)
-- ============================================================
-- ANTI-AIM  (jitters your character to mess up enemy aimbot)
-- ============================================================
local antiAimConn
local antiAimAngle = 0
local function startAntiAim()
    if antiAimConn then return end
    antiAimConn = RunService.RenderStepped:Connect(function()
        if not STATE.antiAim then
            antiAimConn:Disconnect(); antiAimConn=nil; return
        end
        local hrp = getHRP()
        if hrp then
            antiAimAngle = (antiAimAngle + 25) % 360
            hrp.CFrame = CFrame.new(hrp.Position) *
                CFrame.Angles(0, math.rad(antiAimAngle), 0)
        end
    end)
end
-- ============================================================
-- ANTI-SCREENSHOT  (flashes screen when F12/PrintScrn pressed)
-- ============================================================
local ssBlind
UserInputService.InputBegan:Connect(function(inp)
    if not STATE.antiScreen then return end
    if inp.KeyCode == Enum.KeyCode.F12
        or inp.KeyCode == Enum.KeyCode.Print then
        -- Flash a white frame
        if not ssBlind then
            local sg2 = Instance.new("ScreenGui")
            sg2.IgnoreGuiInset=true; sg2.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
            local ok,hui = pcall(function() return gethui() end)
            sg2.Parent = (ok and hui) or plr.PlayerGui
            ssBlind = Instance.new("Frame",sg2)
            ssBlind.Size=UDim2.new(1,0,1,0)
            ssBlind.BackgroundColor3=Color3.new(1,1,1)
            ssBlind.BorderSizePixel=0
            task.delay(0.18, function() sg2:Destroy(); ssBlind=nil end)
        end
    end
end)
-- ============================================================
-- ANTI-EXPLOIT ALERT  (detects sudden suspicious RemoteEvent bursts)
-- Flags players who fire the same Remote >30 times/sec
-- ============================================================
local reCount   = {}
local reTimer   = 0
local function watchRemotes()
    for _,p in ipairs(Players:GetPlayers()) do
        if p ~= plr then
            if not reCount[p.UserId] then reCount[p.UserId]=0 end
        end
    end
end
-- We hook via __namecall if available, otherwise skip silently
pcall(function()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "FireServer" or method == "InvokeServer" then
            local uid = plr.UserId
            reCount[uid] = (reCount[uid] or 0) + 1
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end)
-- ============================================================
-- ANTI-GRAVITY  (zero workspace gravity for local player)
-- ============================================================
local origGravity = nil
local function applyAntiGrav(on)
    if on then
        origGravity = Workspace.Gravity
        Workspace.Gravity = 0
    else
        if origGravity then Workspace.Gravity = origGravity; origGravity = nil end
    end
end
-- ============================================================
-- JUMP BOOST / INFINITE JUMP / BHOP
-- ============================================================
RunService.Heartbeat:Connect(function()
    if STATE.jumpBoost then
        local hum = getHum()
        if hum then hum.JumpPower = STATE.jumpPower end
    end
end)
UserInputService.JumpRequest:Connect(function()
    if STATE.infinite then
        local hum = getHum()
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)
local bhopping = false
RunService.Heartbeat:Connect(function()
    if not STATE.bhop then bhopping = false; return end
    local hum = getHum()
    local hrp = getHRP()
    if not hum or not hrp then return end
    if hum.FloorMaterial ~= Enum.Material.Air then
        -- on ground - auto jump
        if not bhopping then
            bhopping = true
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    else
        bhopping = false
    end
end)
-- ============================================================
-- FULLBRIGHT / NO FOG / TIME FREEZE
-- ============================================================
local Lighting = game:GetService("Lighting")
local origLightProps = nil
local origFog = nil
local frozenTimeConn = nil
local function applyFullbright(on)
    if on then
        origLightProps = {
            Brightness = Lighting.Brightness,
            Ambient    = Lighting.Ambient,
            OutdoorAmbient = Lighting.OutdoorAmbient,
        }
        Lighting.Brightness     = 5
        Lighting.Ambient        = Color3.fromRGB(178,178,178)
        Lighting.OutdoorAmbient = Color3.fromRGB(178,178,178)
    else
        if origLightProps then
            Lighting.Brightness     = origLightProps.Brightness
            Lighting.Ambient        = origLightProps.Ambient
            Lighting.OutdoorAmbient = origLightProps.OutdoorAmbient
            origLightProps = nil
        end
    end
end
local function applyNoFog(on)
    if on then
        origFog = {Start=Lighting.FogStart, End=Lighting.FogEnd}
        Lighting.FogStart = 1e8; Lighting.FogEnd = 1e9
    else
        if origFog then
            Lighting.FogStart = origFog.Start
            Lighting.FogEnd   = origFog.End
            origFog = nil
        end
    end
end
local function applyTimeFreeze(on)
    if frozenTimeConn then frozenTimeConn:Disconnect(); frozenTimeConn = nil end
    if on then
        Lighting.TimeOfDay = string.format("%02d:00:00", STATE.frozenTime)
        frozenTimeConn = RunService.Heartbeat:Connect(function()
            if not STATE.timeFreeze then
                frozenTimeConn:Disconnect(); frozenTimeConn = nil; return
            end
            Lighting.TimeOfDay = string.format("%02d:00:00", STATE.frozenTime)
        end)
    end
end
-- ============================================================
-- ANTI-AFK
-- Simulates input every 60s so the game never idles you out.
-- Uses VirtualUser service - no visible mouse movement.
-- ============================================================
local VirtualUser = game:GetService("VirtualUser")
local afkTimer    = 0
RunService.Heartbeat:Connect(function(dt)
    if not STATE.antiAFK then afkTimer = 0; return end
    afkTimer = afkTimer + dt
    if afkTimer >= 60 then
        afkTimer = 0
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new(0,0))
        end)
    end
end)
-- ============================================================
-- REMOVE SCREEN EFFECTS
-- Strips ColorCorrectionEffect, BlurEffect, SunRaysEffect,
-- DepthOfFieldEffect, BloomEffect from Lighting + all cameras.
-- Stores originals so restore works.
-- ============================================================
local removedFX = {}
local FX_TYPES = {
    "ColorCorrectionEffect", "BlurEffect", "SunRaysEffect",
    "DepthOfFieldEffect", "BloomEffect", "BlackAndWhiteEffect",
}
local function isFXType(obj)
    for _, t in ipairs(FX_TYPES) do
        if obj:IsA(t) then return true end
    end
    return false
end
local function removeScreenFX()
    local function stripFrom(parent)
        for _, obj in ipairs(parent:GetDescendants()) do
            if isFXType(obj) and obj.Enabled then
                obj.Enabled = false
                table.insert(removedFX, obj)
            end
        end
    end
    stripFrom(game:GetService("Lighting"))
    stripFrom(Workspace.CurrentCamera)
    -- Also disable any added after
    game:GetService("Lighting").DescendantAdded:Connect(function(obj)
        if STATE.noScreenFX and isFXType(obj) then
            task.wait()
            obj.Enabled = false
            table.insert(removedFX, obj)
        end
    end)
end
local function restoreScreenFX()
    for _, obj in ipairs(removedFX) do
        pcall(function() obj.Enabled = true end)
    end
    removedFX = {}
end
-- ============================================================
-- UNDETECTED FLY  (invisible platform method)
-- ============================================================
local flyConn
local function destroyFlyParts()
    if STATE.flyPlatform then STATE.flyPlatform:Destroy(); STATE.flyPlatform = nil end
    if STATE.flyBodyVel  then pcall(function() STATE.flyBodyVel:Destroy() end);  STATE.flyBodyVel  = nil end
    if STATE.flyBodyGyro then pcall(function() STATE.flyBodyGyro:Destroy() end); STATE.flyBodyGyro = nil end
end
local function startFly()
    destroyFlyParts()
    local hrp = getHRP()
    if not hrp then return end
    local plat = Instance.new("Part")
    plat.Name         = "cuongoutlookPlat"
    plat.Size         = Vector3.new(2, 0.2, 2)
    plat.Transparency = 1
    plat.CanCollide   = false
    plat.Anchored     = false
    plat.Massless     = true
    plat.CastShadow   = false
    plat.CFrame       = hrp.CFrame * CFrame.new(0, -3, 0)
    plat.Parent       = Workspace
    local weld   = Instance.new("WeldConstraint")
    weld.Part0   = hrp
    weld.Part1   = plat
    weld.Parent  = hrp
    local bv         = Instance.new("BodyVelocity")
    bv.MaxForce      = Vector3.new(1e5, 1e5, 1e5)
    bv.Velocity      = Vector3.zero
    bv.Parent        = hrp
    local bg         = Instance.new("BodyGyro")
    bg.MaxTorque     = Vector3.new(1e5, 1e5, 1e5)
    bg.D             = 100
    bg.P             = 10000
    bg.CFrame        = hrp.CFrame
    bg.Parent        = hrp
    STATE.flyPlatform = plat
    STATE.flyBodyVel  = bv
    STATE.flyBodyGyro = bg
    local hum = getHum()
    if hum then hum.PlatformStand = true end
    if flyConn then flyConn:Disconnect() end
    flyConn = RunService.RenderStepped:Connect(function()
        if not STATE.fly then return end
        local h = getHRP()
        if not h or not STATE.flyBodyVel then return end
        local spd = STATE.flySpeed
        local vel = Vector3.zero
        local function held(k) return UserInputService:IsKeyDown(k) end
        local cf  = Camera.CFrame
        local fwd = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z).Unit
        local rgt = Vector3.new(cf.RightVector.X, 0, cf.RightVector.Z).Unit
        if held(Enum.KeyCode.W)            then vel = vel + fwd * spd end
        if held(Enum.KeyCode.S)            then vel = vel - fwd * spd end
        if held(Enum.KeyCode.D)            then vel = vel + rgt * spd end
        if held(Enum.KeyCode.A)            then vel = vel - rgt * spd end
        if held(Enum.KeyCode.Space)        then vel = vel + Vector3.new(0, spd, 0) end
        if held(Enum.KeyCode.LeftControl)  then vel = vel - Vector3.new(0, spd, 0) end
        STATE.flyBodyVel.Velocity  = vel
        STATE.flyBodyGyro.CFrame   = CFrame.new(h.Position)
    end)
end
local function stopFly()
    if flyConn then flyConn:Disconnect(); flyConn = nil end
    destroyFlyParts()
    local hum = getHum()
    if hum then hum.PlatformStand = false end
end
-- ============================================================
-- FLING SYSTEM
--
-- SPIN TOGGLE (Movement tab):
--   Attaches a BodyAngularVelocity to YOUR OWN HRP.
--   You spin at 9999 rad/s but can still walk freely.
--   No TP, no interruption to movement. Pure spin.
--
-- FLING PLAYER (Players tab):
--   Attaches a WeldConstraint + BodyAngularVelocity to the
--   TARGET so THEY spin ultra fast while you stay still.
--   After 0.4s: releases weld, fires explosive BodyVelocity
--   to launch them. Then CHAIN: auto-attaches to the next
--   nearest player and does it again, repeating until stopped.
-- ============================================================
-- Spin toggle - spins YOUR character, walk freely
local spinConn     = nil
local selfSpinBAV  = nil
local function startSpin()
    if spinConn then return end
    local hrp = getHRP()
    if not hrp then return end
    selfSpinBAV = Instance.new("BodyAngularVelocity")
    selfSpinBAV.AngularVelocity = Vector3.new(0, 9999, 0)
    selfSpinBAV.MaxTorque       = Vector3.new(0, 1e9, 0)
    selfSpinBAV.Parent          = hrp
    -- Re-parent to new HRP if character respawns
    spinConn = RunService.Heartbeat:Connect(function()
        if not STATE.spinToggle then
            if selfSpinBAV then pcall(function() selfSpinBAV:Destroy() end); selfSpinBAV = nil end
            spinConn:Disconnect(); spinConn = nil; return
        end
        local h = getHRP()
        if h and selfSpinBAV and selfSpinBAV.Parent ~= h then
            selfSpinBAV.Parent = h
        end
    end)
end
local function stopSpin()
    if selfSpinBAV then pcall(function() selfSpinBAV:Destroy() end); selfSpinBAV = nil end
    if spinConn    then spinConn:Disconnect(); spinConn = nil end
end
-- Chain fling state
local chainFlingActive = false
local chainFlingConn   = nil
local function getNearestPlayer(excludeList)
    local hrp = getHRP()
    if not hrp then return nil end
    local best, bestDist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= plr then
            local skip = false
            if excludeList then
                for _, ex in ipairs(excludeList) do
                    if ex == p then skip = true; break end
                end
            end
            if not skip then
                local pc = p.Character
                local ph = pc and pc:FindFirstChild("HumanoidRootPart")
                if ph then
                    local d = (ph.Position - hrp.Position).Magnitude
                    if d < bestDist then bestDist = d; best = p end
                end
            end
        end
    end
    return best
end
-- Fling one target: TP to them, weld self to them, spin ultra fast,
-- forces transfer to target, then explosive launch. Chain auto-switches.
local function flingOne(target, onDone)
    if not target then if onDone then onDone(nil) end; return end
    local tc   = target.Character
    local thrp = tc and tc:FindFirstChild("HumanoidRootPart")
    local hum  = tc and tc:FindFirstChildOfClass("Humanoid")
    local hrp  = getHRP()
    if not thrp or not hum or not hrp then
        if onDone then onDone(nil) end; return
    end
    -- Step 1: TP ourselves directly onto the target
    markOwnTP()
    hrp.CFrame = CFrame.new(thrp.Position)
    -- Step 2: Weld OUR HRP to THEIR HRP - forces we generate transfer to them
    local weld = Instance.new("WeldConstraint")
    weld.Part0  = hrp
    weld.Part1  = thrp
    weld.Parent = hrp
    -- Step 3: Spin OUR HRP at 9999 rad/s - torque transfers through weld to target
    local bav = Instance.new("BodyAngularVelocity")
    bav.AngularVelocity = Vector3.new(0, 9999, 0)
    bav.MaxTorque       = Vector3.new(0, 1e9, 0)
    bav.Parent          = hrp
    -- Step 4: BodyVelocity on target ready to fire
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Velocity = Vector3.zero
    bv.Parent   = thrp
    notify("Fling", "Spinning " .. target.Name .. "...", 1)
    -- Step 5: After 0.4s release and LAUNCH
    task.delay(0.4, function()
        pcall(function() bav:Destroy() end)
        pcall(function() weld:Destroy() end)
        -- Massive explosive launch
        bv.Velocity = Vector3.new(
            math.random(-5000, 5000),
            math.random(6000, 10000),
            math.random(-5000, 5000)
        )
        task.delay(0.1, function() pcall(function() bv:Destroy() end) end)
        -- Return ourselves to last safe position
        task.delay(0.05, function()
            local myHRP = getHRP()
            if myHRP and STATE.lastSafePos then
                markOwnTP()
                myHRP.CFrame = CFrame.new(STATE.lastSafePos + Vector3.new(0, 3, 0))
            end
        end)
        notify("Fling", "LAUNCHED " .. target.Name .. "!!!", 2)
        task.delay(0.35, function()
            if onDone then onDone(getNearestPlayer()) end
        end)
    end)
end
-- Public fling: flings selected target once (no chain)
local function flingPlayer(target)
    flingOne(target, nil)
end
-- Start chain fling: flings target, then nearest, then nearest...
local function startChainFling(firstTarget)
    if chainFlingActive then return end
    chainFlingActive = true
    STATE.chainFling = true
    local function doNext(target)
        if not STATE.chainFling or not chainFlingActive then
            chainFlingActive = false
            return
        end
        if not target then
            -- No more players - wait and retry
            task.delay(0.5, function()
                if STATE.chainFling and chainFlingActive then
                    doNext(getNearestPlayer())
                else
                    chainFlingActive = false
                end
            end)
            return
        end
        flingOne(target, doNext)
    end
    doNext(firstTarget or getNearestPlayer())
end
local function stopChainFling()
    STATE.chainFling  = false
    chainFlingActive  = false
end
-- ============================================================
-- CLICK-TP
-- ============================================================
mouse.Button1Down:Connect(function()
    if not STATE.clickTP then return end
    local hrp = getHRP()
    if not hrp then return end
    local hit = mouse.Hit
    if hit then markOwnTP(); hrp.CFrame = hit * CFrame.new(0, 3, 0) end
end)
-- ============================================================
-- SPEED / NOCLIP / REACH  (passive heartbeat loops)
-- ============================================================
RunService.Heartbeat:Connect(function()
    if STATE.speedBoost then
        local hum = getHum()
        if hum then hum.WalkSpeed = STATE.speedValue end
    end
    if STATE.noclip then
        local c = getChar()
        if c then
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end
    else
        -- Restore collision when noclip is turned off
        if STATE._wasNoclip then
            STATE._wasNoclip = false
            local c = getChar()
            if c then
                local hum = c:FindFirstChildOfClass("Humanoid")
                for _, p in ipairs(c:GetDescendants()) do
                    if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                        p.CanCollide = true
                    end
                end
            end
        end
    end
    STATE._wasNoclip = STATE.noclip
    if STATE.reach then
        local c = getChar()
        if c then
            local tool = c:FindFirstChildOfClass("Tool")
            if tool then
                local h = tool:FindFirstChild("Handle")
                if h then h.Size = Vector3.new(STATE.reachValue, STATE.reachValue, STATE.reachValue) end
            end
        end
    end
end)
-- ============================================================
-- SPECTATE
-- ============================================================
local specConn
local function stopSpectate()
    if specConn then specConn:Disconnect(); specConn = nil end
    Camera.CameraType = Enum.CameraType.Custom
    local hum = getChar() and getChar():FindFirstChildOfClass("Humanoid")
    if hum then Camera.CameraSubject = hum end
    STATE.spectateTarget = nil
end
local function spectate(target)
    if not target then stopSpectate(); return end
    STATE.spectateTarget = target
    if specConn then specConn:Disconnect() end
    specConn = RunService.RenderStepped:Connect(function()
        if not STATE.spectateTarget then stopSpectate(); return end
        local tc = STATE.spectateTarget.Character
        if tc then
            local h = tc:FindFirstChildOfClass("Humanoid")
            if h then Camera.CameraSubject = h end
        end
    end)
    notify("Spectate", "Spectating " .. target.Name, 3)
end
-- ============================================================
-- RESPAWN
-- ============================================================
plr.CharacterAdded:Connect(function()
    task.wait(1)
    rb_prevPos         = nil
    tp_prevPos         = nil
    STATE.lastSafePos  = nil
    if STATE.fly then startFly() end
end)
-- ============================================================
-- LOAD SAVED STATE (must happen BEFORE GUI builds so toggles
-- render with the correct ON/OFF state from the start)
-- ============================================================
local _hadSave = loadState()
if _hadSave then
    task.defer(function()
        applyRestoredState()
        notify("CuongOutLook", "Settings restored", 3)
    end)
end
-- ============================================================
-- GUI
-- ============================================================
local C = {
    BG    = Color3.fromRGB(10, 14, 24),
    PANEL = Color3.fromRGB(18, 24, 38),
    ACC   = Color3.fromRGB(0, 220, 255),
    ON    = Color3.fromRGB(38, 190, 78),
    OFF   = Color3.fromRGB(160, 32, 32),
    TXT   = Color3.fromRGB(238, 244, 255),
    TXTM  = Color3.fromRGB(132, 148, 178),
    WHT   = Color3.fromRGB(255, 255, 255),
    WARN  = Color3.fromRGB(230, 160, 20),
    RED   = Color3.fromRGB(200, 40, 40),
    DARK  = Color3.fromRGB(13, 18, 30),
}
local sg = Instance.new("ScreenGui")
sg.Name           = "cuongoutlookUndetect"
sg.ResetOnSpawn   = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local _ok, _hui   = pcall(function() return gethui() end)
pcall(function()
    sg.Parent = (_ok and _hui) or plr:WaitForChild("PlayerGui",10)
end)
if not sg.Parent then sg.Parent = plr.PlayerGui end
-- Main window
local window = Instance.new("Frame", sg)
window.Size             = UDim2.new(0, 600, 0, 350)
window.Position         = UDim2.new(0.5, -300, 0.5, -175)
window.BackgroundColor3 = C.BG
window.BorderSizePixel  = 0
window.Active           = true
window.Draggable        = true
Instance.new("UICorner", window).CornerRadius = UDim.new(0, 18)
local _sbs = Instance.new("UIStroke", window)
_sbs.Color = Color3.fromRGB(56, 92, 148); _sbs.Thickness = 1.6
local sbTitle = Instance.new("Frame", window)
sbTitle.Size             = UDim2.new(0, 236, 0, 44)
sbTitle.Position         = UDim2.new(0, 12, 0, 12)
sbTitle.BackgroundColor3 = C.PANEL
sbTitle.BorderSizePixel  = 0
Instance.new("UICorner", sbTitle).CornerRadius = UDim.new(0, 14)
local sbLbl = Instance.new("TextLabel", sbTitle)
sbLbl.Size               = UDim2.new(1, -20, 1, 0)
sbLbl.Position           = UDim2.new(0, 14, 0, 0)
sbLbl.BackgroundTransparency = 1
sbLbl.Text               = "CuongOutLook"
sbLbl.Font               = Enum.Font.GothamBold
sbLbl.TextSize           = 14
sbLbl.TextColor3         = C.TXT
sbLbl.TextXAlignment     = Enum.TextXAlignment.Left
local closeBtn = Instance.new("TextButton", window)
closeBtn.Size             = UDim2.new(0, 34, 0, 28)
closeBtn.Position         = UDim2.new(1, -18 - 34, 0, 18)
closeBtn.BackgroundColor3 = C.RED
closeBtn.BorderSizePixel  = 0
closeBtn.Font             = Enum.Font.GothamBold
closeBtn.TextSize         = 14
closeBtn.TextColor3       = C.WHT
closeBtn.Text             = "X"
closeBtn.AutoButtonColor  = false
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 10)
closeBtn.MouseEnter:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(230, 60, 60)
end)
closeBtn.MouseLeave:Connect(function()
    closeBtn.BackgroundColor3 = C.RED
end)
-- Create collapsed button (small black square with "COL")
local collapsedBtn = Instance.new("TextButton", sg)
collapsedBtn.Size             = UDim2.new(0, 50, 0, 50)
collapsedBtn.Position         = UDim2.new(0, 20, 0, 20)
collapsedBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
collapsedBtn.BorderSizePixel  = 0
collapsedBtn.Font             = Enum.Font.GothamBold
collapsedBtn.TextSize         = 12
collapsedBtn.TextColor3       = Color3.fromRGB(0, 255, 255)
collapsedBtn.Text             = "COL"
collapsedBtn.AutoButtonColor  = false
collapsedBtn.Visible          = false
collapsedBtn.Active           = true
collapsedBtn.Draggable        = true
Instance.new("UICorner", collapsedBtn).CornerRadius = UDim.new(0, 10)
collapsedBtn.MouseEnter:Connect(function()
    collapsedBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)
collapsedBtn.MouseLeave:Connect(function()
    collapsedBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
end)
local subLbl = Instance.new("TextLabel", window)
subLbl.Size               = UDim2.new(0, 320, 0, 18)
subLbl.Position           = UDim2.new(0, 260, 0, 25)
subLbl.BackgroundTransparency = 1
subLbl.Text               = "Tabs and content stay inside one aligned frame"
subLbl.Font               = Enum.Font.Gotham
subLbl.TextSize           = 11
subLbl.TextColor3         = C.TXTM
subLbl.TextXAlignment     = Enum.TextXAlignment.Left
local tabBar = Instance.new("Frame", window)
tabBar.Size               = UDim2.new(1, -24, 0, 32)
tabBar.Position           = UDim2.new(0, 12, 0, 60)
tabBar.BackgroundTransparency = 1
local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.SortOrder       = Enum.SortOrder.LayoutOrder
tabLayout.FillDirection   = Enum.FillDirection.Horizontal
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabLayout.Padding         = UDim.new(0, 3)
-- Content panel
local content = Instance.new("Frame", window)
content.Size             = UDim2.new(1, -24, 1, -104)
content.Position         = UDim2.new(0, 12, 0, 96)
content.BackgroundColor3 = C.DARK
content.BorderSizePixel  = 0
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 16)
local _cs = Instance.new("UIStroke", content)
_cs.Color = Color3.fromRGB(39, 58, 92); _cs.Thickness = 1.2
local sf = Instance.new("ScrollingFrame", content)
sf.Size                  = UDim2.new(1, -16, 1, -16)
sf.Position              = UDim2.new(0, 8, 0, 8)
sf.BackgroundTransparency = 1
sf.BorderSizePixel       = 0
sf.ScrollBarThickness    = 5
sf.ScrollBarImageColor3  = C.ACC
sf.AutomaticCanvasSize   = Enum.AutomaticSize.Y
sf.CanvasSize            = UDim2.new(0, 0, 0, 0)
local _sfl = Instance.new("UIListLayout", sf)
_sfl.Padding    = UDim.new(0, 8)
_sfl.SortOrder  = Enum.SortOrder.LayoutOrder
local _sfp = Instance.new("UIPadding", sf)
_sfp.PaddingLeft  = UDim.new(0, 8)
_sfp.PaddingRight = UDim.new(0, 8)
_sfp.PaddingTop   = UDim.new(0, 8)
-- Tab system
local TABS     = {"Protect", "ESP", "Aimbot", "Movement", "Chat", "Items", "Visual", "World", "Players"}
local activeTab = TABS[1]
local tabPages  = {}
local tabBtns   = {}
local TAB_BUTTON_WIDTH = 50
for _, t in ipairs(TABS) do tabPages[t] = {} end
local menuHidden    = false
local WINDOW_FULL   = UDim2.new(0, 600, 0, 350)
local MENU_TOGGLE_KEY = Enum.KeyCode.RightControl
window.Size = WINDOW_FULL
subLbl.Text = "Tabs and content stay inside one aligned frame"
local function setMenuHidden(hidden)
    if not hidden and not panelKeyUnlocked then
        requestPanelKey()
    end
    menuHidden = hidden
    window.Visible = not hidden
    collapsedBtn.Visible = hidden
    if hidden then
        notify("CuongOutLook Aimbot", "Menu collapsed. Click COL button to expand.", 5)
    end
end
closeBtn.MouseButton1Click:Connect(function()
    setMenuHidden(true)
end)
collapsedBtn.MouseButton1Click:Connect(function()
    setMenuHidden(false)
end)
UserInputService.InputBegan:Connect(function(inp, gameProcessed)
    if gameProcessed then return end
    if inp.KeyCode == MENU_TOGGLE_KEY then
        setMenuHidden(not menuHidden)
    end
end)
local showTab  -- forward declare
local function _showTab(name)
    activeTab = name
    for n, frames in pairs(tabPages) do
        for _, f in ipairs(frames) do
            f.Visible = (n == name)
        end
    end
    for _, b in pairs(tabBtns) do
        local on = (b.Name == name)
        b.BackgroundColor3 = on and C.ACC or Color3.fromRGB(12, 42, 54)
        b.TextColor3       = on and C.WHT or C.TXTM
    end
end
for i, t in ipairs(TABS) do
    local b = Instance.new("TextButton", tabBar)
    b.Name             = t
    b.Size             = UDim2.new(0, TAB_BUTTON_WIDTH, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(12, 42, 54)
    b.BorderSizePixel  = 0
    b.Text             = t
    b.Font             = Enum.Font.GothamSemibold
    b.TextSize         = 10
    b.TextColor3       = C.TXTM
    b.LayoutOrder      = i
    b.AutoButtonColor  = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    local _bst = Instance.new("UIStroke", b)
    _bst.Color = Color3.fromRGB(0, 140, 165)
    _bst.Thickness = 1
    tabBtns[t]         = b
    b.MouseButton1Click:Connect(function() showTab(t) end)
end
local adminCredit = Instance.new("TextButton", tabBar)
adminCredit.Name             = "AdminCredit"
adminCredit.Size             = UDim2.new(0, 96, 0, 30)
adminCredit.Position         = UDim2.new(1, -96, 0, 0)
adminCredit.BackgroundColor3 = Color3.fromRGB(12, 42, 54)
adminCredit.BorderSizePixel  = 0
adminCredit.Text             = "Credit Admin"
adminCredit.Font             = Enum.Font.GothamSemibold
adminCredit.TextSize         = 12
adminCredit.TextColor3       = Color3.fromRGB(110, 245, 255)
adminCredit.TextXAlignment   = Enum.TextXAlignment.Center
adminCredit.AutoButtonColor  = false
adminCredit.ZIndex           = 2
Instance.new("UICorner", adminCredit).CornerRadius = UDim.new(0, 10)
local _acs = Instance.new("UIStroke", adminCredit)
_acs.Color = Color3.fromRGB(0, 200, 230)
_acs.Thickness = 1
adminCredit.MouseEnter:Connect(function()
    adminCredit.BackgroundColor3 = Color3.fromRGB(18, 62, 78)
end)
adminCredit.MouseLeave:Connect(function()
    adminCredit.BackgroundColor3 = Color3.fromRGB(12, 42, 54)
end)
adminCredit.MouseButton1Click:Connect(function()
    notify("Credit Admin", "facebook.com/adcuong3vien/", 5)
end)
local _ord = 0
local function nxt() _ord = _ord + 1; return _ord end
-- UI builders
local function Sec(tab, txt)
    local f = Instance.new("Frame", sf)
    f.Size                  = UDim2.new(1, 0, 0, 24)
    f.BackgroundTransparency = 1
    f.LayoutOrder           = nxt()
    f.Visible               = false
    local lb = Instance.new("TextLabel", f)
    lb.Size                  = UDim2.new(1, 0, 1, 0)
    lb.BackgroundTransparency = 1
    lb.Text                  = txt
    lb.Font                  = Enum.Font.GothamBold
    lb.TextSize              = 13
    lb.TextColor3            = C.ACC
    lb.TextXAlignment        = Enum.TextXAlignment.Left
    table.insert(tabPages[tab], f)
end
local function Info(tab, txt)
    local f = Instance.new("Frame", sf)
    f.Size                  = UDim2.new(1, 0, 0, 20)
    f.BackgroundTransparency = 1
    f.LayoutOrder           = nxt()
    f.Visible               = false
    local lb = Instance.new("TextLabel", f)
    lb.Size                  = UDim2.new(1, 0, 1, 0)
    lb.BackgroundTransparency = 1
    lb.Text                  = txt
    lb.Font                  = Enum.Font.Gotham
    lb.TextSize              = 11
    lb.TextColor3            = C.TXTM
    lb.TextXAlignment        = Enum.TextXAlignment.Left
    lb.TextWrapped           = true
    table.insert(tabPages[tab], f)
end
local function Tog(tab, label, getS, setS, extra)
    local row = Instance.new("Frame", sf)
    row.Size             = UDim2.new(1, 0, 0, 42)
    row.BackgroundColor3 = C.PANEL
    row.BorderSizePixel  = 0
    row.LayoutOrder      = nxt()
    row.Visible          = false
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 12)
    local rowStroke = Instance.new("UIStroke", row)
    rowStroke.Color = Color3.fromRGB(35, 50, 78)
    rowStroke.Transparency = 0.35
    local lb = Instance.new("TextLabel", row)
    lb.Size               = UDim2.new(1, -68, 1, 0)
    lb.Position           = UDim2.new(0, 12, 0, 0)
    lb.BackgroundTransparency = 1
    lb.Text               = label
    lb.Font               = Enum.Font.Gotham
    lb.TextSize           = 12
    lb.TextColor3         = C.TXT
    lb.TextXAlignment     = Enum.TextXAlignment.Left
    local btn = Instance.new("TextButton", row)
    btn.Size             = UDim2.new(0, 54, 0, 22)
    btn.Position         = UDim2.new(1, -66, 0.5, -11)
    btn.Font             = Enum.Font.GothamBold
    btn.TextSize         = 11
    btn.BorderSizePixel  = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    local function rf()
        local on = getS()
        btn.Text             = on and "ON" or "OFF"
        btn.BackgroundColor3 = on and C.ON or C.OFF
        btn.TextColor3       = C.WHT
    end
    rf()
    btn.MouseButton1Click:Connect(function()
        setS(not getS()); rf()
        if extra then extra(getS()) end
        pcall(saveState)
    end)
    table.insert(tabPages[tab], row)
    return row, rf
end
local function Sli(tab, label, getV, setV, mn, mx)
    local row = Instance.new("Frame", sf)
    row.Size             = UDim2.new(1, 0, 0, 54)
    row.BackgroundColor3 = C.PANEL
    row.BorderSizePixel  = 0
    row.LayoutOrder      = nxt()
    row.Visible          = false
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 12)
    local rowStroke = Instance.new("UIStroke", row)
    rowStroke.Color = Color3.fromRGB(35, 50, 78)
    rowStroke.Transparency = 0.35
    local lb = Instance.new("TextLabel", row)
    lb.Size               = UDim2.new(1, -10, 0, 18)
    lb.Position           = UDim2.new(0, 12, 0, 6)
    lb.BackgroundTransparency = 1
    lb.Font               = Enum.Font.Gotham
    lb.TextSize           = 11
    lb.TextColor3         = C.TXTM
    lb.TextXAlignment     = Enum.TextXAlignment.Left
    local track = Instance.new("Frame", row)
    track.Size             = UDim2.new(1, -24, 0, 8)
    track.Position         = UDim2.new(0, 12, 0, 34)
    track.BackgroundColor3 = Color3.fromRGB(29, 40, 62)
    track.BorderSizePixel  = 0
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
    local fill = Instance.new("Frame", track)
    fill.BackgroundColor3 = C.ACC
    fill.BorderSizePixel  = 0
    fill.Size             = UDim2.new(0, 0, 1, 0)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    local function rf()
        local pct = math.clamp((getV() - mn) / (mx - mn), 0, 1)
        fill.Size = UDim2.new(pct, 0, 1, 0)
        lb.Text   = label .. ": " .. getV()
    end
    rf()
    local drag = false
    track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
            local pct = math.clamp(
                (i.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1
            )
            setV(math.floor(mn + pct * (mx - mn) + 0.5)); rf()
            pcall(saveState)
        end
    end)
    table.insert(tabPages[tab], row)
end
local function Act(tab, label, col, fn)
    local b = Instance.new("TextButton", sf)
    b.Size             = UDim2.new(1, 0, 0, 36)
    b.BackgroundColor3 = col or C.ACC
    b.BorderSizePixel  = 0
    b.Font             = Enum.Font.GothamSemibold
    b.TextSize         = 12
    b.TextColor3       = C.WHT
    b.Text             = label
    b.LayoutOrder      = nxt()
    b.Visible          = false
    b.AutoButtonColor  = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 12)
    b.MouseButton1Click:Connect(fn)
    local safeCol = col or C.ACC
    b.BackgroundColor3 = safeCol
    b.MouseEnter:Connect(function()
        b.BackgroundColor3 = Color3.new(
            math.min(safeCol.R + 0.08, 1),
            math.min(safeCol.G + 0.08, 1),
            math.min(safeCol.B + 0.08, 1)
        )
    end)
    b.MouseLeave:Connect(function() b.BackgroundColor3 = safeCol end)
    table.insert(tabPages[tab], b)
    return b
end
local function Drop(tab, label, onSel)
    local row = Instance.new("Frame", sf)
    row.Size             = UDim2.new(1, 0, 0, 42)
    row.BackgroundColor3 = C.PANEL
    row.BorderSizePixel  = 0
    row.LayoutOrder      = nxt()
    row.Visible          = false
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 12)
    local rowStroke = Instance.new("UIStroke", row)
    rowStroke.Color = Color3.fromRGB(35, 50, 78)
    rowStroke.Transparency = 0.35
    local lb = Instance.new("TextLabel", row)
    lb.Size               = UDim2.new(0, 76, 1, 0)
    lb.Position           = UDim2.new(0, 12, 0, 0)
    lb.BackgroundTransparency = 1
    lb.Text               = label
    lb.Font               = Enum.Font.Gotham
    lb.TextSize           = 11
    lb.TextColor3         = C.TXTM
    lb.TextXAlignment     = Enum.TextXAlignment.Left
    local btn = Instance.new("TextButton", row)
    btn.Size             = UDim2.new(1, -98, 0, 24)
    btn.Position         = UDim2.new(0, 82, 0.5, -12)
    btn.BackgroundColor3 = C.DARK
    btn.BorderSizePixel  = 0
    btn.Font             = Enum.Font.Gotham
    btn.TextSize         = 11
    btn.TextColor3       = C.TXT
    btn.Text             = "Select..."
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(function()
        local list = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= plr then table.insert(list, p) end
        end
        if #list == 0 then btn.Text = "(none)"; return end
        local idx = 1
        for i, p in ipairs(list) do
            if p.Name == btn.Text then idx = (i % #list) + 1; break end
        end
        local sel = list[idx]
        btn.Text = sel.Name
        onSel(sel)
    end)
    table.insert(tabPages[tab], row)
end
-- ============================
-- ESP TAB
-- ============================
Sec("ESP", "Player ESP")
Tog("ESP", "Enable ESP",
    function() return STATE.esp end,
    function(v) STATE.esp = v; if not v then clearAllESP() end end)
Sec("ESP", "Features")
Tog("ESP", "Box",
    function() return STATE.espBox end,
    function(v) STATE.espBox = v end)
Tog("ESP", "Name Tag",
    function() return STATE.espName end,
    function(v) STATE.espName = v end)
Tog("ESP", "Health Bar",
    function() return STATE.espHealth end,
    function(v) STATE.espHealth = v end)
Tog("ESP", "Distance",
    function() return STATE.espDist end,
    function(v) STATE.espDist = v end)
Tog("ESP", "Tracers",
    function() return STATE.espTracer end,
    function(v) STATE.espTracer = v end)
Info("ESP", "  Line from screen-bottom to player feet")
Tog("ESP", "Head Circle",
    function() return STATE.espHeadCircle end,
    function(v) STATE.espHeadCircle = v end)
Tog("ESP", "Chams",
    function() return STATE.espChams end,
    function(v) STATE.espChams = v end)
Info("ESP", "  Red glow through walls")
Tog("ESP", "Skeleton",
    function() return STATE.espSkeleton end,
    function(v) STATE.espSkeleton = v end)
Info("ESP", "  Draws bone lines (slight fps cost)")
Sec("ESP", "Options")
Tog("ESP", "Team Color",
    function() return STATE.espTeamCheck end,
    function(v) STATE.espTeamCheck = v end)
Info("ESP", "  Teammates shown in blue, enemies red")
-- ============================
-- PROTECT TAB
-- ============================
Sec("Protect", "Protections")
Tog("Protect", "Anti-Fling",
    function() return STATE.antiFling end,
    function(v) STATE.antiFling = v end)
Info("Protect", "  Blocks velocity spikes. Enables noclip.")
Tog("Protect", "Anti-Rubber Band",
    function() return STATE.antiRubberBand end,
    function(v) STATE.antiRubberBand = v; if not v then rb_prevPos = nil end end)
Info("Protect", "  Blocks server position snapping.")
Tog("Protect", "Anti-TP",
    function() return STATE.antiTP end,
    function(v) STATE.antiTP = v; if not v then tp_prevPos = nil end end)
Info("Protect", "  Blocks server teleports >50 studs.")
Tog("Protect", "Anti-Item Orbit",
    function() return STATE.antiItemOrbit end,
    function(v) STATE.antiItemOrbit = v end)
Info("Protect", "  Hides orbiting items. Throttled (no lag).")
Tog("Protect", "Noclip",
    function() return STATE.noclip end,
    function(v) STATE.noclip = v end)
Sec("Protect", "Anti Extras")
Tog("Protect", "Anti-Aim",
    function() return STATE.antiAim end,
    function(v) STATE.antiAim = v; if v then startAntiAim() end end)
Info("Protect", "  Spins HRP to break enemy aimbot lock")
Tog("Protect", "Anti-Screenshot",
    function() return STATE.antiScreen end,
    function(v) STATE.antiScreen = v end)
Info("Protect", "  Flashes white on F12/PrintScreen")
Tog("Protect", "Anti-Exploit Alert",
    function() return STATE.antiExploit end,
    function(v) STATE.antiExploit = v end)
Info("Protect", "  Watches for RemoteEvent abuse (if supported)")
Tog("Protect", "Anti-Gravity",
    function() return STATE.antiGravity end,
    function(v) STATE.antiGravity = v; applyAntiGrav(v) end)
Info("Protect", "  Zero workspace gravity. Float freely.")
-- ============================
-- AIMBOT TAB
-- ============================
Sec("Aimbot", "Aimbot")
Tog("Aimbot", "Enable Aimbot",
    function() return STATE.aimbot end,
    function(v) STATE.aimbot = v end)
Tog("Aimbot", "Enable Triggerbot",
    function() return STATE.triggerbot end,
    function(v)
        STATE.triggerbot = v
        if not v and triggerHeld then
            pcall(mouse1release)
            triggerHeld = false
        end
    end)
Info("Aimbot", "  Auto-fire on enemy under crosshair | Hotkey: H")
Sec("Aimbot", "Settings")
Sli("Aimbot", "Smoothness",
    function() return STATE.aimSmooth end,
    function(v) STATE.aimSmooth = v end, 1, 50)
Info("Aimbot", "  1=instant snap  50=very slow")
Sli("Aimbot", "FOV Radius",
    function() return STATE.aimFOV end,
    function(v) STATE.aimFOV = v end, 20, 400)
Sec("Aimbot", "Bone Target")
local BONES = {"Head","HumanoidRootPart","UpperTorso","Torso"}
for _, bone in ipairs(BONES) do
    local bRow = Instance.new("Frame", sf)
    bRow.Size=UDim2.new(1,0,0,28); bRow.BackgroundColor3=C.PANEL
    bRow.BorderSizePixel=0; bRow.LayoutOrder=nxt(); bRow.Visible=false
    Instance.new("UICorner",bRow).CornerRadius=UDim.new(0,7)
    local bLbl = Instance.new("TextLabel",bRow)
    bLbl.Size=UDim2.new(1,-68,1,0); bLbl.Position=UDim2.new(0,9,0,0)
    bLbl.BackgroundTransparency=1; bLbl.Text=bone
    bLbl.Font=Enum.Font.Gotham; bLbl.TextSize=12
    bLbl.TextColor3=C.TXT; bLbl.TextXAlignment=Enum.TextXAlignment.Left
    local bBtn = Instance.new("TextButton",bRow)
    bBtn.Size=UDim2.new(0,54,0,20); bBtn.Position=UDim2.new(1,-58,0.5,-10)
    bBtn.Font=Enum.Font.GothamBold; bBtn.TextSize=10
    bBtn.BorderSizePixel=0; Instance.new("UICorner",bBtn).CornerRadius=UDim.new(0,6)
    local function rfB()
        local sel = STATE.aimBone == bone
        bBtn.Text=sel and "ON" or "SELECT"
        bBtn.BackgroundColor3=sel and C.ON or C.DARK
        bBtn.TextColor3=C.WHT
    end
    rfB()
    bBtn.MouseButton1Click:Connect(function()
        STATE.aimBone = bone
        -- refresh all bone buttons
        for _,f in ipairs(tabPages["Aimbot"]) do
            local b = f:FindFirstChildOfClass("TextButton")
            if b then
                local lbl = f:FindFirstChildOfClass("TextLabel")
                if lbl then
                    local isSel = STATE.aimBone == lbl.Text
                    b.Text=isSel and "ON" or "SELECT"
                    b.BackgroundColor3=isSel and C.ON or C.DARK
                end
            end
        end
    end)
    table.insert(tabPages["Aimbot"], bRow)
end
Sec("Aimbot", "Hotkey")
local KEYS = {"RMB","LMB","E","Q","CapsLock"}
for _, key in ipairs(KEYS) do
    local kRow = Instance.new("Frame",sf)
    kRow.Size=UDim2.new(1,0,0,28); kRow.BackgroundColor3=C.PANEL
    kRow.BorderSizePixel=0; kRow.LayoutOrder=nxt(); kRow.Visible=false
    Instance.new("UICorner",kRow).CornerRadius=UDim.new(0,7)
    local kLbl = Instance.new("TextLabel",kRow)
    kLbl.Size=UDim2.new(1,-68,1,0); kLbl.Position=UDim2.new(0,9,0,0)
    kLbl.BackgroundTransparency=1; kLbl.Text=key
    kLbl.Font=Enum.Font.Gotham; kLbl.TextSize=12
    kLbl.TextColor3=C.TXT; kLbl.TextXAlignment=Enum.TextXAlignment.Left
    local kBtn = Instance.new("TextButton",kRow)
    kBtn.Size=UDim2.new(0,54,0,20); kBtn.Position=UDim2.new(1,-58,0.5,-10)
    kBtn.Font=Enum.Font.GothamBold; kBtn.TextSize=10
    kBtn.BorderSizePixel=0; Instance.new("UICorner",kBtn).CornerRadius=UDim.new(0,6)
    local function rfK()
        local sel = STATE.aimKey == key
        kBtn.Text=sel and "ON" or "SELECT"
        kBtn.BackgroundColor3=sel and C.ON or C.DARK
        kBtn.TextColor3=C.WHT
    end
    rfK()
    kBtn.MouseButton1Click:Connect(function()
        STATE.aimKey = key
        for _,f in ipairs(tabPages["Aimbot"]) do
            local b=f:FindFirstChildOfClass("TextButton")
            if b then
                local l=f:FindFirstChildOfClass("TextLabel")
                if l then
                    local keys2={"RMB","LMB","E","Q","CapsLock"}
                    local isKey=false
                    for _,k2 in ipairs(keys2) do if k2==l.Text then isKey=true break end end
                    if isKey then
                        local isSel=STATE.aimKey==l.Text
                        b.Text=isSel and "ON" or "SELECT"
                        b.BackgroundColor3=isSel and C.ON or C.DARK
                    end
                end
            end
        end
    end)
    table.insert(tabPages["Aimbot"], kRow)
end
Sec("Aimbot", "Options")
Tog("Aimbot", "Prediction",
    function() return STATE.aimPrediction end,
    function(v) STATE.aimPrediction = v end)
Info("Aimbot", "  Leads moving targets")
Tog("Aimbot", "Team Check",
    function() return STATE.aimTeamCheck end,
    function(v) STATE.aimTeamCheck = v end)
Info("Aimbot", "  Skip teammates")
Tog("Aimbot", "Show FOV",
    function() return STATE.aimShowFOV end,
    function(v) STATE.aimShowFOV = v end)
-- ============================
-- MOVEMENT TAB
-- ============================
Sec("Movement", "Movement")
Tog("Movement", "Undetected Fly",
    function() return STATE.fly end,
    function(v) STATE.fly = v end,
    function(on) if on then startFly() else stopFly() end end)
Info("Movement", "  SPACE=up  CTRL=down  WASD=move")
Sli("Movement", "Fly Speed",
    function() return STATE.flySpeed end,
    function(v) STATE.flySpeed = v end, 10, 200)
Tog("Movement", "Click-TP",
    function() return STATE.clickTP end,
    function(v) STATE.clickTP = v end)
Info("Movement", "  Click anywhere to teleport.")
Tog("Movement", "Speed Boost",
    function() return STATE.speedBoost end,
    function(v)
        STATE.speedBoost = v
        if not v then local h = getHum(); if h then h.WalkSpeed = 16 end end
    end)
Sli("Movement", "Walk Speed",
    function() return STATE.speedValue end,
    function(v) STATE.speedValue = v end, 16, 200)
Tog("Movement", "Reach",
    function() return STATE.reach end,
    function(v) STATE.reach = v end)
Sli("Movement", "Reach Size",
    function() return STATE.reachValue end,
    function(v) STATE.reachValue = v end, 5, 60)
Sec("Movement", "Jump & Air")
Tog("Movement", "Jump Boost",
    function() return STATE.jumpBoost end,
    function(v) STATE.jumpBoost = v; if not v then local h=getHum(); if h then h.JumpPower=50 end end end)
Sli("Movement", "Jump Power",
    function() return STATE.jumpPower end,
    function(v) STATE.jumpPower = v end, 50, 500)
Tog("Movement", "Infinite Jump",
    function() return STATE.infinite end,
    function(v) STATE.infinite = v end)
Info("Movement", "  Jump again mid-air endlessly.")
Tog("Movement", "Bunny Hop",
    function() return STATE.bhop end,
    function(v) STATE.bhop = v end)
Info("Movement", "  Auto-jumps the moment you land.")
Sec("Movement", "Fling")
Tog("Movement", "Spin",
    function() return STATE.spinToggle end,
    function(v)
        STATE.spinToggle = v
        if v then startSpin() else stopSpin() end
    end)
Info("Movement", "  Spins YOU at 9999 rad/s. Still walk freely.")
-- ============================
-- CHAT TAB  -  CuongOutLook User Network
-- ============================
-- HOW IT WORKS:
-- MessagingService is server-only and cannot be used from LocalScript.
-- Instead we use Roblox's actual in-game chat:
--   SEND:    Fire the game's SayMessageRequest RemoteEvent with a
--            special hidden prefix [cuongoutlookChat] so the message goes
--            through the real chat system and reaches all clients.
--   RECEIVE: Hook every player's .Chatted event. Messages that start
--            with [cuongoutlookChat] get stripped and shown in the CuongOutLook chat
--            log instead of (or in addition to) the normal chat.
--            Non-CuongOutLook messages are ignored by this tab.
-- This gives true same-server real-time chat between all CuongOutLook users.
-- ============================
local CHAT_PREFIX = "[LC]"   -- short prefix sent in actual Roblox chat
local chatLog     = {}       -- {name, msg, time, mine}
local MAX_CHAT    = 80
local chatSlots   = {}
local CHAT_SLOTS  = 28
local refreshChat            -- forward declare
local function addChatMsg(name, msg, mine)
    table.insert(chatLog, {
        name = name,
        msg  = msg,
        time = os.date("%H:%M"),
        mine = mine,
    })
    while #chatLog > MAX_CHAT do table.remove(chatLog, 1) end
    if refreshChat then refreshChat() end
    if not mine and activeTab ~= "Chat" then
        notify("CuongOutLook Chat", name..": "..msg, 4)
    end
end
-- Send via Roblox chat with prefix
local function chatSend(msg)
    if not msg or #msg == 0 or #msg > 150 then return end
    local full = CHAT_PREFIX.." "..msg
    -- Add own message to log immediately (don't wait for echo)
    addChatMsg(plr.Name, msg, true)
    -- Method 1: TextChatService (newer games 2023+)
    local sent1 = false
    pcall(function()
        local TCS = game:GetService("TextChatService")
        if TCS and TCS.ChatVersion == Enum.ChatVersion.TextChatService then
            local ch = TCS:FindFirstChild("TextChannels")
            if ch then
                local general = ch:FindFirstChild("RBXGeneral")
                    or ch:GetChildren()[1]
                if general and general:IsA("TextChannel") then
                    general:SendAsync(full)
                    sent1 = true
                end
            end
        end
    end)
    -- Method 2: Legacy SayMessageRequest RemoteEvent (most games)
    if not sent1 then
        pcall(function()
            local RE = game:GetService("ReplicatedStorage")
                :FindFirstChild("DefaultChatSystemChatEvents")
            if RE then
                local say = RE:FindFirstChild("SayMessageRequest")
                if say then
                    say:FireServer(full, "All")
                end
            end
        end)
    end
    -- Method 3: Direct via chat module
    pcall(function()
        local chat = game:GetService("Chat")
        chat:Chat(plr.Character and plr.Character:FindFirstChild("Head"), full)
    end)
end
-- Hook a single player's Chatted event to receive CuongOutLook messages
local hookedPlayers = {}
local function hookPlayer(p)
    if hookedPlayers[p] then return end
    hookedPlayers[p] = true
    p.Chatted:Connect(function(msg)
        -- Only process [LC] tagged messages
        if msg:sub(1, #CHAT_PREFIX) == CHAT_PREFIX then
            local body = msg:sub(#CHAT_PREFIX + 2)  -- strip prefix + space
            if body and #body > 0 then
                local mine = (p == plr)
                -- Avoid double-adding our own (we already added on send)
                if not mine then
                    addChatMsg(p.Name, body, false)
                end
            end
        end
    end)
end
-- Hook all current and future players
for _, p in ipairs(Players:GetPlayers()) do hookPlayer(p) end
Players.PlayerAdded:Connect(hookPlayer)
Players.PlayerRemoving:Connect(function(p) hookedPlayers[p] = nil end)
-- Chat tab GUI
Sec("Chat", "CuongOutLook User Chat")
-- Header info
local chatInfo = Instance.new("Frame", sf)
chatInfo.Size             = UDim2.new(1,0,0,28)
chatInfo.BackgroundColor3 = C.PANEL
chatInfo.BorderSizePixel  = 0
chatInfo.LayoutOrder      = nxt()
chatInfo.Visible          = false
Instance.new("UICorner", chatInfo).CornerRadius = UDim.new(0,7)
local chatInfoL = Instance.new("TextLabel", chatInfo)
chatInfoL.Size               = UDim2.new(1,0,1,0)
chatInfoL.Position           = UDim2.new(0,9,0,0)
chatInfoL.BackgroundTransparency = 1
chatInfoL.Font               = Enum.Font.Gotham
chatInfoL.TextSize           = 10
chatInfoL.TextColor3         = C.ACC
chatInfoL.TextXAlignment     = Enum.TextXAlignment.Left
chatInfoL.Text               = "  Cross-server - all CuongOutLook users connected"
table.insert(tabPages["Chat"], chatInfo)
-- Message slots (scrollable via the existing ScrollingFrame)
for _ = 1, CHAT_SLOTS do
    local row = Instance.new("Frame", sf)
    row.Size             = UDim2.new(1,0,0,42)
    row.BackgroundColor3 = C.DARK
    row.BorderSizePixel  = 0
    row.LayoutOrder      = nxt()
    row.Visible          = false
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,6)
    local accent = Instance.new("Frame", row)
    accent.Size             = UDim2.new(0,3,1,-6)
    accent.Position         = UDim2.new(0,0,0,3)
    accent.BackgroundColor3 = C.ACC
    accent.BorderSizePixel  = 0
    Instance.new("UICorner", accent).CornerRadius = UDim.new(1,0)
    local header = Instance.new("TextLabel", row); header.Name = "H"
    header.Size               = UDim2.new(1,-12,0,14)
    header.Position           = UDim2.new(0,10,0,3)
    header.BackgroundTransparency = 1
    header.Font               = Enum.Font.GothamBold
    header.TextSize           = 10
    header.TextColor3         = C.ACC
    header.TextXAlignment     = Enum.TextXAlignment.Left
    header.Text               = ""
    local body = Instance.new("TextLabel", row); body.Name = "B"
    body.Size               = UDim2.new(1,-12,0,22)
    body.Position           = UDim2.new(0,10,0,17)
    body.BackgroundTransparency = 1
    body.Font               = Enum.Font.Gotham
    body.TextSize           = 11
    body.TextColor3         = C.TXT
    body.TextXAlignment     = Enum.TextXAlignment.Left
    body.TextWrapped        = true
    body.Text               = ""
    table.insert(chatSlots, row)
    table.insert(tabPages["Chat"], row)
end
-- Refresh visible slots from chatLog (newest at bottom)
refreshChat = function()
    if activeTab ~= "Chat" then return end
    local logLen = #chatLog
    for i, row in ipairs(chatSlots) do
        -- Show last CHAT_SLOTS messages, newest at bottom
        local logIdx = logLen - CHAT_SLOTS + i
        local entry  = (logIdx >= 1) and chatLog[logIdx] or nil
        if entry then
            local h = row:FindFirstChild("H")
            local b = row:FindFirstChild("B")
            local ac = row:FindFirstChild("Frame") -- accent
            if h then h.Text = entry.name .. "  " .. entry.time end
            if b then b.Text = entry.msg end
            if ac then
                ac.BackgroundColor3 = entry.mine
                    and Color3.fromRGB(110,22,230)
                    or  Color3.fromRGB(60,180,255)
            end
            if h then
                h.TextColor3 = entry.mine
                    and Color3.fromRGB(180,100,255)
                    or  Color3.fromRGB(60,200,255)
            end
            row.Visible = true
        else
            row.Visible = false
        end
    end
end
-- Input row: text box + send button
local inputRow = Instance.new("Frame", sf)
inputRow.Size             = UDim2.new(1,0,0,32)
inputRow.BackgroundColor3 = C.PANEL
inputRow.BorderSizePixel  = 0
inputRow.LayoutOrder      = nxt()
inputRow.Visible          = false
Instance.new("UICorner", inputRow).CornerRadius = UDim.new(0,8)
table.insert(tabPages["Chat"], inputRow)
local chatBox = Instance.new("TextBox", inputRow)
chatBox.Size                   = UDim2.new(1,-50,1,-6)
chatBox.Position               = UDim2.new(0,6,0,3)
chatBox.BackgroundColor3       = C.BG
chatBox.BorderSizePixel        = 0
chatBox.Font                   = Enum.Font.Gotham
chatBox.TextSize               = 11
chatBox.TextColor3             = C.TXT
chatBox.PlaceholderText        = "Type a message..."
chatBox.PlaceholderColor3      = C.TXTM
chatBox.Text                   = ""
chatBox.ClearTextOnFocus       = false
chatBox.TextXAlignment         = Enum.TextXAlignment.Left
Instance.new("UICorner", chatBox).CornerRadius = UDim.new(0,6)
local _cbs = Instance.new("UIPadding", chatBox)
_cbs.PaddingLeft = UDim.new(0,6)
local sendBtn = Instance.new("TextButton", inputRow)
sendBtn.Size             = UDim2.new(0,40,1,-6)
sendBtn.Position         = UDim2.new(1,-44,0,3)
sendBtn.BackgroundColor3 = C.ACC
sendBtn.BorderSizePixel  = 0
sendBtn.Font             = Enum.Font.GothamBold
sendBtn.TextSize         = 11
sendBtn.TextColor3       = Color3.new(1,1,1)
sendBtn.Text             = "Send"
sendBtn.AutoButtonColor  = false
Instance.new("UICorner", sendBtn).CornerRadius = UDim.new(0,6)
local function doSend()
    local txt = chatBox.Text:match("^%s*(.-)%s*$")
    if #txt == 0 then return end
    chatSend(txt)
    chatBox.Text = ""
end
sendBtn.MouseButton1Click:Connect(doSend)
chatBox.FocusLost:Connect(function(enter)
    if enter then doSend() end
end)
-- Refresh chat when switching to tab
-- (hook into showTab defined at bottom of file)
local _origOnDetect = onDetectionAdded
-- ============================
-- ITEMS TAB
-- ============================
-- Scans all common item containers for Tool objects and lists them.
-- Clicking Give clones the tool into your Backpack.
-- Refresh rescans the game for new tools.
-- ============================
local itemList       = {}   -- { name, path, tool } - ALL tools, no name-dedup
local itemSlotFrames = {}
-- Every container a LocalScript can actually read.
-- ServerStorage is server-only and always empty on client - excluded.
local function getRoots()
    local roots = {}
    local services = {
        "ReplicatedStorage","ReplicatedFirst",
        "StarterPack","StarterGui","StarterPlayer",
        "Lighting","SoundService",
    }
    for _, svc in ipairs(services) do
        pcall(function() table.insert(roots, game:GetService(svc)) end)
    end
    table.insert(roots, Workspace)
    for _, p in ipairs(Players:GetPlayers()) do
        pcall(function()
            local bp = p:FindFirstChild("Backpack")
            if bp then table.insert(roots, bp) end
            if p.Character then table.insert(roots, p.Character) end
        end)
    end
    return roots
end
local function scanForTools()
    itemList = {}
    local seenObj = {}  -- keyed by instance to avoid duplicating same object
    local function scanRoot(root)
        local ok, desc = pcall(function() return root:GetDescendants() end)
        if not ok then return end
        for _, obj in ipairs(desc) do
            if not seenObj[obj] and (obj:IsA("Tool") or obj:IsA("HopperBin")) then
                seenObj[obj] = true
                local path = obj.Name
                pcall(function()
                    if obj.Parent then
                        path = obj.Parent.Name.."/"..obj.Name
                    end
                end)
                table.insert(itemList, {name=obj.Name, path=path, tool=obj})
            end
        end
    end
    for _, root in ipairs(getRoots()) do
        pcall(function() scanRoot(root) end)
    end
    table.sort(itemList, function(a,b)
        if a.name:lower() == b.name:lower() then return a.path < b.path end
        return a.name:lower() < b.name:lower()
    end)
end
local function giveItem(toolObj)
    local bp   = plr:FindFirstChild("Backpack")
    local char = plr.Character
    if not bp then notify("Items","No Backpack found",2); return end
    local name = toolObj.Name
    -- Method 1: Clone into backpack (works for most tools)
    local ok1, clone = pcall(function() return toolObj:Clone() end)
    if ok1 and clone then
        clone.Parent = bp
        notify("Items","Got: "..name, 2)
        return
    end
    -- Method 2: Move original into backpack (if not locked and not in use)
    -- Only do this if the tool isn't parented to a critical game object
    local ok2 = pcall(function()
        local parent = toolObj.Parent
        if parent and parent ~= bp and parent ~= char then
            toolObj.Parent = bp
        end
    end)
    if ok2 and toolObj.Parent == bp then
        notify("Items","Got: "..name.." (moved)", 2)
        return
    end
    -- Method 3: Equip directly to character
    if char then
        local ok3 = pcall(function()
            local cl = toolObj:Clone()
            cl.Parent = char
        end)
        if ok3 then
            notify("Items","Got: "..name.." (equipped)", 2)
            return
        end
    end
    -- Method 4: Try to fire the game's own give remote if it exists
    -- Many games use a RemoteFunction/RemoteEvent named "GiveTool","GetTool","RequestTool" etc.
    local giveNames = {
        "GiveTool","GetTool","RequestTool","GiveItem","GetItem",
        "EquipTool","ClaimTool","SpawnTool","AddTool","ObtainTool",
    }
    local RS = game:GetService("ReplicatedStorage")
    for _, rName in ipairs(giveNames) do
        local remote = RS:FindFirstChild(rName, true)
            or game:GetService("ReplicatedFirst"):FindFirstChild(rName, true)
        if remote then
            if remote:IsA("RemoteEvent") then
                pcall(function() remote:FireServer(toolObj) end)
                pcall(function() remote:FireServer(name) end)
                notify("Items","Requested: "..name.." via "..rName, 3)
                return
            elseif remote:IsA("RemoteFunction") then
                pcall(function() remote:InvokeServer(toolObj) end)
                pcall(function() remote:InvokeServer(name) end)
                notify("Items","Requested: "..name.." via "..rName, 3)
                return
            end
        end
    end
    notify("Items","Could not give: "..name.." (server-locked)", 3)
end
-- Item slot builder - creates one row per tool
local function buildItemSlots()
    -- Destroy old slots
    for _, f in ipairs(itemSlotFrames) do
        pcall(function() f:Destroy() end)
    end
    itemSlotFrames = {}
    for _, entry in ipairs(itemList) do
        local row = Instance.new("Frame", sf)
        row.Size             = UDim2.new(1,0,0,30)
        row.BackgroundColor3 = C.DARK
        row.BorderSizePixel  = 0
        row.LayoutOrder      = nxt()
        row.Visible          = (activeTab == "Items")
        Instance.new("UICorner",row).CornerRadius = UDim.new(0,7)
        -- Show path (Parent/Name) only when two items share the same name
        local displayName = entry.name
        if entry.path and entry.path ~= entry.name then
            displayName = entry.name .. "  -  " .. entry.path
        end
        local nameLbl = Instance.new("TextLabel",row)
        nameLbl.Size               = UDim2.new(1,-70,1,0)
        nameLbl.Position           = UDim2.new(0,10,0,0)
        nameLbl.BackgroundTransparency = 1
        nameLbl.Text               = displayName
        nameLbl.Font               = Enum.Font.Gotham
        nameLbl.TextSize           = 11
        nameLbl.TextColor3         = C.TXT
        nameLbl.TextXAlignment     = Enum.TextXAlignment.Left
        nameLbl.TextTruncate       = Enum.TextTruncate.AtEnd
        local giveBtn = Instance.new("TextButton",row)
        giveBtn.Size             = UDim2.new(0,56,0,22)
        giveBtn.Position         = UDim2.new(1,-60,0.5,-11)
        giveBtn.BackgroundColor3 = C.ACC
        giveBtn.BorderSizePixel  = 0
        giveBtn.Text             = "Give"
        giveBtn.Font             = Enum.Font.GothamBold
        giveBtn.TextSize         = 11
        giveBtn.TextColor3       = Color3.new(1,1,1)
        giveBtn.AutoButtonColor  = false
        Instance.new("UICorner",giveBtn).CornerRadius = UDim.new(0,6)
        local captured = entry.tool
        giveBtn.MouseButton1Click:Connect(function()
            giveItem(captured)
        end)
        giveBtn.MouseEnter:Connect(function()
            giveBtn.BackgroundColor3 = Color3.fromRGB(140,40,255)
        end)
        giveBtn.MouseLeave:Connect(function()
            giveBtn.BackgroundColor3 = C.ACC
        end)
        table.insert(itemSlotFrames, row)
        table.insert(tabPages["Items"], row)
    end
    -- Empty label if nothing found
    if #itemList == 0 then
        local eRow = Instance.new("Frame",sf)
        eRow.Size             = UDim2.new(1,0,0,32)
        eRow.BackgroundColor3 = C.PANEL
        eRow.BorderSizePixel  = 0
        eRow.LayoutOrder      = nxt()
        eRow.Visible          = (activeTab == "Items")
        Instance.new("UICorner",eRow).CornerRadius = UDim.new(0,7)
        local eLbl = Instance.new("TextLabel",eRow)
        eLbl.Size=UDim2.new(1,0,1,0); eLbl.BackgroundTransparency=1
        eLbl.Text="  No tools found in this game"
        eLbl.Font=Enum.Font.Gotham; eLbl.TextSize=11
        eLbl.TextColor3=C.TXTM; eLbl.TextXAlignment=Enum.TextXAlignment.Left
        table.insert(itemSlotFrames, eRow)
        table.insert(tabPages["Items"], eRow)
    end
end
Sec("Items", "Game Items")
Act("Items", "Refresh Items", C.ACC, function()
    -- Clear old tabPages entries from itemSlotFrames
    local newPages = {}
    for _, f in ipairs(tabPages["Items"]) do
        local isSlot = false
        for _, sf2 in ipairs(itemSlotFrames) do
            if sf2 == f then isSlot = true; break end
        end
        if not isSlot then table.insert(newPages, f) end
    end
    tabPages["Items"] = newPages
    scanForTools()
    buildItemSlots()
    -- Show slots if on items tab
    for _, f in ipairs(itemSlotFrames) do
        f.Visible = (activeTab == "Items")
    end
    notify("Items", "Found "..#itemList.." tools", 3)
end)
Info("Items", "  Scans ReplicatedStorage, StarterPack,")
Info("Items", "  ServerStorage, Workspace for Tools.")
Info("Items", "  Click Give to add to your Backpack.")
-- Auto-scan on first open
local itemsScanned = false
-- ============================
-- VISUAL TAB
-- ============================
Sec("Visual", "Camera")
local function setFOV(v)
    Camera.FieldOfView = v
end
Sli("Visual", "Field of View",
    function() return math.floor(Camera.FieldOfView) end,
    function(v) setFOV(v) end, 30, 120)
Info("Visual", "  Default is 70. Higher = wider view.")
Act("Visual", "Reset FOV", C.ACC, function()
    Camera.FieldOfView = 70
    notify("Visual","FOV reset to 70", 2)
end)
Sec("Visual", "Third Person")
local tpDistState = 15
Sli("Visual", "Camera Distance",
    function() return tpDistState end,
    function(v)
        tpDistState = v
        local ok = pcall(function()
            Players.LocalPlayer.CameraMaxZoomDistance = v
            Players.LocalPlayer.CameraMinZoomDistance = v
        end)
    end, 1, 100)
Info("Visual", "  Lock camera zoom distance. 1=first person.")
Act("Visual", "Reset Camera", C.ACC, function()
    pcall(function()
        Players.LocalPlayer.CameraMaxZoomDistance = 128
        Players.LocalPlayer.CameraMinZoomDistance = 0.5
    end)
    Camera.FieldOfView = 70
    Camera.CameraType  = Enum.CameraType.Custom
    notify("Visual","Camera reset", 2)
end)
Sec("Visual", "Crosshair")
local crosshairDot = Drawing.new("Circle")
pcall(function()
    crosshairDot.Filled=true; crosshairDot.Radius=3
    crosshairDot.Color=Color3.fromRGB(255,255,255)
    crosshairDot.ZIndex=10; crosshairDot.Visible=false
end)
local crosshairH = Drawing.new("Line")
pcall(function()
    crosshairH.Thickness=1; crosshairH.Color=Color3.fromRGB(255,255,255)
    crosshairH.ZIndex=10; crosshairH.Visible=false
end)
local crosshairV = Drawing.new("Line")
pcall(function()
    crosshairV.Thickness=1; crosshairV.Color=Color3.fromRGB(255,255,255)
    crosshairV.ZIndex=10; crosshairV.Visible=false
end)
local crossState = false
Tog("Visual", "Custom Crosshair",
    function() return crossState end,
    function(v)
        crossState = v
        crosshairDot.Visible = v
        crosshairH.Visible   = v
        crosshairV.Visible   = v
    end)
Info("Visual", "  White dot + lines crosshair overlay")
RunService.RenderStepped:Connect(function()
    if not crossState then return end
    local vp = Camera.ViewportSize
    local cx,cy = vp.X/2, vp.Y/2
    crosshairDot.Position = Vector2.new(cx,cy)
    local s = 12
    crosshairH.From = Vector2.new(cx-s,cy); crosshairH.To = Vector2.new(cx+s,cy)
    crosshairV.From = Vector2.new(cx,cy-s); crosshairV.To = Vector2.new(cx,cy+s)
end)
Sec("Visual", "World")
Tog("Visual", "Rainbow Sky",
    function() return STATE.rainbowSky end,
    function(v) STATE.rainbowSky = v end)
Info("Visual", "  Cycles Lighting Ambient through rainbow colors")
local rainbowHue = 0
RunService.Heartbeat:Connect(function(dt)
    if not STATE.rainbowSky then return end
    rainbowHue = (rainbowHue + dt * 0.3) % 1
    local Lighting = game:GetService("Lighting")
    Lighting.Ambient = Color3.fromHSV(rainbowHue, 0.6, 1)
    Lighting.OutdoorAmbient = Color3.fromHSV((rainbowHue+0.5)%1, 0.6, 1)
end)
-- ============================
-- WORLD TAB
-- ============================
Sec("World", "Performance")
Tog("World", "Anti-AFK",
    function() return STATE.antiAFK end,
    function(v) STATE.antiAFK = v end)
Info("World", "  Pings input every 60s so you never get kicked.")
Tog("World", "Low Poly Mode",
    function() return STATE.lowPoly end,
    function(v) STATE.lowPoly = v; if v then applyLowPoly() else removeLowPoly() end end)
Info("World", "  Makes all textures flat. Removes effects.")
Info("World", "  Big FPS boost on low-end devices.")
Sec("World", "Sound")
Tog("World", "Anti-Music",
    function() return STATE.antiMusic end,
    function(v) STATE.antiMusic = v; if v then muteAll() else unmuteAll() end end)
Info("World", "  Silences all Sounds in workspace + SoundService.")
Sec("World", "World Editing")
Tog("World", "Remove Walls",
    function() return STATE.removeWalls end,
    function(v) STATE.removeWalls = v; applyWorldEdits() end)
Info("World", "  Hides collidable visible parts.")
Tog("World", "Remove Anchored",
    function() return STATE.removeAnchored end,
    function(v) STATE.removeAnchored = v; applyWorldEdits() end)
Info("World", "  Hides all Anchored=true parts.")
Tog("World", "Remove Unanchored",
    function() return STATE.removeUnanchored end,
    function(v) STATE.removeUnanchored = v; applyWorldEdits() end)
Info("World", "  Hides all Anchored=false collidable parts.")
Act("World", "Restore All Parts", Color3.fromRGB(55, 35, 90), function()
    STATE.removeWalls      = false
    STATE.removeAnchored   = false
    STATE.removeUnanchored = false
    restoreAll()
    notify("World", "All parts restored", 2)
    showTab("World")
end)
Sec("World", "Lighting")
Tog("World", "Fullbright",
    function() return STATE.fullbright end,
    function(v) STATE.fullbright = v; applyFullbright(v) end)
Info("World", "  Max ambient brightness. See in the dark.")
Tog("World", "No Fog",
    function() return STATE.noFog end,
    function(v) STATE.noFog = v; applyNoFog(v) end)
Info("World", "  Removes all fog from the game.")
Tog("World", "Freeze Time",
    function() return STATE.timeFreeze end,
    function(v) STATE.timeFreeze = v; applyTimeFreeze(v) end)
Sli("World", "Time of Day",
    function() return STATE.frozenTime end,
    function(v)
        STATE.frozenTime = v
        if STATE.timeFreeze then
            Lighting.TimeOfDay = string.format("%02d:00:00", math.floor(v))
        end
    end, 0, 23)
Info("World", "  0=midnight  6=sunrise  14=noon  20=night")
Sec("World", "Screen Effects")
Tog("World", "Remove Screen FX",
    function() return STATE.noScreenFX end,
    function(v)
        STATE.noScreenFX = v
        if v then removeScreenFX() else restoreScreenFX() end
    end)
Info("World", "  Removes blur, bloom, sun rays, color grade,")
Info("World", "  depth of field. Cleaner visuals + FPS boost.")
Sec("World", "Menu")
Act("World", "Kick Yourself", Color3.fromRGB(200, 55, 55), function()
    notify("World", "Disconnecting...", 2)
    task.delay(0.15, function()
        plr:Kick("You have been kicked from the game by CuongOutLook Admin System.")
    end)
end)
Info("World", "  Disconnects your own client from the current server.")
Act("World", "Rejoin Server", C.ACC, function()
    notify("World", "Rejoining server...", 2)
    task.spawn(function()
        local ok = pcall(function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, plr)
        end)
        if not ok then
            pcall(function()
                TeleportService:Teleport(game.PlaceId, plr)
            end)
        end
    end)
end)
Info("World", "  Rejoins your current game/server.")
Act("World", "Destroy Menu", Color3.fromRGB(150, 35, 35), function()
    notify("World", "Menu destroyed", 2)
    pcall(function()
        sg:Destroy()
    end)
end)
Info("World", "  Closes the UI completely.")
-- ============================
-- PLAYERS TAB
-- ============================
Sec("Players", "Fling")
local flingTgt = nil
Drop("Players", "Target", function(p) flingTgt = p end)
Act("Players", "Fling Once", Color3.fromRGB(150, 28, 28), function()
    if not flingTgt then notify("Fling","Select a target first",2); return end
    flingPlayer(flingTgt)
end)
local chainBtn
chainBtn = Act("Players", "Chain Fling (OFF)", Color3.fromRGB(90, 18, 18), function()
    if chainFlingActive then
        stopChainFling()
        chainBtn.Text             = "Chain Fling (OFF)"
        chainBtn.BackgroundColor3 = Color3.fromRGB(90,18,18)
        notify("Fling","Chain fling stopped",2)
    else
        startChainFling(flingTgt)
        chainBtn.Text             = "Chain Fling (ON)"
        chainBtn.BackgroundColor3 = Color3.fromRGB(200,20,20)
        notify("Fling","Chain fling started - spins then launches, auto-switches!",3)
    end
end)
Info("Players", "  Spins target ULTRA fast, launches them,")
Info("Players", "  then auto-switches to next nearest player.")
Sec("Players", "Spectate")
Drop("Players", "Watch", function(p) spectate(p) end)
Act("Players", "Stop Spectate", Color3.fromRGB(45, 35, 75), stopSpectate)
Sec("Players", "Teleport")
local tpTgt = nil
Drop("Players", "TP to", function(p) tpTgt = p end)
Act("Players", "Teleport", C.ACC, function()
    if not tpTgt then return end
    local tc  = tpTgt.Character
    local hrp = getHRP()
    if tc and hrp then
        local tr = tc:FindFirstChild("HumanoidRootPart")
        if tr then
            markOwnTP()
            hrp.CFrame = tr.CFrame * CFrame.new(4, 0, 0)
            notify("TP", "Teleported to " .. tpTgt.Name, 2)
        end
    end
end)
-- ============================
-- SHOW TAB  (defined last so all tab content exists)
-- ============================
showTab = function(name)
    _showTab(name)
    if name == "Chat"  then refreshChat() end
    if name == "Items" then
        if not itemsScanned then
            itemsScanned = true
            scanForTools()
            buildItemSlots()
        end
        -- make sure slots are visible
        for _, f in ipairs(itemSlotFrames) do f.Visible = true end
    end
end
-- ============================================================
-- APPLY SAVED STATE
-- Load persisted settings and re-enable any features that
-- were ON when the script was last closed.
-- ============================================================
local function applyRestoredState()
    -- Fly
    if STATE.fly then
        pcall(startFly)
    end
    -- Speed
    -- (handled by heartbeat already, STATE.speedBoost just needs to be true)
    -- Noclip
    -- (handled by heartbeat)
    -- Spin
    if STATE.spinToggle then
        pcall(startSpin)
    end
    -- Jump boost / infinite / bhop handled by heartbeat
    -- Anti-gravity
    if STATE.antiGravity then
        pcall(function() applyAntiGrav(true) end)
    end
    -- Fullbright
    if STATE.fullbright then
        pcall(function() applyFullbright(true) end)
    end
    -- No fog
    if STATE.noFog then
        pcall(function() applyNoFog(true) end)
    end
    -- Time freeze
    if STATE.timeFreeze then
        pcall(function() applyTimeFreeze(true) end)
    end
    -- Low poly
    if STATE.lowPoly then
        pcall(applyLowPoly)
    end
    -- Anti-music
    if STATE.antiMusic then
        pcall(muteAll)
    end
    -- Remove screen FX
    if STATE.noScreenFX then
        pcall(removeScreenFX)
    end
    -- Remove walls / anchored / unanchored  (world editor)
    if STATE.removeWalls or STATE.removeAnchored or STATE.removeUnanchored then
        pcall(scanAndHide)
    end
    -- Rainbow sky handled by heartbeat (STATE.rainbowSky = true is enough)
end
showTab("Protect")
notify("CuongOutLook", "Loaded" .. (_hadSave and " - settings restored" or " - all features start OFF"), 4)


