--! file:eyebrow.lua
Eyebrow = Object:extend()

function Eyebrow:new()
    self.width  = 10
    self.height = math.random(2,4)
end

function Eyebrow:draw(direction)
    love.graphics.setColor(0,0,0)
    love.graphics.setLineWidth(self.height)
    love.graphics.line(0,0,self.width,0)
    love.graphics.setLineWidth(1)
end