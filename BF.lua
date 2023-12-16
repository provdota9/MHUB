local HttpService = game:GetService('HttpService')
local UIS = game:GetService('UserInputService')
local RunS = game:GetService('RunService')
local RS = game:GetService('ReplicatedStorage')
local TS = game:GetService('TweenService')
local PS = game:GetService('PhysicsService')

-- VARIABLES

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local DifferentColorsPoints = {Color3.fromRGB(1, 81, 255), Color3.fromRGB(255,0,0), Color3.fromRGB(0,255,0), Color3.fromRGB(255,255,0), Color3.fromRGB(255,0,255), Color3.fromRGB(0,255,255)}
local FPS = 0

makefolder("Skele Hub")
makefolder('Skele Hub\\BF')

local DefaultFiles = {

	['Skele Hub\\BF\\Settings_' .. player.Name] = {

	};




}

function deepcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[deepcopy(orig_key)] = deepcopy(orig_value)
		end
		setmetatable(copy, deepcopy(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

RunS.RenderStepped:Connect(function()
	FPS += 1
end)

for name, value in pairs(DefaultFiles) do -- SET DEFAULT VALUES
	if not pcall(function() readfile(name) end) then writefile(name, HttpService:JSONEncode(value)) end 
end

local Settings = HttpService:JSONDecode(readfile('Skele Hub\\BF\\Settings_' .. player.Name)) 

local function Save (valueName, newValue)
	Settings[valueName] = newValue
	writefile('Skele Hub\\BF\\Settings_' .. player.Name, HttpService:JSONEncode(Settings))
end

local function GetSave (valueName)
	local value = Settings[valueName]
	if value == nil then
		if DefaultFiles['Skele Hub\\BF\\Settings_' .. player.Name][valueName] ~= nil then
			Save(valueName, DefaultFiles['Skele Hub\\BF\\Settings_' .. player.Name][valueName])
		else
			Save(valueName, false)
		end

		value = Settings[valueName]
	end

	if type(value) == 'table' then value = deepcopy(value) end

	return value
end

local function MakeUICorner (scale, newParent)

	local newCorner = Instance.new('UICorner')
	newCorner.CornerRadius = UDim.new(scale, 0)
	newCorner.Parent = newParent

end

local function MakeUIPadding (bottom, left, right, top, newParent)

	local newPadding = Instance.new('UIPadding')
	newPadding.PaddingBottom = UDim.new(bottom, 0)
	newPadding.PaddingLeft = UDim.new(left, 0)
	newPadding.PaddingRight = UDim.new(right, 0)
	newPadding.PaddingTop = UDim.new(top, 0)
	newPadding.Parent = newParent

end

local function makeUIList (padding, newParent, VA)
	local va = VA or Enum.VerticalAlignment.Top

	local newUIList = Instance.new('UIListLayout')
	newUIList.Padding = UDim.new(padding, 0)
	newUIList.FillDirection = Enum.FillDirection.Vertical
	newUIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	newUIList.VerticalAlignment = va
	newUIList.SortOrder = Enum.SortOrder.LayoutOrder
	newUIList.Parent = newParent

end

---------------------------------------------------------

PGUI = game.Players.LocalPlayer:WaitForChild('PlayerGui')

-- MAKING GUI
ScreenGuiSC = Instance.new('ScreenGui', game.CoreGui)
ScreenGuiSC.Name = 'Skele Hub'
ScreenGuiSC.ResetOnSpawn = false
ScreenGuiSC.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGuiSC.Enabled = true


MainFrame = Instance.new('Frame', ScreenGuiSC)
MainFrame.BackgroundTransparency = 1
MainFrame.SizeConstraint = Enum.SizeConstraint.RelativeYY
MainFrame.Size = UDim2.new(0.525, 0, 0.525, 0)
MainFrame.Position = UDim2.new(0.614, 0, 0.284, 0)
MainFrame.Name = 'MainFrame'

MainContent = Instance.new('Frame', MainFrame)
MainContent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainContent.Size = UDim2.new(1, 0, 1, 0)
MainContent.Name = 'Background'
MakeUICorner(0.01, MainContent)

lowerTop = Instance.new('Frame', MainContent)
lowerTop.AnchorPoint = Vector2.new(0.5, 1)
lowerTop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
lowerTop.Size = UDim2.new(1, 0, 0.019, 0)
lowerTop.Position = UDim2.new(0.5, 0, 0.038, 0)	
lowerTop.BorderSizePixel = 0

ShadowMainContent = Instance.new('Frame', MainContent)
ShadowMainContent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ShadowMainContent.AnchorPoint = Vector2.new(0.5, 0.5)
ShadowMainContent.Size = UDim2.new(1.02, 0, 1.02, 0)
ShadowMainContent.Position = UDim2.new(0.5, 0, 0.5, 0)
ShadowMainContent.ZIndex = -1
MakeUICorner(0.015, ShadowMainContent)

additionalFrame = Instance.new('Frame', ScreenGui) additionalFrame.Name = 'Additional'
additionalFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) 
additionalFrame.Position = UDim2.new(0.15, 0, 0.005, 0)
additionalFrame.SizeConstraint = Enum.SizeConstraint.RelativeYY
additionalFrame.Size = UDim2.new(0.195, 0, 0.062, 0)
additionalFrame.ZIndex = 1000001
MakeUICorner(0.07, additionalFrame)

additionalFrameShadow = Instance.new('Frame', additionalFrame)
additionalFrameShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
additionalFrameShadow.AnchorPoint = Vector2.new(0.5, 0.5)
additionalFrameShadow.Size = UDim2.new(1.05, 0, 1.1, 0)
additionalFrameShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
additionalFrameShadow.ZIndex = 1000000
MakeUICorner(0.07, additionalFrameShadow)

additionalFrameInner = Instance.new('Frame', additionalFrame)
additionalFrameInner.BackgroundTransparency = 1
additionalFrameInner.Size = UDim2.new(1,0,1,0)
makeUIList(0.02, additionalFrameInner, Enum.VerticalAlignment.Center)

TimerLabel = Instance.new('TextLabel', additionalFrameInner)
TimerLabel.BackgroundTransparency = 1
TimerLabel.Size = UDim2.new(0.95, 0, 0.3, 0)
TimerLabel.ZIndex = 1000002
TimerLabel.Font = Enum.Font.GothamBlack
TimerLabel.TextColor3 = Color3.fromRGB(255,255,255)
TimerLabel.TextScaled = true
TimerLabel.TextXAlignment = Enum.TextXAlignment.Left
TimerLabel.Text = "Timer: 00:00:00"

FPSLabel = Instance.new('TextLabel', additionalFrameInner)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Size = UDim2.new(0.95, 0, 0.3, 0)
FPSLabel.ZIndex = 1000002
FPSLabel.Font = Enum.Font.GothamBlack
FPSLabel.TextColor3 = Color3.fromRGB(255,255,255)
FPSLabel.TextScaled = true
FPSLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSLabel.Text = "FPS: 0"

DiscordLabel = Instance.new('TextLabel', additionalFrameInner)
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.Size = UDim2.new(0.95, 0, 0.3, 0)
DiscordLabel.ZIndex = 1000002
DiscordLabel.Font = Enum.Font.GothamBlack
DiscordLabel.TextColor3 = Color3.fromRGB(255,255,255)
DiscordLabel.TextScaled = true
DiscordLabel.TextXAlignment = Enum.TextXAlignment.Left
DiscordLabel.Text = "Discord: 32rvCfAmGC"

task.spawn(function()
	while true do
		TimerLabel.Text = string.format("Timer: %02s:%02s:%02s", math.floor((os.time() - StartTime) / 3600), math.floor((os.time() - StartTime)%3600/60), (os.time() - StartTime) % 60 )
		FPSLabel.Text = string.format("FPS: %s", FPS) FPS = 0
		task.wait(1)
	end
end)

Top = Instance.new('Frame', MainFrame)
Top.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Top.AnchorPoint = Vector2.new(1, 0.5)
Top.Size = UDim2.new(1.02, 0, 0.2, 0)
Top.Position = UDim2.new(1.01, 0, -0.070, 0)
Top.ZIndex = 10000
MakeUICorner(0.3, Top)

HubTitle = Instance.new('ImageLabel', Top)
HubTitle.BackgroundTransparency = 1
HubTitle.AnchorPoint = Vector2.new(0.5, 0.5)
HubTitle.Size = UDim2.new(0.85, 0, 0.8, 0)
HubTitle.Position = UDim2.new(0.5, 0, 0.5, 0)
HubTitle.ZIndex = 10001
HubTitle.Image = 'rbxassetid://15533277908'  -- Замените на фактический Asset ID вашего изображения
HubTitle.ScaleType = Enum.ScaleType.Crop
HubTitle.Name = 'SkeleHubImage'
--hide gui
ScreenGuiB = Instance.new('ScreenGui', game.CoreGui)
ScreenGuiB.Name = 'HideScriptButton'
ScreenGuiB.ResetOnSpawn = false
ScreenGuiB.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGuiB.Enabled = true

MainFrameB = Instance.new('Frame', ScreenGuiB)
MainFrameB.BackgroundTransparency = 1
MainFrameB.SizeConstraint = Enum.SizeConstraint.RelativeYY
MainFrameB.Size = UDim2.new(0.525, 0, 0.525, 0)
MainFrameB.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrameB.Name = 'MainFrame'

HideScriptButton = Instance.new('ImageButton', MainFrameB) -- Заменяем 'TextButton' на 'ImageButton'
HideScriptButton.AnchorPoint = Vector2.new(1, 0.5)
HideScriptButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
HideScriptButton.Size = UDim2.new(0, 100, 0, 40)
HideScriptButton.Position = UDim2.new(1.8, 0, -0.8, 0)
HideScriptButton.ZIndex = 10001
HideScriptButton.Image = 'rbxassetid://15533941365'  -- Установите фактический Asset ID вашего изображения или путь к изображению
HideScriptButton.ScaleType = Enum.ScaleType.Crop
HideScriptButton.Name = 'HideButtonImage'
MakeUICorner(0.5, HideScriptButton)

HideScriptButton.MouseButton1Click:Connect(function()
    ScreenGuiSC.Enabled = not ScreenGuiSC.Enabled -- Инвертируем значение свойства Enabled
end)


local function MakeDraggable (dragGui, dragwith)

	local dragging
	local dragInput
	local dragStart
	local startPos
	local function updateDrag(input)
		local delta = input.Position - dragStart
		local dragTime = 0.04
		local SmoothDrag = {}
		SmoothDrag.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		local dragSmoothFunction = TS:Create(dragwith, TweenInfo.new(dragTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), SmoothDrag)
		dragSmoothFunction:Play()
	end

	dragGui.InputBegan:Connect(function(input)
		local usedMouse = input.UserInputType == Enum.UserInputType.MouseButton1
		local usedTouch = input.UserInputType == Enum.UserInputType.Touch

		if usedMouse or usedTouch then
			dragging = true
			dragStart = input.Position
			startPos = dragwith.Position
			local release

			release = UIS.InputEnded:Connect(function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
				dragging = false
				release:Disconnect()

			end)



		end
	end)
	dragGui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			updateDrag(input)
		end
	end)

