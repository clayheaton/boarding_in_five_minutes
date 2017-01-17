--! file: nose.lua
Nose = Object:extend()

function Nose:new(color)
    self.width  = math.random(6,12)
    self.height = math.random(6,12)
    self.color  = color
end

function Nose:draw(direction)
    love.graphics.setColor(self.color[1],self.color[2],self.color[3])
    love.graphics.rectangle("fill", 0, 0, self.width, self.height)
end