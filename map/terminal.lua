--! file: plane.lua
require("colors")
require("actors.person")

Terminal = Object:extend()

function Terminal:new()

    self.zoom     = 1.0
    self.offsetX  = 20
    self.offsetY  = 20
    self.person   = Person()
    self.person.x = 200
    self.person.y = 300
end

function Terminal:update(dt)

end

function Terminal:mousepressed(x, y, button, istouch)
    local innerX = math.floor((x - self.offsetX) / self.zoom)
    local innerY = math.floor((y - self.offsetY) / self.zoom)
    print("Terminal mousepressed: " .. tostring(innerX) .. ", " .. tostring(innerY))
    -- The incoming x, y are in the screen space. We need to convert to terminal space
end

function Terminal:draw()
    setColor({255,255,255})
    love.graphics.push()
    love.graphics.translate(self.offsetX,self.offsetY)
    love.graphics.scale(self.zoom,self.zoom)
    love.graphics.rectangle("fill",0,0,600,600)

    -- test of relative coordinate system
    self.person:draw()

    love.graphics.pop()
end