end
MakeDraggable(additionalFrame, additionalFrame)
MakeDraggable(Top, MainFrame)

Pages = Instance.new('ScrollingFrame', MainContent)
Pages.BackgroundColor3 = Color3.fromRGB(102, 0, 255)
Pages.Size = UDim2.new(1, 0, 0.047, 0)
Pages.Position = UDim2.new(0, 0, 0.038, 0)
Pages.AutomaticCanvasSize = 'Y'
Pages.CanvasSize = UDim2.new(0, 0, 0, 0)
Pages.ScrollBarThickness = 0
Pages.ScrollingDirection = Enum.ScrollingDirection.X
Pages.BorderSizePixel = 0
Pages.ZIndex = 9500

ListPages = Instance.new('UIListLayout', Pages)
ListPages.FillDirection = Enum.FillDirection.Horizontal
ListPages.HorizontalAlignment = Enum.HorizontalAlignment.Left
ListPages.VerticalAlignment = Enum.VerticalAlignment.Center
ListPages.SortOrder = Enum.SortOrder.LayoutOrder

ScrollingContent = Instance.new('ScrollingFrame', MainContent)
ScrollingContent.BackgroundTransparency = 1
ScrollingContent.Size = UDim2.new(1, 0, 0.916, 0)
ScrollingContent.Position = UDim2.new(0, 0, 0.084, 0)
ScrollingContent.AutomaticCanvasSize = 'Y'
ScrollingContent.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingContent.ScrollBarThickness = 4
ScrollingContent.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollingContent.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
ScrollingContent.BorderSizePixel = 0

