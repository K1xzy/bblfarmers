local function getsynassetfromurl(url)
  if not url or type(url) ~= "string" or not tostring(game:HttpGet(url)):find("JFIF") then
    return nil
  end

  local File = "SynAsset ["
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

local function updateImage(ImageLabel)
  local t = os.time()
  local formattedTime = os.date("%H:%M:%S", t)
  printconsole("called cataas.com API at " .. formattedTime, 255, 255, 255)
  local image = getsynassetfromurl("https://cataas.com/cat/says/bbchack")
  if image then
    ImageLabel.Image = image
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

    spawn(function()
      while true do
        updateImage(ImageLabel)
        wait(3)
      end
    end)
  end,

  remove = function()
    local gui = game:GetService("CoreGui"):FindFirstChild("MonarchNoRender")
    if gui then
      gui:Destroy()
    end
  end,
}
