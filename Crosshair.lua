-- ============================================================
--   CuongOutLook Crosshair (standalone)
--   Extracted UI + crosshair features from CuongOutLook Admin
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

local Camera = Workspace.CurrentCamera
local plr = Players.LocalPlayer
local mouse = plr:GetMouse()
local activeXMarks = {}
local getEnemyAtMouse
local xMarkHoldActive = false
local xMarkTouchActive = false
local xMarkLastSpawn = 0
local X_MARK_SPAM_INTERVAL = 0.06

local function notify(title, msg, dur)
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "CuongOutLook | " .. title,
			Text = msg,
			Duration = dur or 3,
		})
	end)
end

-- Drawing API shim for environments where Drawing is unavailable.
if not Drawing then
	local _dmt = {
		__index = function(t, _k)
			return function()
				return t
			end
		end,
		__newindex = function()
		end,
	}

	Drawing = setmetatable({}, {
		__index = function()
			return function()
				return setmetatable({
					Visible = false,
					Filled = false,
					Color = Color3.new(),
					Position = Vector2.new(),
					Radius = 0,
					Thickness = 1,
					ZIndex = 0,
					From = Vector2.new(),
					To = Vector2.new(),
				}, _dmt)
			end
		end,
	})

	Drawing.new = function()
		return setmetatable({
			Visible = false,
			Filled = false,
			Color = Color3.new(),
			Position = Vector2.new(),
			Radius = 0,
			Thickness = 1,
			ZIndex = 0,
			From = Vector2.new(),
			To = Vector2.new(),
			Remove = function()
			end,
			Destroy = function()
			end,
		}, _dmt)
	end
end

local STATE = {
	crosshairEnabled = false,
	crosshairShowDot = true,
	crosshairShowFOVRing = false,
	crosshairShowCross = true,

	dotScale = 3,
	dotOffsetX = 0,
	dotOffsetY = 0,

	fovRingScale = 120,
	fovRingOffsetX = 0,
	fovRingOffsetY = 0,

	crossScale = 12,
	crossOffsetX = 0,
	crossOffsetY = 0,

	dotColorR = 0,
	dotColorG = 255,
	dotColorB = 255,
	dotEnemyColorEnabled = false,
	dotEnemyColorR = 255,
	dotEnemyColorG = 60,
	dotEnemyColorB = 60,

	crossColorR = 0,
	crossColorG = 255,
	crossColorB = 255,
	crossEnemyColorEnabled = false,
	crossEnemyColorR = 255,
	crossEnemyColorG = 60,
	crossEnemyColorB = 60,

	fovRingColorR = 0,
	fovRingColorG = 255,
	fovRingColorB = 255,
	fovRingEnemyColorEnabled = false,
	fovRingEnemyColorR = 255,
	fovRingEnemyColorG = 60,
	fovRingEnemyColorB = 60,

	dotLayer = 12,
	crossLayer = 11,
	fovRingLayer = 10,

	dotThickness = 1,
	crossThickness = 1,
	fovRingThickness = 1,
	xMarkEnabled = false,
	xMarkColorR = 255,
	xMarkColorG = 255,
	xMarkColorB = 255,
	xMarkScale = 20,
	xMarkThickness = 2,
	xMarkDuration = 0.5,
}

local SAVE_FILE = ("CuongOutLookCrosshair_%d.json"):format(plr.UserId)
local saveToken = 0
local COLLAPSED_IMAGE_URL = "https://i.postimg.cc/T3RJcc55/Kh%C3%B4ng_C%C3%B3_Ti%C3%AAu_%C4%90%E1%BB%812_20221121212720.png"
local COLLAPSED_IMAGE_FILE = "CuongOutLookCollapsedIcon.png"

local function saveStateNow()
	if type(writefile) ~= "function" then
		return
	end

	local payload = {}
	for k, v in pairs(STATE) do
		if type(v) == "number" or type(v) == "boolean" or type(v) == "string" then
			payload[k] = v
		end
	end

	pcall(function()
		writefile(SAVE_FILE, HttpService:JSONEncode(payload))
	end)
end

local function queueSaveState()
	saveToken = saveToken + 1
	local currentToken = saveToken
	task.delay(0.25, function()
		if currentToken == saveToken then
			saveStateNow()
		end
	end)
end