newPageButtonBCInfo = TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false)

pageOrder = 1
pageShown = nil
local function MakeNewPage (pageName, pageButtonX)

	local newPageButton = Instance.new('TextButton', Pages)
	newPageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	newPageButton.Name = pageName
	newPageButton.BackgroundTransparency = 1
	newPageButton.Size = UDim2.new(pageButtonX, 0, 1, 0)
	newPageButton.Text = ''
	newPageButton.LayoutOrder = pageOrder pageOrder+=1
	newPageButton.BorderSizePixel = 0
	newPageButton.ZIndex = 9850

	local newPageButtonTitle = Instance.new('TextLabel', newPageButton)
	newPageButtonTitle.AnchorPoint = Vector2.new(0.5, 0.5)
	newPageButtonTitle.BackgroundTransparency = 1
	newPageButtonTitle.Size = UDim2.new(1, 0, 0.8, 0)
	newPageButtonTitle.Position = UDim2.new(0.5, 0, 0.5, 0)
	newPageButtonTitle.Font = Enum.Font.GothamBlack
	newPageButtonTitle.TextScaled = true
	newPageButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	newPageButtonTitle.Text = string.upper(pageName)
	newPageButtonTitle.ZIndex = 9875

	local newPageButtonBottomLine = Instance.new('Frame', newPageButton)
	newPageButtonBottomLine.BackgroundColor3 = Color3.fromRGB(102, 0, 255)
	newPageButtonBottomLine.Name = 'BottomLine'
	newPageButtonBottomLine.AnchorPoint = Vector2.new(0, 1)
	newPageButtonBottomLine.Size = UDim2.new(1, 0, 0.05, 0)
	newPageButtonBottomLine.Position = UDim2.new(0, 0, 1, 0)
	newPageButtonBottomLine.Visible = false
	newPageButtonBottomLine.BorderSizePixel = 0
	newPageButtonBottomLine.ZIndex = 9800

	local newPage = Instance.new('Frame', ScrollingContent)
	newPage.Name = pageName
	newPage.BackgroundTransparency = 1
	newPage.Size = UDim2.new(1, 0, 1, 0)
	newPage.Visible = false

	local LeftPage = Instance.new('Frame', newPage)
	LeftPage.Name = 'Left'
	LeftPage.BackgroundTransparency = 1
	LeftPage.Size = UDim2.new(0.5, 0, 1, 0)
	makeUIList(0.02, LeftPage)
	MakeUIPadding(0.01, 0, 0, 0.01, LeftPage)

	local RightPage = Instance.new('Frame', newPage)
	RightPage.Name = 'Right'
	RightPage.BackgroundTransparency = 1
	RightPage.AnchorPoint = Vector2.new(1, 0)
	RightPage.Position = UDim2.new(1, 0, 0, 0)
	RightPage.Size = UDim2.new(0.5, 0, 1, 0)
	makeUIList(0.02, RightPage)
	MakeUIPadding(0.01, 0, 0, 0.01, RightPage)

	local PlaceHolder = Instance.new('Frame', RightPage)
	PlaceHolder.BackgroundTransparency = 1
	PlaceHolder.Size = UDim2.new(0, 0, 0.4, 0)
	PlaceHolder.LayoutOrder = 999999

	local PlaceHolder = Instance.new('Frame', LeftPage)
	PlaceHolder.BackgroundTransparency = 1
	PlaceHolder.Size = UDim2.new(0, 0, 0.4, 0)
	PlaceHolder.LayoutOrder = 999999

	newPageButton.MouseEnter:Connect(function()
		local TweenButton = TS:Create(newPageButton, newPageButtonBCInfo, {BackgroundTransparency = 0.9})
		TweenButton:Play()
	end)

	newPageButton.MouseLeave:Connect(function()
		local TweenButton = TS:Create(newPageButton, newPageButtonBCInfo, {BackgroundTransparency = 1})
		TweenButton:Play()
	end)

	newPageButton.MouseButton1Click:Connect(function()
		if pageShown == newPage then return end
		pageShown.Visible = false
		Pages[pageShown.Name].BottomLine.Visible = false

		pageShown = newPage
		newPageButtonBottomLine.Visible = true
		newPage.Visible = true


	end)

	return newPage
end

