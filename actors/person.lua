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

    -- For movement
    self.targetX           = 400
    self.targetY           = 400
    self.has_target        = false

    self.movement_rate     = 150
    self.speed_variation   = math.random(40,130)/100
    self.right_handed      = true

    local handedCheck = math.random(1,100)
    if handedCheck > 80 then
        self.right_handed = false
    end

    self.suitcase_type  = "backpack"
    local suitcase_type_check = math.random(1,100)
    if suitcase_type_check > 66 then
        self.suitcase_type = "rollerboard"
    elseif suitcase_type_check > 33 then
        self.suitcase_type = "duffelbag"
    end

    --self.suitcase_type = "backpack"

    -- TODO: Abstract suitcase out from Arms so that the Person can walk away from their suitcase?

    self.head             = Head()
    self.torso_width      = math.random(self.head.width*0.6,self.head.width*1.5)
    self.legs             = Legs(self.torso_width, self.speed_variation)
    self.torso_length     = self.legs.length * 1.2
    self.color_torso      = random_reasonable_color()
    self.torso            = Torso(self.torso_width,self.torso_length,self.color_torso)
    self.color_skin       = self.head.color
    self.animationState   = "standing" -- standing, sitting, walking
    self.direction        = "left"
    self.holding_ticket   = true
    self.holding_suitcase = true
    self.suitcase_color   = random_reasonable_color()
    self.ticket_color     = ticket_color

    -- A little dangerous to do this too much unless everything else is initialized first
    self.arms             = Arms(self)

end

function Person:setAnimationState(animationState)
    self.animationState = animationState
end

function Person:normalizeSpeedVariation()
    self.speed_variation = 0.5
    self.legs:normalizeSpeedVariation(self.speed_variation)
end

function Person:setDirection(dir)
    self.direction = dir
end

function Person:draw()
    -- Position is middle of feet
    -- If the person is "sitting" then we draw both arms first

    -- Need to draw one arm before anything else and one arm after everything else
    -- push the matrix to the center point of the top of the torso.
    if self.animationState ~= "sitting" then
        love.graphics.push()
        love.graphics.translate(self.x,self.y-self.legs.length-self.torso_length)
        self.arms:drawFirst(self.direction,self.animationState,self.holding_ticket,self.holding_suitcase)
        love.graphics.pop()
    end

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

    -- Need to draw one arm before anything else and one arm after everything else
    -- push the matrix to the center point of the top of the torso.
    if self.animationState ~= "sitting" then
        love.graphics.push()
        love.graphics.translate(self.x,self.y-self.legs.length-self.torso_length)
        self.arms:drawLast(self.direction,self.animationState,self.holding_ticket,self.holding_suitcase)
        love.graphics.pop()
    end

    -- Draw the arms on top of the torso if sitting
    if self.animationState == "sitting" then
        love.graphics.push()
        love.graphics.translate(self.x,self.y-self.legs.length-self.torso_length)
        self.arms:drawFirst(self.direction,self.animationState,self.holding_ticket,self.holding_suitcase)
        love.graphics.pop()

        love.graphics.push()
        love.graphics.translate(self.x,self.y-self.legs.length-self.torso_length)
        self.arms:drawLast(self.direction,self.animationState,self.holding_ticket,self.holding_suitcase)
        love.graphics.pop()
    end

    -- Draw the head
    love.graphics.push()
    love.graphics.translate(self.x-self.head.width/2,self.y-self.legs.length-self.torso_length-self.head.height)
    self.head:draw(self.direction)
    love.graphics.pop()

end


function Person:move(dt)
    if self.has_target then
        if self.x < self.targetX - 5 then
            self.x = self.x + (dt * self.movement_rate * self.speed_variation)
        end
    end
end

function Person:update(dt)
    self.legs:update(dt)
    self:move(dt)
end