local function loadState()
	if type(readfile) ~= "function" or type(isfile) ~= "function" then
		return
	end

	local ok, decoded = pcall(function()
		if not isfile(SAVE_FILE) then
			return nil
		end
		local raw = readfile(SAVE_FILE)
		return HttpService:JSONDecode(raw)
	end)

	if not ok or type(decoded) ~= "table" then
		return
	end

	for k, v in pairs(decoded) do
		if STATE[k] ~= nil and type(v) == type(STATE[k]) then
			STATE[k] = v
		end
	end
end

loadState()

local function resolveCollapsedImage()
	if type(game.HttpGet) ~= "function" or type(writefile) ~= "function" or type(isfile) ~= "function" then
		return nil
	end

	if not isfile(COLLAPSED_IMAGE_FILE) then
		local ok, body = pcall(function()
			return game:HttpGet(COLLAPSED_IMAGE_URL)
		end)
		if ok and type(body) == "string" and #body > 0 then
			pcall(function()
				writefile(COLLAPSED_IMAGE_FILE, body)
			end)
		end
	end

	if not isfile(COLLAPSED_IMAGE_FILE) then
		return nil
	end

	if type(getcustomasset) == "function" then
		local ok, asset = pcall(function()
			return getcustomasset(COLLAPSED_IMAGE_FILE)
		end)
		if ok and type(asset) == "string" then
			return asset
		end
	end

	if type(getsynasset) == "function" then
		local ok, asset = pcall(function()
			return getsynasset(COLLAPSED_IMAGE_FILE)
		end)
		if ok and type(asset) == "string" then
			return asset
		end
	end

	return nil
end

-- ============================================================
-- GUI
-- ============================================================
local C = {
	BG = Color3.fromRGB(10, 14, 24),
	PANEL = Color3.fromRGB(18, 24, 38),
	ACC = Color3.fromRGB(0, 220, 255),
	ON = Color3.fromRGB(38, 190, 78),
	OFF = Color3.fromRGB(160, 32, 32),
	TXT = Color3.fromRGB(238, 244, 255),
	TXTM = Color3.fromRGB(132, 148, 178),
	WHT = Color3.fromRGB(255, 255, 255),
	RED = Color3.fromRGB(200, 40, 40),
	DARK = Color3.fromRGB(13, 18, 30),
}

local sg = Instance.new("ScreenGui")
sg.Name = "CuongOutLookCrosshair"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local okHui, hui = pcall(function()
	return gethui()
end)
pcall(function()
	sg.Parent = (okHui and hui) or plr:WaitForChild("PlayerGui", 10)
end)
if not sg.Parent then
	sg.Parent = plr.PlayerGui
end

local window = Instance.new("Frame", sg)
window.Size = UDim2.new(0, 430, 0, 520)
window.Position = UDim2.new(0.5, -215, 0.5, -260)
window.BackgroundColor3 = C.BG
window.BorderSizePixel = 0
window.Active = true
window.Draggable = false
window.ClipsDescendants = true
Instance.new("UICorner", window).CornerRadius = UDim.new(0, 16)

local stroke = Instance.new("UIStroke", window)
stroke.Color = Color3.fromRGB(56, 92, 148)
stroke.Thickness = 1.5

local titleBar = Instance.new("Frame", window)
titleBar.Size = UDim2.new(1, -24, 0, 44)
titleBar.Position = UDim2.new(0, 12, 0, 12)
titleBar.BackgroundColor3 = C.PANEL
titleBar.BorderSizePixel = 0
titleBar.Active = true
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)

-- Drag only from title bar so sliders can be dragged without moving the window.
do
	local dragging = false
	local dragStart = Vector2.new(0, 0)
	local startPos = window.Position

	titleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = window.Position
		end
	end)

	titleBar.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not dragging then
			return
		end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement then
			return
		end
		local delta = input.Position - dragStart
		window.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end)
end

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.Text = "CuongOutLook Crosshair"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = C.TXT
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 30, 0, 24)
closeBtn.Position = UDim2.new(1, -36, 0.5, -12)
closeBtn.BackgroundColor3 = C.RED
closeBtn.BorderSizePixel = 0
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.TextColor3 = C.WHT
closeBtn.Text = "X"
closeBtn.AutoButtonColor = false
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