local Orders = {}
local function MakeNewSubPage (pageName, side, scaleY, cornerScale, UIPaddingTop, UIListLayout)

	local page = ScrollingContent[pageName][side]

	local newSubPage = Instance.new('Frame', page)
	newSubPage.BackgroundColor3 = Color3.fromRGB(51, 0, 102)
	newSubPage.BorderSizePixel = 0
	newSubPage.Size = UDim2.new(0.95, 0, scaleY, 0)
	MakeUICorner(cornerScale, newSubPage)
	makeUIList(UIListLayout, newSubPage)
	MakeUIPadding(0, 0.03, 0.03, UIPaddingTop, newSubPage)

	Orders[newSubPage] = 1
	return newSubPage
end

local function MakeTitle (subPage, TitleTXT, scaleY)

	local newTitle = Instance.new('TextLabel')
	newTitle.BackgroundTransparency = 1
	newTitle.Size = UDim2.new(1, 0, scaleY, 0)
	newTitle.Font = Enum.Font.GothamBlack
	newTitle.Text = TitleTXT
	newTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	newTitle.TextScaled = true
	newTitle.LayoutOrder = Orders[subPage]
	newTitle.Parent = subPage

	Orders[subPage] += 1

	return newTitle
end

local checkBoxColors = {
	[true] = Color3.fromRGB(102, 0, 255);
	[false] = Color3.fromRGB(0, 0, 0)
}

local function MakeCheckbox (subPage, checkBoxTXT, scaleY)

	local newCheckBoxFrame = Instance.new('Frame', subPage)
	newCheckBoxFrame.BackgroundTransparency = 1
	newCheckBoxFrame.Size = UDim2.new(1, 0, scaleY, 0)
	newCheckBoxFrame.LayoutOrder = Orders[subPage]
	Orders[subPage] += 1

	local newCheckBox = Instance.new('Frame', newCheckBoxFrame)
	newCheckBox.AnchorPoint = Vector2.new(0, 0.5)
	newCheckBox.BackgroundColor3 = Color3.fromRGB(51, 0, 102)
	newCheckBox.Size = UDim2.new(0.049, 0, 0.73, 0)
	newCheckBox.Position = UDim2.new(0, 0, 0.5, 0)
	newCheckBox.BorderSizePixel = 0

	newCheckBox.BackgroundColor3 = checkBoxColors[GetSave(checkBoxTXT)]

	local UIStroke = Instance.new('UIStroke', newCheckBox)
	UIStroke.Color = Color3.fromRGB(255, 255, 255)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Thickness = 1

	local newCheckBoxButton = Instance.new('TextButton', newCheckBox)
	newCheckBoxButton.Name = checkBoxTXT
	newCheckBoxButton.BackgroundTransparency = 1
	newCheckBoxButton.Size = UDim2.new(1,0,1,0)
	newCheckBoxButton.ZIndex = 10
	newCheckBoxButton.Text = ''

	local newCheckBoxTXT = Instance.new('TextLabel', newCheckBoxFrame)
	newCheckBoxTXT.BackgroundTransparency = 1
	newCheckBoxTXT.Size = UDim2.new(0.835, 0, 1, 0)
	newCheckBoxTXT.Position = UDim2.new(0.08, 0, 0, 0)
	newCheckBoxTXT.Font = Enum.Font.GothamBold
	newCheckBoxTXT.TextColor3 = Color3.fromRGB(255, 255, 255)
	newCheckBoxTXT.TextScaled = true
	newCheckBoxTXT.TextXAlignment = Enum.TextXAlignment.Left
	newCheckBoxTXT.Text = checkBoxTXT

	return newCheckBoxButton
end

local function MakeLargeButton (subPage, buttonTXT, scaleY)

	local newLargeButtonFrame = Instance.new('Frame', subPage)
	newLargeButtonFrame.BackgroundTransparency = 1
	newLargeButtonFrame.Size = UDim2.new(1, 0, scaleY, 0)
	newLargeButtonFrame.LayoutOrder = Orders[subPage]
	Orders[subPage] += 1

	local newLargeButton = Instance.new('TextButton', newLargeButtonFrame)
	newLargeButton.AnchorPoint = Vector2.new(0.5, 0.5)
	newLargeButton.BackgroundColor3 = Color3.fromRGB(102, 0, 255)
	newLargeButton.BorderSizePixel = 0
	newLargeButton.Size = UDim2.new(1, 0, 0.67, 0)
	newLargeButton.Position = UDim2.new(0.5, 0, 0.5, 0)
	newLargeButton.Text = ''
	newLargeButton.BorderSizePixel = 0


	local newLargeButtonLabel = Instance.new('TextLabel', newLargeButton)
	newLargeButtonLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	newLargeButtonLabel.BackgroundTransparency = 1
	newLargeButtonLabel.Size = UDim2.new(1, 0, 0.8, 0)
	newLargeButtonLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	newLargeButtonLabel.Font = Enum.Font.GothamBlack
	newLargeButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	newLargeButtonLabel.TextScaled = true
	newLargeButtonLabel.Text = buttonTXT
	MakeUICorner(0.15, newLargeButton)

	local UIStroke = Instance.new('UIStroke', newLargeButton)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Color = Color3.fromRGB(178, 102, 255)
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Thickness = 1


	return newLargeButton
end

