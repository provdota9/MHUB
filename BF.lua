local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("Skele HUB", "BloodTheme")

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