local collapsedBtn = Instance.new("ImageButton", sg)
collapsedBtn.Size = UDim2.new(0, 50, 0, 50)
collapsedBtn.Position = UDim2.new(0, 20, 0, 20)
collapsedBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
collapsedBtn.BorderSizePixel = 0
collapsedBtn.Image = resolveCollapsedImage() or ""
collapsedBtn.ScaleType = Enum.ScaleType.Stretch
collapsedBtn.AutoButtonColor = false
collapsedBtn.Visible = false
collapsedBtn.Active = true
collapsedBtn.Draggable = true
Instance.new("UICorner", collapsedBtn).CornerRadius = UDim.new(0, 10)
local collapsedBtnStroke = Instance.new("UIStroke", collapsedBtn)
collapsedBtnStroke.Color = Color3.fromRGB(0, 220, 255)
collapsedBtnStroke.Thickness = 3

local function setWindowVisible(visible)
	window.Visible = visible
	collapsedBtn.Visible = not visible
end

closeBtn.MouseButton1Click:Connect(function()
	setWindowVisible(false)
end)

collapsedBtn.MouseButton1Click:Connect(function()
	setWindowVisible(true)
end)

mouse.Button1Down:Connect(function()
	xMarkHoldActive = true
	if not STATE.xMarkEnabled then
		return
	end

	local enemy = getEnemyAtMouse and getEnemyAtMouse()
	if enemy then
		table.insert(activeXMarks, {
			createdTime = tick(),
		})
		xMarkLastSpawn = tick()
	end
end)

mouse.Button1Up:Connect(function()
	xMarkHoldActive = false
end)

UserInputService.TouchStarted:Connect(function(_input, gameProcessed)
	if gameProcessed then
		return
	end

	xMarkTouchActive = true
	if not STATE.xMarkEnabled then
		return
	end

	local enemy = getEnemyAtMouse and getEnemyAtMouse()
	if enemy then
		table.insert(activeXMarks, {
			createdTime = tick(),
		})
		xMarkLastSpawn = tick()
	end
end)

UserInputService.TouchEnded:Connect(function()
	xMarkTouchActive = false
end)

local sub = Instance.new("TextLabel", window)
sub.Size = UDim2.new(1, -24, 0, 18)
sub.Position = UDim2.new(0, 12, 0, 62)
sub.BackgroundTransparency = 1
sub.Text = "Visual crosshair only"
sub.Font = Enum.Font.Gotham
sub.TextSize = 11
sub.TextColor3 = C.TXTM
sub.TextXAlignment = Enum.TextXAlignment.Left

local content = Instance.new("Frame", window)
content.Size = UDim2.new(1, -24, 1, -90)
content.Position = UDim2.new(0, 12, 0, 82)
content.BackgroundColor3 = C.DARK
content.BorderSizePixel = 0
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 14)

local contentStroke = Instance.new("UIStroke", content)
contentStroke.Color = Color3.fromRGB(39, 58, 92)
contentStroke.Thickness = 1.2

local sf = Instance.new("ScrollingFrame", content)
sf.Size = UDim2.new(1, -16, 1, -16)
sf.Position = UDim2.new(0, 8, 0, 8)
sf.BackgroundTransparency = 1
sf.BorderSizePixel = 0
sf.ScrollBarThickness = 5
sf.ScrollBarImageColor3 = C.ACC
sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
sf.CanvasSize = UDim2.new(0, 0, 0, 0)

local list = Instance.new("UIListLayout", sf)
list.Padding = UDim.new(0, 8)
list.SortOrder = Enum.SortOrder.LayoutOrder

local pad = Instance.new("UIPadding", sf)
pad.PaddingLeft = UDim.new(0, 8)
pad.PaddingRight = UDim.new(0, 8)
pad.PaddingTop = UDim.new(0, 8)

local order = 0
local function nxt()
	order = order + 1
	return order
end

local function Sec(txt)
	local f = Instance.new("Frame", sf)
	f.Size = UDim2.new(1, 0, 0, 24)
	f.BackgroundTransparency = 1
	f.LayoutOrder = nxt()

	local lb = Instance.new("TextLabel", f)
	lb.Size = UDim2.new(1, 0, 1, 0)
	lb.BackgroundTransparency = 1
	lb.Text = txt
	lb.Font = Enum.Font.GothamBold
	lb.TextSize = 13
	lb.TextColor3 = C.ACC
	lb.TextXAlignment = Enum.TextXAlignment.Left
end

local function Info(txt)
	local f = Instance.new("Frame", sf)
	f.Size = UDim2.new(1, 0, 0, 20)
	f.BackgroundTransparency = 1
	f.LayoutOrder = nxt()

	local lb = Instance.new("TextLabel", f)
	lb.Size = UDim2.new(1, 0, 1, 0)
	lb.BackgroundTransparency = 1
	lb.Text = txt
	lb.Font = Enum.Font.Gotham
	lb.TextSize = 11
	lb.TextColor3 = C.TXTM
	lb.TextXAlignment = Enum.TextXAlignment.Left
	lb.TextWrapped = true
