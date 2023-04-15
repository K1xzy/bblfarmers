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
  
      local getsynasset = getsynassetfromurl
      
      local BackGround = Instance.new("Frame")
      BackGround.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
      BackGround.BorderSizePixel = 0
      BackGround.Name = "BackGround"
      BackGround.Size = UDim2.new(1, 0, 1, 0)
      BackGround.Parent = MonarchNoRender
      
      local ImageLabel = Instance.new("ImageLabel")
      ImageLabel.BackgroundTransparency = 1
      ImageLabel.Name = "ImageLabel"
      ImageLabel.Position = UDim2.new(0, 0, 0, 0)
      ImageLabel.Size = UDim2.new(1, 0, 1, 0)
      ImageLabel.Parent = MonarchNoRender
      
      local function updateImage()
          printconsole("called cataas.com API at " .. os.time(), 255, 255, 255)
          ImageLabel.Image = getsynasset("https://cataas.com/cat?")
      end

      while true do
          task.wait(10)
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
