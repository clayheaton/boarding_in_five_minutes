--! file: arms.lua
require "colors"

Arm = Object:extend()

function Arm:new(width,length,color,hand_color,arm_side)
    self.width      = width
    self.length     = length
    self.color      = leg_color
    self.hand_color = hand_color
    self.arm_side   = leg_side
end

function Arm:draw(direction,is_sitting,holding_ticket,holding_suitcase)
    setColor(self.color)
end

function Arm:drawHand(direction,is_sitting,holding_ticket,holding_suitcase)
    setColor(self.hand_color)
end


Arms = Object:extend()

function Arms:new(torso_color,skin_color)
    self.length     = math.random(40,80)
    self.width      = math.random(50,80)/100

    self.armL       = Arm(self.width,self.length,torso_color,skin_color, "LeftArm")
    self.armR       = Arm(self.width,self.length,torso_color,skin_color, "RightArm")
end

function Arms:update(dt)
end

function Arms:draw(direction,is_sitting,holding_ticket,holding_suitcase)

end