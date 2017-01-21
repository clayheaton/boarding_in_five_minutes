--! file: head.lua
require "actors.head"
require "actors.legs"
require "colors"

Person = Object:extend()

function Person:new()
    self.x = 400
    self.y = 400


    self.head         = Head()
    self.torso_width  = math.random(self.head.width*0.6,self.head.width*1.5)
    self.legs         = Legs(self.torso_width)
    self.torso_length = self.legs.length * 1.2



    self.color_torso = random_reasonable_color()

end

function Person:draw(direction)
    -- Position is middle of feet

    -- temporary legs
    love.graphics.push()
    love.graphics.translate(self.x-self.legs.width/2,self.y-self.legs.length)
    self.legs:draw(direction,"standing")
    love.graphics.pop()

    -- temporary torso
    love.graphics.push()
    love.graphics.setColor(self.color_torso[1],self.color_torso[2],self.color_torso[3])
    love.graphics.translate(self.x-self.torso_width/2,self.y-self.legs.length-self.torso_length,self.torso_width,self.torso_length)
    love.graphics.rectangle("fill",0,0,self.torso_width,self.torso_length)
    love.graphics.pop()

    -- Draw the head
    love.graphics.push()
    love.graphics.translate(self.x-self.head.width/2,self.y-self.legs.length-self.torso_length-self.head.height)
    self.head:draw(direction)
    love.graphics.pop()

end