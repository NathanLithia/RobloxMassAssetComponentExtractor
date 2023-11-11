local toolbar = plugin:CreateToolbar("ExportAll")
local Selection = game:GetService("Selection")
local newSelection = {}

local pluginButton = toolbar:CreateButton(
	"Export Model",
	"Button to Export Model",
	"rbxassetid://8740888472")

local function EnumerateChildren(Object)
	for i, v in pairs(Object) do
		if v:IsA("MeshPart") or v:IsA("Part") or v:IsA("TrussPart") or v:IsA("WedgePart") or v:IsA("CornerWedgePart") then
			local uniqueid = math.random(1000, 9999)
			print(tostring(typeof(v)) .. " " .. tostring(v:GetFullName()) .. uniqueid)
			table.insert(newSelection, v)
			Selection:Set(newSelection)
			PluginManager():ExportSelection(tostring(v).."-".. uniqueid)
			table.clear(newSelection)
			game:GetService("UserInputService").InputBegan:Wait()
		end
		EnumerateChildren(v:GetChildren())
	end
end

pluginButton.Click:Connect(function()
	print(" ")
	print("If anything fails to extract or is missing, You can extract it manually.")
	print("Please make sure to have the parent object selected in order for the script to be functional.")
	print(" ")
	local selection = game:GetService("Selection"):Get()
	EnumerateChildren(selection)
end)