end

local function Tog(label, getS, setS)
	local row = Instance.new("Frame", sf)
	row.Size = UDim2.new(1, 0, 0, 42)
	row.BackgroundColor3 = C.PANEL
	row.BorderSizePixel = 0
	row.LayoutOrder = nxt()
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 12)

	local rowStroke = Instance.new("UIStroke", row)
	rowStroke.Color = Color3.fromRGB(35, 50, 78)
	rowStroke.Transparency = 0.35

	local lb = Instance.new("TextLabel", row)
	lb.Size = UDim2.new(1, -68, 1, 0)
	lb.Position = UDim2.new(0, 12, 0, 0)
	lb.BackgroundTransparency = 1
	lb.Text = label
	lb.Font = Enum.Font.Gotham
	lb.TextSize = 12
	lb.TextColor3 = C.TXT
	lb.TextXAlignment = Enum.TextXAlignment.Left

	local btn = Instance.new("TextButton", row)
	btn.Size = UDim2.new(0, 54, 0, 22)
	btn.Position = UDim2.new(1, -66, 0.5, -11)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 11
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

	local function rf()
		local on = getS()
		btn.Text = on and "ON" or "OFF"
		btn.BackgroundColor3 = on and C.ON or C.OFF
		btn.TextColor3 = C.WHT
	end

	rf()
	btn.MouseButton1Click:Connect(function()
		setS(not getS())
		queueSaveState()
		rf()
	end)
end

local function Sli(label, getV, setV, mn, mx)
	local row = Instance.new("Frame", sf)
	row.Size = UDim2.new(1, 0, 0, 54)
	row.BackgroundColor3 = C.PANEL
	row.BorderSizePixel = 0
	row.LayoutOrder = nxt()
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 12)

	local rowStroke = Instance.new("UIStroke", row)
	rowStroke.Color = Color3.fromRGB(35, 50, 78)
	rowStroke.Transparency = 0.35

	local lb = Instance.new("TextLabel", row)
	lb.Size = UDim2.new(1, -10, 0, 18)
	lb.Position = UDim2.new(0, 12, 0, 6)
	lb.BackgroundTransparency = 1
	lb.Font = Enum.Font.Gotham
	lb.TextSize = 11
	lb.TextColor3 = C.TXTM
	lb.TextXAlignment = Enum.TextXAlignment.Left

	local track = Instance.new("Frame", row)
	track.Size = UDim2.new(1, -24, 0, 8)
	track.Position = UDim2.new(0, 12, 0, 34)
	track.BackgroundColor3 = Color3.fromRGB(29, 40, 62)
	track.BorderSizePixel = 0
	Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

	local fill = Instance.new("Frame", track)
	fill.BackgroundColor3 = C.ACC
	fill.BorderSizePixel = 0
	fill.Size = UDim2.new(0, 0, 1, 0)
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

	local function rf()
		local pct = math.clamp((getV() - mn) / (mx - mn), 0, 1)
		fill.Size = UDim2.new(pct, 0, 1, 0)
		lb.Text = label .. ": " .. getV()
	end

	rf()

	local drag = false
	track.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			drag = true
		end
	end)

	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			drag = false
		end
	end)

	UserInputService.InputChanged:Connect(function(i)
		if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
			local pct = math.clamp((i.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
			setV(math.floor(mn + pct * (mx - mn) + 0.5))
			queueSaveState()
			rf()
		end
	end)
end

local function clampRGB(v)
	v = tonumber(v)
	if not v then
		return nil
	end
	return math.clamp(math.floor(v + 0.5), 0, 255)
end

local function RGB(label, getR, setR, getG, setG, getB, setB)
	local row = Instance.new("Frame", sf)
	row.Size = UDim2.new(1, 0, 0, 46)
	row.BackgroundColor3 = C.PANEL
	row.BorderSizePixel = 0
	row.LayoutOrder = nxt()
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 12)

	local rowStroke = Instance.new("UIStroke", row)
	rowStroke.Color = Color3.fromRGB(35, 50, 78)
	rowStroke.Transparency = 0.35

	local lb = Instance.new("TextLabel", row)
	lb.Size = UDim2.new(0, 100, 1, 0)
	lb.Position = UDim2.new(0, 12, 0, 0)
	lb.BackgroundTransparency = 1
	lb.Text = label
	lb.Font = Enum.Font.Gotham
	lb.TextSize = 12
	lb.TextColor3 = C.TXT
	lb.TextXAlignment = Enum.TextXAlignment.Left

	local function mkBox(x, colorLabel, getter, setter)
		local box = Instance.new("TextBox", row)
		box.Size = UDim2.new(0, 64, 0, 26)
		box.Position = UDim2.new(0, x, 0.5, -13)
		box.BackgroundColor3 = C.DARK
		box.BorderSizePixel = 0
		box.Font = Enum.Font.Gotham
		box.TextSize = 11
		box.TextColor3 = C.TXT
		box.PlaceholderText = colorLabel
		box.ClearTextOnFocus = false
		box.Text = tostring(getter())
		Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)

		box.FocusLost:Connect(function()
			local parsed = clampRGB(box.Text)
			if parsed == nil then
				box.Text = tostring(getter())
				return
			end
			setter(parsed)
			queueSaveState()
			box.Text = tostring(parsed)
		end)
	end

	mkBox(112, "R", getR, setR)
	mkBox(184, "G", getG, setG)
	mkBox(256, "B", getB, setB)
