--! file: legs.lua
require "colors"
require "oscillator"

Leg = Object:extend()

function Leg:new(width,length,leg_color,shoe_color)
    self.width      = width
    self.length     = length
    self.color      = leg_color
    self.shoe_color = shoe_color
end

function Leg:draw(direction,rotate_angle,is_seated)
    setColor(self.color)

    love.graphics.push()
    love.graphics.rotate(rotate_angle)
    love.graphics.rectangle("fill",-self.width/2,0,self.width,self.length)

    love.graphics.setLineWidth(0.5)

    setColor(darker_shade(self.color,30))
    love.graphics.rectangle("line",-self.width/2,0,self.width,self.length)

    self:drawShoe(direction,is_seated)
    love.graphics.pop()

end

function Leg:drawShoe(direction,is_seated)
    setColor(self.shoe_color)

    if is_seated then
        love.graphics.rectangle("fill",-5,self.length-10,self.width+5,15)
        return
    end
    love.graphics.setLineWidth(0.5)
    if direction == "left" then
        
        love.graphics.rectangle("fill",-15 - self.width/2,self.length-10,self.width+16,15)
        
        setColor(lighter_shade(self.shoe_color,50))
        love.graphics.rectangle("line",-15 - self.width/2,self.length-10,self.width+16,15)
    elseif direction == "right" then
        love.graphics.rectangle("fill",-1 - self.width/2,self.length-10,self.width+16,15)

        setColor(lighter_shade(self.shoe_color,50))
        love.graphics.rectangle("line",-1 - self.width/2,self.length-10,self.width+16,15)
    end
end


Legs = Object:extend()

function Legs:new(torso_width, speed_variation)
    self.length     = math.random(40,80)
    self.width      = torso_width * (math.random(50,80)/100)
    self.color      = random_reasonable_color()

    self.shoe_color = {math.random(0,50),math.random(0,50),math.random(0,50)}

    self.leg1       = Leg(self.width,self.length,self.color,self.shoe_color)
    self.leg2       = Leg(self.width,self.length,self.color,self.shoe_color)

    self.speed_variation = speed_variation
    self.oscillator      = Oscillator(math.random(0,628)/100,10*self.speed_variation)
end

function Legs:update(dt)
    self.oscillator:update(dt)
end

function Legs:draw(direction,animation_status)
    -- animation_status: walking, standing, seated
    local oscValue = math.pi/16 * self.oscillator.value
    if animation_status == "standing" then
        if direction == "left" then
            self.leg1:draw(direction,oscValue,false)
            self.leg2:draw(direction,-oscValue,false)
        elseif direction == "right" then
            self.leg1:draw(direction,oscValue,false)
            self.leg2:draw(direction,-oscValue,false)
        end
    end
end

-- function Legs:drawShoes(direction)
--     if direction == "left" then

--     else if direction == "right" then

--     else

--     end
-- end