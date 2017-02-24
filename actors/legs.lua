--! file: legs.lua
require "colors"
require "oscillator"

Legs = Object:extend()

function Legs:new(torso_width, speed_variation)
    self.length     = math.random(40,80)
    self.width      = torso_width * (math.random(50,80)/100)
    self.color      = random_reasonable_color()

    self.shoe_color = {math.random(0,50),math.random(0,50),math.random(0,50)}

    self.leg1       = Leg(self.width,self.length,self.color,self.shoe_color, "LeftLeg")
    self.leg2       = Leg(self.width,self.length,self.color,self.shoe_color, "RightLeg")

    self.speed_variation = speed_variation
    self.oscillator      = Oscillator(math.random(0,628)/100,10*self.speed_variation)
end

function Legs:update(dt)
    self.oscillator:update(dt)
end

function Legs:draw(direction,animation_status)
    -- animation_status: walking, standing, seated

    if animation_status == "walking" then
        local oscValue = math.pi/16 * self.oscillator.value
        if direction == "left" then
            self.leg1:draw(direction,oscValue,false)
            self.leg2:draw(direction,-oscValue,false)
        elseif direction == "right" then
            self.leg1:draw(direction,oscValue,false)
            self.leg2:draw(direction,-oscValue,false)
        end
    elseif animation_status == "standing" then
        -- If standing, we only need to draw one leg
        if direction == "left" then
            self.leg1:draw(direction,0,false)
        elseif direction == "right" then
            self.leg1:draw(direction,0,false)
        end
    elseif animation_status == "sitting" then
        -- Use a single leg to draw sitting
        self.leg1:draw(direction,0,true)
        self.leg2:draw(direction,0,true)
    end
end



Leg = Object:extend()

function Leg:new(width,length,leg_color,shoe_color,leg_side)
    self.width      = width
    self.length     = length
    self.color      = leg_color
    self.shoe_color = shoe_color
    self.leg_side   = leg_side
end

function Leg:draw(direction,rotate_angle,is_sitting)
    setColor(self.color)

    if is_sitting == false then
        love.graphics.push()
        love.graphics.rotate(rotate_angle)
        love.graphics.rectangle("fill",-self.width/2,0,self.width,self.length)

        love.graphics.setLineWidth(0.5)

        setColor(darker_shade(self.color,30))
        love.graphics.rectangle("line",-self.width/2,0,self.width,self.length)

        self:drawShoe(direction,is_sitting)
        love.graphics.pop()
    else
        
        if self.leg_side == "LeftLeg" then
            love.graphics.rectangle("fill",-1 * self.width/1.6,0,self.width/2,self.length)
            self:drawShoe(direction,is_sitting)
        elseif self.leg_side == "RightLeg" then
            love.graphics.rectangle("fill",4,0,self.width/2,self.length)
            self:drawShoe(direction,is_sitting)
        end
    end


end

function Leg:drawShoe(direction,is_sitting)
    setColor(self.shoe_color)
    love.graphics.setLineWidth(0.5)

    if is_sitting then
        if self.leg_side == "LeftLeg" then
            love.graphics.rectangle("fill",-self.width/2 - 7,self.length-10,self.width/2+4,11)
        elseif self.leg_side == "RightLeg" then
            love.graphics.rectangle("fill",2,self.length-10,self.width/2+4,11)
        end

        setColor(lighter_shade(self.shoe_color,50))
        -- love.graphics.rectangle("line",-2 - self.width/2,self.length-10,self.width+4,11)
        return
    end


    if direction == "left" then
        love.graphics.rectangle("fill",-15 - self.width/2,self.length-10,self.width+16,11)
        
        setColor(lighter_shade(self.shoe_color,50))
        love.graphics.rectangle("line",-15 - self.width/2,self.length-10,self.width+16,11)

    elseif direction == "right" then
        love.graphics.rectangle("fill",-1 - self.width/2,self.length-10,self.width+16,11)

        setColor(lighter_shade(self.shoe_color,50))
        love.graphics.rectangle("line",-1 - self.width/2,self.length-10,self.width+16,11)
    end
end