end

local function dotColor()
	return Color3.fromRGB(STATE.dotColorR, STATE.dotColorG, STATE.dotColorB)
end

local function crossColor()
	return Color3.fromRGB(STATE.crossColorR, STATE.crossColorG, STATE.crossColorB)
end

local function ringColor()
	return Color3.fromRGB(STATE.fovRingColorR, STATE.fovRingColorG, STATE.fovRingColorB)
end

local function dotEnemyColor()
	return Color3.fromRGB(STATE.dotEnemyColorR, STATE.dotEnemyColorG, STATE.dotEnemyColorB)
end

local function crossEnemyColor()
	return Color3.fromRGB(STATE.crossEnemyColorR, STATE.crossEnemyColorG, STATE.crossEnemyColorB)
end

local function ringEnemyColor()
	return Color3.fromRGB(STATE.fovRingEnemyColorR, STATE.fovRingEnemyColorG, STATE.fovRingEnemyColorB)
end

local function isEnemyTargeted()
	local targetPart = mouse.Target
	if not targetPart then
		return false
	end

	local cur = targetPart
	while cur and cur ~= Workspace do
		if cur:IsA("Model") then
			local hum = cur:FindFirstChildOfClass("Humanoid")
			if hum and hum.Health > 0 then
				local targetPlayer = Players:GetPlayerFromCharacter(cur)
				if targetPlayer and targetPlayer ~= plr then
					if targetPlayer.Team and plr.Team and targetPlayer.Team == plr.Team then
						return false
					end
					return true
				end
				return false
			end
		end
		cur = cur.Parent
	end

	return false
end

getEnemyAtMouse = function()
	local targetPart = mouse.Target
	if not targetPart then
		return nil
	end

	local cur = targetPart
	while cur and cur ~= Workspace do
		if cur:IsA("Model") then
			local hum = cur:FindFirstChildOfClass("Humanoid")
			if hum and hum.Health > 0 then
				local targetPlayer = Players:GetPlayerFromCharacter(cur)
				if targetPlayer and targetPlayer ~= plr then
					if targetPlayer.Team and plr.Team and targetPlayer.Team == plr.Team then
						return nil
					end
					return cur
				end
			end
		end
		cur = cur.Parent
	end

	return nil
end

local function xMarkColor()
	return Color3.fromRGB(STATE.xMarkColorR, STATE.xMarkColorG, STATE.xMarkColorB)
end

Sec("Crosshair")
Tog("Enable Crosshair", function()
	return STATE.crosshairEnabled
end, function(v)
	STATE.crosshairEnabled = v
end)
Info("Toggle all crosshair drawing elements")

