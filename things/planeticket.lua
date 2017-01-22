--! file: planeticket.lua
require "colors"

PlaneTicket = Possession:extend()

function PlaneTicket:new(owner)
    PlaneTicket.super.new(self,owner)
    
    self.color  = {255,255,255}
    self.width  = 10
    self.height = 20
end

function PlaneTicket:draw()
    setColor(self.color)
    love.graphics.rectangle("fill", 0, 0, self.width, self.height)

    setColor(darker_shade(self.color,100))
    love.graphics.rectangle("line", 0, 0, self.width, self.height)
end