function getMacroUnits(macroName, textBlocks)
	local nameMacro = macroName
	local unitsFromMacro = {}

	local macroExist = isfile('Skele Hub\\Anime Adventures\\' .. nameMacro)
	local macroExistjson = isfile('Skele Hub\\Anime Adventures\\' .. nameMacro .. '.json')
	if macroExistjson then nameMacro = nameMacro .. '.json' end


	if macroExist or macroExistjson then

		local sucess, response = pcall(function()
			local MacroAbout = HttpService:JSONDecode( readfile( 'Skele Hub\\Anime Adventures\\' .. nameMacro) )

			for _, macroTabl in pairs(MacroAbout) do
				if not macroTabl['type'] or macroTabl['type'] ~= 'spawn_unit' then continue end
				if table.find(unitsFromMacro, macroTabl.unit) then continue end

				table.insert(unitsFromMacro, macroTabl.unit)
			end
		end)

		if not sucess then
			for i=1,6 do
				unitsFromMacro[i] = "error"
			end
		end

	end

	for textBlockNumb, TextBlock in ipairs(textBlocks) do
		local unitName = unitsFromMacro[textBlockNumb] if oldItemsData[unitsFromMacro[textBlockNumb]] then unitName = oldItemsData[unitsFromMacro[textBlockNumb]].Name end

		TextBlock.Text = string.format('Unit %s: %s', textBlockNumb, unitName or "")
	end

end 

local function MakeDDL (subPage, DDLTXT, scaleY)

	local newDDLFrame = Instance.new('Frame', subPage)
	newDDLFrame.BackgroundTransparency = 1
	newDDLFrame.Size = UDim2.new(1, 0, scaleY, 0)
	newDDLFrame.LayoutOrder = Orders[subPage]
	Orders[subPage] += 1

	local newDDLLabel = Instance.new('TextLabel', newDDLFrame)
	newDDLLabel.BackgroundTransparency = 1
	newDDLLabel.Size = UDim2.new(1, 0, 0.3, 0)
	newDDLLabel.Position = UDim2.new(0, 0, 0.05, 0)
	newDDLLabel.Font = Enum.Font.GothamBlack
	newDDLLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	newDDLLabel.TextScaled = true
	newDDLLabel.TextXAlignment = Enum.TextXAlignment.Left
	newDDLLabel.Text = DDLTXT

	local newDDLButton = Instance.new('TextButton', newDDLFrame)
	newDDLButton.BackgroundColor3 = Color3.fromRGB(102, 0, 255)
	newDDLButton.BorderSizePixel = 0
	newDDLButton.Size = UDim2.new(1, 0, 0.408, 0)
	newDDLButton.Position = UDim2.new(0, 0, 0.45, 0)
	newDDLButton.Text = ''
	MakeUICorner(0.15, newDDLButton)

	local UIStroke = Instance.new('UIStroke', newDDLButton)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Color = Color3.fromRGB(178, 102, 255)
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Thickness = 1

	local newDDLList = Instance.new('TextLabel', newDDLButton)
	newDDLList.BackgroundTransparency = 1
	newDDLList.AnchorPoint = Vector2.new(0.5, 0.5)
	newDDLList.Size = UDim2.new(0.95, 0, 0.8, 0)
	newDDLList.Position = UDim2.new(0.5, 0, 0.5, 0)
	newDDLList.Font = Enum.Font.GothamBlack
	newDDLList.TextScaled = true
	newDDLList.TextXAlignment = Enum.TextXAlignment.Left
	newDDLList.TextColor3 = Color3.fromRGB(255, 255, 255)
	newDDLList.RichText = true
	newDDLList.Text = 'None'


	return newDDLButton
end

local function DDLlabel (ddlButton, newValue)

	if type(newValue) == 'table' then
		local newTXT = "None"

		if #newValue >=1 then 
			newTXT = ""

			for _, addItem in ipairs(newValue) do
				newTXT = string.format(newTXT .. "%s, ", addItem)
			end

		end

		ddlButton.TextLabel.Text = newTXT

	else
		local newTXT = "None" if newValue ~= "" and newValue ~= nil then newTXT = newValue end
		ddlButton.TextLabel.Text = newTXT
	end
end

local DDLColors = {
	[true] = Color3.fromRGB(0, 176, 109);
	[false] = Color3.fromRGB(178, 102, 255)
}