Tog("Dot", function()
	return STATE.crosshairShowDot
end, function(v)
	STATE.crosshairShowDot = v
end)
Sli("Dot Scale", function()
	return STATE.dotScale
end, function(v)
	STATE.dotScale = v
end, 0, 20)
Sli("Dot Offset X", function()
	return STATE.dotOffsetX
end, function(v)
	STATE.dotOffsetX = v
end, -100, 100)
Sli("Dot Offset Y", function()
	return STATE.dotOffsetY
end, function(v)
	STATE.dotOffsetY = v
end, -100, 100)
RGB("Dot Color", function()
	return STATE.dotColorR
end, function(v)
	STATE.dotColorR = v
end, function()
	return STATE.dotColorG
end, function(v)
	STATE.dotColorG = v
end, function()
	return STATE.dotColorB
end, function(v)
	STATE.dotColorB = v
end)
Tog("Dot Enemy Color", function()
	return STATE.dotEnemyColorEnabled
end, function(v)
	STATE.dotEnemyColorEnabled = v
end)
RGB("Dot Enemy RGB", function()
	return STATE.dotEnemyColorR
end, function(v)
	STATE.dotEnemyColorR = v
end, function()
	return STATE.dotEnemyColorG
end, function(v)
	STATE.dotEnemyColorG = v
end, function()
	return STATE.dotEnemyColorB
end, function(v)
	STATE.dotEnemyColorB = v
end)

Tog("FOV Ring", function()
	return STATE.crosshairShowFOVRing
end, function(v)
	STATE.crosshairShowFOVRing = v
end)
Sli("FOV Ring Size", function()
	return STATE.fovRingScale
end, function(v)
	STATE.fovRingScale = v
end, 0, 300)
Sli("FOV Ring Offset X", function()
	return STATE.fovRingOffsetX
end, function(v)
	STATE.fovRingOffsetX = v
end, -100, 100)
Sli("FOV Ring Offset Y", function()
	return STATE.fovRingOffsetY
end, function(v)
	STATE.fovRingOffsetY = v
end, -100, 100)
RGB("FOV Ring Color", function()
	return STATE.fovRingColorR
end, function(v)
	STATE.fovRingColorR = v
end, function()
	return STATE.fovRingColorG
end, function(v)
	STATE.fovRingColorG = v
end, function()
	return STATE.fovRingColorB
end, function(v)
	STATE.fovRingColorB = v
end)
Tog("FOV Enemy Color", function()
	return STATE.fovRingEnemyColorEnabled
end, function(v)
	STATE.fovRingEnemyColorEnabled = v
end)
RGB("FOV Enemy RGB", function()
	return STATE.fovRingEnemyColorR
end, function(v)
	STATE.fovRingEnemyColorR = v
end, function()
	return STATE.fovRingEnemyColorG
end, function(v)
	STATE.fovRingEnemyColorG = v
end, function()
	return STATE.fovRingEnemyColorB
end, function(v)
	STATE.fovRingEnemyColorB = v
end)

Tog("Cross Lines", function()
	return STATE.crosshairShowCross
end, function(v)
	STATE.crosshairShowCross = v
end)
Sli("Cross Length", function()
	return STATE.crossScale
end, function(v)
	STATE.crossScale = v
end, 2, 50)
Sli("Cross Offset X", function()
	return STATE.crossOffsetX
end, function(v)
	STATE.crossOffsetX = v
end, -100, 100)
Sli("Cross Offset Y", function()
	return STATE.crossOffsetY
end, function(v)
	STATE.crossOffsetY = v
end, -100, 100)
RGB("Cross Color", function()
	return STATE.crossColorR
end, function(v)
	STATE.crossColorR = v
end, function()
	return STATE.crossColorG
end, function(v)
	STATE.crossColorG = v
end, function()
	return STATE.crossColorB
end, function(v)
	STATE.crossColorB = v
end)
Tog("Cross Enemy Color", function()
	return STATE.crossEnemyColorEnabled
end, function(v)
	STATE.crossEnemyColorEnabled = v
end)
RGB("Cross Enemy RGB", function()
	return STATE.crossEnemyColorR
end, function(v)
	STATE.crossEnemyColorR = v
end, function()
	return STATE.crossEnemyColorG
end, function(v)
	STATE.crossEnemyColorG = v
end, function()
	return STATE.crossEnemyColorB
end, function(v)
	STATE.crossEnemyColorB = v
end)

Sec("Layer")
Info("Higher layer draws on top")
Sli("Dot Layer", function()
	return STATE.dotLayer
end, function(v)
	STATE.dotLayer = v
end, 1, 30)
Sli("Cross Layer", function()
	return STATE.crossLayer
end, function(v)
	STATE.crossLayer = v
end, 1, 30)
Sli("FOV Ring Layer", function()
	return STATE.fovRingLayer
end, function(v)
	STATE.fovRingLayer = v
end, 1, 30)

