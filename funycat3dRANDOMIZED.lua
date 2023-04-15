local function createMonarchNoRender()
	local MonarchNoRender = Instance.new("ScreenGui")
	MonarchNoRender.Name = "MonarchNoRender"
	MonarchNoRender.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	MonarchNoRender.Parent = game:GetService("CoreGui")
	syn.protect_gui(MonarchNoRender)

	local function getsynassetfromurl(url)
		if url and type(url) == "string" and tostring(game:HttpGet(url)):find("JFIF") then
			local File = "SynAsset [" .. string.format("%05d", math.random(1, 99999)) .. "].jpg"
			writefile(File, game:HttpGet(url))
			delay(5, function()
				pcall(function()
					delfile(File)
				end)
			end)
			return getsynasset(File)
		end
	end

	local BackGround = Instance.new("Frame")
	BackGround.Name = "BackGround"
	BackGround.BackgroundTransparency = 0
	BackGround.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	BackGround.BorderSizePixel = 0
	BackGround.Size = UDim2.new(1, 0, 1, 0)
	BackGround.Parent = MonarchNoRender

	local ImageAsset = getsynassetfromurl("https://cataas.com/cat")
	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.Name = "ImageLabel"
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.Size = UDim2.new(1, 0, 1, 0)
	ImageLabel.Image = ImageAsset
	ImageLabel.Parent = BackGround
	ImageLabel.IgnoreGuiInset = true

	local function updateImage()
		printconsole("called cataas.com API at " .. os.time(), 255, 255, 255)
		ImageAsset = getsynassetfromurl("https://cataas.com/cat?" .. tick())
		ImageLabel.Image = ImageAsset
	end

	while true do
		task.wait(10)
		updateImage()
	end
end

return {
	add = createMonarchNoRender,
	remove = function()
		local gui = game:GetService("CoreGui"):FindFirstChild("MonarchNoRender")
		if gui then
			gui:Destroy()
		end
	end,
}
