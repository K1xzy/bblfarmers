local function createGui()
	local gui = Instance.new("ScreenGui")
	gui.Name = "MonarchNoRender"
	gui.DisplayOrder = 5
	gui.IgnoreGuiInset = true
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	pcall(syn.protect_gui, gui)
	return gui
end

local function createBackground(gui)
	local background = Instance.new("Frame")
	background.Name = "BackGround"
	background.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	background.BorderSizePixel = 0
	background.Size = UDim2.new(1, 0, 1, 0)
	background.Parent = gui
	return background
end

local function createImageLabel(background)
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "ImageLabel"
	imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	imageLabel.BackgroundTransparency = 1
	imageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	imageLabel.Size = UDim2.new(0, Workspace.CurrentCamera.ViewportSize.X, 0, Workspace.CurrentCamera.ViewportSize.Y)
	imageLabel.Parent = background
	return imageLabel
end

local function getImageAssetFromUrl(url)
	if url and type(url) == "string" and tostring(game:HttpGet(url)):find("JFIF") then
		local fileName = "SynAsset [" .. string.format("%05d", math.random(1, 99999)) .. "].jpg"
		writefile(fileName, game:HttpGet(url))
		delay(5, function()
			pcall(delfile, fileName)
		end)
		return getsynasset(fileName)
	end
end

local function updateImage(imageLabel)
	printconsole("called cataas.com API at " .. os.time(), 255, 255, 255)
	imageLabel.Image = getImageAssetFromUrl("https://cataas.com/cat?" .. tick())
end

return {
	add = function()
		local gui = createGui()
		local background = createBackground(gui)
		local imageLabel = createImageLabel(background)
		imageLabel.Image = getImageAssetFromUrl("https://cataas.com/cat")
		while true do
			task.wait(10)
			updateImage(imageLabel)
		end
	end,
	remove = function()
		local gui = game:GetService("CoreGui"):FindFirstChild("MonarchNoRender")
		if gui then
			gui:Destroy()
		end
	end,
}