Sec("Thickness")
Info("Set thickness for each crosshair element")
Sli("Dot Thickness", function()
	return STATE.dotThickness
end, function(v)
	STATE.dotThickness = v
end, 1, 10)
Sli("Cross Thickness", function()
	return STATE.crossThickness
end, function(v)
	STATE.crossThickness = v
end, 1, 10)
Sli("FOV Ring Thickness", function()
	return STATE.fovRingThickness
end, function(v)
	STATE.fovRingThickness = v
end, 1, 10)


Sec("X Mark Effect")
Tog("X Mark On Click", function()
return STATE.xMarkEnabled
end, function(v)
STATE.xMarkEnabled = v
end)
Info("Draw X mark when clicking on enemies")
Info("X appears at crosshair center")
RGB("X Mark Color", function()
return STATE.xMarkColorR
end, function(v)
STATE.xMarkColorR = v
end, function()
return STATE.xMarkColorG
end, function(v)
STATE.xMarkColorG = v
end, function()
return STATE.xMarkColorB
end, function(v)
STATE.xMarkColorB = v
end)
Sli("X Mark Scale", function()
return STATE.xMarkScale
end, function(v)
STATE.xMarkScale = v
end, 5, 50)
Sli("X Mark Thickness", function()
return STATE.xMarkThickness
end, function(v)
STATE.xMarkThickness = v
end, 1, 10)
Sli("X Mark Duration", function()
	return math.floor(STATE.xMarkDuration * 10 + 0.5)
end, function(v)
	STATE.xMarkDuration = math.clamp(v, 1, 20) / 10
end, 1, 20)
-- ============================================================
-- Crosshair drawings
-- ============================================================
local crosshairDot = Drawing.new("Circle")
pcall(function()
	crosshairDot.Filled = true
	crosshairDot.Radius = 3
	crosshairDot.Position = Vector2.new(0, 0)
	crosshairDot.Color = Color3.fromRGB(0, 255, 255)
	crosshairDot.Thickness = STATE.dotThickness
	crosshairDot.ZIndex = STATE.dotLayer
	crosshairDot.Visible = false
end)

local crosshairH = Drawing.new("Line")
pcall(function()
	crosshairH.From = Vector2.new(0, 0)
	crosshairH.To = Vector2.new(0, 0)
	crosshairH.Thickness = STATE.crossThickness
	crosshairH.Color = Color3.fromRGB(0, 255, 255)
	crosshairH.ZIndex = STATE.crossLayer
	crosshairH.Visible = false
end)

local crosshairV = Drawing.new("Line")
pcall(function()
	crosshairV.From = Vector2.new(0, 0)
	crosshairV.To = Vector2.new(0, 0)
	crosshairV.Thickness = STATE.crossThickness
	crosshairV.Color = Color3.fromRGB(0, 255, 255)
	crosshairV.ZIndex = STATE.crossLayer
	crosshairV.Visible = false
end)

local crosshairFOVRing = Drawing.new("Circle")
pcall(function()
	crosshairFOVRing.Filled = false
	crosshairFOVRing.Radius = 120
	crosshairFOVRing.Position = Vector2.new(0, 0)
	crosshairFOVRing.Color = Color3.fromRGB(0, 255, 255)
	crosshairFOVRing.Thickness = STATE.fovRingThickness
	crosshairFOVRing.ZIndex = STATE.fovRingLayer
	crosshairFOVRing.Visible = false
end)


-- X Mark Drawing Pool (up to 20 active X marks)
local xMarkDrawings = {}
for i = 1, 20 do
	local line1 = Drawing.new("Line")
	local line2 = Drawing.new("Line")
	pcall(function()
		line1.Visible = false
		line1.Color = Color3.fromRGB(255, 255, 255)
		line1.Thickness = 2
		line1.Transparency = 1
		line1.ZIndex = 8

		line2.Visible = false
		line2.Color = Color3.fromRGB(255, 255, 255)
		line2.Thickness = 2
		line2.Transparency = 1
		line2.ZIndex = 8
	end)
	table.insert(xMarkDrawings, { line1, line2 })
end

