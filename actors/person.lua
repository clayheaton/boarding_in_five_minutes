--! file: head.lua
require "actors.head"
require "actors.legs"
require "actors.torso"
require "colors"

Person = Object:extend()

function Person:new()
    self.x = 400
    self.y = 400

    self.speed_variation = math.random(40,130)/100

    self.head           = Head()
    self.torso_width    = math.random(self.head.width*0.6,self.head.width*1.5)
    self.legs           = Legs(self.torso_width, self.speed_variation)
    self.torso_length   = self.legs.length * 1.2

    self.color_torso    = random_reasonable_color()
    self.torso          = Torso(self.torso_width,self.torso_length,self.color_torso)

    self.animationState = "sitting"
    self.direction      = "left"

end

function Person:setAnimationState(animationState)
    self.animationState = animationState
end

function Person:setDirection(dir)
    self.direction = dir
end

function Person:draw()
    -- Position is middle of feet

    -- temporary legs
    love.graphics.push()
    love.graphics.translate(self.x,self.y-self.legs.length)
    self.legs:draw(self.direction,self.animationState)
    love.graphics.pop()

    -- temporary torso
    love.graphics.push()
    love.graphics.translate(self.x-self.torso_width/2,self.y-self.legs.length-self.torso_length,self.torso_width,self.torso_length)
    self.torso:draw()
    love.graphics.pop()

    -- Draw the head
    love.graphics.push()
    love.graphics.translate(self.x-self.head.width/2,self.y-self.legs.length-self.torso_length-self.head.height)
    self.head:draw(self.direction)
    love.graphics.pop()

end

function Person:update(dt)
    self.legs:update(dt)
end