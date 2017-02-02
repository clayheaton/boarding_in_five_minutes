--! file: arms.lua
require "colors"

Arm = Object:extend()

function Arm:new(width,length,torso_color,skin_color,arm_side,torso_width)
    self.width      = width
    self.length     = length
    self.color      = torso_color
    self.hand_color = skin_color
    self.arm_side   = arm_side
    self.torso_width = torso_width
end

function Arm:draw(direction,animationState,holding_ticket,holding_suitcase)
    setColor(self.color)

    if animationState == "sitting" then
        -- draw sitting
        if self.arm_side == "RightArm" then
            love.graphics.rectangle("fill",-self.torso_width/2 - self.width - 2,0,self.width,self.length)
            love.graphics.rectangle("fill",-self.torso_width/2 - self.width/2,0,self.width,20)
        else
            love.graphics.rectangle("fill", self.torso_width/2 + 2,0,self.width,self.length)
            love.graphics.rectangle("fill", self.torso_width/2 - self.width/2,0,self.width,20)
        end
        self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
        return
    end
end

function Arm:drawHand(direction,animationState,holding_ticket,holding_suitcase)
    setColor(self.hand_color)
    if animationState == "sitting" then
        -- draw sitting
        if self.arm_side == "RightArm" then
            love.graphics.rectangle("fill",-self.torso_width/2 - self.width,self.length,self.width-4,self.length*0.15)
        else
            love.graphics.rectangle("fill", self.torso_width/2 + 4,self.length,self.width - 4,self.length*0.15)
        end
        return
    end
end


Arms = Object:extend()

function Arms:new(torso_color,skin_color,right_handed,torso_width,torso_length)
    self.length     = torso_length * 0.9
    self.width      = math.random(10,20)

    self.right_handed = right_handed
    self.torso_width  = torso_width
    self.torso_length = torso_length

    self.armL       = Arm(self.width,self.length,torso_color,skin_color, "LeftArm",torso_width)
    self.armR       = Arm(self.width,self.length,torso_color,skin_color, "RightArm",torso_width)

    self.holding_ticket   = false
    self.holding_suitcase = false

end

function Arms:update(dt)
end

function Arms:drawFirst(direction,animationState,holding_ticket,holding_suitcase)
    -- animationState might be 'sitting'
    if animationState == "sitting" then
        -- Draw arms at side
        self:drawRightArm(direction,animationState,holding_ticket,holding_suitcase)
        self:drawLeftArm(direction,animationState,holding_ticket,holding_suitcase)
        return
    end

    if direction == "right" then
        self:drawLeftArm(direction,animationState,holding_ticket,holding_suitcase)
    else
        self:drawRightArm(direction,animationState,holding_ticket,holding_suitcase)
    end
end

function Arms:drawLast(direction,animationState,holding_ticket,holding_suitcase)
    -- animationState might be 'sitting'
    if animationState == "sitting" then
        return
    end

    if direction == "right" then
        self:drawRightArm(direction,animationState,holding_ticket,holding_suitcase)
    else
        self:drawLeftArm(direction,animationState,holding_ticket,holding_suitcase)
    end
end

function Arms:drawRightArm(direction,animationState,holding_ticket,holding_suitcase)

    local draw_ticket   = false
    local draw_suitcase = false

    if self.right_handed == true and holding_suitcase == true then
        draw_suitcase = true
    else
        draw_suitcase = false
    end

    if self.right_handed == false and holding_ticket == true then
        draw_ticket = true
    else
        draw_ticket = false
    end

    self.armR:draw(direction,animationState,draw_ticket,draw_suitcase)
end

function Arms:drawLeftArm(direction,animationState,holding_ticket,holding_suitcase)

    local draw_ticket   = false
    local draw_suitcase = false

    if self.right_handed == true and hoding_ticket == true then
        draw_ticket = true
    else
        draw_ticket = false
    end

    if self.right_handed == false and holding_suitcase == true then
        draw_suitcase = true
    else
        draw_suitcase = false
    end

    self.armL:draw(direction,animationState,draw_ticket,draw_suitcase)
end