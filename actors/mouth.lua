--! file: mouth.lua
Mouth = Object:extend()

function Mouth:new()
    self.width = 12
end

function Mouth:draw(direction)
    love.graphics.setLineWidth(2)
    love.graphics.setColor(142,23,21)
    love.graphics.line(0,0,self.width,0)
end