local function GetDDL (ddlButton, items, multiple, keyName, secondKeyName, tabName)

	local DDL = ddlButton.Parent:FindFirstChild('List')

	if not DDL then
		DDL = Instance.new('Frame', MainContent) DDL.Name = 'List' DDL.Visible = false
		DDL.BackgroundColor3 = Color3.fromRGB(102, 0, 255)
		DDL.BorderSizePixel = 0
		DDL.ZIndex = 555
		--DDL.Size = UDim2.new(0.448, 0, 0.388, 0)
		MakeUICorner(0.02, DDL)
		MakeUIPadding(0, 0.02, 0.02, 0, DDL)

		local UIStroke = Instance.new('UIStroke', DDL)
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
		UIStroke.Color = Color3.fromRGB(178, 102, 255)
		UIStroke.LineJoinMode = Enum.LineJoinMode.Round
		UIStroke.Thickness = 1

		local ScrollingItems = Instance.new('ScrollingFrame', DDL) ScrollingItems.Name = 'ScrollingItems'
		ScrollingItems.BackgroundTransparency = 1
		ScrollingItems.Size = UDim2.new(1, 0, 0.97, 0)
		ScrollingItems.Position = UDim2.new(0, 0, 0.03, 0)
		ScrollingItems.ZIndex = 556
		ScrollingItems.AutomaticCanvasSize = 'Y'
		ScrollingItems.CanvasSize = UDim2.new(0,0,0,0)
		ScrollingItems.ScrollBarImageColor3 = Color3.fromRGB(102,0,255)
		ScrollingItems.ScrollBarThickness = 3
		ScrollingItems.BorderSizePixel = 0
		ScrollingItems.ScrollingDirection = Enum.ScrollingDirection.Y
		makeUIList(0.03, ScrollingItems)

		local TemplateButton = Instance.new('TextButton', ScrollingItems) TemplateButton.Name = 'Template' TemplateButton.Visible = false
		TemplateButton.BackgroundColor3 = Color3.fromRGB(178, 102, 255)
		TemplateButton.BorderSizePixel = 0
		TemplateButton.Size = UDim2.new(1, 0, 0.08, 0)
		TemplateButton.ZIndex = 556
		TemplateButton.RichText = true
		TemplateButton.Font = Enum.Font.GothamBlack
		TemplateButton.TextScaled = true
		TemplateButton.TextStrokeTransparency = 0.65
		TemplateButton.TextColor3 = Color3.fromRGB(255,255,255)

		--DDL.Size = UDim2.new(1, 0, 0, DDL.AbsoluteSize.Y)
		DDL.Position = UDim2.new(0, 0, 1, 0)
		DDL.Parent = ddlButton.Parent
	end

	DDL.Size = UDim2.new(1, 0, 0, MainContent.AbsoluteSize.Y * 0.388)
	DDL.Visible = not DDL.Visible

	for _, button in ipairs(DDL.ScrollingItems:GetChildren()) do
		if button.Name == 'item' then button:Destroy() end
	end

	if not DDL.Visible then return end

	for _, item in ipairs(items) do
		local newItem = DDL.ScrollingItems.Template:Clone() newItem.Name = 'item'
		newItem.Parent = DDL.ScrollingItems
		newItem.Text = item
		newItem.Visible = true

		local itemSelected = false

		if type(GetSave(keyName)) == 'table' then

			if secondKeyName then
				itemSelected = GetSave(keyName)[tabName][secondKeyName] == item
			else
				itemSelected = table.find(GetSave(keyName), item)
			end

		else itemSelected = GetSave(keyName) == item
		end

		if itemSelected then newItem.BackgroundColor3 = DDLColors[true] end

		newItem.MouseButton1Click:Connect(function()
			local isSelected = false

			if multiple then
				local itemInTable = table.find(GetSave(keyName), item)
				local newSave = table.clone(Settings[keyName])

				if itemInTable then 
					table.remove(newSave, itemInTable)
				else
					table.insert(newSave, item)
					isSelected = true
				end

				Save(keyName, newSave)

			else

				local oldKey = GetSave(keyName)

				for _, button in ipairs(DDL.ScrollingItems:GetChildren()) do
					if button.Name ~= 'item' then continue end
					if (not secondKeyName and button.Text == oldKey) or (secondKeyName and button.Text == oldKey[tabName][secondKeyName])  then button.BackgroundColor3 = DDLColors[false] break end
				end

				local toSave = "" if secondKeyName then toSave = deepcopy(oldKey) toSave[tabName][secondKeyName] = "" end

				if not secondKeyName and oldKey ~= item then toSave = item
				elseif secondKeyName and oldKey[tabName][secondKeyName] ~= item then toSave[tabName][secondKeyName] = item
				end



				Save(keyName, toSave)
				if keyName == "Selected Macro" then getMacroUnits(toSave, MacroUnitsTextBlocks) end

				local oldKey = GetSave(keyName)


				isSelected = (secondKeyName and toSave[tabName][secondKeyName] ~= "") or ( not secondKeyName and toSave ~= "")

			end

			local fillDDL = GetSave(keyName) if secondKeyName then fillDDL = fillDDL[tabName][secondKeyName] end



			DDLlabel(ddlButton, fillDDL)

			newItem.BackgroundColor3 = DDLColors[isSelected]

		end)
	end	

end

local function MakeTextBox (subPage, PlacehodlerTXT, TitleTXT, scaleY)

	local TextBoxFrame = Instance.new('Frame', subPage)
	TextBoxFrame.BackgroundTransparency = 1
	TextBoxFrame.Size = UDim2.new(1, 0, scaleY, 0)
	TextBoxFrame.LayoutOrder = Orders[subPage]
	Orders[subPage] += 1

	local TextBoxTitle = Instance.new('TextLabel', TextBoxFrame)
	TextBoxTitle.BackgroundTransparency = 1
	TextBoxTitle.Size = UDim2.new(1, 0, 0.3, 0)
	TextBoxTitle.Position = UDim2.new(0, 0, 0.05, 0)
	TextBoxTitle.Font = Enum.Font.GothamBlack
	TextBoxTitle.TextScaled = true
	TextBoxTitle.TextColor3 = Color3.fromRGB(255,255,255)
	TextBoxTitle.TextXAlignment = Enum.TextXAlignment.Left
	TextBoxTitle.Text = TitleTXT

	local TextBoxShadow = Instance.new('Frame', TextBoxFrame)
	TextBoxShadow.BackgroundColor3 = Color3.fromRGB(102, 0, 255)
	TextBoxShadow.BorderSizePixel = 0
	TextBoxShadow.Size = UDim2.new(1, 0, 0.408, 0)
	TextBoxShadow.Position = UDim2.new(0, 0, 0.45, 0)
	MakeUICorner(0.15, TextBoxShadow)

	local TextBox = Instance.new('TextBox', TextBoxFrame)
	TextBox.BackgroundTransparency = 1
	TextBox.TextXAlignment = Enum.TextXAlignment.Left
	TextBox.Size = UDim2.new(0.985, 0, 0.408, 0)
	TextBox.Position = UDim2.new(0.015, 0, 0.45, 0)
	TextBox.Font = Enum.Font.GothamBold
	TextBox.PlaceholderColor3 = Color3.fromRGB(102, 0, 255)
	TextBox.PlaceholderText = PlacehodlerTXT
	TextBox.TextScaled = true
	TextBox.TextColor3 = Color3.fromRGB(255,255,255)
	TextBox.Text = ""

	local UIStroke = Instance.new('UIStroke', TextBoxShadow)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Color = Color3.fromRGB(178, 102, 255)
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Thickness = 1

	return TextBox
end

