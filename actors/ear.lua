--! file: ear.lua
Ear = Object:extend()

function Ear:new()
    self.height = math.random(10,15)
    self.width  = math.random(6,10)
end

function Ear:draw(direction)
    if direction == "left" then
        love.graphics.setColor(0,0,0)
        love.graphics.setLineWidth(1)
        love.graphics.line(0,0,self.width,0,self.width,self.height,0,self.height)
        love.graphics.setLineWidth(1)
        love.graphics.line(3,self.height/2 - 2,3,self.height/2 + 2)
    else
        love.graphics.setColor(0,0,0)
        love.graphics.setLineWidth(1)
        love.graphics.line(self.width,0,0,0,0,self.height,self.width,self.height)
        love.graphics.setLineWidth(1)
        love.graphics.line(self.width-3,self.height/2 - 2,self.width-3,self.height/2 + 2)
    end
end