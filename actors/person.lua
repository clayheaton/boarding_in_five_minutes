--! file: head.lua
require "actors.head"
require "actors.legs"
require "actors.torso"
require "actors.arms"
require "colors"

Person = Object:extend()

function Person:new()
    self.x = 400
    self.y = 400

    self.speed_variation = math.random(40,130)/100

    self.right_handed   = true

    local handedCheck   = math.random(1,100)
    if handedCheck > 70 then
        self.right_handed = false
    end

    self.head           = Head()
    self.torso_width    = math.random(self.head.width*0.6,self.head.width*1.5)
    self.legs           = Legs(self.torso_width, self.speed_variation)
    self.torso_length   = self.legs.length * 1.2

    self.color_torso    = random_reasonable_color()
    self.torso          = Torso(self.torso_width,self.torso_length,self.color_torso)

    self.animationState = "standing"
    self.direction      = "left"

    self.holding_ticket   = true
    self.holding_suitcase = false
    self.arms             = Arms(self.color_torso,self.head.color,self.right_handed,self.torso_width,self.torso_length)

end

function Person:setAnimationState(animationState)
    self.animationState = animationState
end

function Person:setDirection(dir)
    self.direction = dir
end

function Person:draw()
    -- Position is middle of feet

    -- Need to draw one arm before anything else and one arm after everything else
    -- push the matrix to the center point of the top of the torso.
    love.graphics.push()
    love.graphics.translate(self.x,self.y-self.legs.length-self.torso_length)
    self.arms:drawFirst(self.direction,self.animationState,self.holding_ticket,self.holding_suitcase)
    love.graphics.pop()

    -- legs
    love.graphics.push()
    love.graphics.translate(self.x,self.y-self.legs.length)
    self.legs:draw(self.direction,self.animationState)
    love.graphics.pop()

    -- torso
    love.graphics.push()
    love.graphics.translate(self.x-self.torso_width/2,self.y-self.legs.length-self.torso_length) --,self.torso_width,self.torso_length)
    self.torso:draw()
    love.graphics.pop()

    -- Draw the head
    love.graphics.push()
    love.graphics.translate(self.x-self.head.width/2,self.y-self.legs.length-self.torso_length-self.head.height)
    self.head:draw(self.direction)
    love.graphics.pop()

    -- Need to draw one arm before anything else and one arm after everything else
    -- push the matrix to the center point of the top of the torso.
    love.graphics.push()
    love.graphics.translate(self.x,self.y-self.legs.length-self.torso_length)
    self.arms:drawLast(self.direction,self.animationState,self.holding_ticket,self.holding_suitcase)
    love.graphics.pop()

end

function Person:update(dt)
    self.legs:update(dt)
end