local function MakeSlider (subPage, TitleTXT, scaleY)

	local slideFrame = Instance.new('Frame', subPage)
	slideFrame.BackgroundTransparency = 1
	slideFrame.Size = UDim2.new(1, 0, scaleY, 0)
	slideFrame.LayoutOrder = Orders[subPage]
	Orders[subPage] += 1

	local slideTitle = Instance.new('TextLabel', slideFrame)
	slideTitle.BackgroundTransparency = 1
	slideTitle.Size = UDim2.new(0.532, 0, 0.3, 0)
	slideTitle.Position = UDim2.new(0, 0, 0.05, 0)
	slideTitle.Font = Enum.Font.GothamBlack
	slideTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	slideTitle.TextScaled = true
	slideTitle.TextXAlignment = Enum.TextXAlignment.Left
	slideTitle.Text = TitleTXT

	local slideBox = Instance.new('TextBox', slideFrame)
	slideBox.BackgroundColor3 = Color3.fromRGB(102, 0, 255)
	slideBox.BorderSizePixel = 0
	slideBox.Size = UDim2.new(0.468, 0, 0.312, 0)
	slideBox.Position = UDim2.new(0.532, 0, 0.038, 0)
	slideBox.Font = Enum.Font.GothamBold
	slideBox.TextScaled = true
	slideBox.PlaceholderText = ""
	slideBox.Text = ""
	slideBox.TextColor3 = Color3.fromRGB(255,255,255)
	MakeUICorner(0.15, slideBox)

	local UIStroke = Instance.new('UIStroke', slideBox)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Color = Color3.fromRGB(178, 102, 255)
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Thickness = 1

	local slider = Instance.new('Frame', slideFrame) slider.Name = "slider"
	slider.BackgroundColor3 = Color3.fromRGB(25, 0, 51)
	slider.BorderSizePixel = 0
	slider.Size = UDim2.new(1, 0, 0.35, 0)
	slider.Position = UDim2.new(0, 0, 0.508, 0)
	MakeUICorner(0.2, slider)

	local UIStroke = Instance.new('UIStroke', slider)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Color = Color3.fromRGB(50, 9, 77)
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Thickness = 1

	local sliderBar = Instance.new('Frame', slider)
	sliderBar.BackgroundColor3 = Color3.fromRGB(102,0,255)
	sliderBar.BorderSizePixel = 0
	sliderBar.Size = UDim2.new(1,0,1,0)
	MakeUICorner(0.2, sliderBar)

	local UIGradient = Instance.new('UIGradient', sliderBar)

	UIGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(51, 0, 102) ),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(102, 0, 255) ),
	}

	local sliderButton = Instance.new('TextButton', slider) sliderButton.Name = "SliderButton"
	sliderButton.BackgroundTransparency = 1
	sliderButton.ZIndex = 10
	sliderButton.Size = UDim2.new(1,0,1,0)
	sliderButton.Text = ""

	return slideFrame
end

local function MakeSliderV2 (subPage, TitleTXT, scaleY)
	local slideFrame = Instance.new('Frame', subPage)
	slideFrame.BackgroundTransparency = 1
	slideFrame.Size = UDim2.new(1, 0, scaleY, 0)
	slideFrame.LayoutOrder = Orders[subPage]
	Orders[subPage] += 1

	local slideTitle = Instance.new('TextLabel', slideFrame)
	slideTitle.BackgroundTransparency = 1
	slideTitle.AnchorPoint = Vector2.new(0, 0.5)
	slideTitle.Size = UDim2.new(0.49, 0, 0.9, 0)
	slideTitle.Position = UDim2.new(0.02, 0, 0.5, 0)
	slideTitle.Font = Enum.Font.GothamBlack
	slideTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	slideTitle.TextScaled = true
	slideTitle.TextXAlignment = Enum.TextXAlignment.Left
	slideTitle.Text = TitleTXT
	slideTitle.TextStrokeTransparency = 0
	slideTitle.TextStrokeColor3 = Color3.fromRGB(102, 0, 204)
	slideTitle.ZIndex = 3

	local slideAmount = Instance.new('TextLabel', slideFrame)
	slideAmount.BackgroundTransparency = 1
	slideAmount.AnchorPoint = Vector2.new(1, 0.5)
	slideAmount.Size = UDim2.new(0.49, 0, 0.9, 0)
	slideAmount.Position = UDim2.new(0.98, 0, 0.5, 0)
	slideAmount.Font = Enum.Font.GothamBlack
	slideAmount.TextColor3 = Color3.fromRGB(255, 255, 255)
	slideAmount.TextScaled = true
	slideAmount.TextXAlignment = Enum.TextXAlignment.Right
	slideAmount.Text = "[0/0]"
	slideAmount.Name = "AmountLabel"
	slideAmount.TextStrokeTransparency = 0
	slideAmount.TextStrokeColor3 = Color3.fromRGB(102, 0, 204)
	slideAmount.ZIndex = 3

	local slider = Instance.new('Frame', slideFrame) slider.Name = "slider"
	slider.BackgroundColor3 = Color3.fromRGB(50, 9, 77)
	slider.BorderSizePixel = 0
	slider.Size = UDim2.new(1, 0, 1, 0)
	MakeUICorner(0.2, slider)

	local UIStroke = Instance.new('UIStroke', slider)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Color = Color3.fromRGB(178, 102, 255)
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Thickness = 1

	local sliderBar = Instance.new('Frame', slider)
	sliderBar.BackgroundColor3 = Color3.fromRGB(102,0,255)
	sliderBar.BorderSizePixel = 0
	sliderBar.Size = UDim2.new(1,0,1,0)
	MakeUICorner(0.2, sliderBar)

	local UIGradient = Instance.new('UIGradient', sliderBar)

	UIGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(178, 102, 255) ),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255) ),
	}

	local sliderButton = Instance.new('TextButton', slider) sliderButton.Name = "SliderButton"
	sliderButton.BackgroundTransparency = 1
	sliderButton.ZIndex = 10
	sliderButton.Size = UDim2.new(1,0,1,0)
	sliderButton.Text = ""

	return slideFrame
