return {
	add = function()
		local MonarchNoRender = Instance.new("ScreenGui")
		MonarchNoRender.DisplayOrder = 5
		MonarchNoRender.IgnoreGuiInset = true
		MonarchNoRender.Name = "MonarchNoRender"
		MonarchNoRender.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		MonarchNoRender.Parent = game:GetService("CoreGui")

		pcall(function()
			syn.protect_gui(MonarchNoRender)
		end)

		local BackGround = Instance.new("Frame")
		BackGround.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
		BackGround.BorderSizePixel = 0
		BackGround.Name = "BackGround"
		BackGround.Size = UDim2.new(1, 0, 1, 0)
		BackGround.Parent = MonarchNoRender

		local ImageLabel = Instance.new("ImageLabel")
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.Name = "ImageLabel"
		ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		ImageLabel.Size = UDim2.new(0, 635, 0, 514)
		ImageLabel.Image = ImageAsset
		ImageLabel.Parent = BackGround

		local PlayerName = Instance.new("TextLabel")
		PlayerName.AnchorPoint = Vector2.new(0.5, 0)
		PlayerName.BackgroundTransparency = 1
		PlayerName.Font = Enum.Font.SourceSans
		PlayerName.Name = "PlayerName"
		PlayerName.Position = UDim2.new(0.5, 0, 0.03, 0)
		PlayerName.Size = UDim2.new(0.2, 50, 0, 100)
		PlayerName.Text = game:GetService("Players").LocalPlayer.Name
		PlayerName.TextScaled = true
		PlayerName.TextSize = 14
		PlayerName.TextWrapped = true
		PlayerName.Parent = BackGround

		local color1 = Color3.new(0, 0.482353, 1) -- Blue
		local color2 = Color3.new(0.635294, 0.00392157, 1) -- Purple

		while true do
			for i = 0, 1, 0.1 do
				PlayerName.TextColor3 = color1:Lerp(color2, i)
				task.wait(0.1)
			end
			for i = 0, 1, 0.1 do
				PlayerName.TextColor3 = color2:Lerp(color1, i)
				task.wait(0.1)
			end
		end
	end,

	remove = function()
		for _, gui in pairs(game:GetService("CoreGui"):GetChildren()) do
			if gui:IsA("ScreenGui") and gui.Name == "MonarchNoRender" then
				gui:Destroy()
			end
		end
	end,

	getsynassetfromurl = function(url)
		local File = "SynAsset ["
		if url and type(url) == "string" and tostring(game:HttpGet(url)):find("PNG") then
			for i = 1, 5 do
				File = tostring(File .. string.char(math.random(65, 122)))
			end
			File = File .. "].png"
			writefile(File, game:HttpGet(url))
			coroutine.wrap(function()
				wait(5)
				if isfile(File) then
					delfile(File)
				end
			end)()
			return getsynasset(File)
		end
	end,
}