local function renderXMarks()
	if (xMarkHoldActive or xMarkTouchActive) and STATE.xMarkEnabled and getEnemyAtMouse then
		local now = tick()
		if (now - xMarkLastSpawn) >= X_MARK_SPAM_INTERVAL then
			local enemy = getEnemyAtMouse()
			if enemy then
				table.insert(activeXMarks, {
					createdTime = now,
				})
				xMarkLastSpawn = now
			end
		end
	end

	if STATE.xMarkEnabled then
		local currentTime = tick()
		local drawIndex = 1
		local vp = Camera.ViewportSize
		local center = Vector2.new(vp.X / 2, vp.Y / 2)

		for i = #activeXMarks, 1, -1 do
			local mark = activeXMarks[i]
			local age = currentTime - mark.createdTime

			if age > STATE.xMarkDuration then
				table.remove(activeXMarks, i)
			elseif drawIndex <= #xMarkDrawings then
				local fade = math.clamp(1 - (age / math.max(STATE.xMarkDuration, 0.001)), 0, 1)
				local line1 = xMarkDrawings[drawIndex][1]
				local line2 = xMarkDrawings[drawIndex][2]
				local size = STATE.xMarkScale

				line1.From = center - Vector2.new(size / 2, size / 2)
				line1.To = center + Vector2.new(size / 2, size / 2)
				line1.Color = xMarkColor()
				line1.Thickness = STATE.xMarkThickness
				line1.Transparency = fade
				line1.ZIndex = 8
				line1.Visible = true

				line2.From = center - Vector2.new(size / 2, -size / 2)
				line2.To = center + Vector2.new(size / 2, -size / 2)
				line2.Color = xMarkColor()
				line2.Thickness = STATE.xMarkThickness
				line2.Transparency = fade
				line2.ZIndex = 8
				line2.Visible = true

				drawIndex = drawIndex + 1
			end
		end

		for i = drawIndex, #xMarkDrawings do
			xMarkDrawings[i][1].Visible = false
			xMarkDrawings[i][2].Visible = false
		end
	else
		for _, pair in ipairs(xMarkDrawings) do
			pair[1].Visible = false
			pair[2].Visible = false
		end
	end
end

RunService.RenderStepped:Connect(function()
	if not STATE.crosshairEnabled then
		crosshairDot.Visible = false
		crosshairH.Visible = false
		crosshairV.Visible = false
		crosshairFOVRing.Visible = false
		renderXMarks()
		return
	end

	local vp = Camera.ViewportSize
	local cx = vp.X / 2
	local cy = vp.Y / 2
	local enemyTargeted = isEnemyTargeted()
	local dotCol = (enemyTargeted and STATE.dotEnemyColorEnabled) and dotEnemyColor() or dotColor()
	local crossCol = (enemyTargeted and STATE.crossEnemyColorEnabled) and crossEnemyColor() or crossColor()
	local ringCol = (enemyTargeted and STATE.fovRingEnemyColorEnabled) and ringEnemyColor() or ringColor()

	if STATE.crosshairShowDot then
		crosshairDot.Position = Vector2.new(cx + STATE.dotOffsetX, cy + STATE.dotOffsetY)
		crosshairDot.Radius = math.max(1, STATE.dotScale)
		crosshairDot.Color = dotCol
		crosshairDot.Filled = true
		crosshairDot.Thickness = STATE.dotThickness
		crosshairDot.ZIndex = STATE.dotLayer
		crosshairDot.Visible = true
	else
		crosshairDot.Visible = false
	end

	if STATE.crosshairShowCross then
		local s = math.max(1, STATE.crossScale)
		local x = cx + STATE.crossOffsetX
		local y = cy + STATE.crossOffsetY

		crosshairH.From = Vector2.new(x - s, y)
		crosshairH.To = Vector2.new(x + s, y)
		crosshairH.Color = crossCol
		crosshairH.Thickness = STATE.crossThickness
		crosshairH.ZIndex = STATE.crossLayer
		crosshairH.Visible = true

		crosshairV.From = Vector2.new(x, y - s)
		crosshairV.To = Vector2.new(x, y + s)
		crosshairV.Color = crossCol
		crosshairV.Thickness = STATE.crossThickness
		crosshairV.ZIndex = STATE.crossLayer
		crosshairV.Visible = true
	else
		crosshairH.Visible = false
		crosshairV.Visible = false
	end

	if STATE.crosshairShowFOVRing then
		crosshairFOVRing.Position = Vector2.new(cx + STATE.fovRingOffsetX, cy + STATE.fovRingOffsetY)
		crosshairFOVRing.Radius = math.max(0, STATE.fovRingScale)
		crosshairFOVRing.Color = ringCol
		crosshairFOVRing.Filled = false
		crosshairFOVRing.Thickness = STATE.fovRingThickness
		crosshairFOVRing.ZIndex = STATE.fovRingLayer
		crosshairFOVRing.Visible = true
	else
		crosshairFOVRing.Visible = false
	end

	renderXMarks()

end)

notify("Crosshair", "Loaded (RightCtrl to hide/show menu)", 4)



