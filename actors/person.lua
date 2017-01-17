--! file: head.lua
require "actors.head"
require "colors"

Person = Object:extend()

function Person:new()
    self.x = 400
    self.y = 400
    self.leg_length   = math.random(40,80)
    self.torso_length = self.leg_length * 1.2
    self.head = Head()
    self.torso_width  = math.random(self.head.width*0.6,self.head.width*1.5)
    self.legs_width   = self.torso_width * 0.8

    self.color_legs  = random_reasonable_color()
    self.color_torso = random_reasonable_color()
end

function Person:draw()
    -- Position is middle of feet

    -- temporary legs
    love.graphics.push()
    love.graphics.setColor(self.color_legs[1],self.color_legs[2],self.color_legs[3])
    love.graphics.translate(self.x-self.legs_width/2,self.y-self.leg_length)
    love.graphics.rectangle("fill",0,0,self.legs_width,self.leg_length)
    love.graphics.pop()

    -- temporary torso
    love.graphics.push()
    love.graphics.setColor(self.color_torso[1],self.color_torso[2],self.color_torso[3])
    love.graphics.translate(self.x-self.torso_width/2,self.y-self.leg_length-self.torso_length,self.torso_width,self.torso_length)
    love.graphics.rectangle("fill",0,0,self.torso_width,self.torso_length)
    love.graphics.pop()

    -- Draw the head
    love.graphics.push()
    love.graphics.translate(self.x-self.head.width/2,self.y-self.leg_length-self.torso_length-self.head.height)
    self.head:draw()
    love.graphics.pop()

end