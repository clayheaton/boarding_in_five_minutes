-- file: torso.lua
require "colors"

Torso = Object:extend()

function Torso:new(torso_width,torso_length,color_torso)
    self.torso_width  = torso_width
    self.torso_length = torso_length
    self.torso_color  = color_torso
end

function Torso:draw()
    setColor(self.torso_color)
    love.graphics.rectangle("fill",0,0,self.torso_width,self.torso_length+5)
end