end

local function MakeTextBlock (subPage, DefaultTXT, ScaleY)

	local TxtBlockFrame = Instance.new('Frame', subPage)
	TxtBlockFrame.BackgroundColor3 = Color3.fromRGB(51)
	TxtBlockFrame.BorderSizePixel = 0
	TxtBlockFrame.Size = UDim2.new(1, 0, ScaleY, 0)
	TxtBlockFrame.LayoutOrder = Orders[subPage]
	Orders[subPage] += 1
	MakeUICorner(0.2, TxtBlockFrame)

	local TxtLabel = Instance.new('TextLabel', TxtBlockFrame)
	TxtLabel.BackgroundTransparency = 1
	TxtLabel.AnchorPoint = Vector2.new(0, 0.5)
	TxtLabel.Size = UDim2.new(0.98, 0, 0.9, 0)
	TxtLabel.Position = UDim2.new(0.02, 0, 0.5, 0)
	TxtLabel.Font = Enum.Font.GothamBold
	TxtLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TxtLabel.TextScaled = true
	TxtLabel.TextXAlignment = Enum.TextXAlignment.Left
	TxtLabel.Text = DefaultTXT

	return TxtLabel
end

local function MakeDoubleButton (subPage, ButtonTXT, ScaleY)

	local DoubleButtonFrame = Instance.new('Frame', subPage)
	DoubleButtonFrame.BackgroundTransparency = 1
	DoubleButtonFrame.BorderSizePixel = 0
	DoubleButtonFrame.Size = UDim2.new(1, 0, ScaleY, 0)
	DoubleButtonFrame.LayoutOrder = Orders[subPage] Orders[subPage] +=1

	local BiggerButton = Instance.new('TextButton', DoubleButtonFrame) BiggerButton.Name = "_bigbutton"
	BiggerButton.BackgroundColor3 = Color3.fromRGB(76,0, 153)
	BiggerButton.Size = UDim2.new(0.69, 0, 1, 0)
	BiggerButton.Text = ""
	MakeUICorner(0.15, BiggerButton)

	local UIStroke = Instance.new('UIStroke', BiggerButton)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Color = Color3.fromRGB(153,51,255)
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Thickness = 1

	local BiggetButtonTXT = Instance.new('TextLabel', BiggerButton)
	BiggetButtonTXT.BackgroundTransparency = 1
	BiggetButtonTXT.AnchorPoint = Vector2.new(0, 0.5)
	BiggetButtonTXT.Position = UDim2.new(0,0,0.5,0)
	BiggetButtonTXT.Size = UDim2.new(1,0, 0.8, 0)
	BiggetButtonTXT.Font = Enum.Font.GothamBlack
	BiggetButtonTXT.TextColor3 = Color3.fromRGB(255,255,255)
	BiggetButtonTXT.TextScaled = true
	BiggetButtonTXT.Text = ButtonTXT

	local ResetButton = Instance.new('TextButton', DoubleButtonFrame) ResetButton.Name = '_resetbutton'
	ResetButton.AnchorPoint = Vector2.new(1, 0)
	ResetButton.BackgroundColor3 = Color3.fromRGB(153,51,255)
	ResetButton.Size = UDim2.new(0.279, 0, 1, 0)
	ResetButton.Position = UDim2.new(1,0,0,0)

	local UIStroke = Instance.new('UIStroke', ResetButton)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Color = Color3.fromRGB(153, 51, 255)
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Thickness = 1

	local ResetButtonTXT = Instance.new('TextLabel', ResetButton)
	ResetButtonTXT.BackgroundTransparency = 1
	ResetButtonTXT.AnchorPoint = Vector2.new(0, 0.5)
	ResetButtonTXT.Position = UDim2.new(0,0,0.5,0)
	ResetButtonTXT.Size = UDim2.new(1,0, 0.8, 0)
	ResetButtonTXT.Font = Enum.Font.GothamBlack
	ResetButtonTXT.TextColor3 = Color3.fromRGB(255,255,255)
	ResetButtonTXT.TextScaled = true
	ResetButtonTXT.Text = "RESET"


	return DoubleButtonFrame
end

MakeNewPage('Main', 0.117)

-------------------------------

pageShown = ScrollingContent['Main']
pageShown.Visible = true
Pages['Main'].BottomLine.Visible = true

-------------------------------------------

local Main_MainSubPage = MakeNewSubPage('Main', 'Right', 0.603, 0.03, 0.01, 0.02)
MakeTitle(Main_MainSubPage, 'Main', 0.07)
local AutoLeave = MakeCheckbox(Main_MainSubPage, 'Auto Race Ability', 0.056)
local AutoRetry = MakeCheckbox(Main_MainSubPage, 'Auto V4 (ability)', 0.056)

----------------------------------------------FUNCTIONS-------------------------------------

local funtion AutoRaceAWKFunc()
    while GetSave(AutoAWK.Name) do
		wait(0.5)
        local args = {
            [1] = true
        }
        
        game:GetService("Players").LocalPlayer.Character.Awakening.RemoteFunction:InvokeServer(unpack(args))
    end
end

local function AutoRaceABLFunc()
    while GetSave(AutoRaceAB.Name) do
        wait(0.5)
        local args = {
            [1] = "ActivateAbility"
        }
        
        game:GetService("ReplicatedStorage").Remotes.CommE:FireServer(unpack(args))
    end
end

local function TPLobby ()
	game:GetService('TeleportService'):Teleport(8304191830, player)
end

checkBoxFunc(AutoRaceAWK, AutoAWK)
checkBoxFunc(AutoRaceABL, AutoRaceAB)

TPToLobby.MouseButton1Click:Connect(function()
	TPLobby()
end)
