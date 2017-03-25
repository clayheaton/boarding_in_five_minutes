--! file: plane.lua
require("colors")

Terminal = Object:extend()

function Terminal:new()
    self.offsetX = 20
    self.offsetY = 20
end

function Terminal:update(dt)

end

function Terminal:draw()
    setColor({255,255,255})
    love.graphics.push()
    love.graphics.translate(self.offsetX,self.offsetY)
    love.graphics.rectangle("fill",0,0,400,200)
    love.graphics.pop()
end