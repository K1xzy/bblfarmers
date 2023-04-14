local drawing = Drawing.new('Text')
drawing.Size = 28
drawing.Center = true
drawing.Color = Color3.new(1, 1, 1)

local lines = {}
local maxLines = 3
local m = game:GetService('Players').LocalPlayer:GetMouse()

local update = function()
drawing.Text = table.concat(lines, '\n')
drawing.Position = Vector2.new(m.ViewSizeX / 2, m.ViewSizeY - (drawing.Size * #lines))
end

local printFunction = function(...)
local str = ''
for idx, o in pairs { ... } do
if idx > 1 then
str = str .. ' '
end
str = str .. tostring(o)
end

if #lines >= maxLines then
table.remove(lines, 1)
end

table.insert(lines, str)
update()

task.spawn(function()
task.wait(8)
for idx, line in pairs(lines) do
if line == str then
table.remove(lines, idx)
update()
break
end
end
end)
end

-- prevent gc + whatnot
task.spawn(function()
while task.wait() do
drawing.Visible = true
end
end)

return printFunction
