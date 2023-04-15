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

		local getsynassetfromurl = function(url)
			local File = "SynAsset ["
			if url and type(url) == "string" and tostring(game:HttpGet(url)):find("JFIF") then
				for i = 1, 5 do
					File = tostring(File .. string.char(math.random(65, 122)))
				end
				File = File .. "].jpg"
				writefile(File, game:HttpGet(url))
				coroutine.wrap(function()
					wait(5)
					if isfile(File) then
						delfile(File)
					end
				end)()
				return getsynasset(File)
			end
		end

		local ImageAsset = getsynassetfromurl("https://cataas.com/cat")

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
		ImageLabel.Size = UDim2.new(0, 635, 0, 514) -- adjust size to match dimensions of image
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
		PlayerName.TextColor3 = Color3.fromRGB(0, 0, 127)
		PlayerName.TextScaled = true
		PlayerName.TextSize = 14
		PlayerName.TextWrapped = true
		PlayerName.Parent = BackGround

		local function updateImage()
			ImageAsset = getsynassetfromurl("https://cataas.com/cat")
			ImageLabel.Image = ImageAsset
		end

		while true do
			wait(10)
			updateImage()
		end
	end,
	remove = function()
		local gui = game:GetService("CoreGui"):FindFirstChild("MonarchNoRender")
		if gui then
			gui:Destroy()
		end
	end,
}
